class User {
  final String sub;
  final String email;
  String name;
  final String pictureUrl;
  final bool isPremium;
  final String premiumUntil;
  final String createdAt;
  final String pendingPayment;
  final List<String> roles;

  User({
    required this.sub,
    required this.email,
    required this.name,
    required this.pictureUrl,
    required this.isPremium,
    required this.premiumUntil,
    required this.createdAt,
    required this.pendingPayment,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      sub: json['sub'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      pictureUrl: json['pictureUrl'] ?? '',
      isPremium: json['isPremium'] ?? false,
      premiumUntil: json['premiumUntil'] ?? '',
      createdAt: json['createdAt'] ?? '',
      roles: List<String>.from(json['roles']),
      pendingPayment: json['pendingPayment'] ?? '',
    );
  }
}
