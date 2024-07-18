import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';
import 'package:shop_init_admin/src/presentations/widgets/empty.dart';

import '../../../../consts/constant.dart';
import '../../../../core/models/order_model.dart';
import '../components/order_id_part.dart';
import 'product_details_page.dart';

class OrdersPage extends StatelessWidget {
  final String userId;
  const OrdersPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              name: 'Orders',
              showBack: true,
              isfilterOn: false,
              showColor: false,
            ),
            Expanded(
              child: StreamBuilder(
                stream: orderRef.doc(userId).collection("orders").snapshots(),
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
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                        
                          final orderModel = OrderModel.fromJson(snapshot.data!.docs[index].data());
                          return InkWell(
                            onTap: (){
                              nav(context, ProductsPage(orderModel: orderModel,));
                            },
                            child: OrderIdPart(
                              orderModel: orderModel,
                            )
                          );
                        }
                      
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


