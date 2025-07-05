class ExpertDetailModel {
  final String name;
  final String title;
  final String qualification;
  final String profileImageUrl;
  final List<String> expertise;
  final String about;
  final double overallRating;
  final List<RatingExpertDetailsModel> reviews;

  ExpertDetailModel({
    required this.name,
    required this.title,
    required this.qualification,
    required this.profileImageUrl,
    required this.expertise,
    required this.about,
    required this.overallRating,
    required this.reviews,
  });
}

class RatingExpertDetailsModel {
  final String name;
  final String profileImageUrl;
  final int rating; // e.g., 5 for 5 stars
  final String review;

  RatingExpertDetailsModel({
    required this.name,
    required this.profileImageUrl,
    required this.rating,
    required this.review,
  });
}

final List<RatingExpertDetailsModel> reviews = [
  RatingExpertDetailsModel(
    name: "Sarah K.",
    profileImageUrl: "https://randomuser.me/api/portraits/women/65.jpg",
    rating: 5,
    review:
        "John provided invaluable advice for my resume. Highly recommended!",
  ),
  RatingExpertDetailsModel(
    name: "David L.",
    profileImageUrl: "https://randomuser.me/api/portraits/men/46.jpg",
    rating: 4,
    review:
        "Very insightful feedback, helped me a lot with my career decisions.",
  ),
  RatingExpertDetailsModel(
    name: "Emily C.",
    profileImageUrl: "https://randomuser.me/api/portraits/women/48.jpg",
    rating: 5,
    review: "Amazing guidance and quick responses!",
  ),
  RatingExpertDetailsModel(
    name: "Michael B.",
    profileImageUrl: "https://randomuser.me/api/portraits/men/50.jpg",
    rating: 5,
    review:
        "Professional and detailed. My confidence increased after his session.",
  ),
  RatingExpertDetailsModel(
    name: "Sophia W.",
    profileImageUrl: "https://randomuser.me/api/portraits/women/51.jpg",
    rating: 4,
    review: "Helpful suggestions on interview strategies.",
  ),
  RatingExpertDetailsModel(
    name: "James R.",
    profileImageUrl: "https://randomuser.me/api/portraits/men/52.jpg",
    rating: 5,
    review: "John’s mock interviews are spot on!",
  ),
  RatingExpertDetailsModel(
    name: "Olivia P.",
    profileImageUrl: "https://randomuser.me/api/portraits/women/53.jpg",
    rating: 5,
    review: "I landed my dream job thanks to his resume tweaks.",
  ),
  RatingExpertDetailsModel(
    name: "Daniel M.",
    profileImageUrl: "https://randomuser.me/api/portraits/men/54.jpg",
    rating: 4,
    review: "Solid advice, highly recommend connecting with him.",
  ),
  RatingExpertDetailsModel(
    name: "Ava S.",
    profileImageUrl: "https://randomuser.me/api/portraits/women/55.jpg",
    rating: 5,
    review: "He made the resume-building process so easy.",
  ),
  RatingExpertDetailsModel(
    name: "William H.",
    profileImageUrl: "https://randomuser.me/api/portraits/men/56.jpg",
    rating: 5,
    review:
        "Insightful feedback that helped me stand out from other candidates.",
  ),
];
