import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../elmahal_layout/elmahal_layout.dart';
import '../../shared/components/components.dart';

class SignUpScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit,ElMahalStates>(
      listener: (context,state){
        var cubit = ElMahalCubit.get(context);
        if(state is SignUpSuccessState){
          if(cubit.signUpModel!.status ==1){
            showToast(msg: cubit.isArabic? 'تم تسجيل حسابك بنجاح يمكنك الدخول الان' :'Your account has been successfully registered, you can login now');
            navigateAndFinish(context, ElMahal(),);
            cubit.getMemberCompanies();
          }else{
            showToast(msg: cubit.signUpModel!.message!);
          }
        }
      },
      builder: (context,state){
        var cubit = ElMahalCubit.get(context);
        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(cubit.isArabic ? 'انشاء حساب جديد':'Sign Up'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Text(
                          cubit.isArabic? 'قم بانشاء حسابك الان' : 'Create your account now',
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        defaultFormField(
                          text: cubit.isArabic?'اسم المستخدم' :'User name',
                          controller: cubit.nameSController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return cubit.isArabic? 'الاسم فارغ':'Name is Empty';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          text: cubit.isArabic?'الهاتف':'phone',
                          controller: cubit.phoneSController,
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return cubit.isArabic? 'الهاتف فارغ':'phone is Empty';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          text:  cubit.isArabic?'البريد الالكتروني' :'Email Address',
                          controller: cubit.emailSController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (!value.contains('@')&&!value.contains('.')) {

                              return cubit.isArabic ? 'البريد الالكتروني مدخل بشكل غير صحيح':'Email entered incorrectly';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          text: cubit.isArabic? 'كلمة المرور' :'password',
                          controller: cubit.passwordSController,
                          isPassword: cubit.isPassword,
                          suffix: cubit.isPassword? Icons.visibility_outlined : Icons.visibility_off,
                          suffixPressed: ()
                          {
                            cubit.changeVisi();
                          },
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.length <4&& value != cubit.passwordS2Controller.text) {
                              return cubit.isArabic? 'كلمة المرور مدخل بشكل غير صحيح':'Password entered incorrectly';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          text: cubit.isArabic?'اعد كلمة المرور مره اخري': 'Set the password again',
                          controller: cubit.passwordS2Controller,
                          isPassword: cubit.isPassword,
                          suffix: cubit.isPassword? Icons.visibility_outlined : Icons.visibility_off,
                          suffixPressed: ()
                          {
                            cubit.changeVisi();
                          },
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.length <4 && value != cubit.passwordSController.text) {
                              return cubit.isArabic? 'كلمة المرور مدخل بشكل غير صحيح':'Password entered incorrectly';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        state is! SignUpLoadingState
                        ? defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                if(cubit.passwordSController.text == cubit.passwordS2Controller.text){
                                  cubit.signUp();
                                }else{
                                  showToast(msg:
                                  cubit.isArabic?'كلمة المرور ليست متطابقة': 'Password does not match'
                                  );
                                }
                              }
                            },
                            text: cubit.isArabic?'تسجيل حساب جديد': 'Register a new account',
                            radius: 15
                        ):Center(child: CircularProgressIndicator()),
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
