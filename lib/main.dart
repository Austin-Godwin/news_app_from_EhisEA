import 'package:flutter/material.dart';
import 'package:general_app/views/home/home_view.dart';
import 'package:general_app/views/home/view_models/bookmark_view_model.dart';
import 'package:general_app/views/home/view_models/home_view_model.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          primaryColor: const Color(0xffFC821E)),
      home: Home(
        homeViewModel: HomeViewModel(),
        bookmarkViewModel: BookmarkViewModel(),
        child: const HomeView(
          // homeViewModel: HomeViewModel(),
          // bookmarkViewModel: BookmarkViewModel(),
        ),
      ),
    ),
  );
}

class Home extends InheritedWidget {
  final HomeViewModel homeViewModel;
  final BookmarkViewModel bookmarkViewModel;
  const Home({
    Key? key,
    required this.homeViewModel,
    required this.bookmarkViewModel,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static Home of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Home>()!;
  }
}
