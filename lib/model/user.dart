import 'package:hive_flutter/adapters.dart';

class User {
  final String id;
  final String displayName;
  final String email;
  final bool isActive;

  User(
      {required this.id,
      required this.email,
      required this.displayName,
      required this.isActive});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        displayName: map['displayName'],
        email: map['email'],
        isActive: map['isActive'] == "true");
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "email": email,
        "isActive": "$isActive"
      };

  User copy({bool? activate}) => User(
      id: id,
      email: email,
      displayName: displayName,
      isActive: activate ?? isActive);
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 001;

  @override
  User read(BinaryReader reader) {
    return User(
        id: reader.read(),
        email: reader.read(),
        displayName: reader.read(),
        isActive: reader.read());
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..write(obj.id)
      ..write(obj.email)
      ..write(obj.displayName)
      ..write(obj.isActive);
  }
}
