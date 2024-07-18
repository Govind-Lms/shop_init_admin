part of 'seller_info_bloc.dart';

sealed class SellerInfoEvent extends Equatable {
  const SellerInfoEvent();
  @override
  List<Object> get props => [];
}

class LoadSeller extends SellerInfoEvent {
  @override
  List<Object> get props => [];
}

class AddSeller extends SellerInfoEvent {
  final SellerModel sellerModel;
  const AddSeller(this.sellerModel);
  @override
  List<Object> get props => [sellerModel];
}

class UpdateSeller extends SellerInfoEvent {
  final SellerModel sellerModel;
  const UpdateSeller(this.sellerModel);
  @override
  List<Object> get props => [sellerModel];
}

class DeleteSeller extends SellerInfoEvent {
  final String sellerId;
  const DeleteSeller(this.sellerId);
  @override
  List<Object> get props => [sellerId];
}