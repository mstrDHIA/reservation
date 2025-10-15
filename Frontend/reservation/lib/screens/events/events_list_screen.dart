import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reservation/models/event.dart';
import 'package:reservation/network/apis.dart';
import 'package:reservation/screens/reservation/add_reservation_screen.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  Future<http.Response> getEventsList() async {
    http.Response response = await APIS.client.get(Uri.parse(APIS.baseUrl + APIS.eventsList),
        );
        return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Evenements'),
      ),
      body: Center(
        child: FutureBuilder<http.Response>(
        future: getEventsList(),
         builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Text('Erreur: ${snapshot.error}');
          }
          else if(snapshot.hasData){
            if(snapshot.data!.statusCode == 200){
              List<dynamic> jsonData = jsonDecode(snapshot.data!.body); 
              return ListView.builder(               
                itemCount: jsonData.length, 
                itemBuilder: (context, index) {
                  Event event= Event.fromJson(jsonData[index]);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Card(
                      child: ListTile(
                        title: Text('Event ${event.titre}'), 
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Places Disponibles ${event.placesDisponibles}'),
                            Text('Prix: ${event.prix}'),
                          ],
                        ),
                        trailing: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddReservationScreen(eventId: event.id ?? 0,prix: double.parse(event.prix!),)));
                        }, child: Text("Reserver"))
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('Failed to load events, Status Code: ${snapshot.data!.statusCode}');
            }
          } else {
            return Text('Donnees non disponibles');
          }
        })
      ),
    );
  }
}