class Register {
  final String username;
  final String fullName;
  final String password;

  Register({
    required this.username,
    required this.fullName,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'full_name': fullName,
        'password': password,
      };
}
