class HomeModel {
  bool? status;
  Null message;
  Data? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<Banners>? banners = [];
  List<Products>? products = [];
  String? ad;

  Data({this.banners, this.products, this.ad});

  Data.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((v) {
      banners?.add(Banners.fromJson(v));
    });

    json['products'].forEach((v) {
      products?.add(Products.fromJson(v));
    });

    ad = json['ad'];
  }
}

class Banners {
  int? id;
  String? image;

  Banners({
    this.id,
    this.image,
  });

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Products(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description,
      this.images,
      this.inFavorites,
      this.inCart});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
