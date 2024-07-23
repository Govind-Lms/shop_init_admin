import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';

class PhotoView extends StatelessWidget {
  final List<dynamic> images;
  final String image;
  PhotoView({super.key, required this.images, required this.image});
  var currentIndex = 0;
  bool visible = false;
  PageController controller = PageController();
  

  void onPageChanged(index) {
    currentIndex = index;
  }
 
  @override
  Widget build(BuildContext context) {
    

    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              isfilterOn: false,
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              name: '',
              showBack: true,
              showColor: false,
            ),
            Center(
              child: InteractiveViewer(
                minScale: .8,
                maxScale: 2.5,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height - 300,
                  width: MediaQuery.sizeOf(context).width,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: onPageChanged,
                    controller: controller,
                    children: List.generate(images.length + 1, (index) {
                      if (index == 0) {
                        return CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          height: MediaQuery.sizeOf(context).height - 300,
                          width: MediaQuery.sizeOf(context).width,
                          imageUrl: image,
                        );
                      } else {
                        return CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          height: MediaQuery.sizeOf(context).height - 300,
                          width: MediaQuery.sizeOf(context).width,
                          imageUrl: images[index - 1],
                        );
                      }
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (currentIndex != 0) {
                      currentIndex--;
                      controller.jumpToPage(currentIndex--);
                    } else {
                      currentIndex = 0;
                      controller.jumpToPage(images.length);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: kToolbarHeight,
                    height: kToolbarHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.primaryColorDark,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: theme.primaryColorLight,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (currentIndex < images.length) {
                      currentIndex++;
                      controller.jumpToPage(currentIndex++);
                    } else {
                      currentIndex = 0;
                      controller.jumpToPage(0);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: kToolbarHeight,
                    height: kToolbarHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.primaryColorDark,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: theme.primaryColorLight,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
