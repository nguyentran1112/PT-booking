import 'package:cloud_firestore/cloud_firestore.dart';

class GymOfTypeService {
 
  Future<List<String>> getGymTypes() async {
    final typeOfGymCollection =
        FirebaseFirestore.instance.collection('type_of_gym');
    try {
      final querySnapshot = await typeOfGymCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data()['name'] as String)
          .toList();
    } catch (e) {
      throw Exception('Error fetching gym types: $e');
    }
  }
}
