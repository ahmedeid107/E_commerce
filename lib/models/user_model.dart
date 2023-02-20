import '../main.dart';

class UserModel {
  List<String> name;
  String? gender;
  int type;
  DateTime? birthdaty;
  String? email;
  String? photoPath;
  String id;

  String? phoneNumber;
  Future<void> update() async {
    // var id = await FirebaseAuth.instance.currentUser!.uid;
    db.collection("users").where("id", isEqualTo: id).get().then((value) {
      db.collection("users").doc(value.docs.first.id).update({
        "id": id,
        "birthdaty": birthdaty,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "name": name,
        "email": email,
        "photoPath": photoPath,
      });
    });
  }

  UserModel({
    required this.name,
    this.gender,
    required this.type,
    this.birthdaty,
    this.email,
    this.photoPath,
    required this.id,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map jsondata) {
    return UserModel(
        birthdaty: jsondata["birthdaty"],
        email: jsondata["email"],
        gender: jsondata["gender"],
        name: jsondata["name"],
        phoneNumber: jsondata["phoneNumber"],
        photoPath: jsondata["photoPath"],
        type: jsondata["type"],
        id: '');
  }
}

Map firstUser = {
  "name": ["Ahmed", "Eid"],
  "gender": "Female",
  "birthdaty": null,
  "email": "Ahmed.eid.abdelaal@gmail.com",
  "phoneNumber": "+201127400107",
  "password": "0694348945",
  "photoPath": "assets/2.jpg",
  "type": 0
};
