import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchData() async {
  final character1Response = await http.get(Uri.parse('http://192.168.1.9:5000/character1'));
  final character2Response = await http.get(Uri.parse('http://192.168.1.9:5000/character2'));

  if (character1Response.statusCode == 200 && character2Response.statusCode == 200) {
    return {
      'character1Data': json.decode(character1Response.body),
      'character2Data': json.decode(character2Response.body),
    };
  } else {
    throw Exception('Failed to fetch data');
  }
}