import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/style.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/core/notifier/quantity_notifier.dart';
import 'package:shop_init_admin/src/presentations/views/product/add/update_product.dart';
import 'package:shop_init_admin/src/presentations/views/product/photo_view.dart';
import 'package:shop_init_admin/src/presentations/views/product/view/widgets/color_part.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/dialogs/delete_dialog.dart';
import 'package:shop_init_admin/src/presentations/views/product/view/widgets/sized_part.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';
import 'package:shop_init_admin/src/presentations/widgets/divider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ItemModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PageController controller = PageController();
  var currentIndex = 0;
  void onPageChanged(index) {
    currentIndex = index;
  }

  void onDotClicked(index) {
    currentIndex = index;
    controller.jumpTo(index);
  }

  
  bool isSelected = false;
  
  final counter = Counter();

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    final colorData = widget.productModel.attributes![0];
    final sizeData = widget.productModel.attributes![1];
    final colors = AttributeModel.fromJson(colorData);
    final sizes = AttributeModel.fromJson(sizeData);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                
                ///mainImage
                GestureDetector(
                  onTap: (){
                    nav(context, PhotoView(images: widget.productModel.images!, image: widget.productModel.imageUrl!,));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black12,
                    child: PageView(
                      controller: controller,
                      onPageChanged: onPageChanged,
                      children: List.generate(
                        widget.productModel.images!.length + 1,
                        (index) {
                          if (index == 0) {
                            return CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.productModel.imageUrl!,
                            );
                          } else {
                            return Container(
                              width: 80.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey,
                                  border: Border.all(width: 1)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.productModel.images![index - 1],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),

                ///appbar
                const Positioned(
                  child: Column(
                    children: [
                      Gap(30.0),
                      CustomAppBar(
                        isfilterOn: false,
                        isAnimated: false,
                        showSearchBar: false,
                        showDefinedName: true,
                        name: '',
                        showBack: true,
                        showColor: true,
                      ),
                    ],
                  ),
                ),

                ///set_as_banner
                Positioned(
                  bottom: 10.0,
                  right: 10,
                  child: Card(

                    child: TextButton(
                      onPressed: () async{ 
                        if(widget.productModel.isFeatured == false){
                          await bannerRef.doc(widget.productModel.id.toString())
                          .set({
                            'name': widget.productModel.name,
                            'id': widget.productModel.id,
                            'category': widget.productModel.category,
                            'isFavorite': widget.productModel.isFavorite,
                            'desc': widget.productModel.desc,
                            'stocks': widget.productModel.stocks,
                            'popularity': widget.productModel.popularity,
                            'price': widget.productModel.price,
                            'discountPercent': widget.productModel.discountPercent,
                            'discountedPrice': widget.productModel.discountedPrice,
                            'imageUrl': widget.productModel.imageUrl,
                            'attributes': widget.productModel.attributes,
                            'images': widget.productModel.images?? '',
                            'isFeatured' :widget.productModel.isFeatured?? '',
                            'isDiscounted' :widget.productModel.isDiscounted ?? '',
                            'timestamp': widget.productModel.timestamp ?? '',
                          });
                          await itemRef.doc("products").collection(categoryName).doc(widget.productModel.id.toString()).update({
                            'isFeatured' : true,
                          });
                          setState(() {
                            widget.productModel.isFeatured = true;
                          });
                        }
                        else{
                          
                          await itemRef.doc("products").collection(categoryName).doc(widget.productModel.id.toString()).update({
                            'isFeatured' : false,
                          });
                          await bannerRef.doc(widget.productModel.id).delete();
                          setState(() {
                            widget.productModel.isFeatured = false;
                          });
                        }
                      },
                      child: widget.productModel.isFeatured == true ? const Text('Remove from Banners') : const Text('Set as Banner'),
                    ),
                  ) ,
                ),

                ///images
                Positioned(
                  bottom: 10,
                  left: 10.0,
                  right: 10.0,
                  child: SmoothPageIndicator(
                      controller: controller,
                      count: widget.productModel.images!.length + 1,
                      onDotClicked: onDotClicked,
                      axisDirection: Axis.horizontal,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.black,
                        dotColor: Colors.white,
                        dotHeight: 10,
                        dotWidth: 30,
                        
                      )),
                ),
              
              ],
            ),

            ///details
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.yellow.withOpacity(.8),
                        ),
                        child: Text(' ${widget.productModel.discountPercent}% ',
                            style: ProductStyle.discountStyle),
                      ),
                      const Gap(10.0),
                      Text(
                        '${widget.productModel.price}Ks',
                        style: ViceStyle.priceStyle,
                      ),
                      const Gap(10.0),
                      Text(
                        '${widget.productModel.discountedPrice}Ks',
                        style: ViceStyle.discountedPriceStyle,
                      ),
                    ],
                  ),
                  
                  const Gap(10.0),
                  
                  Text(
                    widget.productModel.name ?? '',
                    style: ViceStyle.titleStyle,
                  ),

                  Row(
                    children: [
                      Text(
                        'In Stocks: ',
                        style: ViceStyle.normalStyle,
                      ),
                      Text(widget.productModel.stocks.toString(),
                          style: ViceStyle.normalStyle),
                    ],
                  ),

                  ///colors
                  const Gap(10.0),
                  Text(
                    'Colors',
                    style: ViceStyle.titleStyle,
                  ),
                  ColorPart(attributes: widget.productModel.attributes),

                  ///sizes
                  Text('Sizes', style: ViceStyle.titleStyle),

                  SizePart(
                    attributes: widget.productModel.attributes,
                  ),

                  const DividerWidget(),


                  const Gap(10.0),

                  Text(
                    'Description',
                    style: ViceStyle.titleStyle,
                  ),
                  const Gap(10.0),
                  Text(
                    widget.productModel.desc ?? '',
                    style: ViceStyle.normalStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          const Gap(10.0),
          InkWell(
            onTap: () async{ 
              showDialog(context: context, builder: (context){
                return DeleteDialog(id: widget.productModel.id.toString());
              });
            },
            child: const CircleAvatar(
              radius: 30.0,
              child: Icon(Icons.delete),
            ),
          ),
          
          const Spacer(),
           InkWell(
            onTap: (){
              nav(context, UpdateProductItem(
                  itemModel: widget.productModel,
                  colors: colors,
                  sizes: sizes,
                ));
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2),
              ),
              child: Center(
                child: Text(
                  'Edit Data',
                  style: ViceStyle.descStyle,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}