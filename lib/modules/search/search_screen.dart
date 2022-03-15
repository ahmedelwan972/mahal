import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahal/modules/search/search_result2_screen.dart';
import 'package:mahal/modules/search/search_result_screen.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../models/search_model/cat_list_model.dart';
import '../../models/search_model/city_list_model.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  var search2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ElMahalCubit.get(context);
        return DefaultTabController(
          length: 2,
          child: Directionality(
            textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios
                  ),
                  onPressed: (){
                    Navigator.pop(context);

                      searchController.text = '';
                      cubit.cat = null;
                      cubit.catId = null;
                      cubit.position3 = null;
                      cubit.city = null;


                      search2Controller.text = '';
                      cubit.cat2 = null;
                      cubit.catId2 = null;
                      cubit.position4 = null;
                      cubit.city2 = null;

                  },
                ),
              //  backgroundColor: Colors.black,
                title: Text(
                  cubit.isArabic ? 'المحل' : 'ElMahal',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                    letterSpacing: 2,
                  ),
                ),
                bottomOpacity: 0.9,
                bottom: TabBar(
                  labelColor: Colors.white,
                  onTap: (value){
                    cubit.isSearchCompanyEmit();
                  },
                 // overlayColor: MaterialStateProperty.all(Colors.black),
                  indicatorColor: Colors.red[900],
                  tabs:
                  [
                    Tab(
                      text: cubit.isArabic ?'البحث في الشركات' : 'Search Companies',
                    ),
                    Tab(
                      text: cubit.isArabic ? 'البحث في العروض' : 'Search offers',
                    ),
                  ],
                ),
              ),
              body: RefreshIndicator(
                onRefresh: () => refresh(context),
                child: TabBarView(
                  children: [
                    ConditionalBuilder(
                      condition: cubit.catListModel != null &&
                          cubit.cityListModel != null &&
                          state is! SearchCompanyLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            defaultFormField(
                              controller: searchController,
                              type: TextInputType.text,
                              text: cubit.isArabic ? 'اكتب ما تبحث عنه' :'Write what you are looking for',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  openDialog(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    cubit.cat == null
                                        ? Text(
                                      cubit.isArabic ? 'قم باختيار القسم' : 'Choose the Category',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    )
                                        : Text(
                                      '${cubit.cat}',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Icon(Icons.arrow_drop_down_circle_outlined),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                if (!cubit.currentLocation) {
                                  cubit.getCurrentLocation3();
                                  cubit.changeCheck();
                                } else {
                                  cubit.position3 = null;
                                  cubit.changeCheck();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    cubit.isArabic ? 'قريب مني' : 'Close to me',
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Icon(
                                    !cubit.currentLocation
                                        ? Icons.check_box_outline_blank_sharp
                                        : Icons.check_box,
                                   // color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  openDialog2(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    cubit.city == null
                                        ? Text(
                                      cubit.isArabic ? 'قم باختيار المدينة' : 'Choose the City',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    )
                                        : Text(
                                      '${cubit.city}',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Icon(Icons.arrow_drop_down_circle_outlined),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50.0,
                              child: MaterialButton(
                                child: Text(
                                  cubit.isArabic ?'بحث' : 'Search',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  cubit.searchCompany(text: searchController.text);
                                  navigateTo(context, SearchResultScreen());
                                  if(searchController.text != ''){
                                    searchController.text = '';
                                    cubit.cat = null;
                                    cubit.catId = null;
                                    cubit.position3 = null;
                                    cubit.city = null;
                                    cubit.cityId = null;

                                  }
                                },
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator()),
                    ),
                    ConditionalBuilder(
                      condition: cubit.catListModel != null &&
                          cubit.cityListModel != null &&
                          state is! SearchCompanyLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            defaultFormField(
                              controller: search2Controller,
                              type: TextInputType.text,
                              text: cubit.isArabic ? 'اكتب ما تبحث عنه' :'Write what you are looking for',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  openDialog(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    cubit.cat2 == null
                                        ? Text(
                                      cubit.isArabic ? 'قم باختيار القسم' : 'Choose the Category',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    )
                                        : Text(
                                      '${cubit.cat2}',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Icon(Icons.arrow_drop_down_circle_outlined),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                if (!cubit.currentLocation4) {
                                  cubit.getCurrentLocation4();
                                  cubit.changeCheck4();
                                } else {
                                  cubit.position4 = null;
                                  cubit.changeCheck4();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    cubit.isArabic ? 'قريب مني' : 'Close to me',
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Icon(
                                    !cubit.currentLocation4
                                        ? Icons.check_box_outline_blank_sharp
                                        : Icons.check_box,
                                  //  color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  openDialog2(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    cubit.city2 == null
                                        ? Text(
                                      cubit.isArabic ? 'قم باختيار المدينة' : 'Choose the City',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    )
                                        : Text(
                                      '${cubit.city2}',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Icon(Icons.arrow_drop_down_circle_outlined),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50.0,
                              child: MaterialButton(
                                child: Text(
                                  cubit.isArabic ?'بحث' : 'Search',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  cubit.searchDiscount(text: search2Controller.text);
                                  navigateTo(context, SearchResult2Screen());
                                  if(search2Controller.text != ''){
                                    search2Controller.text = '';
                                    cubit.cat2 = null;
                                    cubit.catId2 = null;
                                    cubit.position4 = null;
                                    cubit.city2 = null;
                                  }
                                },
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future openDialog(context) async {
    var cubit = ElMahalCubit.get(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(5),
        content: Container(
          height: 500,
          width: 300,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    if(cubit.isSearchCompany){
                      return buildCatList(cubit.catListModel!.data![index], context);
                    }else{
                      return buildCatList2(cubit.catListModel!.data![index], context);
                    }
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 1,
                  ),
                  itemCount: cubit.catListModel!.data!.length,
                ),
              ),
              Align(
                child: defaultButton(

                    function: () {
                      Navigator.pop(context);
                    },
                    text: 'موافق',
                    width: 100),
                alignment: AlignmentDirectional.bottomStart,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCatList(CatListData data, context) {
    var cubit = ElMahalCubit.get(context);
    return Align(
      alignment: AlignmentDirectional.center,
      child: TextButton(
        child: Text(
          '${data.name}',
        ),
        onPressed: () {
          cubit.cat = data.name;
          cubit.catId = data.id;
          cubit.justEmitState();
          Navigator.pop(context);
        },
      ),
    );
  }
  Widget buildCatList2(CatListData data, context) {
    var cubit = ElMahalCubit.get(context);
    return Align(
      alignment: AlignmentDirectional.center,
      child: TextButton(
        child: Text(
          '${data.name}',
        ),
        onPressed: () {
          cubit.cat2 = data.name;
          cubit.catId2 = data.id;
          cubit.justEmitState();
          Navigator.pop(context);
        },
      ),
    );
  }

  Future openDialog2(context) async {
    var cubit = ElMahalCubit.get(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 500,
          width: 300,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    if(cubit.isSearchCompany){
                      return buildCityList(cubit.cityListModel!.data![index], context);
                    }else{
                      return buildCityList2(cubit.cityListModel!.data![index], context);
                    }
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 1,
                  ),
                  itemCount: cubit.cityListModel!.data!.length,
                ),
              ),
              Align(
                child: defaultButton(
                    function: () {
                      Navigator.pop(context);
                    },
                    text: 'موافق',
                    width: 100),
                alignment: AlignmentDirectional.bottomStart,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCityList(CityListData data, context) {
    var cubit = ElMahalCubit.get(context);
    return TextButton(
      child: Text(
        '${data.name}',
      ),
      onPressed: () {
        cubit.city = data.name;
        cubit.citId = data.id;
        cubit.justEmitState();
        Navigator.pop(context);
      },
    );
  }
  Widget buildCityList2(CityListData data, context) {
    var cubit = ElMahalCubit.get(context);
    return TextButton(
      child: Text(
        '${data.name}',
      ),
      onPressed: () {
        cubit.city2 = data.name;
        cubit.justEmitState();
        Navigator.pop(context);
      },
    );
  }
}
