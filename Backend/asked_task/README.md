# Reservation API

## List events
```sh
curl http://localhost:81/Reservtion/Backend/asked_task/ReservationController.php/api/v1/events
```

## Create reservation
```sh
curl -X POST -H "Content-Type: application/json" \
  -d '{"event_id":1,"quantite":2,"client":{"nom":"Test","email":"t@t.be"}}' \
  http://localhost:81/Reservtion/Backend/asked_task/ReservationController.php/api/v1/reservation
```