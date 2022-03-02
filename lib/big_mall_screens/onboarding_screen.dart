// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/login_screen.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/login_cubit.dart';
import 'package:flutter_bigmall/shared_preference/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List titles = ['BIG MALL', 'Restaurants & Cafes', 'We are The Best'];

  List body = [
    'Come Visit Us',
    'You can drink a cop of coffee and taking a rest',
    'You can find anything you looking for'
  ];

  var boardcontroller = PageController();

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                navigateAndRemove(context, LogInScreen());
                CacheHelper.saveData(key: 'onBoard', value: true);
              },
              child: Text('SKIP'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_arrow_right),
          onPressed: () {
            if (islast) {
              navigateAndRemove(context, LogInScreen());
              CacheHelper.saveData(key: 'onBoard', value: true);
            } else {
              boardcontroller.nextPage(
                  duration: Duration(milliseconds: 750),
                  curve: Curves.fastLinearToSlowEaseIn);
            }
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardcontroller,
              onPageChanged: (value) {
                if (value == titles.length - 1) {
                  setState(() {
                    islast = true;
                  });
                } else {
                  setState(() {
                    islast = false;
                  });
                }
              },
              itemCount: 3,
              itemBuilder: (context, index) => buildOnBoard(index),
              physics: BouncingScrollPhysics(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: SmoothPageIndicator(
              controller: boardcontroller,
              count: 3,
              effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  expansionFactor: 4,
                  spacing: 5,
                  dotColor: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOnBoard(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
        ),
        Image(
          image: AssetImage('images/bigmall${index}.jpg'),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            titles[index],
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            body[index],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
