import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/login_cubit.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/model/search_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchcontroller = TextEditingController();

    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit().get(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Text(
                'Search',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: textBox(
                      keyboard: TextInputType.name,
                      hinttext: 'Search',
                      onSubmit: (value) {
                        ShopCubit().get(context).searchData(search: value);
                      },
                      onchange: (value) {},
                      validate: (value) {},
                      prefix: Icon(Icons.search),
                      controller: searchcontroller),
                ),
                SizedBox(
                  height: 15,
                ),
                if (state is SearchShopLoadingState)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: LinearProgressIndicator(),
                    ),
                  ),
                if (state is SearchShopSucceedState)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return buildListProduct(
                            cubit.searchModel?.data?.data?[index],
                            context,
                            isOldPrice: false,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: cubit.searchModel!.data!.data!.length),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
