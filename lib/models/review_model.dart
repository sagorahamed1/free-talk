class ReviewModel {
  String? description;
  String feeling;
  String rating;
  String reviewId;
  String reviewName;
  String time;
  String image;

  ReviewModel({
    this.description,
    required this.feeling,
    required this.rating,
    required this.reviewId,
    required this.reviewName,
    required this.time,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'feeling': feeling,
      'rating': rating,
      'reviewId': reviewId,
      'reviewName': reviewName,
      'time': time,
      'image': image,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      description: map['description'] ?? '', // Default to empty string if null
      feeling: map['feeling'] ?? '',         // Default to empty string if null
      rating: map['rating'] ?? '0',           // Default rating to '0' if null
      reviewId: map['reviewId'] ?? '',       // Default to empty string if null
      reviewName: map['reviewName'] ?? '',   // Default to empty string if null
      time: map['time'] ?? DateTime.now().toString(), // Default to now if null
      image: map['image'] ?? '',              // Default to empty string if null
    );
  }
}
