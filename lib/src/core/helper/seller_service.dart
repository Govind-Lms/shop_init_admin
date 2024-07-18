import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/core/models/seller_model.dart';

class SellerDatabaseService {
  Stream<List<SellerModel>> getSellerDetails() {
    return userRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return SellerModel(
          name: data['name'],
          email: data['email'],
          imageUrl: data['imageUrl'],
          phoneNo: data['phoneNo'],
          id: doc.id,
        );
      }).toList();
    });
  }

  Future<void> addSeller(SellerModel seller) {
    return userRef.add({
      'id': seller.id,
      'email': seller.email,
      'phoneNo': seller.phoneNo,
      'imageUrl': seller.imageUrl,
      'name' : seller.name,
    });
  }

  Future<void> deleteSeller(String sellerId) {
    return userRef.doc(sellerId).delete();
  }
}

