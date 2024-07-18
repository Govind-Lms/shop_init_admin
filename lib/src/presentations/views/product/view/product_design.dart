import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/style.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/presentations/views/product/view/product_details.dart';

class ProductDesign extends StatefulWidget {
  final ItemModel productModel;
  const ProductDesign({super.key, required this.productModel});

  @override
  State<ProductDesign> createState() => _ProductDesignState();
}

class _ProductDesignState extends State<ProductDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nav(context, ProductDetailsScreen(productModel: widget.productModel));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.withOpacity(.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  Hero(
                    tag: widget.productModel.imageUrl ?? '',
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 150,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.productModel.imageUrl ?? '',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error),
                            ),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.yellow.withOpacity(.8),
                      ),
                      child: Text(
                          '${widget.productModel.discountPercent!.isEmpty ? "0" : widget.productModel.discountPercent}%',
                          style: ProductStyle.discountStyle),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: CircleAvatar(
                      radius: 18.0,
                      backgroundColor: Colors.white.withOpacity(.5),
                      child: IconButton(
                        iconSize: 20.0,
                        onPressed: () async {
                          if (widget.productModel.isFavorite == false) {
                            await itemRef
                                .doc('products')
                                .collection(categoryName)
                                .doc(widget.productModel.id)
                                .update({
                              'isFavorite': true,
                            }).whenComplete(
                              () async {
                                await itemRef
                                    .doc('products')
                                    .collection('favorites')
                                    .doc(widget.productModel.id)
                                    .set({
                                  'name': widget.productModel.name,
                                  'id': widget.productModel.id,
                                  'category': widget.productModel.category,
                                  'isFavorite': widget.productModel.isFavorite,
                                  'desc': widget.productModel.desc,
                                  'stocks': widget.productModel.stocks,
                                  'popularity': widget.productModel.popularity,
                                  'price': widget.productModel.price,
                                  'discountPercent':
                                      widget.productModel.discountPercent,
                                  'discountedPrice':
                                      widget.productModel.discountedPrice,
                                  'imageUrl': widget.productModel.imageUrl,
                                  'attributes': widget.productModel.attributes,
                                  'images': widget.productModel.images,
                                  'isFeatured': widget.productModel.isFeatured,
                                  'isDiscounted':
                                      widget.productModel.isDiscounted,
                                  'timestamp': widget.productModel.timestamp,
                                });
                              },
                            );
                            setState(() {
                              widget.productModel.isFavorite = true;
                            });
                          } else {
                            await itemRef
                                .doc('products')
                                .collection(categoryName)
                                .doc(widget.productModel.id)
                                .update({
                              'isFavorite': false,
                            });
                            await itemRef
                                .doc('products')
                                .collection('favorites')
                                .doc(widget.productModel.id)
                                .delete()
                                .whenComplete(() {
                              widget.productModel.isFavorite = false;
                            });
                          }
                        },
                        icon: Icon(widget.productModel.isFavorite == false
                            ? ViceIcons.heart
                            : ViceIcons.heartFill),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
              child: Row(
                children: [
                  Text(
                    widget.productModel.name ?? '',
                    style: ProductStyle.productNameStyle,
                  ),
                ],
              ),
            ),

            ///price
            widget.productModel.isDiscounted == true ||
                    widget.productModel.discountPercent != '' ||
                    widget.productModel.discountedPrice != 0
                ? Text(
                    '${widget.productModel.price}Ks',
                    style: ProductStyle.categoryStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                : Text(
                    '${widget.productModel.price}Ks',
                    style: ProductStyle.priceStyle,
                  ),

            const Spacer(),

            ///plus
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.productModel.isDiscounted == true ||
                        widget.productModel.discountPercent != '' ||
                        widget.productModel.discountedPrice != 0
                    ? Text(
                        '${widget.productModel.discountedPrice}Ks',
                        style: ProductStyle.priceStyle.copyWith(
                          color: Colors.green,
                        ),
                      )
                    : Text(
                        '${widget.productModel.price}Ks',
                        style: ProductStyle.priceStyle,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
