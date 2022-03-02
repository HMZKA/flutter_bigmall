import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/login_screen.dart';
import 'package:flutter_bigmall/big_mall_screens/shop_screen.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/main.dart';
import 'package:flutter_bigmall/model/login_model.dart';
import 'package:flutter_bigmall/model/register_model.dart';
import 'package:flutter_bigmall/service/dio_helper.dart';
import 'package:flutter_bigmall/shared_preference/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginCubit extends Cubit<ShopStates> {
  ShopLoginCubit() : super(ShopInitialState());

  ShopLoginCubit get(context) => BlocProvider.of(context);
  UserData? loginData;

  void userData(
      {required String email, required String password, required context}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: 'login',
        lang: 'en',
        data: {'email': email, 'password': password}).then((value) {
      // print(value.data['data']['token']);
      // print(value.data['status']);
      loginData = UserData.fromJson(value.data);
      print(loginData?.data?.token);
      token = loginData?.data?.token;
      CacheHelper.saveData(key: 'token', value: loginData?.data?.token)
          .then((value) {
        print('saved');
      });
      emit(ShopLoginSuccessState());
      if (value.data['status'] == true) {
        Fluttertoast.showToast(
            msg: value.data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        navigateAndRemove(context, ShopScreen());
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
    }).catchError((erorr) {
      print('Errorr IS' + erorr.toString());
      emit(ShopLoginErorrState(erorr));
    });
  }

  bool isDark = false;
  void changeAppMode({bool? fromshared}) {
    if (fromshared != null) {
      isDark = fromshared;
    } else {
      isDark = !isDark;
    }

    CacheHelper.saveData(key: 'isDark', value: isDark)
        .then((value) => emit(ChangeAppModeState()));
  }

  bool isShow = true;
  IconData icon = Icons.visibility_off;
  void obscureText() {
    isShow = !isShow;
    if (isShow) {
      icon = Icons.visibility_off;
    } else {
      icon = Icons.remove_red_eye;
    }
    emit(ChangeScureTextState());
  }

  RegisterModel? registerModel;

  void registerData(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required context}) {
    emit(RegisterAppLoadingState());
    DioHelper.postData(url: 'register', lang: 'en', data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      loginData = UserData.fromJson(value.data);
      emit(RegisterAppSucceedState(loginData as UserData));
      if (value.data['status'] == true) {
        Fluttertoast.showToast(
            msg: value.data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        token = loginData?.data?.token;
        print(loginData?.data?.token);
        CacheHelper.saveData(key: 'token', value: loginData?.data?.token)
            .then((value) {
          if (value as bool) {
            navigateAndRemove(context, ShopScreen());
          }
        }).catchError((error) {
          print(error.toString());
        });
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
    }).catchError((error) {
      print(error.toString());
      emit(RegisterAppErrorState());
    });
  }

  void logOut(context) {
    token = '';
    CacheHelper.removeData(key: 'token')?.then((value) {
      if (value) {
        navigateAndRemove(context, LogInScreen());
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}
