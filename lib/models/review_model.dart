class ReviewModel {
  String? description;
  String feeling;
  String rating;
  String reviewId;
  String reviewName;
  String time;


  ReviewModel({
    this.description,
    required this.feeling,
    required this.rating,
    required this.reviewId,
    required this.reviewName,
    required this.time

  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'feeling': feeling,
      'rating': rating,
      'reviewId': reviewId,
      'reviewName': reviewName,
      'time': time,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      description: map['description'],
      feeling: map['feeling'],
      rating: map['rating'],
      reviewId: map['reviewId'],
      reviewName: map['reviewName'],
      time: map['time'],
    );
  }
}
