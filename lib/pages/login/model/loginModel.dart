class LoginUser {
  String userID;
  SubscribeModel subscribe;

  LoginUser({this.userID, this.subscribe});

  factory LoginUser.fromJson(Map<String, dynamic> json) => new LoginUser(
        userID: json['userID'],
        subscribe: SubscribeModel.fromJson(json["subscribe"]),
      );
}

class SubscribeModel {
  List<String> komik;
  List<String> parenting;

  SubscribeModel({this.komik, this.parenting});

  factory SubscribeModel.fromJson(Map<String, dynamic> json) =>
      new SubscribeModel(
        komik: new List<String>.from(json["komik"]),
        parenting: new List<String>.from(json["parenting"]),
      );
}
