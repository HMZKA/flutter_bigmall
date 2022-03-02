// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/login_screen.dart';
import 'package:flutter_bigmall/big_mall_screens/onboarding_screen.dart';
import 'package:flutter_bigmall/big_mall_screens/shop_screen.dart';
import 'package:flutter_bigmall/cubit&states/login_cubit.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/service/dio_helper.dart';
import 'package:flutter_bigmall/shared_preference/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'big_mall_screens/register_screen.dart';
import 'cubit&states/states.dart';

String? token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';
  bool onboard = CacheHelper.getData(key: 'onBoard') ?? false;
  Widget widget = OnBoarding();
  if (onboard) {
    if (token == '') {
      widget = LogInScreen();
    } else {
      widget = ShopScreen();
    }
  }

  runApp(MyApp(isDark, token.toString(), widget));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final String token;
  Widget widget;
  MyApp(this.isDark, this.token, this.widget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ShopLoginCubit()..changeAppMode(fromshared: isDark)),
        ],
        child: BlocConsumer<ShopLoginCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              darkTheme: ThemeData(scaffoldBackgroundColor: Colors.black12),
              themeMode: ShopLoginCubit().get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: widget,
            );
          },
        ));
  }
}
