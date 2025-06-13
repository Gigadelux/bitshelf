import 'dart:convert';

class User {
  String username;
  String passwordHash;

  User({
    required this.username,
    required this.passwordHash,
  });


  User copyWith({
    String? username,
    String? passwordHash,
  }) {
    return User(
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'passwordHash': passwordHash,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      passwordHash: map['passwordHash'] as String,
    );
  }
  factory User.empty() {
    return User(
      username: "",
      passwordHash: ""
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
      other.username == username &&
      other.passwordHash == passwordHash;
  }

  @override
  int get hashCode => username.hashCode ^ passwordHash.hashCode;


  static void check(User user) {
    if (user.username.isEmpty) throw ArgumentError('Username cannot be empty');
    if (user.passwordHash.isEmpty) throw ArgumentError('Password hash cannot be empty');
  }
}
