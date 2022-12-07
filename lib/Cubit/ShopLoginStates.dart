abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}
class ShopLoginLoadingState extends ShopLoginState{}
class ShopLoginsuccessState extends ShopLoginState{
  final ShopLoginModelData;
  ShopLoginsuccessState(this.ShopLoginModelData);
}
class ShopLoginErrorState extends ShopLoginState{
  final String error;

  ShopLoginErrorState(this.error);
}

