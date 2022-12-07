abstract class ShopLayoutStates{}

class ShopLayoutInitialState extends ShopLayoutStates{}
class ShopLayoutChangeState extends ShopLayoutStates{}
class ShopLoginChangeModeState extends ShopLayoutStates{}
class ShopLayoutAfterAddState extends ShopLayoutStates{}
class ShopLayoutLoadingState extends ShopLayoutStates{}
class ShopLayoutSuccessState extends ShopLayoutStates{}
class CategLayoutSuccessState extends ShopLayoutStates{}
class ShopLayoutErrorAddState extends ShopLayoutStates{}
class FavLayoutSuccessState extends ShopLayoutStates{}
class FavLayoutLoadingState extends ShopLayoutStates{}
class FavLayoutErrorState extends ShopLayoutStates{}

class ProfileSuccessState extends ShopLayoutStates{}
class ProfileLoadingState extends ShopLayoutStates{}
class ProfileErrorState extends ShopLayoutStates{}


class UpdateProfileSuccessState extends ShopLayoutStates{}
class UpdateProfileLoadingState extends ShopLayoutStates{}
class UpdateProfileErrorState extends ShopLayoutStates{}


class ShopLayoutErrorState extends ShopLayoutStates{
  final String error;

  ShopLayoutErrorState(this.error);
}
class CategLayoutErrorState extends ShopLayoutStates{
  final String error;

  CategLayoutErrorState(this.error);
}
