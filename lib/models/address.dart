class Addresss {
  final String address;
  final String title;
  final String number;

  Addresss({
    required this.address,
    required this.title,
    required this.number,
  });
  static String offer = "Offer";
  static String feed = "Feed";
  static String acivity = "Acivity";

  factory Addresss.fromJson(title, jsondata) {
    var mapp = jsondata.values.toList();
    return Addresss(title: title, address: mapp[0], number: mapp[1]);
  }
}

class Addresss1 {
  String country;
  String streatAddress;
  String? streatAddress2;
  String city;
  String userId;
  String state;
  String zibCode;
  String phoneNumber;
  List name;
  int id;

  Addresss1({
    required this.country,
    required this.streatAddress,
    this.streatAddress2,
    required this.city,
    required this.userId,
    required this.state,
    required this.zibCode,
    required this.phoneNumber,
    required this.name,
    required this.id,
  });

  factory Addresss1.fromJson(jsondata1) {
    var jsondata = jsondata1['address'];
    return Addresss1(
      city: jsondata['city'],
      country: jsondata['country'],
      phoneNumber: jsondata['phoneNumber'],
      streatAddress2: jsondata['streatAddress2'],
      name: jsondata['name'],
      streatAddress: jsondata['streatAddress'],
      zibCode: jsondata['zibCode'],
      state: jsondata['state'],
      userId: jsondata1['userId'],
      id: jsondata1['id'],
    );
  }
}

Map addresses = {
  "Priscekila": {
    "address":
        "3711 Spring Hill Rd undefined Tallahassee, Nevada 52874 United States",
    "number": "+99 1234567890"
  },
  "Ahmad Khaidir": {
    "address":
        "3711 Spring Hill Rd undefined Tallahassee, Nevada 52874 United States",
    "number": "+99 1234567890"
  }
};

class AddresssFull {
  final String address;
  final String title;
  final String number;

  AddresssFull({
    required this.address,
    required this.title,
    required this.number,
  });
  static String offer = "Offer";
  static String feed = "Feed";
  static String acivity = "Acivity";

  factory AddresssFull.fromJson(title, jsondata) {
    var mapp = jsondata.values.toList();
    return AddresssFull(title: title, address: mapp[0], number: mapp[1]);
  }
}
