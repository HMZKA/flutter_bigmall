import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/big_mall_screens/categoriesdetails_screen.dart';
import 'package:flutter_bigmall/components/components.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bigmall/cubit&states/states.dart';
import 'package:flutter_bigmall/model/categories_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit().get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: cubit.categoriesModel != null,
          builder: (context) {
            return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildCateItem(
                    cubit.categoriesModel?.data?.data?[index], context, index),
                separatorBuilder: (context, index) => Divider(),
                itemCount: cubit.categoriesModel!.data!.data!.length);
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

  Widget buildCateItem(DataModel? model, context, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return BlocProvider.value(
              value: BlocProvider.of<ShopCubit>(context),
              child: CateInfoScreen(model),
            );
          }));
          ShopCubit().get(context).cateDetails = null;
          ShopCubit().get(context).getCateDetail(model);
        },
        child: Row(
          children: [
            Image(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('images/gifp.gif'),
                      ),
                    );
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
                height: 100,
                width: 100,
                image: NetworkImage('${model?.image}')),
            SizedBox(
              width: 20,
            ),
            Text(
              '${model?.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}
