import 'dart:convert';
import 'package:http/http.dart' as http;

class GooglePlace {
  final String name;
  final String address;
  final double lat;
  final double lng;
  final String imageUrl;
  final double rating;

  GooglePlace({
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.imageUrl,
    required this.rating,
  });
}

class GooglePlacesService {
  static const _baseUrl =
      'https://maps.googleapis.com/maps/api/place/textsearch/json';
  static const _apiKey = 'AIzaSyBEcaNxrkIY_nKY9sFzqAyotYJaxxaq-Yo';

  static Future<List<GooglePlace>> getAttractions(String city) async {
    try {
      final query = Uri.encodeComponent('top tourist attractions in $city');
      final url = Uri.parse('$_baseUrl?query=$query&key=$_apiKey');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        print('⚠️ Google Places failed: ${response.body}');
        return [];
      }

      final data = json.decode(response.body);
      final results = data['results'] as List?;

      if (results == null || results.isEmpty) {
        print('ℹ️ No attractions found via Google for $city');
        return [];
      }

      return results.map((place) {
        final photos = place['photos'];
        final imageUrl = (photos != null && photos.isNotEmpty)
            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=${photos[0]['photo_reference']}&key=$_apiKey'
            : 'https://source.unsplash.com/featured/?${place['name']},${city},travel';
        return GooglePlace(
          name: place['name'] ?? 'Unknown Place',
          address: place['formatted_address'] ?? '',
          lat: place['geometry']['location']['lat'] ?? 0.0,
          lng: place['geometry']['location']['lng'] ?? 0.0,
          imageUrl: imageUrl,
          rating: (place['rating'] ?? 0).toDouble(),
        );
      }).toList();
    } catch (e) {
      print('❌ Error fetching attractions for $city: $e');
      return [];
    }
  }
}
