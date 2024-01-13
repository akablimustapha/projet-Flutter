import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  Future addPlayer(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("players")
        .doc()
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getPlayer(String name) async {
    return await FirebaseFirestore.instance
        .collection("players")
        .where("name", isEqualTo: name)
        .get();
  }

  Future UpdatePlayer(String club, String id) async {
    return await FirebaseFirestore.instance
        .collection("players")
        .doc(id)
        .update({"club": club});
  }

  Future<DocumentSnapshot> getPlayerById(String id) async {
  return await FirebaseFirestore.instance
      .collection("players")
      .doc(id)
      .get();
}

Future<void> updatePlayer(String id, Map<String, dynamic> data) async {
  return await FirebaseFirestore.instance
      .collection("players")
      .doc(id)
      .update(data);
}



  Future DeletePlayer(String id) async {
    return await FirebaseFirestore.instance
        .collection("players")
        .doc(id)
        .delete();
  }
}
