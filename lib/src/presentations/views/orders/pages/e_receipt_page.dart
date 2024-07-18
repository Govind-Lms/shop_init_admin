import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/order_model.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';

class EReceiptScreen extends StatelessWidget {
  final OrderModel orderModel;
  const EReceiptScreen({super.key, required this.orderModel});

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
              name: 'E-Receipt',
              showBack: true,
              showColor: false,
              isfilterOn: false,
            ),
            BarcodeWidget(
              barcode: Barcode.codabar(),
              data: orderModel.id,
              errorBuilder: (context, error) => Center(child: Text(error)),
              margin: const EdgeInsets.all(20),
              height: 80,
              color: theme.primaryColorDark,
              drawText: false,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider()),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        style: ViceStyle.normalStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                      Text(
                        "${orderModel.totalAmt} Ks",
                        style: ViceStyle.normalStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Id',
                        style: ViceStyle.normalStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                      Text(
                        "#${orderModel.id}",
                        style: ViceStyle.normalStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Charge',
                        style: ViceStyle.normalStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                      Text(
                        '0.00 Ks',
                        style: ViceStyle.normalStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: List.generate(
                      200 ~/ 5,
                      (index) => Expanded(
                        child: Container(
                          color:
                              index % 2 == 0 ? Colors.transparent : Colors.grey,
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: ViceStyle.titleStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                      Text(
                        '${orderModel.totalAmt} Ks',
                        style: ViceStyle.titleStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method',
                        style: ViceStyle.normalStyle.copyWith(
                          color: theme.primaryColorDark,
                        ),
                      ),
                      Text(
                        'Cash',
                        style: ViceStyle.normalStyle.copyWith(fontWeight: FontWeight.bold,color: theme.primaryColorDark),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: ViceStyle.normalStyle.copyWith(color: theme.primaryColorDark),
                      ),
                      Text(
                        orderModel.timestamp!.toDate().toString().replaceRange(9, 25,''),
                        style: ViceStyle.normalStyle.copyWith(fontWeight: FontWeight.bold,color: theme.primaryColorDark),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction Id',
                        style: ViceStyle.normalStyle.copyWith(color: theme.primaryColorDark),
                      ),
                      Text(
                        orderModel.uid!.substring(10),
                        style: ViceStyle.normalStyle.copyWith(fontWeight: FontWeight.bold,color: theme.primaryColorDark),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: (){
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width ,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Center(
                  child: Text(
                    'Send Receipt',
                    style: ViceStyle.descStyle.copyWith(color: theme.primaryColor),
                  ),
                ),
              ),
            ),
            const Gap(20.0),
          ],
        ),
      ),
    );
  }
}
