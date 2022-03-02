// ignore_for_file: void_checks

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/login_screen.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/login_cubit.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/shared_preference/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit().get(context);
    // passwordController.text = profile?.data?.password as String;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: cubit.loginModel != null,
          builder: (context) {
            var profile = ShopCubit().get(context).loginModel;

            TextEditingController nameController = TextEditingController();
            TextEditingController emailController = TextEditingController();
            TextEditingController phoneController = TextEditingController();
            TextEditingController passwordController = TextEditingController();
            nameController.text = profile?.data?.name as String;
            emailController.text = profile?.data?.email as String;
            phoneController.text = profile?.data?.phone as String;
            var keyform = GlobalKey<FormState>();
            String? value;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Form(
                  key: keyform,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${nameController.text}',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  // ignore: void_checks
                                  return buildDialouge(
                                      context,
                                      textBox(
                                          hinttext: 'new name',
                                          validate: (tr) {},
                                          onchange: (info) {
                                            value = info;
                                            print(value);
                                          },
                                          controller: nameController),
                                      title: 'change name',
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              if (value!.isNotEmpty) {
                                                ShopCubit()
                                                    .get(context)
                                                    .updateProfile(
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text,
                                                        phone: phoneController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text);
                                                Navigator.pop(context);
                                                ShopCubit()
                                                    .get(context)
                                                    .getProfile();
                                              }
                                            },
                                            child: Text('change'))
                                      ]);
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${emailController.text}',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  return buildDialouge(
                                      context,
                                      textBox(
                                          hinttext: 'new email',
                                          validate: (value) {},
                                          onchange: (info) {
                                            value = info;
                                            print(value);
                                          },
                                          controller: emailController),
                                      title: 'change email',
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              if (value!.isNotEmpty) {
                                                ShopCubit()
                                                    .get(context)
                                                    .updateProfile(
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text,
                                                        phone: phoneController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text);
                                                Navigator.pop(context);
                                                ShopCubit()
                                                    .get(context)
                                                    .getProfile();
                                              }
                                            },
                                            child: Text('change'))
                                      ]);
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Phone',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${phoneController.text}',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  return buildDialouge(
                                      context,
                                      textBox(
                                          hinttext: 'new phone',
                                          validate: (value) {},
                                          onchange: (info) {
                                            value = info;
                                            print(value);
                                          },
                                          controller: phoneController),
                                      title: 'change phone',
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              if (value!.isNotEmpty) {
                                                ShopCubit()
                                                    .get(context)
                                                    .updateProfile(
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text,
                                                        phone: phoneController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text);
                                                Navigator.pop(context);
                                                ShopCubit()
                                                    .get(context)
                                                    .getProfile();
                                              }
                                            },
                                            child: Text('change'))
                                      ]);
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '*************',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  return buildDialouge(
                                      context,
                                      textBox(
                                          hinttext: 'new password',
                                          validate: (value) {},
                                          onchange: (info) {
                                            value = info;
                                            print(value);
                                          },
                                          controller: passwordController),
                                      title: 'change password',
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              if (value!.isNotEmpty) {
                                                ShopCubit()
                                                    .get(context)
                                                    .updateProfile(
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text,
                                                        phone: phoneController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text);
                                                Navigator.pop(context);
                                                ShopCubit()
                                                    .get(context)
                                                    .getProfile();
                                              }
                                            },
                                            child: Text('change'))
                                      ]);
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          FloatingActionButton(
                            onPressed: () {
                              ShopLoginCubit().logOut(context);
                            },
                            child: Icon(Icons.logout),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
