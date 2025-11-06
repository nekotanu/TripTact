// lib/providers/trip_provider.dart
import 'package:flutter/material.dart';
import 'package:triptact/models/trips.dart';

class TripProvider extends ChangeNotifier {
  final List<Trip> _trips = [];

  List<Trip> get trips => List.unmodifiable(_trips);

  void addTrip(Trip trip) {
    _trips.add(trip);
    notifyListeners();
  }
}
