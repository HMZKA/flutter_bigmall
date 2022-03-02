import 'package:flutter_bigmall/model/change_favorites_model.dart';
import 'package:flutter_bigmall/model/login_model.dart';
import 'package:flutter_bigmall/model/register_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopLoginLoadingState extends ShopStates {}

class ShopLoginSuccessState extends ShopStates {}

class ShopLoginErorrState extends ShopStates {
  final error;

  ShopLoginErorrState(this.error);
}

class ChangeAppModeState extends ShopStates {}

class ChangeScureTextState extends ShopStates {}

class GetHomeDataShopSucceedState extends ShopStates {}

class GetHomeDataShopErrorState extends ShopStates {
  String error;
  GetHomeDataShopErrorState(this.error);
}

class GetHomeDataShopLoadingState extends ShopStates {}

class GetCateDataShopSucceedState extends ShopStates {}

class GetCateDataShopErrorState extends ShopStates {
  String error;
  GetCateDataShopErrorState(this.error);
}

class GetCateDataShopLoadingState extends ShopStates {}

class ChangeBottomNavShopState extends ShopStates {}

class GetCatogeriesDetailsSucceedState extends ShopStates {}

class GetCatogeriesDetailsErrorState extends ShopStates {}

class GetCatogeriesDetailsLoadingState extends ShopStates {}

class GetProfileShopSucceedState extends ShopStates {}

class GetProfileShopErrorState extends ShopStates {}

class GetProfileShopLoadingState extends ShopStates {}

class RegisterAppSucceedState extends ShopStates {
  UserData userData;
  RegisterAppSucceedState(this.userData);
}

class RegisterAppLoadingState extends ShopStates {}

class RegisterAppErrorState extends ShopStates {}

class SearchShopSucceedState extends ShopStates {}

class SearchShopErrorState extends ShopStates {}

class SearchShopLoadingState extends ShopStates {}

class UpdateProfileAppSucceedState extends ShopStates {
  UserData? userData;
  UpdateProfileAppSucceedState(this.userData);
}

class UpdateProfileAppLoadingState extends ShopStates {}

class UpdateProfileAppErrorState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel? model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopGetProductSucceedState extends ShopStates {}

class ShopGetProductErrorState extends ShopStates {}

class ShopGetProductLoadingState extends ShopStates {}
