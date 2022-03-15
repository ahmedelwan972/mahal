import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../models/category_model/company_category_sub_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../company/company_show.dart';
import '../member/sign_in.dart';

class CompanyCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ElMahalCubit.get(context);
        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.isArabic?'المحل': 'El Mahal',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  letterSpacing: 2,
                ),
              ),
            ),
            body: ConditionalBuilder(
                builder: (context) => RefreshIndicator(
                      onRefresh: ()=> refresh(context),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCateItem(
                            cubit.companyCategoryModel!.data![index], context),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 1,
                        ),
                        itemCount: cubit.companyCategoryModel!.data!.length,
                      ),
                    ),
                condition: cubit.companyCategoryModel != null  && state is! GetCompanyCateLoadingState,
                fallback: (context) => Center(child: CircularProgressIndicator()),

                ),
          ),
        );
      },
    );
  }

  Widget buildCateItem(CompanyCategorySubData data, context) {
    var cubit = ElMahalCubit.get(context);
    return InkWell(
      onTap: () {
        cubit.companyShow(data.id).then((value)
        {
          navigateTo(context, CompanyShowScreen(),);
            });
      },
      child: Container(
        width: 190,
        height: 180,
        child: Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if(token != null ) {
                          if(cubit.favorites[data.id]!){
                          cubit.deleteFav(companyId: data.id).then((value) {
                            cubit.myFav();
                          });
                        }else{
                          cubit.addFav(companyId: data.id).then((value) {
                            cubit.myFav();
                          });
                        }
                        }else{
                          navigateTo(context, SignInScreen());
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: token != null ? cubit.favorites[data.id]! ? Colors.red : Colors.grey : Colors.grey,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 260,
                      height: 125,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              '${data.companyName}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${data.description}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 230,
                                child: Text(
                                  '${data.addressAr}',
                                  style: Theme.of(context).textTheme.caption,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Icon(Icons.location_on,color: Colors.green,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(15)),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/holder.jpg',
                        image: 'https://elyafta.com/egypt/public/images/companies/${data.companyLogo}',
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/images/holder.jpg')),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      cubit.isArabic?'كم' : 'Km',
                    ),
                    Text(
                      '${data.distance}',
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text('${data.views}'),
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refresh(context)
  {
    return Future.delayed(
      Duration(seconds: 1),
    ).then((value) =>
        navigateTo(context, CompanyCategoryScreen()));


  }
}
