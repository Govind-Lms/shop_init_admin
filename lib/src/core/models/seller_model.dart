class SellerModel {
  final String id;
  final String name;
  final String imageUrl;
  final String phoneNo;
  final String email;

  SellerModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.phoneNo,
    required this.email,
  });
  factory SellerModel.fromJson(Map<String,dynamic> doc){
    return SellerModel(
      id : doc['id'],
      name : doc['name'],
      imageUrl : doc['imageUrl'],
      phoneNo : doc['phoneNo'],
      email : doc['email'],
    );
  }
}
