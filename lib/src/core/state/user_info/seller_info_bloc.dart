import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_init_admin/src/core/helper/seller_service.dart';
import 'package:shop_init_admin/src/core/models/seller_model.dart';

part 'seller_info_event.dart';
part 'seller_info_state.dart';

class SellerInfoBloc extends Bloc<SellerInfoEvent, SellerInfoState> {
  SellerInfoBloc() : super(SellerInfoInitial()) {
    on<LoadSeller>(loadSeller);
    on<AddSeller>(addSeller);
    on<UpdateSeller>(updateSeller);
    on<DeleteSeller>(deleteSeller);
  }

  final SellerDatabaseService databaseService = SellerDatabaseService();

  Future<void> loadSeller(LoadSeller event, state) async {
    emit(SellerInfoLoading());
    databaseService.getSellerDetails().listen((seller) {
      emit(SellerInfoSuccess(sellerList: seller));
    },);
   
    // emit(const SellerInfoError('Failed to load seller info data'));
    
  }

  Future<void> addSeller(AddSeller event, state) async {
    try {
      emit(SellerInfoLoading());
      await databaseService.addSeller(event.sellerModel);
      // emit(const SellerInfoSuccess('Seller Info added successfully.'));
    } catch (e) {
      emit(const SellerInfoError("Error in adding seller info"));
    }
  }

  Future<void> updateSeller(UpdateSeller event, state) async {}
  Future<void> deleteSeller(DeleteSeller event, state) async {}
}
