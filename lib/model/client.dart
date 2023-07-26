import 'dart:convert';
//
// class Client {
//   int id;
//   String fname;
//   String lname;
//   int phoneNo;
//   int massageNo;
//   String email;
//
//   Client({
//     required this.id,
//     required this.fname,
//     required this.lname,
//     required this.phoneNo,
//     required this.massageNo,
//     required this.email,
//   });
//
//   factory Client.fromJson(String str) =>
//       Client.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Client.fromMap(Map<String, dynamic> json) => Client(
//         id: json["id"],
//         fname: json["fname"],
//         lname: json["lname"],
//         phoneNo: json["phoneNO"],
//         massageNo: json["massageNO"],
//         email: json["email"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "fname": fname,
//         "lname": lname,
//         "phoneNO": phoneNo,
//         "massageNO": massageNo,
//         "email": email,
//       };
// }
//
//
// class FollowUP {
//   int id;
//   String message;
//   String actions;
//   DateTime dateSent;
//   bool done;
//   int client;
//
//   FollowUP({
//     required this.id,
//     required this.message,
//     required this.actions,
//     required this.dateSent,
//     required this.done,
//     required this.client,
//   });
//
//   factory FollowUP.fromJson(String str) => FollowUP.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory FollowUP.fromMap(Map<String, dynamic> json) => FollowUP(
//     id: json["id"],
//     message: json["message"],
//     actions: json["actions"],
//     dateSent: DateTime.parse(json["date_sent"]),
//     done: json["done"],
//     client: json["client"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "message": message,
//     "actions": actions,
//     "date_sent": dateSent.toIso8601String(),
//     "done": done,
//     "client": client,
//   };
// }
// class CreateFollowUP {
//   // int id;
//   String message;
//   String actions;
//   DateTime dateSent;
//   // bool done;
//   int client;
//
//   CreateFollowUP({
//     // required this.id,
//     required this.message,
//     required this.actions,
//     required this.dateSent,
//     // required this.done,
//     required this.client,
//   });
//
//   factory CreateFollowUP.fromJson(String str) => CreateFollowUP.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory CreateFollowUP.fromMap(Map<String, dynamic> json) => CreateFollowUP(
//     // id: json["id"],
//     message: json["message"],
//     actions: json["actions"],
//     dateSent: DateTime.parse(json["date_sent"]),
//     // done: json["done"],
//     client: json["client"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     // "id": id,
//     "message": message,
//     "actions": actions,
//     "date_sent": dateSent.toIso8601String(),
//     // "done": done,
//     "client": client,
//   };
// }

// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  int id;
  String fname;
  String lname;
  int phoneNo;
  int massageNo;
  String email;
  List<Followup> followups;
  List<Feedbacks> feedback;

  Client({
    required this.id,
    required this.fname,
    required this.lname,
    required this.phoneNo,
    required this.massageNo,
    required this.email,
    required this.followups,
    required this.feedback,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    fname: json["fname"],
    lname: json["lname"],
    phoneNo: json["phoneNO"],
    massageNo: json["massageNO"],
    email: json["email"],
    followups: List<Followup>.from(json["followups"].map((x) => Followup.fromJson(x))),
    feedback: List<Feedbacks>.from(json["feedback"].map((x) => Feedbacks.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fname": fname,
    "lname": lname,
    "phoneNO": phoneNo,
    "massageNO": massageNo,
    "email": email,
    "followups": List<dynamic>.from(followups.map((x) => x.toJson())),
    "feedback": List<dynamic>.from(feedback.map((x) => x.toJson())),
  };
}

class Feedbacks {
  int id;
  String response;
  String message;
  int followUp;

  Feedbacks({
    required this.id,
    required this.response,
    required this.message,
    required this.followUp,
  });

  factory Feedbacks.fromJson(Map<String, dynamic> json) => Feedbacks(
    id: json["id"],
    response: json["response"],
    message: json["message"],
    followUp: json["follow_up"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "response": response,
    "message": message,
    "follow_up": followUp,
  };
}

class Followup {
  int id;
  String message;
  String actions;
  DateTime dateSent;
  bool done;
  int client;

  Followup({
    required this.id,
    required this.message,
    required this.actions,
    required this.dateSent,
    required this.done,
    required this.client,
  });

  factory Followup.fromJson(Map<String, dynamic> json) => Followup(
    id: json["id"],
    message: json["message"],
    actions: json["actions"],
    dateSent: DateTime.parse(json["date_sent"]),
    done: json["done"],
    client: json["client"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "actions": actions,
    "date_sent": dateSent.toIso8601String(),
    "done": done,
    "client": client,
  };
}

List<Clients> clientsFromJson(String str) => List<Clients>.from(json.decode(str).map((x) => Clients.fromJson(x)));

String clientsToJson(List<Clients> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Clients {
  int id;
  String fname;
  String lname;
  int phoneNo;
  int massageNo;
  String email;

  Clients({
    required this.id,
    required this.fname,
    required this.lname,
    required this.phoneNo,
    required this.massageNo,
    required this.email,
  });

  factory Clients.fromJson(Map<String, dynamic> json) => Clients(
    id: json["id"],
    fname: json["fname"],
    lname: json["lname"],
    phoneNo: json["phoneNO"],
    massageNo: json["massageNO"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fname": fname,
    "lname": lname,
    "phoneNO": phoneNo,
    "massageNO": massageNo,
    "email": email,
  };
}
