import 'package:flutter/material.dart';

import '../../elmahal_layout/cubit/cubit.dart';

class InfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ElMahalCubit.get(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
        ),
        body: Container(
          width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ElMahalCubit.get(context).isArabic
                    ?'المحل , اول دليل للشركات والمحلات بالصور , اول دليل للعروض والتخفيضات في مصر , تقدر تتفرج علي الصور المكان والمنيو والخدمات الي بيقدمها واسعارها قبل اما تروحلة بنفسك للاستفسارات  01223364710 '
                    :'The shop, the first guide for companies and stores with pictures, the first guide to offers and discounts in Egypt, you can look at the pictures of the place, menu, services and prices before you go yourself for inquiries 01223364710',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.end,
              ),
            ),),
      ),
    );
  }
}
