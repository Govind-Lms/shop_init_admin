// import 'dart:async';
// import 'dart:convert';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;
// import 'package:shop_init_admin/src/consts/constant.dart';
// import '../../../../main.dart';
// import 'message.dart';

// String accessToken = "";

// notification(String? token) {
//   return jsonEncode({
//     "message": {
//       "token": token,
//       "notification": {
//         "title": "Breaking News",
//         "body": "New news story available."
//       },
//       "data": {"story_id": "story_12345"},
//       "android": {
//         "notification": {"click_action": "TOP_STORY_ACTIVITY"}
//       },
//       "apns": {
//         "payload": {
//           "aps": {"category": "NEW_MESSAGE_CATEGORY"}
//         }
//       }
//     }
//   });
// }

// /// Renders the example application.
// class Application extends StatefulWidget {
//   const Application({super.key});

//   @override
//   State<StatefulWidget> createState() => _Application();
// }

// class _Application extends State<Application> {
//   String? _token;
//   String? initialMessage;
//   @override
//   void initState() {
//     super.initState();

//     FirebaseMessaging.instance.getInitialMessage().then(
//       (value) async {
//         accessToken = await generateFCMAccessToken();
//         setState(
//         () {
//           initialMessage = value?.data.toString();
//         },
//       );
//       },
//     );

//     FirebaseMessaging.onMessage.listen(showFlutterNotification);

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       Navigator.pushNamed(
//         context,
//         '/orderLists',
//         arguments: MessageArguments(message, true),
//       );
//     });
//   }

//   saveToFirestore(String? token) async {
//     // final id = token.toString().replaceRange(0, 150, "0");
//     await tokenRef.doc('00000001').set({"token": token});
//   }

//   Future<void> sendPushMessage() async {
//     if (_token == null) {
//       print('Unable to send FCM message, no token exists.');
//       return;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $accessToken',
//         },
//         body: notification(
//             "fkXr1l04RjaW2BZd_5mDkF:APA91bE9Bh4gfQ7_IS0LbWqh58zfSRuJS9AOuSauPJIyfEw5DadIFqsG-o4jmPQ7KKaTYXlhGNUIMwW7UGrMfenE3bLDqLbbjO2LpJkdT1L_m5azg3HgByH4Ga97TOEwnc1b5vmX_Tsy"),
//       );
//       print('FCM request for device sent! ');
//       print("Response ${response.statusCode}");
//       print("Response ${response.body}");
//     } catch (e) {
//       print(e);
//     }
//   }

//   static Future<String> generateFCMAccessToken() async {
//     try {
//       /* get these details from the file you downloaded(generated)
//           from firebase console
//       */
//       String type = "service_account";
//       String projectId = "sho-pinit";
//       String privateKeyId = "b1a9cbfa3b763f1d9dc1dd05e288741da54be79b";
//       String privateKey =
//           "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDa61zsgoWkpKMu\ng+KtSZa1EP+kpGTsYgH3Im6HuK/bOVsyvYQJJtFs+Mug6kk5enxoJzLCsnAvKgV5\nOkWIHsuHOw2KmsIzkIkGAfdApSyW61fDSR1fdcaLwkAphn6zeOrDDPAY9NTN+3Ny\nQHNfqoj4lZB3X2Bc2jdxbwr7l83DhEU0MpCuzX3qX3r5ZJhhCHNHVyQENvgNk0tw\nqr4agMHKjYpBgrbip5QL6x+9K00SIS+A+gocC90ou95LutYpcblHoXTv1cLxuK0O\naNoqijXmEoj4ai/m3smX6uKaoUhDMB/CSJuJUC4O/q3GQbro/Azt+EzKRoJ5Lf2V\n1iK6fzc7AgMBAAECggEAGO+gSQxg/q0GLWE2a7irIvrJs85J9KcBRE42utztoxH4\ncmIl7Qjv5/K69xxYtORf0VlNreG3Z5fowbNCgkvHsSKn2zbfkhIPmZCVwlZOKu6p\ns4PbhakbsYWx20kHm5fVXdxWaPFSYBgZQVVYDviU24PlzcMebdUpZZFZdekHthJf\n+3X52tigujLJ1J6xOfkAhnyUyFdQ8PZWuQlDBXo8HTzm9RhXTbjV3T18mYuop3yj\ngeZyJ94sgb+B9fnsGf/xxzILoLEyK9xi7zh4PH+qOjXYyYcZLwrMdCfDMOLa8gTl\n5nyprdjWfCEBWRFc4wzyQTmauvR5FpyGHosraZyx+QKBgQD1yHpkDKrBGriOKh4t\niroFo3UR+yTlZXoaDkwe+J4otweNCWjabR/FCPGm0P7DGuWQsL08jBN7EtjWHMyg\nvtP4Q44RIkXNFVpe+qbzHW5rRFhNL9JG4C/A3DmKFaOeGxerf7hgS+DtRNGZARR9\nsLh49aGtdK3CK2ts17RHsOi3JQKBgQDkBQMg+s1CQKpRr89j6956RxTiTT4PxDWZ\nPvq5GfRgPGaJEU4TiDcy+WUFl8Tlw5x/0/oifw1kYsWnDEOP61oZy/GMYYtV4Vso\nMkyI84dyo6U2NxcuzuxeMZ7H/Cij2dfqsjQLjgGbFdhB3Q4IokU/dyAzSoNQ/A1e\nVEI65RiW3wKBgC4lux0n57OkIbzHmazxXCYM38FFh1Lu77MOtiomggOhAfDwMFi6\nnnlvSXgJy5u0ZB/7nzxMDKhSDJZ/B8iyq7f0bys2ZSaxeKtWopwJDZ9kULQFY5Td\nKPosHz2W/IaGDbasn2CtPokuH7B7rG5BDRHhBL89phZL8rqX8Yh4ZellAoGAHqqF\n5zOT02s6/M12SOv5+dwBdQYKaLhstPWBZs+UzDSTXa/UHlBdjB96dKwasQQD0jVC\nGM2ZkXyvNG4zz/FJJtsE22prANvUFK3fGTQXbVWQ7J+wIH130Js/zYmeNZsgrNHW\nqg8pLCBd+02ti3+3bHeq/vrwej3L1nnihmU1T2UCgYBaifUgpCsTTz/0m7R3Dl09\nlCYwtQPDEodIMyi0QD24PpRBHwb8XekqbZtf07FDmdtBCXWv8a8VdctHPqqmxHEz\nN1lGJHPBa+S/SyYmGKrZ0yRw8l6C1ss9ikeVL/SOaA2w5ibpdcbM8MzMG+/pyiAR\n3Vz481WXLjMVtvEXHqmmZA==\n-----END PRIVATE KEY-----\n";
//       String clientEmail =
//           "firebase-adminsdk-zmfop@sho-pinit.iam.gserviceaccount.com";
//       String clientId = "100577609957653481302";
//       String authUri = "https://accounts.google.com/o/oauth2/auth";
//       String tokenUri = "https://oauth2.googleapis.com/token";
//       String authProviderX509CertUrl =
//           "https://www.googleapis.com/oauth2/v1/certs";
//       String clientX509CertUrl =
//           "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-zmfop%40sho-pinit.iam.gserviceaccount.com";
//       String universeDomain = "googleapis.com";

//       final credentials = ServiceAccountCredentials.fromJson({
//         "type": type,
//         "project_id": projectId,
//         "private_key_id": privateKeyId,
//         "client_email": clientEmail,
//         "private_key": privateKey,
//         "client_id": clientId,
//         "auth_uri": authUri,
//         "token_uri": tokenUri,
//         "auth_provider_x509_cert_url": authProviderX509CertUrl,
//         "client_x509_cert_url": clientX509CertUrl,
//         "universe_domain": universeDomain
//       });

//       List<String> scopes = [
//         "https://www.googleapis.com/auth/firebase.messaging"
//       ];

//       final client = await obtainAccessCredentialsViaServiceAccount(
//           credentials, scopes, http.Client());
//       final accessToken = client;
//       Timer.periodic(const Duration(minutes: 59), (timer) {
//         accessToken.refreshToken;
//       });
//       return accessToken.accessToken.data;
//     } catch (e) {
//       print("THis is the error: $e");
//     }
//     return "";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cloud Messaging'),
//       ),
//       floatingActionButton: Builder(
//         builder: (context) => FloatingActionButton(
//           onPressed: () async {
//             sendPushMessage();
//             // saveToFirestore(_token);
//           },
//           backgroundColor: Colors.white,
//           child: const Icon(Icons.send),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
//               child: Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(bottom: 16),
//                         child: const Text("FCM Token", style: TextStyle(fontSize: 18)),
//                       ),
//                       Expanded(
//                         child: TokenMonitor((token) {
//                           _token = token;
//                           return token == null
//                               ? const CircularProgressIndicator()
//                               : SelectableText(
//                                   token,
//                                   style: const TextStyle(fontSize: 12),
//                                 );
//                         }),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
            
//           ],
//         ),
//       ),
//     );
//   }
// }
