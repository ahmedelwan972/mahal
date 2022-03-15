
import '../../models/sign_models/sign_in_model.dart';
import '../../models/signup_model/signup_model.dart';

abstract class ElMahalStates{}

class InitState extends ElMahalStates {}

class ChangeBottomNavState extends ElMahalStates {}

class GetCategoryLoadingState extends ElMahalStates {}

class GetCategorySuccessState extends ElMahalStates {}

class GetCategoryErrorState extends ElMahalStates {}

class GetGovernorateSuccessState extends ElMahalStates {}

class GetGovernorateErrorState extends ElMahalStates {}

class GetCityLoadingState extends ElMahalStates {}

class GetCitySuccessState extends ElMahalStates {}

class GetCityErrorState extends ElMahalStates {}

class ChangeLangState extends ElMahalStates {}

class GetSignInSuccessState extends ElMahalStates {
  SignInModel? signInModel;
  GetSignInSuccessState(this.signInModel);
}

class GetSignInErrorState extends ElMahalStates {
}

class GetSignInLoadingState extends ElMahalStates {}

class GetSubCategoryLoadingState extends ElMahalStates {}

class GetSubCategorySuccessState extends ElMahalStates {}

class GetSubCategoryErrorState extends ElMahalStates {}

class GetCurrentLocationLoadingState extends ElMahalStates {}

class GetCurrentLocationState extends ElMahalStates {}

class GetCompanyCateLoadingState extends ElMahalStates {}

class GetCompanyCateSuccessState extends ElMahalStates {}

class GetCompanyCateErrorState extends ElMahalStates {}

class ChangeFavState extends ElMahalStates {}

class ShopLoginChangeVisiState extends ElMahalStates {}

class GetShowCompanyLoadingState extends ElMahalStates {}

class GetShowCompanySuccessState extends ElMahalStates {}

class GetShowCompanyErrorState extends ElMahalStates {}

class ViewPlusState extends ElMahalStates {}

class GetMemberCompaniesLoadingState extends ElMahalStates {}

class GetMemberCompaniesSuccessState extends ElMahalStates {}

class GetMemberCompaniesErrorState extends ElMahalStates {}

class GetMemberDiscountLoadingState extends ElMahalStates {}

class GetMemberDiscountSuccessState extends ElMahalStates {}

class GetMemberDiscountErrorState extends ElMahalStates {}

class PickImageSuccessState extends ElMahalStates {}

class PickImageErrorState extends ElMahalStates {}

class PickLogoSuccessState extends ElMahalStates {}

class PickLogoErrorState extends ElMahalStates {}

class EditProfileLoadingState extends ElMahalStates {}

class EditProfileSuccessState extends ElMahalStates {}

class EditProfileErrorState extends ElMahalStates {}

class EditPasswordSuccessState extends ElMahalStates {}

class EditPasswordErrorState extends ElMahalStates {}

class GetServiceSuccessState extends ElMahalStates {}

class GetServiceErrorState extends ElMahalStates {}

class SelectMultiImagePickedState extends ElMahalStates {}

class AddCompanyLoadingState extends ElMahalStates {}

class AddCompanySuccessState extends ElMahalStates {}

class AddCompanyErrorState extends ElMahalStates {}

class ContactSuccessState extends ElMahalStates {}

class ContactErrorState extends ElMahalStates {}

class AddFavoritesSuccessState extends ElMahalStates {}

class AddFavoritesErrorState extends ElMahalStates {}

class DeleteFavoritesLoadingState extends ElMahalStates {}

class DeleteFavoritesSuccessState extends ElMahalStates {}

class DeleteFavoritesErrorState extends ElMahalStates {}

class MyFavoritesLoadingState extends ElMahalStates {}

class MyFavoritesSuccessState extends ElMahalStates {}

class MyFavoritesErrorState extends ElMahalStates {}

class SearchCompanyLoadingState extends ElMahalStates {}

class SearchCompanySuccessState extends ElMahalStates {}

class SearchCompanyErrorState extends ElMahalStates {}

class CatListSuccessState extends ElMahalStates {}

class CatListErrorState extends ElMahalStates {}

class CityListSuccessState extends ElMahalStates {}

class CityListErrorState extends ElMahalStates {}

class ChangeCheckState extends ElMahalStates {}

class JustEmitState extends ElMahalStates {}

class AddDiscountLoadingState extends ElMahalStates {}

class AddDiscountSuccessState extends ElMahalStates {}

class AddDiscountErrorState extends ElMahalStates {}

class SearchDiscountLoadingState extends ElMahalStates {}

class SearchDiscountSuccessState extends ElMahalStates {}

class SearchDiscountErrorState extends ElMahalStates {}

class CheckNetState extends ElMahalStates {}

class SignUpLoadingState extends ElMahalStates {}


class SignUpSuccessState extends ElMahalStates {
  SignUpModel signUpModel;
  SignUpSuccessState(this.signUpModel);

}

class SignUpErrorState extends ElMahalStates {}

class UpdateCompanyLoadingState extends ElMahalStates {}

class UpdateCompanySuccessState extends ElMahalStates {}

class UpdateCompanyErrorState extends ElMahalStates {}







