import 'package:flutter/cupertino.dart';
import 'package:mocko_app/utils/my_text_stile.dart';

Widget MyWidget2(
    {required String httpImage,
      required String author,
      required String title,
      required VoidCallback onTap})=>
    GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            child: Image.network(httpImage, width: 100, height: 100,),
          ),
          SizedBox(
            height: 15,
          ),
          Text(title, style: MyTextStyle.interBold700.copyWith(fontSize: 15)),
          SizedBox(
            height: 5,
          ),
          Text(author,
              style: MyTextStyle.interMedium500.copyWith(fontSize: 10)),
        ],
      ),
    );
