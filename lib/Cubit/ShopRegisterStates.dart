abstract class ShopRegState{}

class ShopRegInitialState extends ShopRegState{}
class ShopRegLoadingState extends ShopRegState{}
class ShopRegsuccessState extends ShopRegState{
  final ShopLoginModelData;
  ShopRegsuccessState(this.ShopLoginModelData);
}
class ShopRegErrorState extends ShopRegState{
  final String error;

  ShopRegErrorState(this.error);
}

