import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../elmahal_layout/elmahal_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class ConnectScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
              title: Text(
                cubit.isArabic ? 'تواصل معنا' : 'Contact Us',
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.black12,
                          child: Icon(
                            Icons.email_outlined,
                            color: defaultColor,
                            size: 70,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          cubit.isArabic?  'تواصل معنا الان' : 'contact with us now ',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            text: cubit.isArabic? 'الاسم' : 'name' ,
                            controller: nameController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                cubit.isArabic? 'من فضلك ادخل الاسم' : 'Please enter the name';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            text: cubit.isArabic? 'الجوال' : 'phone',
                            controller: phoneController,
                            type: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                cubit.isArabic? 'من فضلك ادخل الجوال' : ' Please enter the phone';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            text: cubit.isArabic? 'البريد الالكتروني' : 'Email Address',
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                cubit.isArabic? 'من فضلك ادخل البرد الالكتروني' : 'Please enter Email Address';
                              }
                            }),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              cubit.isArabic?  'من فضلك ادخل رسالتك': 'Please enter your message';
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: cubit.isArabic? 'رسالتك' : 'your message',
                          ),
                          controller: textController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.contactUs(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                message: textController.text,
                              ).then((value) {
                                if (cubit.contactModel!.status == 1) {
                                  showToast(msg: cubit.contactModel!.message!);
                                  navigateAndFinish(context, ElMahal());
                                } else if (cubit.contactModel!.status == 0) {
                                  showToast(msg: cubit.contactModel!.message!);
                                }
                              });
                            }
                          },
                          text: cubit.isArabic? 'ارسل الان' : 'Send Now',
                          radius: 15,
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
