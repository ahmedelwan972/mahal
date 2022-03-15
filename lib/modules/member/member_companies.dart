import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../models/company_model/member_companies_model.dart';
import '../../shared/components/components.dart';
import '../update_comapny/update_company.dart';

class MemberCompanies extends StatelessWidget {
  const MemberCompanies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit,ElMahalStates>(
      listener: (context, state){
      },
      builder: (context, state){
        var cubit = ElMahalCubit.get(context);
        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(cubit.isArabic? 'شركاتي' : 'My Companies'),
            ),
            body: ConditionalBuilder(
              builder:(context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index) => buildMemberCompaniesItem(cubit.memberCompaniesModel!.data![index],context),
                        separatorBuilder: (context,index) => SizedBox(height: 30,),
                        itemCount: cubit.memberCompaniesModel!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
              condition: cubit.memberCompaniesModel != null && state is! GetMemberCompaniesLoadingState && state is! AddCompanyLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget buildMemberCompaniesItem(MemberCompaniesData data,context){
    return InkWell(
      onTap: (){
        ElMahalCubit.get(context).coId = data.id;
        navigateTo(context, UpdateCompany());
      },
      child: Card(
        elevation: 15,
        child: Container(
          width: double.infinity,
          height: 200,
          color: Colors.grey[200],
          padding: EdgeInsetsDirectional.all(20),
          child: Row(
            children:
            [
              Column(
                children:
                [
                  Text(
                    '${data.companyName}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text(
                      '${data.description}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      Text(
                        '${data.accentName}'
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 100,
                width: 100,
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
        ),
      ),
    );
  }
}
