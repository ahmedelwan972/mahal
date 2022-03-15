import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../elmahal_layout/elmahal_layout.dart';
import '../../models/company_model/company_show.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../member/sign_in.dart';

class CompanyShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state) {
        var cubit = ElMahalCubit.get(context);
        if (state is GetShowCompanyErrorState && result!) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(cubit.isArabic?'اسف يوجد مشكله هنا':'Sorry we have error here'),
              content: Container(
                height: 50,
                width: 80,
                color: Colors.red,
                child: TextButton(
                  onPressed: () {
                    navigateAndFinish(context, ElMahal());
                  },
                  child: Text(
                    cubit.isArabic? 'اضغط للرجوع':'Click to Back',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = ElMahalCubit.get(context);
        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.isArabic?'المحل':'El Mahal',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  letterSpacing: 2,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  if(!cubit.fav){
                    cubit.changeF();
                  }

                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: ConditionalBuilder(
              builder: (context) => RefreshIndicator(
                onRefresh: () => refresh(context),
                child: buildCompany(context, cubit.companyShowModel!.data!,),
              ),
              condition: state is! GetShowCompanyLoadingState &&
                  cubit.companyShowModel != null &&
                  state is! EditProfileLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget buildCompany(
    context,
    CompanyShowData data,
  ) {
    var cubit = ElMahalCubit.get(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (data.images!.length > 1)
              CarouselSlider(
                items: data.images!.map((e) => FadeInImage.assetNetwork(
                  placeholder: 'assets/images/holder.jpg',
                  image: 'https://elyafta.com/egypt/public/images/companies/${e.image}',
                  width: double.infinity,
                  imageErrorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/images/holder.jpg'),),
                ),).toList(),
                options: CarouselOptions(
                  height: 300,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                ),
              ),
            if (data.images!.length == 1)
              Container(
                width: double.infinity,
                height: 300,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/holder.jpg',
                  image: 'https://elyafta.com/egypt/public/images/companies/${data.images![0].image}',
                  imageErrorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/images/holder.jpg')),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '${data.name}',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Text(
              '${data.categoryName}',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey,
                ),
                Text(
                  '${data.views}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        '${data.description}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (data.services!.isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.insert_emoticon,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildService(context, data.services![index]),
                          itemCount: data.services!.length,
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.lightBlue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        '${data.address}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    openDialog(context, data);
                  },
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.call,
                      color: Colors.lightBlue,
                      size: 55,
                    ),
                  ),
                ),
                SizedBox(
                  width: 22,
                ),
                InkWell(
                  onTap: () {
                    cubit.openMap(lat: data.lat!, long: data.lang!);
                  },
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.yellow[900],
                      size: 55,
                    ),
                  ),
                ),
                SizedBox(
                  width: 22,
                ),
                InkWell(
                  onTap: () {
                    cubit.share();
                  },
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 55,
                    ),
                  ),
                ),
                SizedBox(
                  width: 22,
                ),
                if(cubit.fav)
                  InkWell(
                  onTap: () {
                    if(token != null ) {
                      if (cubit.favorites[data.id] == null && cubit.fav) {
                        cubit.changeF();
                        cubit.deleteFav(companyId: data.id!).then((value) {
                          cubit.myFav();
                        });
                      } else if (cubit.favorites[data.id]!) {
                        cubit.deleteFav(companyId: data.id!).then((value) {
                          cubit.myFav();
                        });
                      } else if (!cubit.favorites[data.id]!) {
                        cubit.addFav(companyId: data.id!).then((value) {
                          cubit.myFav();
                        });
                      }
                    }else{
                      navigateTo(context, SignInScreen());
                    }
                  },
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: token != null ?cubit.favorites[data.id] != null ? Icon(
                      Icons.favorite,
                      color: cubit.favorites[data.id]! ? Colors.red : Colors.grey,
                      size: 55,
                    ) : cubit.fav ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 55,
                    ):Container():Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 55,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Image(
              image: AssetImage('assets/images/discount_icon.png'),
            ),
            Text(
              cubit.isArabic? 'عروض & تخفيضات' : 'Offers & Discounts',
              style: Theme.of(context).textTheme.headline5,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: defaultColor,
              child: Text(
                cubit.isArabic?'المحل':'El Mahal',
                style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            if (cubit.companyShowModel!.data!.nearby !=
                null)
              Container(
                height: 180,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCatList(
                      context, cubit.companyShowModel!.data!.nearby![index]),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
                  itemCount: cubit.companyShowModel!.data!.nearby!.length,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCatList(context, Nearby nearby) => InkWell(
        onTap: () {
          ElMahalCubit.get(context).companyShow(nearby.id!).then((value) {
            if(!ElMahalCubit.get(context).fav) {
              ElMahalCubit.get(context).changeF();
            }
            navigateTo(context, CompanyShowScreen(),
            );
          });
        },
        child: Container(
          width: 150,
          height: 140,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/holder.jpg',
                image:
                    'https://elyafta.com/egypt/public/images/companies/${nearby.companyLogo}',
                height: 125,
                width: 150,
                //fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image(image: AssetImage('assets/images/holder.jpg')),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${nearby.companyName}',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> refresh(context) {
    return Future.delayed(
      Duration(seconds: 1),
    ).then((value) => navigateTo(context, CompanyShowScreen()));
  }

  Widget buildService(context, Services data) {
    return Text(
      '${data.name}',
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget buildListImage(Images data) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/holder.jpg',
      image: 'https://elyafta.com/egypt/public/images/companies/${data.image}',
      fit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) =>
          Image(image: AssetImage('assets/images/holder.jpg')),
    );
  }

  Future openDialog(context, CompanyShowData mobiles) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(ElMahalCubit.get(context).isArabic? 'اتصال':'Call'),
          content: Container(
            height: 100,
            width: 100,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return phone(mobiles.mobiles![index]);
              },
              itemCount: mobiles.mobiles!.length,
            ),
          ),
        ),
      );
  Widget phone(Mobiles mobile) {
    return TextButton(
      onPressed: () {
        launch('tel:${mobile.mobile}');
      },
      child: Text(
        '${mobile.mobile}',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
