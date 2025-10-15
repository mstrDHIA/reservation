import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reservation/models/reservation.dart';
import 'package:reservation/network/apis.dart';
import 'package:reservation/utils/methods.dart';

class AddReservationScreen extends StatelessWidget {
  final int eventId;
  final double prix;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController placesController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add form key

  AddReservationScreen({super.key, required this.eventId, required this.prix});

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nom requis';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email requis';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Email invalide';
    }
    return null;
  }

  String? _validatePlaces(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Quantité requise';
    }
    final int? places = int.tryParse(value.trim());
    if (places == null || places <= 0) {
      return 'Entrez un entier positif';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation evenement ID: $eventId'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: Form(
            key: _formKey, // Use form key
            child: Column(
              children: [
                MyField(
                  controller: nameController,
                  label: "Nom",
                  hint: "Entrez votre nom",
                  textType: TextInputType.name,
                  validator: _validateName, // Add validator
                ),
                SizedBox(height: 20,),
                MyField(
                  controller: emailController,
                  label: "Email",
                  hint: "Entrez votre email",
                  textType: TextInputType.emailAddress,
                  validator: _validateEmail, // Add validator
                ),
                SizedBox(height: 20,),
                MyField(
                  controller: placesController,
                  label: "Places",
                  hint: "Entrez le nombre de places",
                  textType: TextInputType.number,
                  validator: _validatePlaces, // Add validator
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text("Votre totale est: ${calculerTotal(prix, placesController.text.isNotEmpty ? int.parse(placesController.text) : 0)}"),
                        content: Text("Voulez-vous confirmer la reservation?"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("Annuler")),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            confirmReservation(context);
                          }, child: Text("Confirmer"))
                        ],
                      );
                    });
                    // confirmReservation(context);
                  },
                  child: Text("Reserver")
                ),          
              ],
            )
          ),
        ),
      ),
    );
  }

  

  void confirmReservation(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      Reservation reservation = Reservation(
        client: Client(
          nom: nameController.text,
          email: emailController.text,
        ),
        eventId: eventId,
        quantite: int.parse(placesController.text),
      );
      Map<String, dynamic> reservationData = reservation.toJson();
      String data = jsonEncode(reservationData);
      APIS.client.post(
        Uri.parse(APIS.baseUrl + APIS.addReservation),
        body: data,
      ).then((response) {
        if (response.statusCode == 200) {
          Map<String,dynamic> responseData = jsonDecode(response.body);
    
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reservation validee le total est ${responseData['total']}'),
          backgroundColor: Colors.green,
          ));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reservation echouee'),
          backgroundColor: Colors.red,
          ));
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $error'),
        backgroundColor: Colors.red,
        ));
      });
    }
  }
}

class MyField extends StatelessWidget {
  const MyField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.textType = TextInputType.text,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType textType;
  final String? Function(String?)? validator; // Add validator

  @override
  Widget build(BuildContext context) {
    return SizedBox(           
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: TextFormField(
        keyboardType: textType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint, // Fix: use hintText instead of hint
          border: OutlineInputBorder(),
        ),
        controller: controller,
        validator: validator, // Use validator
      ),
    );
  }
}