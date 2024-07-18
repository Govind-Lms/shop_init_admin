part of 'product_info_bloc.dart';

sealed class ProductInfoState extends Equatable {
  final List<ItemModel>? products;
  const ProductInfoState({this.products});
  @override
  List<Object?> get props => [products];
}

final class ProductInfoInitial extends ProductInfoState {
  ProductInfoInitial(): super(products: []);
  @override
  List<Object?> get props => [];
}

final class ProductInfoLoading extends ProductInfoState {
  ProductInfoLoading(): super(products: []);
  @override
  List<Object?> get props => [];
}

final class ProductInfoSuccess extends ProductInfoState {
  final List<ItemModel> products;

  const ProductInfoSuccess({required this.products});
  @override
  List<Object?> get props => [products];
}

final class ProductInfoError extends ProductInfoState {
  final String errorMessage;
  const ProductInfoError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
