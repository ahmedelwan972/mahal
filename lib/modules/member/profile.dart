import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../shared/components/components.dart';
import 'edit_profile.dart';

class Profile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = ElMahalCubit.get(context).editProfileModel;
        var cubit = ElMahalCubit.get(context);
        nameController.text = user!.data!.nameEn!;
        phoneController.text = user.data!.mobile!;
        emailController.text = user.data!.email!;
        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(cubit.isArabic ? 'الصفحة الشخصية' : 'Profile'),
            ),
            body: ConditionalBuilder(
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (state is EditProfileLoadingState)
                        LinearProgressIndicator(),
                      if (state is EditProfileLoadingState)
                        SizedBox(
                          height: 20,
                        ),
                      CircleAvatar(
                        radius: 64,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            cubit.profileImage != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(cubit.profileImage!),
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    child:FadeInImage.assetNetwork(
                                      height: 110,
                                      width: 100,
                                      placeholder:'assets/images/holder.jpg',
                                      image: 'https://elyafta.com/egypt/public/images/members/${user.data!.image}',
                                      imageErrorBuilder: (context,error, stackTrace)=>Icon(Icons.error),
                                    )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        enabled: false,
                        controller: nameController,
                        label: cubit.isArabic ? 'الأسم' : 'Name',
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return cubit.isArabic
                                ? 'يجب ألا يكون الاسم فارغًا'
                                : 'name must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        label: cubit.isArabic ? 'رقم الهاتف' : 'Phone Number',
                        enabled: false,
                        controller: phoneController,
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) {
                           return cubit.isArabic
                                ? 'يجب ألا يكون رقم الهاتف فارغًا'
                                : 'Phone number must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        enabled: false,
                        label: cubit.isArabic
                            ? 'البريد الالكتروني'
                            : 'Email Address',
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return cubit.isArabic
                                ? 'يجب ألا يكون البريد الالكتروني فارغًا'
                                : 'Email Address must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                        function: () {
                          navigateTo(context, EditProfile());
                        },
                        text: cubit.isArabic ? 'تعديل البيانات' : 'Edit Data',
                      ),
                    ],
                  ),
                ),
              ),
              condition: cubit.editProfileModel != null &&
                  state is! EditProfileLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
