// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/login_screen.dart';
import 'package:flutter_bigmall/big_mall_screens/search_screen.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/login_cubit.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/shared_preference/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..homeData()
        ..categoriesData()
        ..getProfile()
        ..getFavorites(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit().get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              title: Text(
                'BigMall',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ))
              ],
            ),
            body: cubit.pages[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentindex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorites'),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.profile_circled),
                      label: 'Profile'),
                ]),
          );
        },
      ),
    );
  }
}
