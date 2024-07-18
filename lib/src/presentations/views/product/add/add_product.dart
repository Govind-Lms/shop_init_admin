import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:path/path.dart' as Path;
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/core/state/product_info/product_info_bloc.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';

class AddProductItem extends StatefulWidget {
  const AddProductItem({super.key});

  @override
  State<AddProductItem> createState() => _AddProductItemState();
}

class _AddProductItemState extends State<AddProductItem> {
  String? name;
  String? desc;
  String? discountPercent;
  int? stocks;
  int? discountedPrice;
  int? price;

  static List<String> colors = [
    'white',
    'black',
    'red',
    'pink',
    'purple',
    'deepPurple',
    'indigo',
    'blue',
    'lightBlue',
    'cyan',
    'teal',
    'green',
    'lightGreen',
    'lime',
    'yellow',
    'amber',
    'orange',
    'deepOrange',
    'brown',
  ];

  static List<String> sizes = [
    'XXS',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'EU 32',
    'EU 33',
    'EU 34',
    'EU 35',
    'EU 36',
    'EU 37',
    'EU 38',
    'EU 39',
    'EU 40',
    'EU 41',
    'EU 42',
    'EU 43',
    'EU 44',
  ];

  final _colors = colors.map((color) => MultiSelectItem(color, color)).toList();

  final _sizes = sizes.map((size) => MultiSelectItem(size, size)).toList();

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
    final theme = Theme.of(context);
    List<String> colorsData = [];
    List<String> sizesData = [];
    return Scaffold(
      backgroundColor: theme.primaryColor,
      
      body: SafeArea(
        child: ListView(
          children: [
            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              name: 'Add Product',
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
                    margin: const EdgeInsets.only(left:15.0),
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
                        : Center(
                            child: IconButton(
                              icon: const Icon(Icons.photo),
                              onPressed: () {
                                uploadImage();
                              },
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
                        name = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Name',
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
                        price = int.parse(value);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'price',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        discountedPrice = int.parse(value);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'discount price',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        discountPercent = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '%',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        stocks = int.parse(value);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'stocks',
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
                  desc = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Upload Multiple Images",style: ViceStyle.titleStyle,),
            ),
            SizedBox(
              height: 120,
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                controller: ScrollController(),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: images.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Center(
                          child: IconButton(
                              onPressed: () {
                                uploadMultipleImages();
                              },
                              icon: const Icon(Icons.add)));
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: FileImage(
                                  images[index - 1]!,
                                  scale: 20,
                                ),
                                fit: BoxFit.cover)),
                      );
                    }
                  },
                ),
              ),
            ),
        
        
        
            Container(
              margin: const EdgeInsets.all(20.0),
              child: MultiSelectDialogField(
                items: _colors,
                title: const Text("Colors"),
                selectedColor: Colors.blue,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(3, 3),
                        blurRadius: 5,
                        color: Colors.black12,
                      )
                    ]),
                buttonIcon: const Icon(
                  Icons.color_lens,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Pick Colors",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  colorsData = results;
                  print(colorsData);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: MultiSelectDialogField(
                items: _sizes,
                title: const Text("Sizes"),
                selectedColor: Colors.blue,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(3, 3),
                        blurRadius: 5,
                        color: Colors.black12,
                      )
                    ]),
                buttonIcon: const Icon(
                  Icons.color_lens,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Pick Sizes",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  sizesData = results;
                  print("SizesData : $sizesData");
                },
              ),
            ),
            
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () async {
                showDialog(
                  context: context, builder: (context){
                  Future.delayed(const Duration(seconds: 10), () {
                    navPop(context);
                    navPop(context);
                  });
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blue),
                          child: const Center(child: CircularProgressIndicator(color: Colors.white,),),
                        ),
                      ),
                    );
                    
                  } 
                  
                );
        
               
                
                final storageReference = FirebaseStorage.instance
                    .ref()
                    .child("items")
                    .child(categoryName)
                    .child(name.toString())
                    .child("${Random().nextInt(100000000)}.jpg");
        
                final task = storageReference.putFile(_selectedimage!);
                var downloadUrl = await (await task).ref.getDownloadURL();
        
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
        
                final productModel = ItemModel(
                  isFavorite: false,
                  id: '${Random().nextInt(10000000)}',
                  name: name,
                  desc: desc,
                  category: categoryName,
                  stocks: stocks,
                  popularity: 1200,
                  price: price,
                  discountedPrice: discountedPrice ?? 0,
                  discountPercent: discountPercent ?? '',
                  imageUrl: downloadUrl,
                  images: imageUrls,
                  attributes: [
                    {
                      'name': 'Colors',
                      'values': colorsData,
                    },
                    {
                      'name': 'Sizes',
                      'values': sizesData,
                    }
                  ],
                  timestamp: Timestamp.now(),
                  isDiscounted: discountedPrice != 0 ? true : false,
                  isFeatured: false,
                );
                BlocProvider.of<ProductInfoBloc>(context)
                    .add(AddProduct(productModel)); 
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
