class CateDetails {
  bool? status;
  DataModel? data;
  CateDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  int? currentpage;
  List<Data>? data = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    currentpage = json['current_page'];
    json['data'].forEach((element) {
      data?.add(Data.fromJson(element));
    });
  }
}

class Data {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  bool? infavorites;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    oldPrice = json['old_price'];
    infavorites = json['in_favorites'];
  }
}
