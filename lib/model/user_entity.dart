import 'package:equatable/equatable.dart';


class UserEntity extends Equatable {
  UserEntity({
    required this.password,
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.handicap,
    required this.role,
  });

  String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String handicap;
  final String role;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'] ?? "",
        firstName: json['firstname'] ?? "",
        lastName: json['lastname'] ?? "",
        email: json['email'] ?? "",
        handicap: json['handicap'] ?? "",
        role: json['role'] ?? "",
        password: json['role'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'handicap': handicap,
        'role': role
      };
  factory UserEntity.empty() {
    // ignore: prefer_const_constructors
    return UserEntity(
      id: "",
      firstName: "",
      lastName: "",
      email: "",
      handicap: '',
      role: '',
      password: '',
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email];
}
