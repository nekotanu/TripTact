import 'dart:convert';
import 'package:http/http.dart' as http;

class Place {
  final String name;
  final String description;
  final String imageUrl;
  final double lat;
  final double lon;

  Place({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.lat,
    required this.lon,
  });
}

class PlaceService {
  static const _baseUrl = 'https://api.opentripmap.com/0.1/en/places';
  static const _apiKey =
      '5ae2e3f221c38a28845f05b66df93e757ce5b2fd5efccfd9a16b165b';

  static Future<List<Place>> getPlacesForCity(String city) async {
    try {
      final coords = await _getCoordinates(city);
      if (coords == null)
        throw Exception('Could not find coordinates for $city');

      final double lat = coords['lat']!;
      final double lon = coords['lon']!;
      const offset = 0.3; // roughly ~30km bounding box

      final lonMin = lon - offset;
      final lonMax = lon + offset;
      final latMin = lat - offset;
      final latMax = lat + offset;

      final url = Uri.parse(
        '$_baseUrl/bbox?lon_min=$lonMin&lat_min=$latMin&lon_max=$lonMax&lat_max=$latMax'
        '&limit=25'
        '&kinds=interesting_places,tourist_facilities,historic,architecture,cultural,natural'
        '&apikey=$_apiKey',
      );

      print('🌍 Fetching attractions for $city via bbox: $url');

      final res = await http.get(url);
      if (res.statusCode != 200) {
        print('⚠️ OpenTripMap failed for $city: ${res.body}');
        throw Exception('Failed to fetch places');
      }

      final data = json.decode(res.body);
      final features = data['features'] as List?;
      if (features == null || features.isEmpty) {
        print('ℹ️ No attractions found near $city (bbox mode).');
        throw Exception('No places found');
      }

      final places = features
          .map((feature) {
            final props = feature['properties'];
            return Place(
              name: props['name'] ?? 'Unnamed Place',
              description: props['kinds'] ?? 'Attraction',
              imageUrl:
                  'https://source.unsplash.com/featured/?${props['name']},${city},travel',
              lat: feature['geometry']['coordinates'][1],
              lon: feature['geometry']['coordinates'][0],
            );
          })
          .where((p) => p.name.trim().isNotEmpty)
          .toList();

      print('✅ Found ${places.length} attractions for $city via bbox');
      return places;
    } catch (e) {
      print('❌ Error fetching places for $city: $e');
      return [];
    }
  }

  static Future<Map<String, double>?> _getCoordinates(String city) async {
    try {
      // Try OpenTripMap geoname
      final geoUrl = Uri.parse('$_baseUrl/geoname?name=$city&apikey=$_apiKey');
      final geoRes = await http.get(geoUrl);

      if (geoRes.statusCode == 200) {
        final geoData = json.decode(geoRes.body);
        if (geoData['lat'] != null && geoData['lon'] != null) {
          print('✅ Found coordinates for $city via OpenTripMap');
          return {
            'lat': (geoData['lat'] as num).toDouble(),
            'lon': (geoData['lon'] as num).toDouble(),
          };
        }
      }

      // Fallback: OpenStreetMap
      final osmUrl = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$city&format=json&limit=1',
      );
      final osmRes = await http.get(
        osmUrl,
        headers: {'User-Agent': 'TripTact/1.0 (contact@triptact.app)'},
      );

      if (osmRes.statusCode == 200) {
        final osmData = json.decode(osmRes.body);
        if (osmData.isNotEmpty) {
          print('✅ Found coordinates for $city via OpenStreetMap');
          return {
            'lat': double.parse(osmData[0]['lat']),
            'lon': double.parse(osmData[0]['lon']),
          };
        }
      }
    } catch (e) {
      print('⚠️ Error getting coordinates for $city: $e');
    }
    return null;
  }
}
