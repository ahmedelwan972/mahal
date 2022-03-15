import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../elmahal_layout/elmahal_layout.dart';
import '../../shared/components/components.dart';
import 'edit_password.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
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
                  cubit.isArabic? 'الصفحة الشخصية' : 'Profile'
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(state is EditProfileLoadingState)
                        LinearProgressIndicator(),
                      if(state is EditProfileLoadingState)
                        SizedBox(
                          height: 20,
                        ),
                      CircleAvatar(
                        radius: 64,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: ElMahalCubit.get(context).profileImage == null
                                  ? AssetImage('assets/images/holder.jpg')
                                  : FileImage(ElMahalCubit.get(context).profileImage!) as ImageProvider,
                              // ElMahalCubit.get(context).profileImage == null
                              //     ? FadeInImage.assetNetwork(
                              //   placeholder: 'assets/images/holder.jpg',
                              //   image: 'https://elyafta.com/egypt/public/images/companies/${data.image}' ,
                              //   //fit: BoxFit.cover,
                              //   imageErrorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/images/holder.jpg')),)
                              //     : FileImage(ElMahalCubit.get(context).profileImage!) as ImageProvider,
                            ),
                            CircleAvatar(
                              radius: 16,
                              child: IconButton(
                                onPressed: () {
                                  ElMahalCubit.get(context).getPickedImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: nameController,
                        label:cubit.isArabic?'الاسم':'name',
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            cubit.isArabic? 'يجب ألا يكون الاسم فارغًا':'name must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        label: 'الرقم',
                        type: TextInputType.phone,
                        validator:  (value) {
                          if (value.isEmpty) {
                            cubit.isArabic? 'يجب ألا يكون الجوال  فارغًا':'phone must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: emailController,
                        label: cubit.isArabic?'البريد الالكتروني' : 'Email Address',
                        type: TextInputType.emailAddress,
                        validator:  (value) {
                          if (value.isEmpty) {
                            cubit.isArabic? 'يجب ألا يكون البريد الالكتروني فارغ ':'Email Address must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, EditPassword());
                        },
                        child: Text(
                          cubit.isArabic?'تغير كلمة المرور': 'Change Password',
                          style: TextStyle(
                            fontSize: 22,
                          ),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                        function: () {
                          if(formKey.currentState!.validate())
                          {
                            ElMahalCubit.get(context).method3();
                            ElMahalCubit.get(context).editProfile(
                              name:  nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            ).then((value) => navigateAndFinish(context, ElMahal()));
                          }
                        },
                        text: cubit.isArabic?'حفظ' : ' Save',
                      ),
                    ],
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
