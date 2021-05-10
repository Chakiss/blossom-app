class ChatDialogModel {
  String dialogId;
  int userId;
  int unreadMessageCount;
  String name;
  List<int> occupantsIds;
  int occupantsCount;

  ChatDialogModel(
      {this.dialogId, this.userId, this.unreadMessageCount, this.name, this.occupantsIds, this.occupantsCount});

  factory ChatDialogModel.fromJson(Map<String, dynamic> json) {
    return ChatDialogModel(
      dialogId: json["dialogId"],
      userId: json["userId"],
      unreadMessageCount: json["unreadMessageCount"],
      name: json["name"],
      occupantsIds: json["occupantsIds"],
      occupantsCount: json["occupantsCount"],
    );
  }
}
