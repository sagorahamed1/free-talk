class ReviewModel {
  String? description;
  String feeling;
  String image;
  String rating;
  String reviewId;
  DateTime reviewName;


  ReviewModel({
    this.description,
    required this.feeling,
    required this.image,
    required this.rating,
    required this.reviewId,
    required this.reviewName,

  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'feeling': feeling,
      'image': image,
      'rating': rating,
      'reviewId': reviewId,
      'reviewName': reviewName,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      description: map['description'],
      feeling: map['feeling'],
      image: map['image'],
      rating: map['rating'],
      reviewId: map['reviewId'],
      reviewName: map['reviewName'],
    );
  }
}
