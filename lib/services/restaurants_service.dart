import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class RestaurantService {
  static const _baseUrl =
      'https://maps.googleapis.com/maps/api/place/textsearch/json';
  static const _apiKey = 'YOUR_GOOGLE_API_KEY';

  static Future<List<Place>> getRestaurants(String city) async {
    final url = Uri.parse('$_baseUrl?query=restaurants+in+$city&key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.map((p) {
        return Place(
          name: p['name'],
          description: p['formatted_address'] ?? '',
          imageUrl: p['photos'] != null
              ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${p['photos'][0]['photo_reference']}&key=$_apiKey'
              : 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
          lat: p['geometry']['location']['lat'],
          lng: p['geometry']['location']['lng'],
          category: 'Restaurant',
        );
      }).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
