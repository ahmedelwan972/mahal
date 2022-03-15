import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/member/contact_screen.dart';
import '../modules/member/info_app.dart';
import '../modules/member/member_companies.dart';
import '../modules/member/member_discount.dart';
import '../modules/member/my_favorites.dart';
import '../modules/member/profile.dart';
import '../modules/member/sign_in.dart';
import '../modules/member/sign_up.dart';
import '../modules/search/search_screen.dart';
import '../modules/select_location/select_governorate.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/network/local/cache_helper.dart';
import '../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ElMahal extends StatelessWidget {
  ElMahal({this.name});
  String? name;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state) {
        checkNet(context);
      },
      builder: (context, state) {
        var cubit = ElMahalCubit.get(context);
        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.isArabic ? 'المحل' : 'ElMahal',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  letterSpacing: 2,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    cubit.getLocation();
                    cubit.getCurrentLocation();
                    navigateTo(context, SelectGovernorate());
                  },
                  child: Row(
                    children: [
                      cubit.myAddressName.isEmpty
                          ? Text(
                              name == null
                                  ? cubit.isArabic
                                      ? 'اختر المدينة'
                                      : 'Choose the city'
                                  : name.toString(),
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 0,
                                      ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  cubit.myAddressName.toString(),
                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    height: 0,
                                      ),
                                ),
                                Text(
                                  cubit.cityT.toString(),
                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    height: 0,
                                      ),
                                ),
                              ],
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Image(
                        width: 25,
                        height: 25,
                        image: AssetImage(
                          'assets/images/map_icon.png',
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            drawer: Container(
              color: Colors.white,
              width: 250,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: defaultColor,
                        child: Text(
                          cubit.isArabic ? 'المحل' : 'El Mahal',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, ElMahal());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            cubit.isArabic ? 'الصفحة الرئيسية' : 'Homepage ',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (token != null)
                      InkWell(
                        onTap: () {
                          cubit.editProfile();
                          navigateTo(context, Profile());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              cubit.isArabic ? 'الصفحة الشخصيه' : 'Profile',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    if (token != null)
                      SizedBox(
                        height: 20,
                      ),
                    if (token != null)
                      InkWell(
                        onTap: () {
                          cubit.myFav();
                          navigateTo(context, MyFav());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              cubit.isArabic ? 'المفضلة' : 'Favorites',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    if (token != null)
                      SizedBox(
                        height: 20,
                      ),
                    if (token != null)
                      InkWell(
                        onTap: () {
                          cubit.getMemberCompanies();
                          navigateTo(context, MemberCompanies());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.business,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              cubit.isArabic ? 'شركاتي' : 'My Company',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    if (token != null)
                      SizedBox(
                        height: 20,
                      ),
                    if (token != null)
                      InkWell(
                        onTap: () {
                          cubit.getMemberDiscount().then((value) {
                            navigateTo(context, MemberDiscount());
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_offer,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              cubit.isArabic ? 'تخفيضاتي' : 'My Discounts',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    if (token != null)
                      SizedBox(
                        height: 20,
                      ),
                    if (token == null)
                      InkWell(
                        onTap: () {
                          navigateTo(context, SignInScreen());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              cubit.isArabic ? 'تسجيل الدخول' : 'Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    if (token == null)
                      SizedBox(
                        height: 20,
                      ),
                    if (token == null)
                      InkWell(
                        onTap: () {
                          navigateTo(context, SignUpScreen());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_add,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              cubit.isArabic
                                  ? 'تسجيل حساب جديد'
                                  : 'Register a new account',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    if (token == null)
                      SizedBox(
                        height: 20,
                      ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, InfoScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            cubit.isArabic ? 'عن النطبيق' : 'About the app',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, ConnectScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            cubit.isArabic ? 'تواصل معانا' : 'Connect with us',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, InfoScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.question_answer_outlined,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            cubit.isArabic
                                ? 'الاسئلة الشائعة'
                                : 'Common Questions',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        openDialog(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.language_outlined,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            cubit.isArabic ? 'اللغة' : 'Language',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (token != null)
                      InkWell(
                        onTap: () {
                          CacheHelper.removeData('myId');
                          token = null;
                          navigateAndFinish(context, ElMahal());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              cubit.isArabic ? 'تسجيل الخروج' : 'Sign Out',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0.0,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              backgroundColor: Colors.grey[50],
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: cubit.isArabic ? 'الاقسام' : 'Category',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.whatshot),
                //   label: cubit.isArabic ? 'التخفيضات' : 'Discounts',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_business_outlined),
                  label: cubit.isArabic ? 'اضف مجانا' : 'Add Free',
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          ),
        );
      },
    );
  }

  Future openDialog(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  //   ElMahalCubit.get(context).setLocale(Locale.fromSubtags(languageCode: 'ar'));
                  ElMahalCubit.get(context).changeLang();
                  navigateAndFinish(context, ElMahal());
                },
                child: Text(
                  ElMahalCubit.get(context).isArabic ? 'English' : 'العربية',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
}
