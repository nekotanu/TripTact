import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:triptact/core/constants/app_theme.dart';
import 'package:triptact/models/trips.dart';
import 'package:triptact/provider/trip_provider.dart';

// Screens
import 'package:triptact/screens/create_trips/create_trip_dialog.dart';
import 'package:triptact/screens/splash/splash_screen.dart';
import 'package:triptact/screens/home/home_screen.dart';
import 'package:triptact/screens/loading/loading_screen.dart';
import 'package:triptact/screens/itinerary/itinerary_screen.dart';

import 'package:triptact/trip/trip_screen.dart'; // <-- NEW IMPORT

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TripProvider(),
      child: const TripTactApp(),
    ),
  );
}

class TripTactApp extends StatelessWidget {
  const TripTactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TripTact',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/itinerary': (context) => const ItineraryScreen(),
        '/create_trip': (context) => const CreateTripDialog(),
        '/trip_screen': (context) {
          final trip = ModalRoute.of(context)!.settings.arguments as Trip;
          return TripScreen(trip: trip);
        },
      },
    );
  }
}
