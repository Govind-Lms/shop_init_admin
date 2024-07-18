import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/seller_model.dart';

class UserIdPart extends StatelessWidget {
  final SellerModel sellerModel;
  const UserIdPart({super.key,required this.sellerModel});

  @override
  Widget build(BuildContext context) {

    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandableNotifier(
            initialExpanded: true,
            child: Expandable(
              collapsed: ExpandableButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User Details',
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
                          'User Details',
                          style: ViceStyle.normalStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Icon(ViceIcons.dropup)
                      ],
                    ),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User Id',
                        style: ViceStyle.descStyle,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width/2,
                        child: Text(
                          '#${sellerModel.id}',
                          style: ViceStyle.descStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: ViceStyle.descStyle,
                      ),
                      Text(
                        sellerModel.name,
                        style: ViceStyle.descStyle,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: ViceStyle.descStyle,
                      ),
                      Text(
                        sellerModel.email,
                        style: ViceStyle.descStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        
          const Divider(),
          Text(
            'Date',
            style: ViceStyle.descStyle
                .copyWith(fontWeight: FontWeight.normal),
          ),

          
        
        ],
        
      ),
    );
  }
}

