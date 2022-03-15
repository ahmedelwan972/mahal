import 'package:flutter/material.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../add_comapny/add_company/add_company.dart';
import '../discount/add_discount.dart';
import '../member/sign_in.dart';

class AddFreeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   var cubit =  ElMahalCubit.get(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              SizedBox(
                height: 110,
              ),
              Column(
                children:
                [
                  Image(
                    width: 90,
                    height: 90,
                    image: AssetImage(
                      'assets/images/add_company.png'
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height:  40,
                    width: cubit.isArabic ? 120 : 160,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      onPressed: ()
                      {
                        navigateTo(context, AddCompany());
                      },
                      child: Text(
                        cubit.isArabic? 'اضف شركة جديدة': 'Add New Company',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    cubit.isArabic
                        ? 'نزل بيانات شغلك أون لاين أمام ملايين المستخدمين ووصل شغلك لكل الناس في منطقتك بالصور مجانا'
                        :'Download your job data online in front of millions of users and communicate your work to everyone in your area with pictures for free',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children:
                [
                  Image(
                    width: 90,
                    height: 90,
                    image: AssetImage(
                      'assets/images/add_discount.png'
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40 ,
                    width: cubit.isArabic ? 120 : 160,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      onPressed: ()
                      {
                        if(token == null){
                          navigateTo(context, SignInScreen());
                        }else{
                          navigateTo(context, AddDiscount());
                        }
                      },
                      child: Text(
                        cubit.isArabic ?'اضف تخفيض جديدة' : 'Add New Discount',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    cubit.isArabic
                        ?'نزل بيانات شغلك أون لاين أمام ملايين المستخدمين ووصل شغلك لكل الناس في منطقتك بالصور مجانا'
                        :'Download your job data online in front of millions of users and communicate your work to everyone in your area with pictures for free',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
