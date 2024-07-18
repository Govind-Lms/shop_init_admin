import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/components/category_widget.dart';
import 'package:shop_init_admin/src/presentations/views/product/view/categorized_screen.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CustomAppBar(
                isAnimated: false,
                showDefinedName: true,
                name: 'Categories',
                showSearchBar: false,
                isfilterOn: false,
              ),
            ),
            
           
            SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 5,
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
      
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CategorizedScreen(
                        ),
                      ),
                    );
                  },
                  child: CategoryWidget(
                    color: colors[index],
                    image: images[index],
                    name: categoryNames[index],
                    angle: angles[index],
                  ),
                );
              },
            ),
      
          ],
        ),
      ),
    );
  }
}
