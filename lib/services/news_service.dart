import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String _baseUrl = "https://newsdata.io/api/1/news";
  final String _apiKey = "pub_628050577f5d16020616fabdf3fe290097516";

  // Fetch news without search query
  Future<Map<String, dynamic>> fetchNews() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?apikey=$_apiKey&language=en'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch news: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching news: $e');
    }
  }

  // Fetch news by search query
  Future<Map<String, dynamic>> fetchNewsBySearching(String title) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?apikey=$_apiKey&language=ar,en&q=$title'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch searched news: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching searched news: $e');
    }
  }
}
