class User {
  int id;
  String firstName;
  String lastName;
  String phone;
  String country;
  String avatar;
  String description;

  User(int id, String firstName, String lastName, String country, String avatar,
      String description) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.phone = phone;
    this.country = country;
    this.avatar = avatar;
    this.description = description;
  }

  User.fromJson(Map json)
      : id = json['Id'],
        firstName = json['FirstName'],
        lastName = json['LastName'],
        phone = json['Phone'],
        country = json['Country'],
        avatar = json['Avatar'],
        description = json['Description'];

  Map toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'country': country,
      'avatar': avatar,
      'description': description
    };
  }
}
