import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/state/product_info/product_info_bloc.dart';
import 'package:shop_init_admin/src/presentations/views/product/add/add_product.dart';
import 'package:shop_init_admin/src/presentations/views/product/view/product_design.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';
import 'package:shop_init_admin/src/presentations/widgets/reuse_grid_view.dart';
import 'package:shop_init_admin/src/presentations/widgets/skeleton.dart';

class CategorizedScreen extends StatelessWidget {

  CategorizedScreen({super.key});
  
  final refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            
            CustomAppBar(
              isfilterOn: true,
              isAnimated: false,
              showDefinedName: true,
              name: categoryName.toUpperCase(),
              showSearchBar: false,
              showBack: true,
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
                  color: Colors.blue,
                ),
                child:  Center(child: Text('Add',style: ViceStyle.normalStyle.copyWith(color: Colors.white),)),
              ),
            ),
            Expanded(
              child: BlocProvider(
                create: (context) => ProductInfoBloc()..add(LoadProduct()),
                child: BlocBuilder<ProductInfoBloc, ProductInfoState>(
                  builder: (context, state) {
                    if (state is ProductInfoInitial) {
                      return const SkeletonCondition();
                    } else if (state is ProductInfoLoading) {
                      return const SkeletonCondition();
                    } else if (state is ProductInfoSuccess) {
                      final productInfo = state.products;
                      if (productInfo.isNotEmpty) {
                        return ReUseGridView(
                          controller: refreshController,
                          onRefresh: () {
                            BlocProvider.of<ProductInfoBloc>(context)
                                .add(LoadProduct());
                            refreshController.refreshCompleted();
                          },
                          itemCount: productInfo.length,
                          itemBuilder: (context, index) {
                            return ProductDesign(productModel: productInfo[index]);
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No Products Currently'),
                        );
                      }
                    } else {
                      return Text(state.props.toString());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
