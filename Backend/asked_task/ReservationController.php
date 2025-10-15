<?php
header("Content-Type: application/json");
include 'db.php';

// Helper: send JSON response with status code
function send_json($data, $code = 200) {
    http_response_code($code);
    echo json_encode($data);
    exit;
}

// Routing
$method = $_SERVER['REQUEST_METHOD'];
$request = $_SERVER['REQUEST_URI'];

// Extract endpoint after script name
$script_name = $_SERVER['SCRIPT_NAME'];
$endpoint = substr($request, strlen($script_name));

// Remove query string if present
$endpoint = strtok($endpoint, '?');

if ($endpoint === '/api/v1/events' && $method === 'GET') {
    listEvents($pdo);
} elseif ($endpoint === '/api/v1/reservation' && $method === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    createReservation($pdo, $input);
} else {
    send_json(['message' => 'Not found'], 404);
}

// Endpoint 1: GET /api/v1/events
function listEvents($pdo) {
    $sql = "SELECT id, titre, prix, places_disponibles FROM events WHERE places_disponibles > 0";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $events = $stmt->fetchAll(PDO::FETCH_ASSOC);
    send_json($events);
}

// Endpoint 2: POST /api/v1/reservation
function createReservation($pdo, $input) {
    // Validate input
    if (
        !isset($input['event_id'], $input['quantite'], $input['client']['nom'], $input['client']['email'])
    ) {
        send_json(['status' => 'error', 'message' => 'Missing required fields'], 400);
    }

    // Ensure event_id and quantite are integers (convert if string)
    $event_id = $input['event_id'];
    $quantite = $input['quantite'];

    if (!is_int($event_id)) {
        $event_id = intval($event_id);
    }
    if (!is_int($quantite)) {
        $quantite = intval($quantite);
    }

    $nom = trim($input['client']['nom']);
    $email = filter_var($input['client']['email'], FILTER_VALIDATE_EMAIL);

    if ($event_id <= 0 || $quantite <= 0 || !$nom || !$email) {
        send_json(['status' => 'error', 'message' => 'Invalid input values'], 400);
    }

    try {
        $pdo->beginTransaction();

        // Check event
        $stmt = $pdo->prepare("SELECT id, titre, prix, places_disponibles FROM events WHERE id = :id FOR UPDATE");
        $stmt->execute(['id' => $event_id]);
        $event = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$event) {
            $pdo->rollBack();
            send_json(['status' => 'error', 'message' => 'Event not found'], 400);
        }

        if ($event['places_disponibles'] < $quantite) {
            $pdo->rollBack();
            send_json(['status' => 'error', 'message' => 'Not enough places available'], 422);
        }

        $total = floatval($event['prix']) * $quantite;

        // Insert reservation
        $stmt = $pdo->prepare("INSERT INTO reservations (event_id, nom, email, quantite, total, date_reservation) VALUES (:event_id, :nom, :email, :quantite, :total, NOW())");
        $stmt->execute([
            'event_id' => $event_id,
            'nom' => $nom,
            'email' => $email,
            'quantite' => $quantite,
            'total' => $total
        ]);

        // Update event 
        $stmt = $pdo->prepare("UPDATE events SET places_disponibles = places_disponibles - :quantite WHERE id = :id");
        $stmt->execute(['quantite' => $quantite, 'id' => $event_id]);

        $pdo->commit();

        send_json([
            'status' => 'success',
            'message' => 'Réservation confirmée',
            'total' => $total
        ]);
    } catch (Exception $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        send_json(['status' => 'error', 'message' => 'Server error'], 500);
    }
}
?>