import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/product_screen.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/model/catedetail_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateInfoScreen extends StatelessWidget {
  var model;
  CateInfoScreen(this.model);
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit().get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Color color;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: BuildCondition(
              condition: cubit.cateDetails?.data?.data != null,
              builder: (context) => Container(
                color: Colors.grey[300],
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 1.7,
                  crossAxisCount: 2,
                  children: List.generate(cubit.cateDetails!.data!.data!.length,
                      (index) {
                    bool? color = ShopCubit()
                        .get(context)
                        .cateDetails
                        ?.data
                        ?.data?[index]
                        .infavorites;
                    return InkWell(
                      onTap: () {
                        ShopCubit()
                            .get(context)
                            .getProduct(cubit.cateDetails?.data?.data?[index]);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<ShopCubit>(context),
                            child: ProductScreen(),
                          );
                        }));
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
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Image.asset('images/gifp.gif');
                                        }
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Text(
                                            'Connection is slow',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        );
                                      },
                                      height: 200,
                                      width: double.infinity,
                                      image: NetworkImage(
                                          '${cubit.cateDetails?.data?.data?[index].image}')),
                                  if (cubit.cateDetails?.data?.data?[index]
                                          .discount !=
                                      0)
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
                                    '${cubit.cateDetails?.data?.data?[index].name}',
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
                                        '${cubit.cateDetails?.data?.data?[index].price.round()}\$',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      if (cubit.cateDetails?.data?.data?[index]
                                              .discount !=
                                          0)
                                        Text(
                                          '${cubit.cateDetails?.data?.data?[index].oldPrice.round()}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          ShopCubit()
                                              .get(context)
                                              .changeFavorites(cubit
                                                  .cateDetails
                                                  ?.data
                                                  ?.data?[index]
                                                  .id as int);
                                        },
                                        icon: CircleAvatar(
                                          radius: 15.0,
                                          backgroundColor: ShopCubit()
                                                      .get(context)
                                                      .cateDetails
                                                      ?.data
                                                      ?.data?[index]
                                                      .infavorites ??
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
                    );
                  }),
                ),
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}
