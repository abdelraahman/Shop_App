class ShopLayoutModel{
  bool? status;
  Data? data;
  ShopLayoutModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    print('status hna $status');
    data = json['data'] != null ? Data.fromJson(json['data']): null;
    print('data hna $data');

  }

}
class Data {
  List<BannersData> bannersdata=[];
  List<ProductsData> productsData=[];
  Data.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      bannersdata.add(BannersData.fromJson(element));
    });
    json['products'].forEach((element){
      productsData.add(ProductsData.fromJson(element));
    });
  }
}
class BannersData {
  int? id;
  String? image;


  BannersData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];

  }


}
class ProductsData {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  bool? inFav;
  bool? inCart;

  ProductsData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFav = json['in_favorites'];
    inCart = json['in_cart'];

  }


}
