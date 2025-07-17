class ExpertModel {
  final String? id;
  final String userId;
  final String categoryId;
  final String? subcategory;
  final String fullName;
  final String? email;
  final String? phone;
  final String? bio;
  final String? expertise;
  final int? experienceYears;
  final String? currentCompany;
  final String? currentDesignation;
  final String? linkedinUrl;
  final double ratePerMinute;
  final double rating;
  final int reviewsCount;
  final String? profilePicture;
  final String? degreeCertificateUrl;
  final String? idProofUrl;
  final String? offerLetterUrl;
  final String? otherCertificateUrl;
  final String status;
  final bool isApproved;
  final bool isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ExpertModel({
    this.id,
    required this.userId,
    required this.categoryId,
    this.subcategory,
    required this.fullName,
    this.email,
    this.phone,
    this.bio,
    this.expertise,
    this.experienceYears,
    this.currentCompany,
    this.currentDesignation,
    this.linkedinUrl,
    required this.ratePerMinute,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.profilePicture,
    this.degreeCertificateUrl,
    this.idProofUrl,
    this.offerLetterUrl,
    this.otherCertificateUrl,
    this.status = 'pending',
    this.isApproved = false,
    this.isAvailable = true,
    this.createdAt,
    this.updatedAt,
  });

  factory ExpertModel.fromJson(Map<String, dynamic> json) {
    return ExpertModel(
      id: json['_id'] ?? json['id'],
      userId: json['userId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      subcategory: json['subcategory'],
      fullName: json['fullName'] ?? '',
      email: json['email'],
      phone: json['phone'],
      bio: json['bio'],
      expertise: json['expertise'],
      experienceYears: json['experienceYears'],
      currentCompany: json['currentCompany'],
      currentDesignation: json['currentDesignation'],
      linkedinUrl: json['linkedinUrl'],
      ratePerMinute: (json['ratePerMinute'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      profilePicture: json['profilePicture'],
      degreeCertificateUrl: json['degreeCertificateUrl'],
      idProofUrl: json['idProofUrl'],
      offerLetterUrl: json['offerLetterUrl'],
      otherCertificateUrl: json['otherCertificateUrl'],
      status: json['status'] ?? 'pending',
      isApproved: json['isApproved'] ?? false,
      isAvailable: json['isAvailable'] ?? true,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'userId': userId,
      'categoryId': categoryId,
      if (subcategory != null) 'subcategory': subcategory,
      'fullName': fullName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (bio != null) 'bio': bio,
      if (expertise != null) 'expertise': expertise,
      if (experienceYears != null) 'experienceYears': experienceYears,
      if (currentCompany != null) 'currentCompany': currentCompany,
      if (currentDesignation != null) 'currentDesignation': currentDesignation,
      if (linkedinUrl != null) 'linkedinUrl': linkedinUrl,
      'ratePerMinute': ratePerMinute,
      'rating': rating,
      'reviewsCount': reviewsCount,
      if (profilePicture != null) 'profilePicture': profilePicture,
      if (degreeCertificateUrl != null)
        'degreeCertificateUrl': degreeCertificateUrl,
      if (idProofUrl != null) 'idProofUrl': idProofUrl,
      if (offerLetterUrl != null) 'offerLetterUrl': offerLetterUrl,
      if (otherCertificateUrl != null)
        'otherCertificateUrl': otherCertificateUrl,
      'status': status,
      'isApproved': isApproved,
      'isAvailable': isAvailable,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  ExpertModel copyWith({
    String? id,
    String? userId,
    String? categoryId,
    String? subcategory,
    String? fullName,
    String? email,
    String? phone,
    String? bio,
    String? expertise,
    int? experienceYears,
    String? currentCompany,
    String? currentDesignation,
    String? linkedinUrl,
    double? ratePerMinute,
    double? rating,
    int? reviewsCount,
    String? profilePicture,
    String? degreeCertificateUrl,
    String? idProofUrl,
    String? offerLetterUrl,
    String? otherCertificateUrl,
    String? status,
    bool? isApproved,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpertModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      subcategory: subcategory ?? this.subcategory,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      expertise: expertise ?? this.expertise,
      experienceYears: experienceYears ?? this.experienceYears,
      currentCompany: currentCompany ?? this.currentCompany,
      currentDesignation: currentDesignation ?? this.currentDesignation,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      ratePerMinute: ratePerMinute ?? this.ratePerMinute,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      profilePicture: profilePicture ?? this.profilePicture,
      degreeCertificateUrl: degreeCertificateUrl ?? this.degreeCertificateUrl,
      idProofUrl: idProofUrl ?? this.idProofUrl,
      offerLetterUrl: offerLetterUrl ?? this.offerLetterUrl,
      otherCertificateUrl: otherCertificateUrl ?? this.otherCertificateUrl,
      status: status ?? this.status,
      isApproved: isApproved ?? this.isApproved,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'ExpertModel(id: $id, fullName: $fullName, email: $email, status: $status, isApproved: $isApproved)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExpertModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  //* Helper getters
  bool get isPending => status == 'pending';
  bool get isVerified => status == 'verified';
  bool get isRejected => status == 'rejected';

  String get displayRating => rating.toStringAsFixed(1);
  String get displayRate => '₹${ratePerMinute.toStringAsFixed(0)}/min';

  String get experienceText {
    if (experienceYears == null) return 'Experience not specified';
    if (experienceYears! == 1) return '1 year experience';
    return '$experienceYears years experience';
  }
}

// // Assuming you have an ExpertModel instance
// ExpertModel expert = ExpertModel.fromJson(apiResponse);

// // Call the getters directly (no parentheses needed)
// bool pending = expert.isPending;
// bool verified = expert.isVerified;
// bool rejected = expert.isRejected;

// String rating = expert.displayRating;
// String rate = expert.displayRate;
// String experience = expert.experienceText;
