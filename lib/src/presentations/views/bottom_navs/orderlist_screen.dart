import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/order_model.dart';
import 'package:shop_init_admin/src/core/notifier/status_filter_notifier.dart';
import 'package:shop_init_admin/src/presentations/views/orders/components/order_id_part.dart';
import 'package:shop_init_admin/src/presentations/views/orders/pages/product_details_page.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = Filter();
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: filter.statusFilter,
            builder: (context, value, child) {
              return Column(
                children: [
                  CustomAppBar(
                    isAnimated: false,
                    showSearchBar: false,
                    showDefinedName: true,
                    name: 'Order Lists',
                    showBack: true,
                    showColor: false,
                    isfilterOn: true,
                    filterWidget: IconButton(
                      onPressed: () {
                        showPlatformDialog(
                          context: context,
                          builder: (context) => BasicDialogAlert(
                            title:  Text('Filters',style: ViceStyle.titleStyle,),
                            content: Wrap(children: [
                              TextButton(
                                child: const Text('Approve Only'),
                                onPressed: () {
                                  value = "approve";
                                  filter.statusFilter.value = "approve";
                                  filter.streamQuery.value = orderListRef.where('approve' ,isEqualTo: "approve").snapshots();
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              TextButton(
                                child: const Text('Reject Only'),
                                onPressed: () {
                                  value = "reject";
                                  filter.statusFilter.value = "reject";
                                  filter.streamQuery.value = orderListRef.where('approve' ,isEqualTo: "reject").snapshots();
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              TextButton(
                                child: const Text('timestamp'),
                                onPressed: () {
                                  value  = "timestamp";
                                 filter.statusFilter.value = "timestamp";
                                 filter.streamQuery.value = orderListRef.orderBy('timestamp',descending: true).snapshots();
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ]),
                            actions: <Widget>[
                              BasicDialogAction(
                                title: const Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Iconsax.filter_edit5,size: 20,),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: filter.streamQuery.value,
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
                              final orderModel = OrderModel.fromJson(
                                  snapshot.data!.docs[index].data());
                              return InkWell(
                                  onTap: () {
                                    nav(
                                        context,
                                        ProductsPage(
                                          orderModel: orderModel,
                                        ));
                                  },
                                  child: OrderIdPart(
                                    orderModel: orderModel,
                                  ));
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
