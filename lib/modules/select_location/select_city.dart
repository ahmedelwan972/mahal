import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../elmahal_layout/elmahal_layout.dart';
import '../../models/location_model/city_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class SelectCity extends StatelessWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = ElMahalCubit.get(context);
        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                  cubit.isArabic ? 'اختر المدينة' : 'Choose the City',
              ),
              backgroundColor: defaultColor,
            ),
            body: cubit.cityModel != null && state is! GetCityLoadingState
                ? Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      cubit.isArabic ? 'اختر المدينة' : 'Choose the City',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder:(context , index) => buildLocationItem(cubit.cityModel!.data! [index],context) ,
                    separatorBuilder:(context , index) => Container(width: double.infinity,height: 1, color: Colors.grey[600],) ,
                    itemCount: cubit.cityModel!.data!.length,
                  ),
                ),
              ],
            )
                : Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildLocationItem(CityData data ,context) {
    var name = data.name;
    return InkWell(
      onTap: () {
        ElMahalCubit.get(context).myAddressName= '';
        navigateAndFinish(context, ElMahal(name: name,));
      },
      child: Container(
        height: 70,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              '${data.name}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }
}
