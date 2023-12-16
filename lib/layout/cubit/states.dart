abstract class FastStates{}

class FastInitState extends FastStates{}

class ChangeIndexState extends FastStates{}

class EmitState extends FastStates{}



class HomeSuccessState extends FastStates{}
class HomeWrongState extends FastStates{}
class HomeErrorState extends FastStates{}





class ProviderProductsLoadingState extends FastStates{}
class ProviderProductsSuccessState extends FastStates{}
class ProviderProductsWrongState extends FastStates{}
class ProviderProductsErrorState extends FastStates{}

class ProviderBranchesLoadingState extends FastStates{}
class ProviderBranchesSuccessState extends FastStates{}
class ProviderBranchesWrongState extends FastStates{}
class ProviderBranchesErrorState extends FastStates{}


class RateLoadingState extends FastStates{}
class RateSuccessState extends FastStates{}
class RateWrongState extends FastStates{}
class RateErrorState extends FastStates{}

class AddToCartLoadingState extends FastStates{}
class AddToCartSuccessState extends FastStates{}
class AddToCartWrongState extends FastStates{}
class AddToCartErrorState extends FastStates{}

class GetCartLoadingState extends FastStates{}
class GetCartSuccessState extends FastStates{}
class GetCartWrongState extends FastStates{}
class GetCartErrorState extends FastStates{}

class CreateOrderLoadingState extends FastStates{}
class CreateOrderSuccessState extends FastStates{
  String? id;
  CreateOrderSuccessState({this.id});
}
class CreateOrderWrongState extends FastStates{}
class CreateOrderErrorState extends FastStates{}

class NotifyMeLoadingState extends FastStates{}
class NotifyMeSuccessState extends FastStates{}
class NotifyMeWrongState extends FastStates{}
class NotifyMeErrorState extends FastStates{}

class DeleteAllCartLoadingState extends FastStates{}
class DeleteAllCartSuccessState extends FastStates{}
class DeleteAllCartWrongState extends FastStates{}
class DeleteAllCartErrorState extends FastStates{}


class CouponLoadingState extends FastStates{}
class CouponSuccessState extends FastStates{}
class CouponWrongState extends FastStates{}
class CouponErrorState extends FastStates{}


class SingleProviderLoadingState extends FastStates{}
class SingleProviderSuccessState extends FastStates{}
class SingleProviderWrongState extends FastStates{}
class SingleProviderErrorState extends FastStates{}

///add remove product from fav
class AddOrRemoveProductFavoriteLoadingState extends FastStates{}
class AddOrRemoveProductFavoriteSuccessState extends FastStates{}
class AddOrRemoveProductFavoriteWrongState extends FastStates{}
class AddOrRemoveProductFavoriteErrorState extends FastStates{}


///Check Order Status
class CheckOrderStatusLoadingState extends FastStates{}
class CheckOrderStatusSuccessState extends FastStates{}
class CheckOrderStatusWrongState extends FastStates{}
class CheckOrderStatusErrorState extends FastStates{}