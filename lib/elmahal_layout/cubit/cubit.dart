import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mahal/elmahal_layout/cubit/states.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/category_model/category_model.dart';
import '../../models/category_model/company_category_sub_model.dart';
import '../../models/category_model/sub_category_model.dart';
import '../../models/company_model/add_company_model.dart';
import '../../models/company_model/company_show.dart';
import '../../models/company_model/member_companies_model.dart';
import '../../models/company_model/service_model.dart';
import '../../models/company_model/update_company_model.dart';
import '../../models/discount_model/add_discount_model.dart';
import '../../models/discount_model/member_discounts_model.dart';
import '../../models/edit_model/edit_profile_model.dart';
import '../../models/favorites_model/delete_fav_model.dart';
import '../../models/favorites_model/fav_model.dart';
import '../../models/location_model/city_model.dart';
import '../../models/location_model/governorate_model.dart';
import '../../models/member_model/contact_model.dart';
import '../../models/search_model/cat_list_model.dart';
import '../../models/search_model/city_list_model.dart';
import '../../models/search_model/search_company_model.dart';
import '../../models/search_model/search_discount_model.dart';
import '../../models/sign_models/sign_in_model.dart';
import '../../models/signup_model/signup_model.dart';
import '../../modules/add_free/add_free.dart';
import '../../modules/category/category_screen.dart';
import '../../modules/discount/discount.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_point.dart';
import '../../shared/network/location_helper/geolocator.dart';
import '../../shared/network/remote/dio.dart';

class ElMahalCubit extends Cubit<ElMahalStates> {
  ElMahalCubit() : super(InitState());

  static ElMahalCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  bool isSelect = false;
  bool isSelect2 = false;
  List<int>? cityId = [];
  String? govereName;
  String? cityName;
  String? cateName;
  String? cateSubName;
  List<int>? cateIds = [];
  var companyNameController = TextEditingController();
  var phoneController = TextEditingController();
  var phone2Controller = TextEditingController();
  var addressController = TextEditingController();
  var detailsController = TextEditingController();
  var nameController = TextEditingController();
  var phoneUserController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  List<String>? mobiles = [];

  Locale? locale;

  void setLocale(Locale value) {
    locale = value;
    emit(ChangeLangState());
  }

  bool isArabic = true;
  String lang = 'ar';
  void changeLang() {
    isArabic = !isArabic;
    isArabic ? lang = 'ar' : lang = 'en';
    emit(ChangeLangState());
  }

  bool fav = true;

  void changeF() {
    fav = !fav;
    emit(ChangeFavState());
  }

  Future<void> changeSelect() async {
    isSelect = !isSelect;
    emit(ShopLoginChangeVisiState());
  }

  Future<void> changeSelectB() async {
    isSelectB = !isSelectB;
    emit(ShopLoginChangeVisiState());
  }

  Future<void> changeSelect2() async {
    isSelect2 = !isSelect2;
    emit(ShopLoginChangeVisiState());
  }

  void changeVisi() {
    isPassword = !isPassword;
    emit(ShopLoginChangeVisiState());
  }

  List<Widget> screens = [
    CategoryScreen(),
  //  DiscountScreen(),
    AddFreeScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  ///////////////////////////////////////////////CATEGORY///////////////////////////////////////////////
  CategoryModel? categoryModel;

  void getCategory() async {
    emit(GetCategoryLoadingState());
    await DioHelper.getData(
      url: categoryShow,
      lang: lang,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(GetCategorySuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetCategoryErrorState());
    });
  }

  CompanyCategoryModel? companyCategoryModel;

  Future<void> showCateCompany(int subCategory) async {
    emit(GetCompanyCateLoadingState());
    DioHelper.getData(
      url:
          'company/catSub/$subCategory/${position != null ? position!.latitude : 30.1090705}/${position != null ? position!.longitude : 31.3773879}/${token ?? 0}',
      lang: lang,
    ).then((value) {
      companyCategoryModel = CompanyCategoryModel.fromJson(value.data);
      companyCategoryModel!.data!.forEach((element) {
        favorites.addAll({
          element.id: element.isFav == 1 ? true : false,
        });
      });
      emit(GetCompanyCateSuccessState());
    }).catchError((e) {
      emit(GetCompanyCateErrorState());
    });
  }

  CompanyShowModel? companyShowModel;

  Future<void> companyShow(int id) async {
    emit(GetShowCompanyLoadingState());
    DioHelper.getData(
      url: 'companyData/show/$id',
      lang: lang,
    ).then((value) {
      companyShowModel = CompanyShowModel.fromJson(value.data);
      emit(GetShowCompanySuccessState());
    }).catchError((e) {
      emit(GetShowCompanyErrorState());
    });
  }

  SubCategoryModel? subCategoryModel;

  void getSubCategory(int subCate) {
    emit(GetSubCategoryLoadingState());
    DioHelper.getData(
      url: 'category/sub/$subCate',
      lang: lang,
    ).then((value) {
      subCategoryModel = SubCategoryModel.fromJson(value.data);
      emit(GetSubCategorySuccessState());
    }).catchError((e) {
      emit(GetSubCategoryErrorState());
    });
  }

////////////////////////////////////////////////////////////MEMBER/////////////////////////////////////////////////////////
  SignInModel? signInModel;

  void getSignIn({
    required String mobile,
    required String password,
  }) {
    emit(GetSignInLoadingState());
    DioHelper.postData(
      url: signIn,
      lang: lang,
      data: {
        'mobile': mobile,
        'password': password,
      },
    ).then((value) {
      signInModel = SignInModel.fromJson(value.data);
      emit(GetSignInSuccessState(signInModel!));
    }).catchError((e) {
      print(e.toString());
      emit(GetSignInErrorState());
    });
  }

  MemberDiscountModel? memberDiscountModel;

  Future<void> getMemberDiscount() async {
    emit(GetMemberDiscountLoadingState());
    DioHelper.getData(
      url: 'member/discounts/$token',
      lang: lang,
    ).then((value) {
      memberDiscountModel = MemberDiscountModel.fromJson(value.data);
      emit(GetMemberDiscountSuccessState());
    }).catchError((e) {
      emit(GetMemberDiscountErrorState());
    });
  }

  MemberCompaniesModel? memberCompaniesModel;

  Future<void> getMemberCompanies() async {
    emit(GetMemberCompaniesLoadingState());
    DioHelper.getData(
      url: 'member/companies/$token',
      lang: lang,
    ).then((value) {
      memberCompaniesModel = MemberCompaniesModel.fromJson(value.data);
      emit(GetMemberCompaniesSuccessState());
    }).catchError((e) {
      emit(GetMemberCompaniesErrorState());
    });
  }

  Io.File? profileImage;
  String? profileString;
  Io.File? logoImage;
  var picker = ImagePicker();

  Future<void> getPickedImage() async {
    var pickedCover = await picker.getImage(source: ImageSource.gallery);

    if (pickedCover != null) {
      profileImage = Io.File(pickedCover.path);
      emit(PickImageSuccessState());
    } else {
      print('no image selected');
      emit(PickImageErrorState());
    }
  }

  Future<void> getPickedLogo() async {
    var pickedLogo = await picker.getImage(source: ImageSource.gallery);

    if (pickedLogo != null) {
      logoImage = Io.File(pickedLogo.path);
      emit(PickLogoSuccessState());
    } else {
      print('no image selected');
      emit(PickLogoErrorState());
    }
  }

  Future<void> method3() async {
    final bytes = Io.File(profileImage!.path).readAsBytesSync();
    profileString = base64Encode(bytes);
  }

  EditProfileModel? editProfileModel;

  Future<void> editProfile({
    String? name,
    String? phone,
    String? email,
  }) async {
    emit(EditProfileLoadingState());
    await DioHelper.postData(
      url: 'profile/edit/$token',
      lang: lang,
      data: {
        'image': profileString,
        'name_en': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) {
      editProfileModel = EditProfileModel.fromJson(value.data);
      emit(EditProfileSuccessState());
    }).catchError((e) {
      emit(EditProfileErrorState());
    });
  }

  Future<void> editPassword(String password) async {
    DioHelper.postData(
      url: 'password/edit/$token',
      lang: lang,
      data: {'password': password},
    ).then((value) {
      emit(EditPasswordSuccessState());
    }).catchError((e) {
      emit(EditPasswordErrorState());
    });
  }

  ServiceModel? serviceModel;

  void getService() async {
    await DioHelper.getData(
      url: getServices,
      lang: lang,
    ).then((value) {
      serviceModel = ServiceModel.fromJson(value.data);
      emit(GetServiceSuccessState());
    }).catchError((e) {
      emit(GetServiceErrorState());
    });
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null) {
      imageFileList.addAll(selectedImages);
      emit(SelectMultiImagePickedState());
    } else {
      emit(SelectMultiImagePickedState());
    }
  }

  String image64 = '';
  List<String> images64 = [];
  List<Uint8List> bytes2 = [];

  Future<void> method() async {
    final bytes = Io.File(logoImage!.path).readAsBytesSync();
    image64 = base64Encode(bytes);
  }

  void method2() {
    imageFileList.forEach((e) {
      bytes2.add(Io.File(e.path).readAsBytesSync());
    });

    bytes2.forEach((e) {
      images64.add(base64Encode(e));
    });
  }

  AddCompanyModel? addCompanyModel;

  void addCompany({
    required List<int> service,
  }) {
    mobiles!.add(phoneController.text);
    mobiles!.add(phone2Controller.text);
    emit(AddCompanyLoadingState());
    DioHelper.postData(
      url: addCompanyUrl,
      lang: lang,
      data: {
        'member_id': token,
        'images': images64.toString(),
        'mobiles': mobiles.toString(),
        'city': cityId.toString(),
        'category': cateIds.toString(),
        'address': addressController.text,
        'desc': detailsController.text,
        'name': companyNameController.text,
        'lat': position2!.latitude.toString(),
        'lng': position2!.longitude.toString(),
        'company_logo': image64.toString(),
        'service': service.toString(),
        'user_name': nameController.text,
        'user_mobile': phoneUserController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    ).then((value) {
      addCompanyModel = AddCompanyModel.fromJson(value.data);

      emit(AddCompanySuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(AddCompanyErrorState());
    });
  }

  void addCompanyWithSignUp({required List<int> service, context}) {
    mobiles!.add(phoneController.text);
    mobiles!.add(phone2Controller.text);
    emit(AddCompanyLoadingState());
    DioHelper.postData(
      url: addCompanyUrl,
      lang: lang,
      data: {
        'images': images64.toString(),
        'mobiles': mobiles.toString(),
        'city': cityId.toString(),
        'category': cateIds.toString(),
        'address': addressController.text,
        'desc': detailsController.text,
        'name': companyNameController.text,
        'lat': position2!.latitude.toString(),
        'lng': position2!.longitude.toString(),
        'company_logo': image64.toString(),
        'service': service.toString(),
        'user_name': nameController.text,
        'user_mobile': phoneUserController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    ).then((value) {
      addCompanyModel = AddCompanyModel.fromJson(value.data);
      emit(AddCompanySuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(AddCompanyErrorState());
    });
  }

  var nameSController = TextEditingController();
  var phoneSController = TextEditingController();
  var emailSController = TextEditingController();
  var passwordSController = TextEditingController();
  var passwordS2Controller = TextEditingController();

  SignUpModel? signUpModel;

  List<String> S = ['kkk', 'jjj'];
  List<int> A = [0, 0];
  List<int> B = [0, 0];
  List<int> X = [0];
  List<int> Y = [0];
  double Z = 31.42442;
  double J = 30.146456;
  String O = '0';

  void signUp() {
    emit(SignUpLoadingState());
    DioHelper.postData(
      url: addCompanyUrl,
      lang: lang,
      data: {
        'images': S.toString(),
        'mobiles': A.toString(),
        'city': B.toString(),
        'category': X.toString(),
        'address': 'no',
        'desc': 'no',
        'name': 'no',
        'lat': Z.toString(),
        'lng': J.toString(),
        'company_logo': O.toString(),
        'service': Y.toString(),
        'user_name': nameSController.text,
        'user_mobile': phoneSController.text,
        'email': emailSController.text,
        'password': passwordSController.text,
      },
    ).then((value) {
      signUpModel = SignUpModel.fromJson(value.data);
      emit(SignUpSuccessState(signUpModel!));
    }).catchError((e) {
      print(e.toString());
      emit(SignUpErrorState());
    });
  }

  ContactModel? contactModel;

  Future<void> contactUs({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    DioHelper.postData(
      url: contact,
      lang: lang,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'massege': message,
      },
    ).then((value) {
      contactModel = ContactModel.fromJson(value.data);
      emit(ContactSuccessState());
    }).catchError((e) {
      emit(ContactErrorState());
    });
  }

  String image64BB = '';
  List<String> images64BB = [];
  List<Uint8List> bytes2BB = [];

  Future<void> methodBB() async {
    final bytes = Io.File(logoImage!.path).readAsBytesSync();
    image64BB = base64Encode(bytes);
  }

  void method2BB() {
    imageFileList.forEach((e) {
      bytes2BB.add(Io.File(e.path).readAsBytesSync());
    });

    bytes2BB.forEach((e) {
      images64BB.add(base64Encode(e));
    });
  }

  bool isSelectB = false;
  List<int>? cityIdB = [];
  String? govereNameB;
  String? cityNameB;
  String? cateNameB;
  String? cateSubNameB;
  List<int>? cateIdsB = [];
  var companyNameControllerB = TextEditingController();
  var phoneControllerB = TextEditingController();
  var phone2ControllerB = TextEditingController();
  var addressControllerB = TextEditingController();
  var detailsControllerB = TextEditingController();
  var phoneUserControllerB = TextEditingController();
  var emailControllerB = TextEditingController();
  var passwordControllerB = TextEditingController();
  List<String>? mobilesB = [];
  int? coId;

  Position? position2B;

  Future<void> getCurrentLocation2B() async {
    await LocationHelper.getCurrentLocation();
    position2B = await Geolocator.getLastKnownPosition().whenComplete(() {
      emit(GetCurrentLocationState());
    });
  }

  UpdateCompanyModel? updateCompanyModel;

  void updateCompany({
    required List<int> service,
  }) {
    mobilesB!.add(phoneControllerB.text);
    mobilesB!.add(phone2ControllerB.text);
    emit(UpdateCompanyLoadingState());
    DioHelper.postData(url: editCompany, data: {
      'company_id': coId,
      'desc': detailsControllerB.text,
      'name': companyNameControllerB.text,
      'address': addressControllerB.text,
      'lat': position2B!.latitude.toString(),
      'lng': position2B!.longitude.toString(),
      'company_logo': image64BB.toString(),
      'city': cityIdB.toString(),
      'category': cateIdsB.toString(),
      'images': images64BB,
      'mobiles': mobilesB.toString(),
      'service': service.toString()
    }).then((value) {
      updateCompanyModel = UpdateCompanyModel.fromJson(value.data);
      print(value);
      print(coId);
      print(detailsControllerB.text);
      print(companyNameControllerB.text);
      print(addressControllerB.text);
      print(position2B!.latitude);
      print(position2B!.longitude);
      print(image64BB);
      print(cityIdB);
      print(cateIdsB);
      print(images64BB);
      print(mobilesB);
      print(service);
      emit(UpdateCompanySuccessState());
    }).catchError((e) {
      emit(UpdateCompanyErrorState());
    });
  }

///////////////////////////////////////////////////////CITY///////////////////////////////////////////////

  Position? position;
  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    await LocationHelper.getCurrentLocation();
    position = await Geolocator.getLastKnownPosition().whenComplete(() async {
      await getAddress();
      emit(GetCurrentLocationState());
    });
  }

  String myAddressName = '';
  String cityT = '';

  Future<void> getAddress() async {
    if (position != null) {
      List<Placemark> place = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark placeMark = place[0];
      myAddressName = placeMark.locality!;
      cityT = placeMark.country!;
    }
  }

  Position? position2;

  Future<void> getCurrentLocation2() async {
    await LocationHelper.getCurrentLocation();
    position2 = await Geolocator.getLastKnownPosition().whenComplete(() {
      emit(GetCurrentLocationState());
    });
  }

  Governorate? governorate;

  void getLocation() {
    DioHelper.getData(
      url: getGovernorate,
      lang: lang,
    ).then((value) {
      governorate = Governorate.fromJson(value.data);
      emit(GetGovernorateSuccessState());
    }).catchError((e) {
      emit(GetGovernorateErrorState());
    });
  }

  CityModel? cityModel;

  void getCityLocation(int id) {
    emit(GetCityLoadingState());
    DioHelper.postData(
      url: getCity,
      lang: lang,
      data: {
        'sub': id,
      },
    ).then((value) {
      cityModel = CityModel.fromJson(value.data);
      emit(GetCitySuccessState());
    }).catchError((e) {
      emit(GetCitySuccessState());
    });
  }

  Future<void> openMap({required String lat, required String long}) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  Future<void> share() async {
    Share.share('Sorry this is empty for now :D');
  }

//////////////////////////////////////////////////////////////FAVORITES//////////////////////////////////////////////

  Map<int, bool> favorites = {};

  Future<void> addFav({required int companyId}) async {
    favorites[companyId] = !favorites[companyId]!;

    await DioHelper.postData(
      url: addFavorite,
      lang: lang,
      data: {
        'type': 'company',
        'member_id': token,
        'id': companyId,
      },
    ).then((value) {
      if (value.data['status'] == 0) {
        favorites[companyId] = !favorites[companyId]!;
      }
      emit(AddFavoritesSuccessState());
    }).catchError((e) {
      favorites[companyId] = !favorites[companyId]!;
      emit(AddFavoritesErrorState());
    });
  }

  DeleteFavModel? deleteFavModel;

  Future<void> deleteFav({required int companyId}) async {
    if (fav) {
      favorites[companyId] = !favorites[companyId]!;
    }
    emit(DeleteFavoritesSuccessState());
    await DioHelper.postData(
      url: deleteFavorite,
      lang: lang,
      data: {
        'type': 'company',
        'member_id': token,
        'id': companyId,
      },
    ).then((value) {
      deleteFavModel = DeleteFavModel.fromJson(value.data);
      if (value.data['status'] == 0) {
        favorites[companyId] = !favorites[companyId]!;
      }
      emit(DeleteFavoritesSuccessState());
    }).catchError((e) {
      if (fav) {
        favorites[companyId] = !favorites[companyId]!;
      }
      emit(DeleteFavoritesErrorState());
    });
  }

  GetFavModel? getFavModel;

  Future<void> myFav() async {
    emit(MyFavoritesLoadingState());
    DioHelper.getData(
      url: 'getFavorite/company/$token',
      lang: lang,
    ).then((value) {
      getFavModel = GetFavModel.fromJson(value.data);
      //print(value.data);
      emit(MyFavoritesSuccessState());
    }).catchError((e) {
      emit(MyFavoritesErrorState());
    });
  }

///////////////////////////////////////////////////////////////SEARCH///////////////////////////////

  SearchCompanyModel? searchCompanyModel;

  Future<void> searchCompany({
    required String text,
  }) async {
    emit(SearchCompanyLoadingState());
    DioHelper.postData(url: searchCompanyNow, lang: lang, data: {
      'city_id': citId ?? 0,
      'sub_cat': catId ?? 0,
      'lat': position3 == null ? 0 : position3!.latitude,
      'lng': position3 == null ? 0 : position3!.longitude,
      'text1': text,
    }).then((value) {
      searchCompanyModel = SearchCompanyModel.fromJson(value.data);
      emit(SearchCompanySuccessState());
    }).catchError((e) {
      emit(SearchCompanyErrorState());
    });
  }

  CatListModel? catListModel;

  void cateList() async {
    await DioHelper.getData(
      url: catList,
      lang: lang,
    ).then((value) {
      catListModel = CatListModel.fromJson(value.data);
      emit(CatListSuccessState());
    }).catchError((e) {
      emit(CatListErrorState());
    });
  }

  CityListModel? cityListModel;

  void cityList() async {
    await DioHelper.getData(
      url: accentList,
      lang: lang,
    ).then((value) {
      cityListModel = CityListModel.fromJson(value.data);
      emit(CityListSuccessState());
    }).catchError((e) {
      emit(CityListErrorState());
    });
  }

  String? cat;
  String? city;
  int? catId;
  int? citId;

  String? cat2;
  String? city2;
  int? catId2;

  Position? position3;

  Future<void> getCurrentLocation3() async {
    await LocationHelper.getCurrentLocation();
    position3 = await Geolocator.getLastKnownPosition().whenComplete(() {
      emit(GetCurrentLocationState());
    });
  }

  Position? position4;

  Future<void> getCurrentLocation4() async {
    await LocationHelper.getCurrentLocation();
    position4 = await Geolocator.getLastKnownPosition().whenComplete(() {
      emit(GetCurrentLocationState());
    });
  }

  bool currentLocation = false;

  changeCheck() {
    currentLocation = !currentLocation;
    emit(ChangeCheckState());
  }

  bool currentLocation4 = false;
  bool isSearchCompany = true;

  changeCheck4() {
    currentLocation4 = !currentLocation4;
    emit(ChangeCheckState());
  }

  isSearchCompanyEmit() {
    isSearchCompany = !isSearchCompany;
    emit(ChangeCheckState());
  }

  void justEmitState() {
    emit(JustEmitState());
  }

  SearchDiscountModel? searchDiscountModel;

  void searchDiscount({String? text}) {
    emit(SearchDiscountLoadingState());
    DioHelper.postData(
      url: searchDis,
      lang: lang,
      data: {
        'category_id': catId2,
        'type': text,
        'lat': position4 == null ? 0 : position4!.latitude,
        'lng': position4 == null ? 0 : position4!.longitude,
      },
    ).then((value) {
      searchDiscountModel = SearchDiscountModel.fromJson(value.data);
      emit(SearchDiscountSuccessState());
    }).catchError((e) {
      emit(SearchDiscountErrorState());
    });
  }

////////////////////////////////////////////////DISCOUNT////////////////////////////////

  AddDiscountModel? addDiscountModel;

  Future<void> addDiscount({
    required List<int> cId,
    required String nameDis,
    required String desc,
  }) async {
    emit(AddDiscountLoadingState());
    DioHelper.postData(
      url: addDisC,
      lang: lang,
      data: {
        'company_id': cId,
        'type': 'Time',
        'name': nameDis,
        'start_date': startDate,
        'end_date': lastDate,
        'desc': desc,
        'image': image64B,
        'images': images64B,
      },
    ).then((value) {
      addDiscountModel = AddDiscountModel.fromJson(value.data);
      emit(AddDiscountSuccessState());
    }).catchError((e) {
      emit(AddDiscountErrorState());
    });
  }

  Io.File? logoDisImage;

  Future<void> getPickedLogoDis() async {
    var pickedLogo = await picker.getImage(source: ImageSource.gallery);

    if (pickedLogo != null) {
      logoDisImage = Io.File(pickedLogo.path);
      emit(PickLogoSuccessState());
    } else {
      print('no image selected');
      emit(PickLogoErrorState());
    }
  }

  List<XFile>? imageFileDisList = [];

  void selectImagesDis() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null) {
      imageFileDisList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileDisList!.length.toString());
    emit(SelectMultiImagePickedState());
  }

  bool currentLocation2 = false;

  changeCheck2() {
    currentLocation2 = !currentLocation2;
    emit(ChangeCheckState());
  }

  bool currentLocation3 = false;

  changeCheck3() {
    currentLocation3 = !currentLocation3;
    emit(ChangeCheckState());
  }

  String? startDate;
  String? lastDate;

  String image64B = '';
  List<String> images64B = [];
  List<Uint8List> bytes2B = [];

  Future<void> methodB() async {
    final bytes = Io.File(logoDisImage!.path).readAsBytesSync();
    image64B = base64Encode(bytes);
  }

  void method2B() {
    imageFileDisList!.forEach((e) {
      bytes2B.add(Io.File(e.path).readAsBytesSync());
    });

    bytes2B.forEach((e) {
      images64B.add(base64Encode(e));
    });
  }

  checkInterNet() async {
    await InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      result = state;
      print(result);
      emit(CheckNetState());
    });
  }
}
