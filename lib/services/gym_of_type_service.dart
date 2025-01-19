import 'dart:convert';

import 'package:fitness/models/gym_of_type.dart';
import 'package:http/http.dart' as http;

class GymOfTypeService {
  static const String _jsonUrl = '/assets/type_of_gym.json';

  Future<List<GymOfTypeModel>> getGymTypes() async {
    try {
      final response = await http.get(Uri.parse(_jsonUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => GymOfTypeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load gym types');
      }
    } catch (e) {
      throw Exception('Error fetching gym types: $e');
    }
  }
}
