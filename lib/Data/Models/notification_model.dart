class NotificationModel {
  List<Message>? message;
  List<bool>? isSeens;
  List<int>? ids;

  NotificationModel({this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(Message.fromJson(v));
        isSeens = <bool>[];
        ids = <int>[];
        for (Message see in message!) {
          if (see.isSeen == false) {
            isSeens!.add(see.isSeen!);
            ids!.add(see.id!);
          }
        }
      });
    }
  }
}

class Message {
  int? id;
  String? dateCreated;
  String? timeCreated;
  bool? isSeen;
  String? title;
  String? body;
  int? user;
  DateTime? dateTime;

  Message({this.id, this.isSeen, this.title, this.body, this.user});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSeen = json['is_seen'];
    title = json['title'];
    body = json['body'];
    // timestamp = json['timestamp'];
    user = json['user'];
    dateTime = DateTime.parse(json['timestamp']);
    dateCreated = "${dateTime!.year}-${dateTime!.month}-${dateTime!.day}";
    if (dateTime!.hour > 12) {
      timeCreated = "${dateTime!.hour - 12}:${dateTime!.minute}:PM";
    } else {
      timeCreated = "${dateTime!.hour}:${dateTime!.minute}:AM";
    }
  }
}
