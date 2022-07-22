import 'package:flutter/material.dart';
import 'package:general_app/views/home/home_view.dart';
import 'package:general_app/views/home/view_models/home_view_model.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          primaryColor: const Color(0xffFC821E)),
      home: HomeView(
        homeViewModel: HomeViewModel(),
      ),
    ),
  );
}
