import 'package:connectycube_sdk/connectycube_pushnotifications.dart';

class FCMManager {

  static void sendPushNotificationFromChat(String dialogId, String message, int senderId, int targetId, String fullName) {
    CreateEventParams params = CreateEventParams();
    params.parameters = {
      "message": message,
      "dialogId": dialogId,
      "notificationType": "chat",
      "fullName": fullName,
      "senderId" : senderId
      // 'ios_voip': 1
      // to send VoIP push notification to iOS
      //more standard parameters you can found by link https://developers.connectycube.com/server/push_notifications?id=universal-push-notifications
    };

    params.notificationType = NotificationType.PUSH;
    params.environment = CubeEnvironment.PRODUCTION;
    params.usersIds = [targetId];

    createEvent(params.getEventForRequest()).then((cubeEvent) {}).catchError((error) {
    });
  }
}