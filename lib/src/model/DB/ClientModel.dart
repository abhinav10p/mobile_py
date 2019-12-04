import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String firstName;
  String lastName;
  String phone;
  String country;
  String avatar;
  String description;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.country,
    this.avatar,
    this.description,
  });

  Client.fromJson(Map json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        phone = json['phone'],
        country = json['country'],
        avatar = json['avatar'],
        description = json['description'];

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        country: json["country"],
        avatar: json["avatar"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "country": country,
        "avatar": avatar,
        "description": description,
      };
}
