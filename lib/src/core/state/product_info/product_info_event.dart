part of 'product_info_bloc.dart';

sealed class ProductInfoEvent extends Equatable {
  const ProductInfoEvent();
  @override
  List<Object> get props => [];
}

final class LoadProduct extends ProductInfoEvent{
  @override
  List<Object> get props => [];
}

final class AddProduct extends ProductInfoEvent{
  final ItemModel productModel;
  const AddProduct(this.productModel);
  @override
  List<Object> get props => [productModel];
}

final class UpdateProduct extends ProductInfoEvent{
  final ItemModel productModel;
  const UpdateProduct(this.productModel);
  @override
  List<Object> get props => [productModel];
}

final class DeleteProduct extends ProductInfoEvent{
  final ItemModel productModel;
  const DeleteProduct(this.productModel);
  @override
  List<Object> get props => [productModel];
}


