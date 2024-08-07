class UserProfile {
  final String aboutMe;
  final String coin;
  final String country;
  final String email;
  final String gender;
  final String image;
  final String label;
  final String name;
  final String totalCall;
  final String totalTalkTime;
  final String totalReviews;

  UserProfile({
    this.aboutMe = '',
    this.coin = '',
    this.country = '',
    this.email = '',
    this.gender = '',
    this.image = '',
    this.label = '',
    this.name = '',
    this.totalCall = '',
    this.totalTalkTime = '',
    this.totalReviews = '',
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      aboutMe: map['about_me'] ?? '',
      coin: map['coin'] ?? '',
      country: map['country'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
      label: map['label'] ?? '',
      name: map['name'] ?? '',
      totalCall: map['total_call'] ?? '',
      totalTalkTime: map['total_talk_time'] ?? '',
      totalReviews: map['total_review'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'about_me': aboutMe,
      'coin': coin,
      'country': country,
      'email': email,
      'gender': gender,
      'image': image,
      'label': label,
      'name': name,
      'total_call': totalCall,
      'total_talk_time': totalTalkTime,
      'total_review': totalReviews,
    };
  }
}
