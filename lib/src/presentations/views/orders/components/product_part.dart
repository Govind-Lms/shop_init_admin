import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/cart_model.dart';

class ProductPart extends StatelessWidget {
  final int total;
  final int totalQty;
  final List<CartModel> cartLists;
  const ProductPart({super.key, required this.cartLists, required this.total, required this.totalQty});


  
  @override
  Widget build(BuildContext context) {

   

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ExpandableNotifier(
            initialExpanded: true,
            child: Expandable(
              collapsed: ExpandableButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Details',
                      style: ViceStyle.normalStyle
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Icon(ViceIcons.dropdown)
                  ],
                ),
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandableButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Details',
                          style: ViceStyle.normalStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Icon(ViceIcons.dropup)
                      ],
                    ),
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      cartLists.length,
                      (index) {
                        return ListTile(

                          leading: Container(
                            width: 50,
                            height: 100,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: cartLists[index].imageUrl,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Product Id',
                                    style: ViceStyle.descStyle,
                                  ),
                                  Text(
                                    '#${cartLists[index].id}',
                                    style: ViceStyle.descStyle,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name',
                                    style: ViceStyle.descStyle,
                                  ),
                                  Text(
                                    cartLists[index].name,
                                    style: ViceStyle.descStyle,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${cartLists[index].totalPrice} Ks',
                                    style: ViceStyle.titleStyle,
                                  ),
                                  Text(
                                    'Qty: ${cartLists[index].quantity}',
                                    style: ViceStyle.descStyle,
                                  ),
                                ],
                              ),
                              
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const Gap(10),
          const Divider(),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub Total',
                style: ViceStyle.normalStyle,
              ),
              Text(
                '$total Ks',
                style:
                    ViceStyle.normalStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Qty',
                style: ViceStyle.normalStyle,
              ),
              Text(
                '$totalQty',
                style:
                    ViceStyle.normalStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery',
                style: ViceStyle.normalStyle,
              ),
              Text(
                'Pick Up',
                style: ViceStyle.normalStyle
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
          const Gap(10.0),
          
        ],
      ),
    );
  }
}
