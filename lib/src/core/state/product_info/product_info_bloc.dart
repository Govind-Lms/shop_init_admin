import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/core/helper/product_service.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';

part 'product_info_event.dart';
part 'product_info_state.dart';

class ProductInfoBloc extends Bloc<ProductInfoEvent, ProductInfoState> {
  ProductInfoBloc() : super(ProductInfoInitial()) {
    on<LoadProduct>(loadProduct);
    on<AddProduct>(addProduct);
    on<UpdateProduct>(updateProduct);
  }

  final databaseService = ProductDatabaseService();

  Future<void> loadProduct(LoadProduct event, state) async {
    try {
      emit(ProductInfoLoading());
      databaseService.getCategoryProductDetails(categoryName).listen((products){
        emit(ProductInfoSuccess(products: products));
      });
      
    } catch (e) {
      emit(const ProductInfoError('Failed to load product info data'));
    }
  }

  Future<void> addProduct(AddProduct event, state) async {
    try {
      emit(ProductInfoLoading());
      await databaseService.addCategoryProduct(event.productModel);
    } catch (e) {
      emit(const ProductInfoError("Error in adding product info"));
    }
  }


  Future<void> updateProduct(UpdateProduct event, state) async {
    try {
      emit(ProductInfoLoading());
      await databaseService.updateCategoryProduct(event.productModel);
    } catch (e) {
      emit(const ProductInfoError("Error in adding product info"));
    }
  }
}
