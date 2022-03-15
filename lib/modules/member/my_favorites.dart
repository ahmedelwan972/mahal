import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../models/favorites_model/fav_model.dart';
import '../../shared/components/components.dart';
import '../company/company_show.dart';

class MyFav extends StatelessWidget {
  const MyFav({Key? key}) : super(key: key);

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
              title: Text(cubit.isArabic? 'المفضلة' :'Favorites'),
            ),
            body: ConditionalBuilder(
              builder:(context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index) => buildMyFav(cubit.getFavModel!.data![index],context),
                        separatorBuilder: (context,index) => SizedBox(height: 20,),
                        itemCount: cubit.getFavModel!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
              condition: cubit.getFavModel != null && state is! MyFavoritesLoadingState && state is! DeleteFavoritesLoadingState ,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget buildMyFav(FavData data,context){
    var cubit = ElMahalCubit.get(context);
    return InkWell(
      onTap: (){
        if( cubit.fav){
          cubit.changeF();
          cubit.companyShow(data.companyId!).then((value)
          {
            navigateTo(context, CompanyShowScreen(),);
          });
        }else{
          cubit.companyShow(data.companyId!).then((value)
          {
            navigateTo(context, CompanyShowScreen(),);
          });
        }
      },
      child: Card(
        elevation: 15,
        child: Container(
          width: double.infinity,
          height: 180,
          color: Colors.grey[200],
          padding: EdgeInsetsDirectional.all(8),
          child: Row(
            children:
            [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: IconButton(
                  onPressed: () {
                    if(cubit.fav){
                       cubit.changeF();
                    }
                      cubit.deleteFav(companyId: data.companyId!).then((value) {
                        cubit.favorites.remove(data.companyId!);
                        cubit.myFav();
                      showToast(msg: cubit.deleteFavModel!.message!);
                      });
                  },
                  icon: Icon(
                    Icons.favorite,
                   color: Colors.red ,
                  ),
                ),
              ),
              Container(
                height: 160,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          '${data.companyDescription}',
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
