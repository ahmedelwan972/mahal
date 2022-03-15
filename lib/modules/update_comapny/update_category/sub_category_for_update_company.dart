import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../elmahal_layout/cubit/cubit.dart';
import '../../../elmahal_layout/cubit/states.dart';
import '../../../models/category_model/sub_category_model.dart';
import '../../../shared/components/components.dart';
import '../update_company.dart';

class SubCategoryForUpdate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context,state){
      },
      builder: (context,state){
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
            body: RefreshIndicator(
              onRefresh: ()=> refresh(context),
              child: ConditionalBuilder(
                builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index)=>buildCateItem(context,cubit.subCategoryModel!.data![index]),
                  separatorBuilder: (context, index)=>Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[400],
                  ),
                  itemCount: cubit.subCategoryModel!.data!.length,
                ),
                condition: cubit.subCategoryModel != null && state is! GetSubCategoryLoadingState,
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCateItem(context,SubCategoryData data)
  {
    var name = data.name;
    return InkWell(
      onTap: (){
        ElMahalCubit.get(context).cateNameB = name;
        ElMahalCubit.get(context).cateIdsB!.add(data.id!);
        navigateTo(context, UpdateCompany());

      },
      child: Container(
        height: 85,
        child: Row(
          children:
          [
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.pink,
              child: Text(
                ElMahalCubit.get(context).isArabic?'المحل':'El Mahal',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(
                    color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${data.name}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined,color: Colors.pink,),
          ],
        ),
      ),
    );
  }


  Future<void> refresh(context)
  {
    return Future.delayed(
      Duration(seconds: 1),
    ).then((value) =>
        navigateTo(context, SubCategoryForUpdate()));


  }

}
