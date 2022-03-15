import 'package:flutter/material.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../shared/components/components.dart';

class ForgetPasswordScreen extends StatelessWidget {

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ElMahalCubit.get(context);
    return Directionality(
      textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                CircleAvatar(
                  child: Icon(
                    Icons.lock,
                    size: 70,
                    color: Colors.green,
                  ),
                  radius: 70,
                  backgroundColor: Colors.black12,
                ),
                SizedBox(
                  height: 30,
                ),
                defaultFormField(
                    text:  cubit.isArabic?'ادخل البريد الالكتروني' : 'Enter Email Address',
                    controller: passwordController,
                ),
                SizedBox(
                  height: 30,
                ),
                defaultButton(
                  function: (){},
                  text: cubit.isArabic? 'استعادة كلمة المرور' : 'Restore password',
                  radius: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
