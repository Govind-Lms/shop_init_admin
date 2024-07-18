import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/components/product_category.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';
class TopSellingPart extends StatelessWidget {
  const TopSellingPart({super.key});

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
              name: 'Upload',
              showBack: true,
              showColor: false,
              isfilterOn: false,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/1,
                ),
                itemCount: categoryNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      switch (categoryNames[index]) {
                        case 'tee':
                          categoryName = 'tee';
                        case 'outerwear':
                          categoryName = 'outerwear';
                        case 'sneaker':
                          categoryName = 'sneaker';
                        case 'hoodie':
                          categoryName = 'hoodie';
                      }
              
                      navName(context, '/stockDetails');
                    },
                    child: ProductCategoryWidget(name: categoryNames[index], image: images[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}