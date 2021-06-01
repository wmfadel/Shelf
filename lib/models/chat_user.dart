class ChatUser {
  late String id;
  late String name;
  late String email;
  late String photo;

  ChatUser.otherUser(Map<String, dynamic> json) {
    id = json['oUser'];
    name = json['oName'];
    email = json['oEmail'];
    photo = json['oPhoto'];
  }

  ChatUser.user(Map<String, dynamic> json) {
    id = json['user'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }
}
