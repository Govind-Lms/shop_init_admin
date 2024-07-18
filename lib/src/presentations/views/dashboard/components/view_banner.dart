import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/dialogs/delete_banner.dialog.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';
import 'package:shop_init_admin/src/presentations/widgets/skeleton.dart';

class ViewBannerPage extends StatelessWidget {
  const ViewBannerPage({super.key});

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
              name: 'Banners',
              showBack: true,
              showColor: false,
              isfilterOn: false,
            ),
            
            const Gap(10),
            Expanded(
              child: StreamBuilder(
                stream: bannerRef.orderBy('timestamp',descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const BannerSkeletonCondition();
                  } else if (snapshot.hasError) {
                    return const BannerSkeletonCondition();
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
                          // onTap: (){
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return OptionsDialog(productModel: productModel);
                          //     },
                          //   );
                          // },
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
                          trailing: IconButton(
                            onPressed: (){
                              showDialog(context: context, builder: (context){
                                return DeleteBannerDialog(itemModel: productModel,);
                              });
                            },
                            icon: const Icon(Iconsax.trash),
                          )
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
