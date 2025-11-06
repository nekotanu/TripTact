// lib/models/trip.dart
class Trip {
  final String destination;
  final List<String> places;
  final List<String> restaurants;

  Trip({
    required this.destination,
    required this.places,
    required this.restaurants,
  });
}
