class ReviewModel {
  String? id;
  String name;
  String image;
  double rating;
  String reviewMessage;
  DateTime time;
  int like;

  ReviewModel({
    this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.reviewMessage,
    required this.time,
    required this.like,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'reviewMessage': reviewMessage,
      'time': time.toIso8601String(),
      'like': like,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      rating: map['rating'],
      reviewMessage: map['reviewMessage'],
      time: DateTime.parse(map['time']),
      like: map['like'],
    );
  }
}
