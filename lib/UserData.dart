class UserData {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? lastSeenTime;
  String? avatar;
  String? status;
  int? messages;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.lastSeenTime,
    this.avatar,
    this.status,
    this.messages,

  });

  UserData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    lastSeenTime = json['last_seen_time'];
    avatar = json['avatar'];
    messages = json['messages'];
  }
}