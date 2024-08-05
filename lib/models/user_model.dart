class UserModel {
  String? id;
  String name;
  String email;
  String country;
  String gender;
  String language;
  int level;
  int coin;
  int totalTalkTime;
  int totalCall;
  int totalReview;
  String aboutMe;
  String image;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.gender,
    required this.language,
    required this.level,
    required this.coin,
    required this.totalTalkTime,
    required this.totalCall,
    required this.totalReview,
    required this.aboutMe,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'country': country,
      'gender': gender,
      'language': language,
      'level': level,
      'coin': coin,
      'totalTalkTime': totalTalkTime,
      'totalCall': totalCall,
      'totalReview': totalReview,
      'aboutMe': aboutMe,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      country: map['country'],
      gender: map['gender'],
      language: map['language'],
      level: map['level'],
      coin: map['coin'],
      totalTalkTime: map['totalTalkTime'],
      totalCall: map['totalCall'],
      totalReview: map['totalReview'],
      aboutMe: map['aboutMe'],
      image: map['image'],
    );
  }
}
