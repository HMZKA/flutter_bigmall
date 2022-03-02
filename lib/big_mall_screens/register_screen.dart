import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/login_cubit.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopLoginCubit().get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Register'),
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: Form(
              key: keyform,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      textBox(
                          hinttext: 'Name',
                          label: Text('Name'),
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                          },
                          prefix: Icon(CupertinoIcons.person),
                          controller: namecontroller),
                      SizedBox(
                        height: 15,
                      ),
                      textBox(
                          keyboard: TextInputType.emailAddress,
                          hinttext: 'Email',
                          label: Text('Email'),
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          prefix: Icon(Icons.email),
                          controller: emailcontroller),
                      SizedBox(
                        height: 15,
                      ),
                      textBox(
                          hinttext: 'Phone',
                          label: Text('Phone'),
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            }
                          },
                          prefix: Icon(CupertinoIcons.phone),
                          controller: phonecontroller),
                      SizedBox(
                        height: 15,
                      ),
                      textBox(
                          isShown: true,
                          hinttext: 'Password',
                          label: Text('Password'),
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'passowrd must not be empty';
                            }
                          },
                          prefix: Icon(CupertinoIcons.lock),
                          controller: passwordcontroller),
                      SizedBox(
                        height: 20,
                      ),
                      state is! RegisterAppLoadingState
                          ? TextButton(
                              onPressed: () {
                                if (keyform.currentState!.validate()) {
                                  cubit.registerData(
                                      context: context,
                                      name: namecontroller.text,
                                      email: emailcontroller.text,
                                      phone: phonecontroller.text,
                                      password: passwordcontroller.text);
                                }
                              },
                              child: Container(
                                color: Colors.blue,
                                width: 300,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'REGISTER ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ))
                          : CircularProgressIndicator()
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
