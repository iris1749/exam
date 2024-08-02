import 'package:http/http.dart' as http;

class WeatherService {
  Future<String> getTemperature() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/weather'));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load temperature');
      }
    } catch (e) {
      print('Error getting temperature: $e');
      return 'Error';
    }
  }
}