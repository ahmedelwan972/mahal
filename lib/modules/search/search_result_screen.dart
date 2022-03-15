import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../models/search_model/search_company_model.dart';
import '../../shared/components/components.dart';
import '../company/company_show.dart';

class SearchResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state) {
        if(ElMahalCubit.get(context).searchCompanyModel!.status ==0) {
          showToast(msg:
          ElMahalCubit.get(context).isArabic ? 'نتائج البحث غير موجوده حاول مره اخري' : 'Search results not found, try again'
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
                cubit.isArabic ? 'المحل' : 'ElMahal',
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
                  itemBuilder: (context, index) => buildSearchCateItem(
                      cubit.searchCompanyModel!.data![index], context),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 1,
                  ),
                  itemCount: cubit.searchCompanyModel!.data!.length,
                ),
              ),
              condition: cubit.searchCompanyModel != null  && state is! SearchCompanyLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()),

            ),
          ),
        );
      },
    );
  }

  Widget buildSearchCateItem(SearchCompanyData data, context) {
    var cubit = ElMahalCubit.get(context);
    return InkWell(
      onTap: () {
        cubit.companyShow(data.id!).then((value)
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
                    Container(
                      width: 280,
                      height: 125,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                      width: 35,
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


}
