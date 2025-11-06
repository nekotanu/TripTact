import 'place.dart';

class ItineraryDay {
  final int day;
  final List<Place> morning;
  final List<Place> afternoon;
  final List<Place> evening;

  ItineraryDay({
    required this.day,
    required this.morning,
    required this.afternoon,
    required this.evening,
  });
}
