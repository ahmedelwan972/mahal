import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahal/modules/update_comapny/select_location_update_company/select_governorate_for_update_company.dart';
import 'package:mahal/modules/update_comapny/update_category/category_for_update_company.dart';

import '../../elmahal_layout/cubit/cubit.dart';
import '../../elmahal_layout/cubit/states.dart';
import '../../elmahal_layout/elmahal_layout.dart';
import '../../models/company_model/service_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class UpdateCompany extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  bool isSelect = false;
  List<int> serviceB = [];
  List<String> serviceName = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMahalCubit, ElMahalStates>(
      listener: (context, state) {
        var cubit = ElMahalCubit.get(context);
        if (state is UpdateCompanySuccessState) {
          if (cubit.updateCompanyModel!.status == 1) {
            navigateAndFinish(context, ElMahal());
            cubit.logoImage = null;
            cubit.imageFileList.clear();
            showToast(msg: cubit.updateCompanyModel!.message!,);
          } else {
            showToast(msg: cubit.updateCompanyModel!.message!,);
          }
        } else if (state is UpdateCompanyErrorState) {
          showToast(
            msg: cubit.isArabic?'البيانات المدخله غير صحيحه' : 'The data entered is incorrect',
          );
        }
      },
      builder: (context, state) {
        var cubit = ElMahalCubit.get(context);

        return Directionality(
          textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.isArabic? 'تعديل بيانات الشركة' :'Change Company data'
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  navigateAndFinish(context, ElMahal());
                  cubit.logoImage = null;
                  cubit.imageFileList.clear();
                },
              ),
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
                        if (cubit.logoImage == null)
                          InkWell(
                            onTap: () {
                              cubit.getPickedLogo();
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
                                  cubit.isArabic?'اضغظ لرفع لوجو الشركة': 'Click to raise the company\'s logo',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        if (cubit.logoImage != null)
                          InkWell(
                            onTap: () {
                              cubit.getPickedLogo();
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: FileImage(cubit.logoImage!),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  cubit.isArabic?'اضغظ لرفع لوجو الشركة': 'Click to raise the company\'s logo',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            text: cubit.isArabic?'اسم الشركة':'Company Name',
                            controller: cubit.companyNameControllerB,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return  cubit.isArabic? 'الاسم فارغ':'Name is Empty';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            text: cubit.isArabic?'رقم الجوال' : 'Phone Number',
                            controller: cubit.phoneControllerB,
                            type: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                             return   cubit.isArabic? 'الجوال فارغ': 'Phone is Empty';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            text:cubit.isArabic? 'رقم الهاتف':'Phone Number',
                            controller: cubit.phone2ControllerB,
                            type: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return  cubit.isArabic? 'الجوال فارغ': 'Phone is Empty';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            text:  cubit.isArabic?'العنوان':'Address',
                            controller: cubit.addressControllerB,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return  cubit.isArabic?'العنوان فارغ':'Address is Empty';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                          function: () {
                            cubit.getLocation();
                            navigateTo(context, SelectGovernorateForUpdate());
                          },
                          text:  cubit.isArabic?'اختر المدينة':'Choose the City',
                        ),
                        if (cubit.cityNameB != null&& cubit.govereNameB != null)
                          SizedBox(
                            height: 10,
                          ),
                        if (cubit.cityNameB != null&& cubit.govereNameB != null)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text(
                                    cubit.cityNameB!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: defaultColor),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      cubit.cityNameB = null;
                                      cubit.cityIdB!.clear();
                                      cubit.justEmitState();
                                    },
                                    icon: Icon(
                                        Icons.delete
                                    ),),
                                ],
                              ),
                              Text(
                                cubit.govereNameB!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: defaultColor),
                              ),

                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                          function: () {
                            navigateTo(context, CategoryForUpdate());
                          },
                          text:  cubit.isArabic?'اضافة فئة':'Add Category',
                        ),
                        if (cubit.cateNameB != null&& cubit.cateSubNameB !=null)
                          SizedBox(
                            height: 30,
                          ),
                        if (cubit.cateNameB != null&& cubit.cateSubNameB !=null)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text(cubit.cateNameB!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: defaultColor)),
                                  IconButton(
                                    onPressed: (){
                                      cubit.cateNameB = null;
                                      cubit.cateIdsB!.clear();
                                      cubit.justEmitState();
                                    },
                                    icon: Icon(
                                        Icons.delete
                                    ),),
                                ],
                              ),
                              Text(cubit.cateSubNameB!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: defaultColor)),
                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        if (cubit.position2B == null)
                          defaultButton(
                            function: () {
                              cubit.getCurrentLocation2B().then((value) {
                                showToast(msg: cubit.isArabic?'تم تحديد المكان بنجاح':'Location selected successfully' );
                              });
                            },
                            text:cubit.isArabic? 'حدد مكانك علي خرائط جوجل':'Locate your place on Google Maps',
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
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
                                cubit.isArabic? 'الخدمات' :'Services',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (serviceName.isNotEmpty) Text('$serviceName'),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return  cubit.isArabic?'الوصف فارغ':'Description is Empty';
                              }
                            },
                            keyboardType: TextInputType.text,
                            maxLines: 6,
                            decoration: InputDecoration(
                              hintText: cubit.isArabic?'الوصف':'Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            controller: cubit.detailsControllerB,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                          function: () {
                            cubit.selectImages();
                          },
                          text: cubit.isArabic?'ارفاق الصور' :'Add Photos',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (cubit.imageFileList.isNotEmpty)
                          Container(
                            height: 220,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: GridView.builder(
                                itemCount: cubit.imageFileList.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 4),
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    alignment: AlignmentDirectional.center,
                                    children :[
                                      Image.file(
                                      File(cubit.imageFileList[index].path),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                      IconButton(
                                          onPressed: (){
                                            cubit.imageFileList.remove(cubit.imageFileList[index]);
                                            cubit.justEmitState();
                                          }, icon: Icon(Icons.delete,color: Colors.red,)),
                                    ]
                                  );
                                }),
                          ),
                        SizedBox(
                          height: 30,
                        ),
                        state is! UpdateCompanyLoadingState
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
                                    if (formKey.currentState!.validate()) {
                                      if (cubit.mobilesB != null) {
                                        cubit.mobilesB!.remove(
                                            cubit.phoneControllerB.text);
                                        cubit.mobilesB!.remove(
                                            cubit.phone2ControllerB.text);
                                      }
                                      cubit.methodBB();
                                      cubit.method2BB();
                                      cubit.updateCompany(
                                        service: serviceB,
                                      );
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
          ),
        );
      },
    );
  }

  Future openDialog(context) {
    var cubit = ElMahalCubit.get(context);

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(cubit.isArabic?'اختر خدماتك' : 'Choose your Services'),
          content: Container(
            height: 300,
            width: 120,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => buildService(
                        ElMahalCubit.get(context).serviceModel!.data![index],
                        context),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 3,
                    ),
                    itemCount:
                        ElMahalCubit.get(context).serviceModel!.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
                Align(
                  child: defaultButton(
                      function: () {
                        Navigator.pop(context);
                      },
                      text: cubit.isArabic?'موافق' :'Agree',
                      width: 100),
                  alignment: AlignmentDirectional.bottomStart,
                ),
              ],
            ),
          ),
        ),
      );}

  Widget buildService(ServiceData data, context) {
    var cubit = ElMahalCubit.get(context);
    return TextButton(
      child: Row(
        children: [
          Text(
              '${!serviceName.contains(data.name) ? data.name : cubit.isArabic?'تم الاختيار':'selected'}'),
        ],
      ),
      onPressed: () {
        cubit.changeSelectB().then((value) {
          if (cubit.isSelectB) {
            if (!serviceB.contains(data.id) &&
                !serviceName.contains(data.name)) {
              serviceB.add(data.id!);
              serviceName.add(data.name!);
            }
          }
          if (!cubit.isSelectB) {
            serviceB.remove(data.id!);
            serviceName.remove(data.name!);
          }
        });
      },
    );
  }
}
