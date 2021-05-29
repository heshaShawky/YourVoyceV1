class NotificationsNewUpdate {
  int statusCode;
  Body body;

  NotificationsNewUpdate({this.statusCode, this.body});

  NotificationsNewUpdate.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }
}

class Body {
  int notifications;
  int friendRequests;
  int messages;

  Body({this.notifications, this.friendRequests, this.messages});

  Body.fromJson(Map<String, dynamic> json) {
    notifications = json['notifications'];
    friendRequests = json['friend_requests'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notifications'] = this.notifications;
    data['friend_requests'] = this.friendRequests;
    data['messages'] = this.messages;
    return data;
  }
}
