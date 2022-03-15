import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahal/modules/member/sign_up.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../elmahal_layout/elmahal_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import 'forget_password.dart';

class SignInScreen extends StatelessWidget {

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit,ElMahalStates>(
      listener: (context,state){
        if (state is GetSignInErrorState){
          showToast(msg: ElMahalCubit.get(context).isArabic? 'البيانات المدخله غير صحيحه' :'The data entered is incorrect');
        }
        if(state is GetSignInSuccessState)
        {
          if(state.signInModel!.status! == 1)
          {
            CacheHelper.saveData(key: 'myId', value: state.signInModel!.data!.id!).then((value)
            {
              token = state.signInModel!.data!.id!;
              navigateAndFinish(context, ElMahal(),);
              ElMahalCubit.get(context).getMemberCompanies();
              ElMahalCubit.get(context).editProfile();
            }).catchError((e){
              print(e.toString());
            });

          } else
          {
            showToast(msg: state.signInModel!.message!);
          }
        }
      },
      builder: (context,state){
        var cubit = ElMahalCubit.get(context);
        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text( cubit.isArabic? 'تسجيل الدخول': 'Login'),
            ),
            body: Center(
              child: Container(
                padding: EdgeInsetsDirectional.all(20),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Text(
                          cubit.isArabic? 'مرحبا': 'Welcome',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: defaultColor
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Icon(
                          Icons.login_outlined,
                          size: 90,
                          color: defaultColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          text: cubit.isArabic?'ادخل رقم الهاتف او البريد الالكتروني' : 'Enter Phone Number or Email Address',
                          controller: phoneController,
                          type: TextInputType.emailAddress,
                          validator: (value){
                            if(value.isEmpty){
                              return cubit.isArabic?'رقم الهاتف او الاميل غير مدخل' : 'Phone Number or Email Address not entered';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          text:cubit.isArabic?'كلمة المرور':'Password' ,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          suffix: cubit.isPassword? Icons.visibility_outlined : Icons.visibility_off,
                          suffixPressed: ()
                          {
                            cubit.changeVisi();
                          },
                          validator: (value){
                            if(value.isEmpty){
                              return cubit.isArabic?'كلمة المرور غير مدخلة' : 'Password not entered';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        state is! GetSignInLoadingState ? OutlinedButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()) {
                              cubit.getSignIn(
                                mobile: phoneController.text,
                                password: passwordController.text,
                              );
                            }
                            return;
                          },
                          child: Text(
                            cubit.isArabic?'تسجيل الدخول' :'Login',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(defaultColor),
                          ),
                        ) : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: ()
                          {
                            navigateTo(context, SignUpScreen());
                          },
                          child: Text(
                            cubit.isArabic? 'ليس لديك حساب قم بانشاء حساب الان' : 'You do not have an account, create an account now.',
                            style: TextStyle(
                                color: defaultColor
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: ()
                          {
                            navigateTo(context, ForgetPasswordScreen());
                          },
                          child: Text(
                            cubit.isArabic? 'استعاده كلمة المرور' : 'Restore password',
                            style: TextStyle(
                              color: defaultColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
