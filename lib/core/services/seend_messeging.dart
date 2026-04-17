import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

Future<String> getToken() async {
  final jsonString = await rootBundle.loadString(
    'assets/chatapp-6d87b-3a0704778052.json',
  );
  final accountCredentials = auth.ServiceAccountCredentials.fromJson(
    jsonString,
  );
  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  final client = await auth.clientViaServiceAccount(accountCredentials, scopes);
  return client.credentials.accessToken.data;
}

Future<void> sendNotification({
  required String chatId,
  required String message,
  required String fcmToken,
  required String senderId,
}) async {
  final token = await getToken();

  try {
    final body = {
      "message": {
        "token": fcmToken,
        "notification": {"title": "New Message", "body": message},
        "data": {
          "type": "chat",
          "chatId": chatId,
          "senderId": senderId,
          "message": message,
        },
        'android': {
          'notification': {
            "sound": "custom_sound",
            'click_action':
                'FLUTTER_NOTIFICATION_CLICK', // Required for tapping to trigger response
            'channel_id': 'high_importance_channel',
          },
        },
      },
    };

    final response = await Dio().post(
      "https://fcm.googleapis.com/v1/projects/chatapp-6d87b/messages:send",
      data: body,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    debugPrint(response.data.toString());
  } catch (e) {
    debugPrint(e.toString());
  }
}
