import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/product_screen.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/model/favorites_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homemodel = ShopCubit().get(context).homeModel;
    var favoritesmodel = ShopCubit().get(context).favoritesModel;
    var productmodel = ShopCubit().get(context).productModel;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: ShopCubit().get(context).favoritesModel != null,
          builder: (context) => ShopCubit()
                      .get(context)
                      .favoritesModel
                      ?.data
                      ?.total !=
                  0
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ShopCubit().get(context).getProduct(
                            favoritesmodel?.data?.data?[index].product);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<ShopCubit>(context),
                            child: ProductScreen(),
                          );
                        }));
                      },
                      child: buildListProduct(
                          ShopCubit()
                              .get(context)
                              .favoritesModel
                              ?.data
                              ?.data?[index]
                              .product,
                          context,
                          isFav: true),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: ShopCubit()
                      .get(context)
                      .favoritesModel!
                      .data!
                      .data!
                      .length,
                )
              : Center(
                  child: Text(
                    'No Favorites',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
