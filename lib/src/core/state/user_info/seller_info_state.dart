part of 'seller_info_bloc.dart';

sealed class SellerInfoState extends Equatable {
  final List<SellerModel>? sellerList;
  const SellerInfoState({this.sellerList});
  @override
  List<Object?> get props => [sellerList];
}

final class SellerInfoInitial extends SellerInfoState {
  SellerInfoInitial(): super(sellerList: []);
  @override
  List<Object?> get props => [];
}

class SellerInfoLoading extends SellerInfoState {
  SellerInfoLoading(): super(sellerList: []);
  @override
  List<Object?> get props => [];
}

class SellerInfoSuccess extends SellerInfoState {
  final List<SellerModel> sellerList;

  const SellerInfoSuccess({required this.sellerList});
  @override
  List<Object?> get props => [sellerList];
}

class SellerInfoError extends SellerInfoState {
  final String errorMessage;
  const SellerInfoError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
