import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';

class UpdateProductItem extends StatefulWidget {
  final ItemModel itemModel;
  final AttributeModel colors;
  final AttributeModel sizes;
  const UpdateProductItem({super.key, required this.itemModel, required this.colors, required this.sizes});

  @override
  State<UpdateProductItem> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProductItem> {
  String name = '';
  String desc = '';
  String discountPercent = '';
  int stocks = 0;
  int discountedPrice = 0;
  int price = 0;



  File? _selectedimage;

  List<File?> images = [];

  Future<void> uploadImage() async {
    final uploadedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (uploadedImage != null) {
      setState(() {
        _selectedimage = File(uploadedImage.path);
      });
    }
  }

  Future<void> uploadMultipleImages() async {
    final uploadedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (uploadedImage != null) {
      setState(() {
        images.add(File(uploadedImage.path));
      });
    } else {
      retrieveLostData();
    }
  }

  Future<void> retrieveLostData() async {
    final response = await ImagePicker().retrieveLostData();
    if (response.isEmpty) {
      return;
    } else if (response.file != null) {
      setState(() {
        images.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      
      body: SafeArea(
        
        child: ListView(
          children: [

            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              name: 'Update Product',
              showBack: true,
              showColor: false,
              isfilterOn: false,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    uploadImage();
                  },
                  child: Container(
                      height: 60.0,
                      width: 60.0,
                      margin: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.blue[100]),
                      child: _selectedimage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: kIsWeb == false
                                  ? Image.file(
                                      _selectedimage!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      _selectedimage!.path,
                                      fit: BoxFit.cover,
                                    ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: InkWell(
                                onTap: () {
                                  uploadImage();
                                },
                                child: CachedNetworkImage(
                                  imageUrl: widget.itemModel.imageUrl ?? '',
                                ),
                              ),
                            ),
                      ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        value.isEmpty
                            ? name = widget.itemModel.name!
                            : name = value;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Name ${widget.itemModel.name}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        value.isEmpty
                            ? price = widget.itemModel.price!
                            : price = int.parse(value);
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Price ${widget.itemModel.price} Ks',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        value.isEmpty
                            ? discountedPrice = widget.itemModel.discountedPrice!
                            : discountedPrice = int.parse(value);
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText:
                            'Discount Price ${widget.itemModel.discountedPrice}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        value.isEmpty
                            ? discountPercent = widget.itemModel.discountPercent!
                            : discountPercent = value;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: '${widget.itemModel.discountPercent}%',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        value.isEmpty
                            ? stocks = widget.itemModel.stocks!
                            : stocks = int.parse(value);
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: '${widget.itemModel.stocks}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                onChanged: (value) {
                  value.isEmpty ? desc = widget.itemModel.desc! : desc = value;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '${widget.itemModel.desc}',
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Uploaded Images",
                style: ViceStyle.titleStyle,
              ),
            ),
            Wrap(
              children: List.generate(widget.itemModel.images!.length, (index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: CachedNetworkImage(
                    width: 100,
                    height: 100,
                    imageUrl: widget.itemModel.images![index] ?? '',
                  ),
                );
              }),
            ),
            
            InkWell(
              onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(const Duration(seconds: 5), () {
                          navPop(context);
                          navPop(context);
                          navPop(context);
                        });
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: Container(
                              width: 200.0,
                              height: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
              
                 
                  List<String> imageUrls = [];
                  for (var image in images) {
                    final imagesRef = FirebaseStorage.instance
                        .ref()
                        .child("items")
                        .child(categoryName)
                        .child(name.toString())
                        .child("images")
                        .child("${Path.basename(image!.path)}.jpg");
                    await imagesRef.putFile(image).whenComplete(() async {
                      await imagesRef.getDownloadURL().then((value) {
                        imageUrls.add(value);
                      });
                    });
                  }
              
                  imageUrls.addAll(['${widget.itemModel.images}']);
              
                  // final itemModel = ItemModel(
                  //   // isFavorite: false,
                  //   // id: widget.itemModel.id,
                  //   name: name.toString().isEmpty ? widget.itemModel.name : name,
                  //   desc: desc.toString().isEmpty ? widget.itemModel.desc : desc,
                  //   stocks: stocks!=0 ? widget.itemModel.stocks : stocks,
                  //   price: price !=0 ? widget.itemModel.price : price,
                  //   discountedPrice: discountedPrice !=0 ? widget.itemModel.discountedPrice : discountedPrice,
                  //   discountPercent: discountPercent.toString().isEmpty ? widget.itemModel.discountPercent : discountPercent,
                  //   // imageUrl: _selectedimage == null ? widget.itemModel.imageUrl : widget.itemModel.imageUrl,
                  //   // images: imageUrls.isEmpty ? widget.itemModel.images : imageUrls,
                  //   // attributes: [
                  //   //   {
                  //   //     'name': 'Colors',
                  //   //     'values': colorsData.isEmpty ? widget.colors.values : colorsData,
                  //   //   },
                  //   //   {
                  //   //     'name': 'Sizes',
                  //   //     'values': sizesData.isEmpty ? widget.sizes.values : sizesData,
                  //   //   }
                  //   // ],
                  //   // timestamp: Timestamp.now(),
                  //   // isDiscounted: discountedPrice != 0 ? true : false,
                  //   // isFeatured: false,
                  // );
              
                  await itemRef.doc('products').collection(categoryName).doc(widget.itemModel.id).update({
                    'name': name.toString().isEmpty ? widget.itemModel.name : name,
                    'desc': desc.toString().isEmpty ? widget.itemModel.desc : desc,
                    'stocks': stocks ==0 ? widget.itemModel.stocks : stocks,
                    'price': price == 0 ? widget.itemModel.price : price,
                    'discountPercent': discountPercent.isEmpty ? widget.itemModel.discountPercent : discountPercent,
                    'discountedPrice': discountedPrice ==0 ? widget.itemModel.discountedPrice : discountedPrice,
                  });
                },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.primaryColorDark,
                ),
                child:  Center(child: Text('Update',style: ViceStyle.normalStyle.copyWith(color: theme.primaryColorLight),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
