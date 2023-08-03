import 'dart:convert';

List<FollowupNotification> followupNotificationFromJson(String str) => List<FollowupNotification>.from(json.decode(str).map((x) => FollowupNotification.fromJson(x)));

String followupNotificationToJson(List<FollowupNotification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FollowupNotification {
  int client;
  String message;
  String actions;
  DateTime dateSent;
  bool done;
  String fname;
  String lname;

  FollowupNotification({
    required this.client,
    required this.message,
    required this.actions,
    required this.dateSent,
    required this.done,
    required this.fname,
    required this.lname,
  });

  factory FollowupNotification.fromJson(Map<String, dynamic> json) => FollowupNotification(
    client: json["client"],
    message: json["message"],
    actions: json["actions"],
    dateSent: DateTime.parse(json["date_sent"]),
    done: json["done"],
    fname: json["fname"],
    lname: json["lname"],
  );

  Map<String, dynamic> toJson() => {
    "client": client,
    "message": message,
    "actions": actions,
    "date_sent": dateSent.toIso8601String(),
    "done": done,
    "fname": fname,
    "lname": lname,
  };
}
