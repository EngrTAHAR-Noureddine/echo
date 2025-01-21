import 'package:hive_flutter/adapters.dart';

class User {
  final String id;
  final String displayName;
  final String email;

  User({required this.id, required this.email, required this.displayName});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'], displayName: map['displayName'], email: map['email']);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "displayName": displayName, "email": email};
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 001;

  @override
  User read(BinaryReader reader) {
    return User(
        id: reader.read(), email: reader.read(), displayName: reader.read());
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..write(obj.id)
      ..write(obj.email)
      ..write(obj.displayName);
  }
}
