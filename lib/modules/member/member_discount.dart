import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../models/discount_model/member_discounts_model.dart';

class MemberDiscount extends StatelessWidget {
  const MemberDiscount({Key? key}) : super(key: key);

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
              title: Text(cubit.isArabic? 'تخفيضاتي' : 'My Discounts'),
            ),
            body: ConditionalBuilder(
              builder:(context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index) => buildMemberDiscountsItem(cubit.memberDiscountModel!.data![index],context),
                        separatorBuilder: (context,index) => SizedBox(height: 30,),
                        itemCount: cubit.memberDiscountModel!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
              condition: cubit.memberDiscountModel != null && state is! GetMemberDiscountLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget buildMemberDiscountsItem(MemberDiscountData data,context){
    return Card(
      elevation: 15,
      child: Container(
        width: double.infinity,
        height: 120,
        color: Colors.grey[200],
        padding: EdgeInsetsDirectional.all(20),
        child: Row(
          children:
          [
            Column(
              children:
              [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '${data.discountName}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.deepOrange,
                    ),
                    Text(
                     ElMahalCubit.get(context).isArabic? '${data.startDate} - ألي > ${data.endDate}': '${data.startDate} - to > ${data.endDate}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),

              ],
            ),
            Spacer(),
            Container(
              height: 75,
              width: 75,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/holder.jpg',
                image: 'https://elyafta.com/egypt/public/images/discounts/${data.image}',
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/images/holder.jpg')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
