// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/register_screen.dart';
import 'package:flutter_bigmall/big_mall_screens/shop_screen.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/login_cubit.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> keyform = GlobalKey<FormState>();
    var cubit = ShopLoginCubit().get(context);

    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    return BlocConsumer<ShopLoginCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: keyform,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Text(
                      'LOGIN',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login To Enjoy The Hot Offers',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    textBox(
                        keyboard: TextInputType.emailAddress,
                        controller: emailcontroller,
                        hinttext: 'Email',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }
                        },
                        prefix: Icon(Icons.email)),
                    SizedBox(
                      height: 20,
                    ),
                    textBox(
                        keyboard: TextInputType.visiblePassword,
                        controller: passwordcontroller,
                        hinttext: 'Password',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'password must not be empty';
                          }
                        },
                        prefix: Icon(Icons.lock),
                        suffix: InkWell(
                            onTap: () {
                              cubit.obscureText();
                            },
                            child: Icon(cubit.icon)),
                        isShown: cubit.isShow),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: state is! ShopLoginLoadingState
                            ? TextButton(
                                onPressed: () {
                                  if (keyform.currentState!.validate()) {
                                    cubit.userData(
                                        context: context,
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text);
                                    // navigateAndRemove(context, ShopScreen());

                                  }
                                },
                                child: Container(
                                  color: Colors.blue,
                                  width: 300,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      'LOG IN',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ))
                            : CircularProgressIndicator()),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have account?',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, RegisterScreen());
                          },
                          child: Text(
                            'Create one',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
