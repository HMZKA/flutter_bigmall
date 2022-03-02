import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/categories_screen.dart';
import 'package:flutter_bigmall/big_mall_screens/favorites_screen.dart';
import 'package:flutter_bigmall/big_mall_screens/home_screen.dart';
import 'package:flutter_bigmall/big_mall_screens/profile_screen.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/main.dart';
import 'package:flutter_bigmall/model/catedetail_model.dart';
import 'package:flutter_bigmall/model/categories_model.dart';
import 'package:flutter_bigmall/model/change_favorites_model.dart';
import 'package:flutter_bigmall/model/favorites_model.dart';
import 'package:flutter_bigmall/model/home_model.dart';
import 'package:flutter_bigmall/model/login_model.dart';
import 'package:flutter_bigmall/model/product_model.dart';
import 'package:flutter_bigmall/model/profile_model.dart';
import 'package:flutter_bigmall/model/search_model.dart';
import 'package:flutter_bigmall/service/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  ShopCubit get(context) => BlocProvider.of(context);
  List pages = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen()
  ];
  int currentindex = 0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int, bool>? favorites;
  void homeData() {
    emit(GetHomeDataShopLoadingState());
    DioHelper.getData(url: 'home', lang: 'en', token: token).then((value) {
      // print(value.data['data']);
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel?.data?.products?[0].images);
      print(homeModel?.data?.products?[0].inFavorites);
      homeModel?.data?.products?.forEach((element) {
        favorites?.addAll({
          element.id as int: element.inFavorites as bool,
        });
      });
      emit(GetHomeDataShopSucceedState());
    }).catchError((error) {
      print(error.toString());
      emit(GetHomeDataShopErrorState(error.toString()));
    });
  }

  void changeBottomNav(int index) {
    currentindex = index;
    emit(ChangeBottomNavShopState());
  }

  void categoriesData() {
    DioHelper.getData(url: 'categories', lang: 'en').then((value) {
      emit(GetCateDataShopLoadingState());
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel?.data?.data?[0].name);
      emit(GetCateDataShopSucceedState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCateDataShopErrorState(error));
    });
  }

  CateDetails? cateDetails;
  dynamic modell;
  void getCateDetail(model) {
    emit(GetCatogeriesDetailsLoadingState());
    modell = model;
    DioHelper.getData(url: 'categories/${model.id}', lang: 'en', token: token)
        .then((value) {
      cateDetails = CateDetails.fromJson(value.data);
      print(cateDetails?.data?.data?[0].name);
      emit(GetCatogeriesDetailsSucceedState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCatogeriesDetailsErrorState());
    });
  }

  ProfileModel? profileModel;
  void getProfile() {
    emit(GetProfileShopLoadingState());
    DioHelper.getData(url: 'profile', lang: 'en', token: token).then((value) {
      loginModel = UserData.fromJson(value.data);
      print(loginModel?.data?.name);
      emit(GetProfileShopSucceedState());
    }).catchError((error) {
      print(error);
      emit(GetProfileShopSucceedState());
    });
  }

  SearchModel? searchModel;
  void searchData({required String search}) {
    searchModel?.data?.data = null;
    emit(SearchShopLoadingState());
    DioHelper.postData(
        url: 'products/search',
        token: token,
        lang: 'en',
        data: {'text': search}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel?.data?.data?[0].name);
      emit(SearchShopSucceedState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchShopErrorState());
    });
  }

  UserData? loginModel;
  void updateProfile(
      {String? name, String? phone, String? email, String? password}) {
    emit(UpdateProfileAppLoadingState());
    DioHelper.putData(
            url: 'update-profile',
            data: {
              'name': name,
              'email': email,
              'phone': phone,
              'password': password
            },
            token: token)
        .then((value) {
      loginModel = UserData.fromJson(value.data);
      print(loginModel?.data?.name);
      emit(UpdateProfileAppSucceedState(loginModel));
    }).catchError((error) {
      emit(UpdateProfileAppErrorState());
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  bool a = true;
  bool status = true;
  void changeFavorites(int productId) {
    favorites?[productId] = !favorites![productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
            url: 'favorites',
            data: {
              'product_id': productId,
            },
            token: token,
            lang: 'en')
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites?[productId] = !favorites![productId]!;
      } else {
        getFavorites();
        homeData();
        if (modell != null) {
          getCateDetail(modell);
        }
      }
      if (value.data['status'] == true) {
        Fluttertoast.showToast(
            msg: value.data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: value.data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites?[productId] = !favorites![productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: 'favorites',
      lang: 'en',
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());
      print(favoritesModel?.data?.data?[0].id);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ProductModel? productModel;

  void getProduct(model) {
    productModel = null;
    emit(ShopGetProductLoadingState());
    DioHelper.getData(url: 'products/${model.id}', lang: 'en', token: token)
        .then((value) {
      productModel = ProductModel.fromJson(value.data);
      print(productModel?.data?.name);
      emit(ShopGetProductSucceedState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProductErrorState());
    });
  }
}
