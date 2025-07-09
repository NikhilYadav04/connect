// lib/models/review.dart

class Review {
  final String author;
  final double rating;
  final String comment;
  final DateTime date;

  Review({
    required this.author,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

//* Sample data: 50 reviews
final List<Review> recentReviews = List.generate(50, (i) {
  final authors = ['John D.', 'Sarah M.', 'Mike R.', 'Alice W.', 'David K.'];
  final author = authors[i % authors.length];
  final baseRating = 3 + (i % 3); // 3,4,5 repetitive
  final rating = baseRating + (i.isEven ? 0.0 : 0.5);
  final comment = [
    'Excellent advice on product strategy.',
    'Very insightful session!',
    'Great UI/UX best‑practices tips.',
    'Helped solve our development challenges.',
    'Would highly recommend!'
  ][i % 5];
  final date = DateTime(2024, 1, 1).add(Duration(days: i));

  return Review(
    author: author,
    rating: rating,
    comment: comment,
    date: date,
  );
});

//* If you just need a list of author‑names:
final List<String> recentReviewNames =
    recentReviews.map((r) => r.author).toList();
