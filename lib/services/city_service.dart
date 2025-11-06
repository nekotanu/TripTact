import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CityService {
  static const _baseUrl = 'https://wft-geo-db.p.rapidapi.com/v1/geo/cities';
  static const _headers = {
    'X-RapidAPI-Key': 'a1871d0c61mshfab7d520ba87840p1394eejsn455dc9b9e895',
    'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
  };

  static Timer? _debounceTimer;
  static Completer<List<String>>? _debounceCompleter;

  /// Debounced city search
  static Future<List<String>> searchCities(String query) async {
    // Return immediately if query is empty
    if (query.isEmpty) return [];

    // Cancel any ongoing timer and request
    _debounceTimer?.cancel();

    // If no completer exists, create one
    _debounceCompleter ??= Completer<List<String>>();

    // Start debounce timer
    _debounceTimer = Timer(const Duration(milliseconds: 800), () async {
      try {
        final url = Uri.parse(
          '$_baseUrl?namePrefix=$query&limit=10&sort=-population',
        );

        final response = await http.get(url, headers: _headers);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final cities = data['data'] as List;
          final results = cities.map((c) => c['city'] as String).toList();
          _debounceCompleter?.complete(results);
        } else {
          print('❌ GeoDB error: ${response.statusCode} — ${response.body}');
          _debounceCompleter?.complete([]);
        }
      } catch (e) {
        print('⚠️ Error fetching cities: $e');
        _debounceCompleter?.complete([]);
      } finally {
        _debounceCompleter = null;
      }
    });

    // Return future that resolves once debounce completes
    return _debounceCompleter!.future;
  }
}
