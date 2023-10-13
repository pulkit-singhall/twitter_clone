class UserModel {
  final String name;
  final String email;
  final List<String> followers; // stored by their uid
  final List<String> following;
  final String profilePicture;
  final String bannerPicture;
  final String uid;
  final String bio;
  final bool isTwitterBlue;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.bannerPicture,
    required this.bio,
    required this.followers,
    required this.following,
    required this.isTwitterBlue,
    required this.profilePicture,
  });


}
