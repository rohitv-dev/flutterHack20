class User {
  final String uid;
  final String email;
  final bool isUserEmailVerified;
  User({this.uid, this.email, this.isUserEmailVerified});
}

class Role {
  final String email;
  final String role;
  Role({
    this.email,
    this.role,
  });
}