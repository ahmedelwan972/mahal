import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahal/modules/update_comapny/update_category/sub_category_for_update_company.dart';

import '../../../elmahal_layout/cubit/cubit.dart';
import '../../../elmahal_layout/cubit/states.dart';
import '../../../models/category_model/category_model.dart';
import '../../../shared/components/components.dart';

class CategoryForUpdate extends StatelessWidget {

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
            appBar: AppBar(),
            body: ConditionalBuilder(
              builder: (context) => RefreshIndicator(
                onRefresh: ()=> refresh(context),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index)=>buildCateItem(context,ElMahalCubit.get(context).categoryModel!.data[index]),
                  separatorBuilder: (context, index)=>Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[400],
                  ),
                  itemCount: cubit.categoryModel!.data.length,
                ),
              ),
              condition: cubit.categoryModel != null && state is! GetCategoryLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget buildCateItem(context,Data model)
  {
    var name = model.name;
    return InkWell(
      onTap: ()
      {
        ElMahalCubit.get(context).getSubCategory(model.id!);
        ElMahalCubit.get(context).cateSubNameB = name;
        navigateTo(context, SubCategoryForUpdate());
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
              backgroundColor: Colors.red,
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
              '${model.name}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.red,),
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
        navigateTo(context, CategoryForUpdate()));


  }

}
