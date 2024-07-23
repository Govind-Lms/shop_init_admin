import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/cart_model.dart';
import 'package:shop_init_admin/src/core/models/order_model.dart';
import 'package:shop_init_admin/src/presentations/views/notifications/approve_noti.dart';
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

  const ProductsPage({super.key, required this.orderModel});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String? _token;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (value) async {
        await tokenRef.doc('00000001').set({'token': _token});
      },
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      navName(context, '/order');
    });
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
                stream: orderRef
                    .doc(widget.orderModel.uid)
                    .collection("orders")
                    .doc(widget.orderModel.id)
                    .collection('items')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return const EmptyPage();
                    } else {
                      return Builder(
                        builder: (BuildContext context) {
                          List<CartModel> cartLists = [];

                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            cartLists.add(CartModel.fromJson(
                                snapshot.data!.docs[i].data()));
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
                    onTap: () {
                      nav(context,
                          EReceiptScreen(orderModel: widget.orderModel));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.white),
                        color: Theme.of(context).primaryColorDark,
                      ),
                      child: Center(
                        child: Text(
                          'View E Receipt',
                          style: ViceStyle.descStyle
                              .copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      nav(context, DeliveryPage(orderModel: widget.orderModel));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.white),
                        color: Theme.of(context).primaryColorDark,
                      ),
                      child: Center(
                        child: Text(
                          'Delivery',
                          style: ViceStyle.descStyle
                              .copyWith(color: theme.primaryColor),
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
            onTap: () async {

              showDialog(
                  context: context,
                  builder: (context) => ApproveNotiDialog(
                        orderModel: widget.orderModel,
                        token: _token,
                        approveOrReject: "reject",
                      ));


              
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.white),
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
            onTap: () async {
              ///notification sending....
              showDialog(
                  context: context,
                  builder: (context) => ApproveNotiDialog(
                        orderModel: widget.orderModel,
                        token: _token,
                        approveOrReject: "approve",
                      ));
              // sendApproveMessage();

              // await orderRef.doc(widget.orderModel.uid).collection('orders').doc(widget.orderModel.id).update({
              //   'approve' : 'approve',
              // });
              // await orderListRef.doc(widget.orderModel.id).update({
              //   'approve' : 'approve',
              // }).whenComplete((){
              //   navPop(context);
              // });
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.white),
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
