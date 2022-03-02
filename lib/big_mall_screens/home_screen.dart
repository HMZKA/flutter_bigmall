import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/model/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit().get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: cubit.homeModel != null,
          builder: (context) {
            return homeBuilder(cubit.homeModel, context);
          },
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget homeBuilder(
    HomeModel? model,
    context,
  ) {
    model = ShopCubit().get(context).homeModel;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model?.data?.banners
                  ?.map((e) => Image(
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: Image(
                                image: AssetImage('images/gifb.gif'),
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              'Connection is slow',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                        image: NetworkImage('${e.image}'),
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 1.0,
                  autoPlayAnimationDuration: Duration(seconds: 1))),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'New Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.85,
                crossAxisCount: 2,
                children: List.generate(
                    model!.data!.products!.length,
                    (index) => InkWell(
                          onTap: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CarouselSlider(
                                        items: model
                                            ?.data?.products?[index].images
                                            ?.map((e) => Image(
                                                  fit: BoxFit.fitWidth,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return Center(
                                                        child: Image(
                                                          image: AssetImage(
                                                              'images/gifb.gif'),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Center(
                                                      child: Text(
                                                        'Connection is slow',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    );
                                                  },
                                                  image: NetworkImage('${e}'),
                                                ))
                                            .toList(),
                                        options: CarouselOptions(
                                            height: 250,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            viewportFraction: 1.0,
                                            autoPlayAnimationDuration:
                                                Duration(seconds: 1)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${model?.data?.products?[index].name}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  '${model?.data?.products?[index].price.round()}\$',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'description:',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${model?.data?.products?[index].description}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                    onPressed: () {},
                                                    child: Container(
                                                      width: 70,
                                                      height: 35,
                                                      color: Colors.blue,
                                                      child: Center(
                                                        child: Text(
                                                          'Buy',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      ShopCubit()
                                                          .get(context)
                                                          .changeFavorites(model
                                                              ?.data
                                                              ?.products?[index]
                                                              .id as int);
                                                    },
                                                    child: Container(
                                                        width: 155,
                                                        height: 36,
                                                        color: Colors.blue,
                                                        child: Center(
                                                          child: ShopCubit()
                                                                      .get(
                                                                          context)
                                                                      .homeModel
                                                                      ?.data
                                                                      ?.products?[
                                                                          index]
                                                                      .inFavorites ??
                                                                  false
                                                              ? Text(
                                                                  'Remove From Favorites',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : Text(
                                                                  'Add To Favorites',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                        )))
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                    alignment: AlignmentDirectional.bottomStart,
                                    children: [
                                      Image(
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Image.asset(
                                                  'images/gifp.gif');
                                            }
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Text(
                                                'Connection is slow',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            );
                                          },
                                          height: 200,
                                          width: double.infinity,
                                          image: NetworkImage(
                                              '${model?.data?.products?[index].image}')),
                                      if (model?.data?.products?[index]
                                              .discount !=
                                          0)
                                        Container(
                                          child: Text(
                                            'DISCOUNT',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.red,
                                        )
                                    ]),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${model?.data?.products?[index].name}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${model?.data?.products?[index].price.round()}\$',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          if (model?.data?.products?[index]
                                                  .discount !=
                                              0)
                                            Text(
                                              '${model?.data?.products?[index].oldPrice.round()}',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              ShopCubit()
                                                  .get(context)
                                                  .changeFavorites(model
                                                      ?.data
                                                      ?.products?[index]
                                                      .id as int);
                                            },
                                            icon: CircleAvatar(
                                              radius: 15.0,
                                              backgroundColor: ShopCubit()
                                                          .get(context)
                                                          .homeModel
                                                          ?.data
                                                          ?.products?[index]
                                                          .inFavorites ??
                                                      false
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              child: Icon(
                                                Icons.favorite_border,
                                                size: 14.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              ))
        ],
      ),
    );
  }

  Widget buildProuduct(model, context, int index, {bool oldPrice = true}) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Image.asset('images/gifp.gif');
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      'Connection is slow',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  );
                },
                height: 200,
                width: double.infinity,
                image: NetworkImage('${model.data?.products?[index].image}')),
            if (model.data?.products?[index].discount != 0 && oldPrice)
              Container(
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
              )
          ]),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.data?.products?[index].name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, height: 1.3),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      '${model.data?.products?[index].price.round()}\$',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    if (model.data?.products?[index].discount != 0 && oldPrice)
                      Text(
                        '${model.data?.products?[index].oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit().get(context).changeFavorites(
                            model.data?.products?[index].id as int);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit().get(context).favorites?[
                                    model.data?.products?[index].id] ??
                                false
                            ? Colors.blue
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
