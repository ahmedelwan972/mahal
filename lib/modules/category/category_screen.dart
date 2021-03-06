import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahal/modules/category/sub_category.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../models/category_model/category_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context,state){
      },
      builder: (context,state){
        var cubit = ElMahalCubit.get(context);
        return ConditionalBuilder(
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
        );
      },
    );
  }

  Widget buildCateItem(context,Data model)
  {
    return InkWell(
      onTap: ()
      {
        ElMahalCubit.get(context).getSubCategory(model.id!);
        navigateTo(context, SubCategoryScreen());
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
              backgroundColor: defaultColor,
              child: Text(
                ElMahalCubit.get(context).isArabic?'??????????':'El Mahal',
                style: Theme.of(context).textTheme.headline6!.copyWith(
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
            Icon(Icons.arrow_forward_ios_outlined,color: defaultColor,),
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
        navigateTo(context, CategoryScreen()));


  }

}
