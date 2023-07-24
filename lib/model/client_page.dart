import 'dart:convert';

class Client {
  int id;
  String fname;
  String lname;
  int phoneNo;
  int massageNo;
  String email;

  Client({
    required this.id,
    required this.fname,
    required this.lname,
    required this.phoneNo,
    required this.massageNo,
    required this.email,
  });

  factory Client.fromJson(String str) =>
      Client.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Client.fromMap(Map<String, dynamic> json) => Client(
        id: json["id"],
        fname: json["fname"],
        lname: json["lname"],
        phoneNo: json["phoneNO"],
        massageNo: json["massageNO"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "phoneNO": phoneNo,
        "massageNO": massageNo,
        "email": email,
      };
}


class FollowUP {
  int id;
  String message;
  String actions;
  DateTime dateSent;
  bool done;
  int client;

  FollowUP({
    required this.id,
    required this.message,
    required this.actions,
    required this.dateSent,
    required this.done,
    required this.client,
  });

  factory FollowUP.fromJson(String str) => FollowUP.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FollowUP.fromMap(Map<String, dynamic> json) => FollowUP(
    id: json["id"],
    message: json["message"],
    actions: json["actions"],
    dateSent: DateTime.parse(json["date_sent"]),
    done: json["done"],
    client: json["client"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "message": message,
    "actions": actions,
    "date_sent": dateSent.toIso8601String(),
    "done": done,
    "client": client,
  };
}
class CreateFollowUP {
  // int id;
  String message;
  String actions;
  DateTime dateSent;
  // bool done;
  int client;

  CreateFollowUP({
    // required this.id,
    required this.message,
    required this.actions,
    required this.dateSent,
    // required this.done,
    required this.client,
  });

  factory CreateFollowUP.fromJson(String str) => CreateFollowUP.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateFollowUP.fromMap(Map<String, dynamic> json) => CreateFollowUP(
    // id: json["id"],
    message: json["message"],
    actions: json["actions"],
    dateSent: DateTime.parse(json["date_sent"]),
    // done: json["done"],
    client: json["client"],
  );

  Map<String, dynamic> toMap() => {
    // "id": id,
    "message": message,
    "actions": actions,
    "date_sent": dateSent.toIso8601String(),
    // "done": done,
    "client": client,
  };
}
