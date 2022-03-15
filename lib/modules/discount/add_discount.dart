import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../elmahal_layout/elmahal_layout.dart';
import '../../models/company_model/member_companies_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class AddDiscount extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameDisController = TextEditingController();
  var descController = TextEditingController();
  List<int> companyID = [];
  List<String> companyName = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state) {
        var cubit = ElMahalCubit.get(context);
        if(state is AddDiscountSuccessState){
          if(cubit.addDiscountModel!.status == 1){
            showToast(msg: cubit.addDiscountModel!.message!,);
            navigateTo(context, ElMahal());
          }else{
            showToast(msg: cubit.addDiscountModel!.message!,);
          }
        }
      },
      builder: (context, state) {
        var cubit = ElMahalCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.isArabic? 'اضافة خصم جديد' : 'Add New Discount'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (cubit.logoDisImage == null)
                        InkWell(
                          onTap: () {
                            cubit.getPickedLogoDis();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 70,
                                  color: defaultColor,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                cubit.isArabic? 'اضغظ لرفع لوجو التخفيض' : 'Click to raise the discount logo',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      if (cubit.logoDisImage != null)
                        InkWell(
                          onTap: () {
                            cubit.getPickedLogoDis();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(cubit.logoDisImage!),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                cubit.isArabic? 'اضغظ لرفع لوجو التخفيض' : 'Click to raise the discount logo',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          text: cubit.isArabic?'اسم الخصم': 'Discount name',
                          controller: nameDisController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              cubit.isArabic?'الاسم فارغ' : 'Name is empty';
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextButton(
                          onPressed: () {
                             openDialog(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_drop_down,
                              ),
                              Text(
                                cubit.isArabic?'قم باختيار الشركة' : 'Choose the company',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (companyName.isNotEmpty)
                        SizedBox(
                        height: 10,
                      ),
                      if (companyName.isNotEmpty)
                        Text('$companyName'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (!cubit.currentLocation3) {
                                cubit.changeCheck3();
                              } else {
                                cubit.changeCheck3();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(cubit.isArabic?'حتي النفاذ' : 'until exhaustion'),
                                SizedBox(
                                  width: 9,
                                ),
                                Icon(
                                  !cubit.currentLocation3
                                      ? Icons.check_box_outline_blank_sharp
                                      : Icons.check_box,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (!cubit.currentLocation2) {
                                      cubit.changeCheck2();
                                    } else {
                                      cubit.changeCheck2();
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(cubit.isArabic?'الوقت (من , الي )' : 'time (from, to)'),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Icon(
                                        !cubit.currentLocation2
                                            ? Icons.check_box_outline_blank_sharp
                                            : Icons.check_box,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                if (cubit.currentLocation2)
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.parse("2100-11-29"),
                                          ).then((value) {
                                            if(value != null){
                                              cubit.startDate = DateFormat.yMMMd().format(value).toString();
                                              cubit.justEmitState();
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                            ),
                                            Text(cubit.isArabic?'البداية': 'the beginning'),
                                            Spacer(),
                                            if(cubit.startDate == null)
                                              Text(cubit.isArabic?'اضغط': 'Click',
                                                style: TextStyle(
                                                color: Colors.blueAccent
                                              ),),
                                            if(cubit.startDate != null)
                                              Text(cubit.startDate!),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.parse("2100-11-29"),
                                          ).then((value) {
                                            if(value != null){
                                              cubit.lastDate = DateFormat.yMMMd().format(value).toString();
                                              cubit.justEmitState();
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                            ),
                                            Text(cubit.isArabic?'النهاية': 'The End'),
                                            Spacer(),
                                            if(cubit.lastDate == null)
                                              Text(cubit.isArabic?'اضغط': 'Click',
                                                style: TextStyle(
                                                  color: Colors.blueAccent
                                              ),),
                                            if(cubit.lastDate != null)
                                              Text(cubit.lastDate!),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              cubit.isArabic? 'الوصف فارغ': 'Description is Empty';
                            }
                          },
                          keyboardType: TextInputType.text,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: cubit.isArabic?'الوصف': 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          controller: descController,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                        function: () {
                          cubit.selectImagesDis();
                        },
                        text: cubit.isArabic?'ارفاق الصور': 'Add Photos',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (cubit.imageFileDisList != null)
                        Container(
                          height: 220,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: GridView.builder(
                              itemCount: cubit.imageFileDisList!.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (BuildContext context, int index) {
                                return Image.file(
                                  File(cubit.imageFileDisList![index].path),
                                  fit: BoxFit.cover,
                                );
                              }),
                        ),
                      SizedBox(
                        height: 30,
                      ),
                      state is! AddDiscountLoadingState
                          ? Container(
                              width: double.infinity,
                              height: 50.0,
                              child: MaterialButton(
                                child: Text(
                                  cubit.isArabic?'ارسل الان':'Send Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  cubit.methodB();
                                  cubit.method2B();
                                  if(formKey.currentState!.validate()) {
                                    cubit.addDiscount(
                                    desc: descController.text,
                                    cId: companyID,
                                    nameDis: nameDisController.text,
                                  ).then((value) {

                                    });
                                  }
                                },
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )
                          : Center(child: CircularProgressIndicator()),
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

  Future openDialog(context) => showDialog(
    context: context,
    builder: (context) {
      var cubit = ElMahalCubit.get(context);
      return AlertDialog(
      title: Text(
          cubit.isArabic?'اختر شركتك':'Choose your company'
      ),
      content: Container(
        height: 300,
        width: 120,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => buildMemberCompanies(
                    cubit.memberCompaniesModel!.data![index],
                    context),
                separatorBuilder: (context, index) => SizedBox(
                  height: 3,
                ),
                itemCount:
                cubit.memberCompaniesModel!.data!.length,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
            Align(
              child: defaultButton(
                  function: () {
                    Navigator.pop(context);
                  },
                  text: cubit.isArabic?'موافق':'Agree',
                  width: 100),
              alignment: AlignmentDirectional.bottomStart,
            ),
          ],
        ),
      ),
    );}
  );

  Widget buildMemberCompanies(MemberCompaniesData data, context) {
    var cubit = ElMahalCubit.get(context);
    return TextButton(
      child: Row(
        children: [
          Text(
              '${!companyName.contains(data.companyName) ? data.companyName : cubit.isArabic?'تم الاختيار': 'selected'}'),
        ],
      ),
      onPressed: () {
        cubit.changeSelect2().then((value) {
          if (cubit.isSelect2) {
            if (!companyID.contains(data.id) &&
                !companyName.contains(data.companyName)) {
              companyID.add(data.id!);
              companyName.add(data.companyName!);
            }
          }
          if (!cubit.isSelect2) {
            companyID.remove(data.id!);
            companyName.remove(data.companyName!);
          }
        });
      },
    );
  }

}
