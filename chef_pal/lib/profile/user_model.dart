class UserData {
  final String uid;
  String username, diet;
  Map<String, dynamic> intolerences;
  UserData({this.uid, this.username, this.diet, this.intolerences});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'intolerences': intolerences,
      'diet': diet,
    };
  }
}
