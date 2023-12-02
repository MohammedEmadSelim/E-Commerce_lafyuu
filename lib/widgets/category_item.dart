 import 'package:flutter/material.dart';

import '../model/category_model.dart';

Widget categoryItem(Datum date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 31,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Image.network(date.image),
        ),
      ),
    );
  }