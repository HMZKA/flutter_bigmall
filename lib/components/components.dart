import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigmall/cubit&states/login_cubit.dart';
import 'package:flutter_bigmall/cubit&states/shop_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void navigateTo(context, widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopLoginCubit>(context),
      child: widget,
    );
  }));
}

void navigateAndRemove(
  context,
  widget,
) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopLoginCubit>(context),
      child: widget,
    );
  }), (route) => false);
}

Widget textBox(
    {required String hinttext,
    required dynamic validate,
    Widget? prefix,
    dynamic onchange,
    dynamic onSubmit,
    Widget? label,
    Widget? suffix,
    TextInputType? keyboard,
    required TextEditingController controller,
    bool? isShown}) {
  return TextFormField(
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      keyboardType: keyboard,
      obscureText: isShown ?? false,
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hinttext,
          prefixIcon: prefix,
          suffixIcon: suffix,
          label: label));
}

Widget buildGridProuduct(model, context, {bool oldPrice = true}) {
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                );
              },
              height: 200,
              width: double.infinity,
              image: NetworkImage(
                  'https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg')),
          if (model.discount != 0 && oldPrice)
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
                '${model.name}',
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
                    '${model.price.round()}\$',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  if (model.discount != 0 && oldPrice)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit().get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                          ShopCubit().get(context).favorites?[model.id] ?? false
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

buildDialouge(context, content, {title, List<Widget>? actions}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(20),
        titlePadding: EdgeInsets.all(15),
        title: Text('${title}'),
        content: content,
        actions: actions,
      );
    },
  );
}

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
  int? index,
  bool isFav = false,
}) {
  var homemodel = ShopCubit().get(context).homeModel;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120.0,
                height: 120.0,
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.0, height: 1.3, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}\$',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit().get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: isFav || model.inFavorites
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
}
