

import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/cart_model.dart';
import 'package:shop_init_admin/src/core/models/order_model.dart';
import 'package:shop_init_admin/src/presentations/views/notifications/message.dart';
import 'package:shop_init_admin/src/presentations/views/orders/components/product_part.dart';
import 'package:shop_init_admin/src/presentations/views/orders/pages/delivery_page.dart';
import 'package:shop_init_admin/src/presentations/views/orders/pages/e_receipt_page.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';
import 'package:shop_init_admin/src/presentations/widgets/empty.dart';

import '../../../../../main.dart';
import '../../../../consts/constant.dart';

class ProductsPage extends StatefulWidget {
  final OrderModel orderModel;
  
  const ProductsPage({super.key,required this.orderModel});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  String? _token;
  String? _targetToken;
  List<String> tokens= [];
  late Stream<String> _tokenStream;

  void setToken(String? token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (value) async {
        accessToken = await generateFCMAccessToken();

        final data = await tokenRef.doc(widget.orderModel.uid).collection("tokens").get();
        
        _targetToken = data.docs[0].get('token');

        FirebaseMessaging.instance.getToken();
        _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
        _tokenStream.listen(setToken);

        await tokenRef.doc('00000001').set({'token':_token});
        print("Token In InitState : $_token");
        
      },
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(
        context,
        '/order',
        arguments: MessageArguments(message, true),
      );
    });
  }
 
  
  static Future<String> generateFCMAccessToken() async {
    try {
     
      String type = "service_account";
      String projectId = "sho-pinit";
      String privateKeyId = "b1a9cbfa3b763f1d9dc1dd05e288741da54be79b";
      String privateKey =
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDa61zsgoWkpKMu\ng+KtSZa1EP+kpGTsYgH3Im6HuK/bOVsyvYQJJtFs+Mug6kk5enxoJzLCsnAvKgV5\nOkWIHsuHOw2KmsIzkIkGAfdApSyW61fDSR1fdcaLwkAphn6zeOrDDPAY9NTN+3Ny\nQHNfqoj4lZB3X2Bc2jdxbwr7l83DhEU0MpCuzX3qX3r5ZJhhCHNHVyQENvgNk0tw\nqr4agMHKjYpBgrbip5QL6x+9K00SIS+A+gocC90ou95LutYpcblHoXTv1cLxuK0O\naNoqijXmEoj4ai/m3smX6uKaoUhDMB/CSJuJUC4O/q3GQbro/Azt+EzKRoJ5Lf2V\n1iK6fzc7AgMBAAECggEAGO+gSQxg/q0GLWE2a7irIvrJs85J9KcBRE42utztoxH4\ncmIl7Qjv5/K69xxYtORf0VlNreG3Z5fowbNCgkvHsSKn2zbfkhIPmZCVwlZOKu6p\ns4PbhakbsYWx20kHm5fVXdxWaPFSYBgZQVVYDviU24PlzcMebdUpZZFZdekHthJf\n+3X52tigujLJ1J6xOfkAhnyUyFdQ8PZWuQlDBXo8HTzm9RhXTbjV3T18mYuop3yj\ngeZyJ94sgb+B9fnsGf/xxzILoLEyK9xi7zh4PH+qOjXYyYcZLwrMdCfDMOLa8gTl\n5nyprdjWfCEBWRFc4wzyQTmauvR5FpyGHosraZyx+QKBgQD1yHpkDKrBGriOKh4t\niroFo3UR+yTlZXoaDkwe+J4otweNCWjabR/FCPGm0P7DGuWQsL08jBN7EtjWHMyg\nvtP4Q44RIkXNFVpe+qbzHW5rRFhNL9JG4C/A3DmKFaOeGxerf7hgS+DtRNGZARR9\nsLh49aGtdK3CK2ts17RHsOi3JQKBgQDkBQMg+s1CQKpRr89j6956RxTiTT4PxDWZ\nPvq5GfRgPGaJEU4TiDcy+WUFl8Tlw5x/0/oifw1kYsWnDEOP61oZy/GMYYtV4Vso\nMkyI84dyo6U2NxcuzuxeMZ7H/Cij2dfqsjQLjgGbFdhB3Q4IokU/dyAzSoNQ/A1e\nVEI65RiW3wKBgC4lux0n57OkIbzHmazxXCYM38FFh1Lu77MOtiomggOhAfDwMFi6\nnnlvSXgJy5u0ZB/7nzxMDKhSDJZ/B8iyq7f0bys2ZSaxeKtWopwJDZ9kULQFY5Td\nKPosHz2W/IaGDbasn2CtPokuH7B7rG5BDRHhBL89phZL8rqX8Yh4ZellAoGAHqqF\n5zOT02s6/M12SOv5+dwBdQYKaLhstPWBZs+UzDSTXa/UHlBdjB96dKwasQQD0jVC\nGM2ZkXyvNG4zz/FJJtsE22prANvUFK3fGTQXbVWQ7J+wIH130Js/zYmeNZsgrNHW\nqg8pLCBd+02ti3+3bHeq/vrwej3L1nnihmU1T2UCgYBaifUgpCsTTz/0m7R3Dl09\nlCYwtQPDEodIMyi0QD24PpRBHwb8XekqbZtf07FDmdtBCXWv8a8VdctHPqqmxHEz\nN1lGJHPBa+S/SyYmGKrZ0yRw8l6C1ss9ikeVL/SOaA2w5ibpdcbM8MzMG+/pyiAR\n3Vz481WXLjMVtvEXHqmmZA==\n-----END PRIVATE KEY-----\n";
      String clientEmail =
          "firebase-adminsdk-zmfop@sho-pinit.iam.gserviceaccount.com";
      String clientId = "100577609957653481302";
      String authUri = "https://accounts.google.com/o/oauth2/auth";
      String tokenUri = "https://oauth2.googleapis.com/token";
      String authProviderX509CertUrl =
          "https://www.googleapis.com/oauth2/v1/certs";
      String clientX509CertUrl =
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-zmfop%40sho-pinit.iam.gserviceaccount.com";
      String universeDomain = "googleapis.com";

      final credentials = ServiceAccountCredentials.fromJson({
        "type": type,
        "project_id": projectId,
        "private_key_id": privateKeyId,
        "client_email": clientEmail,
        "private_key": privateKey,
        "client_id": clientId,
        "auth_uri": authUri,
        "token_uri": tokenUri,
        "auth_provider_x509_cert_url": authProviderX509CertUrl,
        "client_x509_cert_url": clientX509CertUrl,
        "universe_domain": universeDomain
      });

      List<String> scopes = [
        "https://www.googleapis.com/auth/firebase.messaging"
      ];

      final client = await obtainAccessCredentialsViaServiceAccount(
          credentials, scopes, http.Client());
      final accessToken = client;
      Timer.periodic(const Duration(minutes: 59), (timer) {
        accessToken.refreshToken;
      });
      return accessToken.accessToken.data;
    } catch (e) {
      print("THis is the error: $e");
    }
    return "";
  }


  Future<void> sendApproveMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }
    try {
      final response = await http.post(
       Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body:jsonEncode({
          "message": {
            "token": _targetToken,
            "notification": {
              "title": "Order Approval",
              "body": "Your order with order no: ${widget.orderModel.id} has been approved."
            },
            "data": {"story_id": widget.orderModel.id},
            "android": {
              "notification": {"click_action": "new order placed"}
            },
          }
        }),
      );
      print("Response ${response.statusCode}");
      print("Response ${response.body}");
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendRejectMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body:jsonEncode({
          "message": {
            "token": _targetToken,
            "notification": {
              "title": "Order Rejection",
              "body": "Your order with order no: ${widget.orderModel.id} has been rejected."
            },
            "data": {"story_id": widget.orderModel.id},
            "android": {
              "notification": {"click_action": "new order placed"}
            },
          }
        }),
      );
      print("Response ${response.statusCode}");
      print("Response ${response.body}");
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(
                isAnimated: false,
                showSearchBar: false,
                showDefinedName: true,
                name: 'Products Details',
                isfilterOn: false,
                showBack: true,
                showColor: false,
              ),
              StreamBuilder(
                stream: orderRef.doc(widget.orderModel.uid).collection("orders").doc(widget.orderModel.id).collection('items').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    if(snapshot.data!.docs.isEmpty){
                      return const EmptyPage();
                    }
                    else{
                      return Builder(
                        builder: (BuildContext context) {
                          List<CartModel> cartLists =[];
                        
                          for(int i =0;i<snapshot.data!.docs.length; i++){
                            cartLists.add(CartModel.fromJson(snapshot.data!.docs[i].data()));
                          }
                
                          return ProductPart(
                            cartLists: cartLists,
                            totalQty: widget.orderModel.totalQty,
                            total: widget.orderModel.totalAmt,
                          );
                        },
                      );
                    }
                    
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      nav(context, EReceiptScreen(orderModel: widget.orderModel));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2,color: Colors.white),
                        color: Theme.of(context).primaryColorDark,
                      ),
                      child: Center(
                        child: Text(
                          'View E Receipt',
                          style: ViceStyle.descStyle.copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      nav(context, DeliveryPage(orderModel: widget.orderModel));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2,color: Colors.white),
                        color: Theme.of(context).primaryColorDark,
                      ),
                      child: Center(
                        child: Text(
                          'Delivery',
                          style: ViceStyle.descStyle.copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          
          
          
              TokenMonitor((token) {
                    _token = token;
                    
                    return token == null
                        ? const CircularProgressIndicator()
                        : Container();
                  }),
          
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          
          InkWell(
            onTap: ()async{
              
              ///notification sending....
              sendRejectMessage();
      
              await orderRef.doc(widget.orderModel.uid).collection('orders').doc(widget.orderModel.id).update({
                'approve' : 'reject',
              });
              await orderListRef.doc(widget.orderModel.id).update({
                'approve' : 'reject',
              }).whenComplete((){
                navPop(context);
              });
      
      
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2,color: Colors.white),
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  'Reject',
                  style: ViceStyle.descStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          const Spacer(),
           InkWell(
            onTap: ()async{
              ///notification sending....
              sendApproveMessage();
      
              await orderRef.doc(widget.orderModel.uid).collection('orders').doc(widget.orderModel.id).update({
                'approve' : 'approve',
              });
              await orderListRef.doc(widget.orderModel.id).update({
                'approve' : 'approve',
              }).whenComplete((){
                navPop(context);
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2,color: Colors.white),
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'Approve',
                  style: ViceStyle.descStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
      
        ],
      ),
    );
  }
}