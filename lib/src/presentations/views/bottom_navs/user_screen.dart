import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/core/models/seller_model.dart';
import 'package:shop_init_admin/src/presentations/views/orders/components/user_id_page.dart';
import 'package:shop_init_admin/src/presentations/views/orders/pages/order_list_page.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              name: 'User Details',
              showBack: true,
              isfilterOn: false,
              showColor: false,
            ),
            Expanded(
              child: StreamBuilder(
                stream: userRef.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final sellerModel = SellerModel.fromJson(snapshot.data!.docs[index].data());
                        return InkWell(
                          onTap: (){
                            nav(context, OrdersPage(userId: sellerModel.id.toString()));
                          },
                          child: UserIdPart(sellerModel: sellerModel,)
                        );
                      },
                    );
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
