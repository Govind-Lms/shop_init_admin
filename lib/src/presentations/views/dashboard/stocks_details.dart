import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/dialogs/options_dialog.dart';
import 'package:shop_init_admin/src/presentations/views/product/add/add_product.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';
import 'package:shop_init_admin/src/presentations/widgets/skeleton.dart';

class StocksDetailsPage extends StatelessWidget {
  const StocksDetailsPage({super.key});

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
              name: 'Stock Details',
              showBack: true,
              showColor: false,
              isfilterOn: false,
            ),
            GestureDetector(
              onTap: (){
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return const AddProductItem();
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColorDark,
                ),
                child:  Center(child: Text('Add Product',style: ViceStyle.normalStyle.copyWith(color: theme.primaryColor),)),
              ),
            ),
            const Gap(10),
            Expanded(
              child: StreamBuilder(
                stream: itemRef.doc("products").collection(categoryName).orderBy('stocks',descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SkeletonCondition();
                  } else if (snapshot.hasError) {
                    return const SkeletonCondition();
                  } else {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 4/1,
                      ),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final productModel = ItemModel.fromJson(snapshot.data!.docs[index].data());

                        return ListTile(
                          onTap: (){
                            
                            showDialog(
                              context: context,
                              builder: (context) {
                                return OptionsDialog(productModel: productModel);
                              },
                            );
                          },
                          leading: SizedBox(
                            width: 60,
                            height: 60,
                            child: CachedNetworkImage(
                               width: 60,
                            height: 60,
                              imageUrl: productModel.imageUrl ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text("Name: ${productModel.name}",style: ViceStyle.normalStyle,),
                          subtitle: Text("Stocks ${productModel.stocks}",style: ViceStyle.descStyle,),
                          trailing: const Icon(Icons.arrow_right),
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
