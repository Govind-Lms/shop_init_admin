

import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';

class ProductDatabaseService {
  Stream<List<ItemModel>> getCategoryProductDetails(String category) {
    return itemRef.doc('products').collection(category).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return ItemModel(
          id: doc.id,
          name: data['name'],
          category: data['category'],
          isFavorite: data['isFavorite'],
          desc: data['desc'],
          stocks: data['stocks'],
          popularity: data['popularity'],
          price: data['price'],
          discountedPrice: data['discountedPrice'],
          discountPercent: data['discountPercent'],
          imageUrl: data['imageUrl'],
          attributes: data['attributes'],
          images: data['images'],
          isDiscounted: data['isDiscounted'],
          isFeatured: data['isFeatured'],
          timestamp: data['timestamp'],
        );
      }).toList();
    });
  }

  Future<void> addCategoryProduct(ItemModel productModel) {
    return itemRef.doc('products').collection(categoryName).doc(productModel.id).set({
      'name': productModel.name,
      'id': productModel.id,
      'category': productModel.category,
      'isFavorite': productModel.isFavorite,
      'desc': productModel.desc,
      'stocks': productModel.stocks,
      'popularity': productModel.popularity,
      'price': productModel.price,
      'discountPercent': productModel.discountPercent,
      'discountedPrice': productModel.discountedPrice,
      'imageUrl': productModel.imageUrl,
      'attributes': productModel.attributes,
      'images': productModel.images?? '',
      'isFeatured' : productModel.isFeatured?? '',
      'isDiscounted' : productModel.isDiscounted ?? '',
      'timestamp': productModel.timestamp ?? '',
      
    }).onError((error, stackTrace) => print("Errror in upload :::::$error"),);
  }

  Future<void> deleteCategoryProduct(ItemModel productModel) {
    return itemRef.doc('products').collection(categoryName).doc(productModel.id).delete();
  }



  Future<void> updateCategoryProduct(ItemModel productModel) {
    return itemRef.doc('products').collection(categoryName).doc(productModel.id).update({
      'name': productModel.name,
      'id': productModel.id,
      'category': productModel.category,
      'isFavorite': productModel.isFavorite,
      'desc': productModel.desc,
      'stocks': productModel.stocks,
      'popularity': productModel.popularity,
      'price': productModel.price,
      'discountPercent': productModel.discountPercent,
      'discountedPrice': productModel.discountedPrice,
      'imageUrl': productModel.imageUrl,
      'attributes': productModel.attributes,
      'images': productModel.images?? '',
      'isFeatured' : productModel.isFeatured?? '',
      'isDiscounted' : productModel.isDiscounted ?? '',
      'timestamp': productModel.timestamp ?? '',
      
    }).onError((error, stackTrace) => print("Errror in update :::::$error"),);
  }



}

