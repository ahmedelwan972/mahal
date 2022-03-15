import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahal/shared/bloc_observer.dart';
import 'package:mahal/shared/components/constants.dart';
import 'package:mahal/shared/network/local/cache_helper.dart';
import 'package:mahal/shared/network/remote/dio.dart';
import 'package:mahal/shared/styles/colors.dart';

import 'elmahal_layout/cubit/cubit.dart';
import 'elmahal_layout/cubit/states.dart';
import 'elmahal_layout/elmahal_layout.dart';

void main() async {

  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init1();



  token = CacheHelper.getData(key: 'myId');
  print(token);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=> ElMahalCubit()..getCategory()..getService()..getMemberCompanies()..cityList()..cateList()..editProfile()..checkInterNet(),
      child: BlocConsumer<ElMahalCubit,ElMahalStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            locale: ElMahalCubit.get(context).locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.teal,
                appBarTheme: AppBarTheme(
                  backgroundColor: defaultColor,
                  iconTheme: IconThemeData(
                      color: Colors.white
                  ),
                )
            ),
            home: Directionality(
                textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: ElMahal()),
          );
        },
      ),
    );

  }
}
