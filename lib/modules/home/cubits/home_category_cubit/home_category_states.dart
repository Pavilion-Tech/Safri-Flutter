abstract class HomeCategoryStates{}

class HomeCategoryInitState extends HomeCategoryStates{}



class HomeCategoryLoadingState extends HomeCategoryStates{}
class HomeCategorySuccessState extends HomeCategoryStates{}
class HomeCategoryWrongState extends HomeCategoryStates{}
class HomeCategoryErrorState extends HomeCategoryStates{}

class GetCurrentLocationLoadingState extends HomeCategoryStates{}

class GetCurrentLocationState extends HomeCategoryStates{}

class ProviderCategoryLoadingState extends HomeCategoryStates{}
class ProviderCategorySuccessState extends HomeCategoryStates{}
class ProviderCategoryWrongState extends HomeCategoryStates{}
class ProviderCategoryErrorState extends HomeCategoryStates{}

class ProviderCategorySearchLoadingState extends HomeCategoryStates{}
class ProviderCategorySearchSuccessState extends HomeCategoryStates{}
class ProviderCategorySearchWrongState extends HomeCategoryStates{}
class ProviderCategorySearchErrorState extends HomeCategoryStates{}


class EmitState extends HomeCategoryStates{}

class AutoScrollDownState extends HomeCategoryStates{}
