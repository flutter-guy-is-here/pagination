import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pagination/models/module.dart';

class ModulesData {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static DocumentSnapshot? lastDoc;
  static int batchSize = 5;

  static Future<void> uploadModuleToFirestore(List<Module> modules) async {
    try {
      for (Module module in modules) {
        await firestore.collection("modules").add(module.toJson());
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getModules() async {
    try {
      final querySnapshot = await firestore
          .collection("modules")
          .orderBy("timestamp", descending: true)
          .limit(11)
          .get();
      if (querySnapshot.docs.isNotEmpty) lastDoc = querySnapshot.docs.last;
      List<Module> myList = querySnapshot.docs
          .map((doc) => Module.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      if (querySnapshot.metadata.isFromCache) {
        return {
          'list': myList,
          'isFromCache': true,
        };
      }
      return {
        'list': myList,
        'isFromCache': false,
      };
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Module>> loadMore() async {
    try {
      Query query = firestore
          .collection("modules")
          .orderBy("timestamp", descending: true)
          .limit(batchSize);

      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) lastDoc = querySnapshot.docs.last;
      return querySnapshot.docs
          .map((doc) => Module.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
