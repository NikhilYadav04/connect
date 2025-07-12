//* User model matching your MongoDB schema exactly
class User {
  final String? id;
  final String fullName;
  final String email;
  final String? phone;
  final String? password; // Usually not returned by API for security
  final double walletBalance;
  final String? profilePicture;
  final String role;
  final bool isBanned;
  final bool isExpert;
  final bool isVerified;
  final bool isBlocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.password,
    this.walletBalance = 0.0,
    this.profilePicture,
    this.role = 'user',
    this.isBanned = false,
    this.isExpert = false,
    this.isVerified = false,
    this.isBlocked = false,
    this.createdAt,
    this.updatedAt,
  });

  //* Create User from JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'],
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      password: json['password'], // Usually null in responses
      walletBalance: (json['walletBalance'] ?? 0).toDouble(),
      profilePicture: json['profilePicture'],
      role: json['role'] ?? 'user',
      isBanned: json['isBanned'] ?? false,
      isExpert: json['isExpert'] ?? false,
      isVerified: json['isVerified'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  //* Convert User to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'fullName': fullName,
      'email': email,
      if (phone != null) 'phone': phone,
      if (password != null) 'password': password,
      'walletBalance': walletBalance,
      if (profilePicture != null) 'profilePicture': profilePicture,
      'role': role,
      'isBanned': isBanned,
      'isExpert': isExpert,
      'isVerified': isVerified,
      'isBlocked': isBlocked,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  //* Create a copy of User with updated fields
  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? password,
    double? walletBalance,
    String? profilePicture,
    String? role,
    bool? isBanned,
    bool? isExpert,
    bool? isVerified,
    bool? isBlocked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      walletBalance: walletBalance ?? this.walletBalance,
      profilePicture: profilePicture ?? this.profilePicture,
      role: role ?? this.role,
      isBanned: isBanned ?? this.isBanned,
      isExpert: isExpert ?? this.isExpert,
      isVerified: isVerified ?? this.isVerified,
      isBlocked: isBlocked ?? this.isBlocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  //* Get full profile picture URL
  String? get fullProfilePictureUrl {
    if (profilePicture == null || profilePicture!.isEmpty) return null;

    //* If it's already a full URL, return as is
    if (profilePicture!.startsWith('http')) {
      return profilePicture;
    }

    //* Otherwise, prepend your server base URL
    return 'https://your-server-url.com/$profilePicture';
  }

  //* Check if user has admin privileges
  bool get isAdmin => role == 'admin';

  //* Check if user can perform actions (not banned or blocked)
  bool get canPerformActions => !isBanned && !isBlocked;

  //* Get formatted wallet balance
  String get formattedWalletBalance => '\${walletBalance.toStringAsFixed(2)}';

  //* Get user status summary
  String get statusSummary {
    List<String> statuses = [];
    if (isVerified) statuses.add('Verified');
    if (isExpert) statuses.add('Expert');
    if (isAdmin) statuses.add('Admin');
    if (isBanned) statuses.add('Banned');
    if (isBlocked) statuses.add('Blocked');

    return statuses.isEmpty ? 'Active User' : statuses.join(', ');
  }

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, email: $email, role: $role, walletBalance: $walletBalance)';
  }
}
