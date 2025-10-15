import 'package:flutter/material.dart';
import 'package:reservation/screens/events/events_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: EventsListScreen(),
      ),
    );
  }
}
