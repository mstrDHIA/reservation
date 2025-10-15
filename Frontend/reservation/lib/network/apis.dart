
import 'package:http/http.dart' as http;

class APIS{
  static const String baseUrl = "https://862303accba4.ngrok-free.app/Reservtion/Backend/asked_task/ReservationController.php";
  static const String eventsList = "/api/v1/events";
  static const String addReservation = "/api/v1/reservation";

  static var client = http.Client();

}