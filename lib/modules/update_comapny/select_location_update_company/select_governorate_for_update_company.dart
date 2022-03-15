import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahal/modules/update_comapny/select_location_update_company/select_city_for_update_company.dart';
import '../../../elmahal_layout/cubit/cubit.dart';
import '../../../elmahal_layout/cubit/states.dart';
import '../../../models/location_model/governorate_model.dart';
import '../../../shared/components/components.dart';

class SelectGovernorateForUpdate extends StatelessWidget {
  const SelectGovernorateForUpdate({Key? key}) : super(key: key);

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
              title: Text(cubit.isArabic?'اختر المحافظة' :'Choose The Governorate'),
            ),
            body: cubit.governorate != null
                ? Column(
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            cubit.isArabic?'اختر المحافظة' :'Choose The Governorate',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildLocationItem(
                              cubit.governorate!.data![index], context, cubit),
                          separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          itemCount: cubit.governorate!.data!.length,
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

  Widget buildLocationItem(Data data, context, ElMahalCubit cubit) {
    var name = data.name;
    return InkWell(
      onTap: () {
        cubit.getCityLocation(data.id!);
        cubit.govereNameB = name;
        navigateTo(context, SelectCityForUpdate());
      },
      child: Container(
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              '${data.name}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }
}
