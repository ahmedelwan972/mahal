import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../styles/colors.dart';
import 'constants.dart';

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 15.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget defaultFormField({
  String? text,
  required TextEditingController controller,
  bool isPassword = false,
  FormFieldValidator? validator,
  TextInputType? type,
  String? label,
  bool enabled = true,
  Function? suffixPressed,
  IconData? suffix,
}) =>
    TextFormField(
      obscureText: isPassword,
      enabled: enabled,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: text,
        labelText: label,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  {
                    suffixPressed!();
                  }
                },
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      validator: validator,
    );

Future<bool?>  showToast ({required String msg}) =>
     Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0);


Future<void> refresh(context)
{
  return Future.delayed(
    Duration(seconds: 1),
  ).then((value) => ElMahalCubit.get(context).justEmitState());


}


checkNet(context){
  if(!result!){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No internet connection'),
        content: Container(
          height: 60,
          width: 80,
          color: defaultColor,
          child: TextButton(
            onPressed: () {
              JustEmitState();
              Navigator.pop(context);
            },
            child: Text(
              'Click to retry',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}


