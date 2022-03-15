import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class EditPassword extends StatelessWidget {

  var passwordController = TextEditingController();
  var passwordController2 = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
              title: Text(
                cubit.isArabic?  'تغير كلمة المرور' : 'Change Password',
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.lock,
                        size: 70,
                        color: defaultColor,
                      ),
                      radius: 70,
                      backgroundColor: Colors.black12,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      text: cubit.isArabic? 'ادخل كلمة المرور' : 'enter password',
                      controller: passwordController,
                        isPassword: cubit.isPassword,
                        suffix: cubit.isPassword? Icons.visibility_outlined : Icons.visibility_off,
                        suffixPressed: ()
                        {
                          cubit.changeVisi();
                        },
                        validator: (value){
                        if(value.isEmpty && value != passwordController2.text){
                          return cubit.isArabic? 'كلمة المرور المدخله خطأ' : 'Incorrect password entered';
                        }
                      }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      text: cubit.isArabic? 'ادخل كلمة المرور مره اخري' : 'Enter the password again',
                      controller: passwordController2,
                        isPassword: cubit.isPassword,
                        suffix: cubit.isPassword? Icons.visibility_outlined : Icons.visibility_off,
                        suffixPressed: ()
                        {
                          cubit.changeVisi();
                        },
                        validator: (value){
                        if(value.isEmpty && value != passwordController.text){
                          return cubit.isArabic?'كلمة المرور المدخله خطأ': 'Incorrect password entered';
                        }
                        }

                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          if(passwordController.text == passwordController2.text){
                            ElMahalCubit.get(context).editPassword(
                              passwordController2.text,).then((value) {
                              showToast(msg:
                              cubit.isArabic? 'تم تغير كلمة المرور بنجاح' : 'Password changed successfully'
                              );
                              Navigator.pop(context);
                            });
                          }else{
                            showToast(msg:
                            cubit.isArabic?'كلمة المرور ليست متطابقة': 'Password does not match'
                            );
                          }
                        }
                      },
                      text:  cubit.isArabic?'تغير' : 'Change',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

  }

}
