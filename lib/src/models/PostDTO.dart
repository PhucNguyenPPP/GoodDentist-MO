class CustomerDTO {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;

  CustomerDTO({required this.id, required this.name, required this.username, required this.email, required this.phone});

  factory CustomerDTO.fromJson(Map<String, dynamic> json) {
    return CustomerDTO(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}