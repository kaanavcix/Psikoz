import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/View/homePage.dart';
import 'package:psikoz_me/Message/view/message_screen.dart';
import 'package:psikoz_me/Profile/view/profile_screen.dart';
import 'package:psikoz_me/Search/view/search_Screen.dart';
import 'package:psikoz_me/newPost/view/addScreen.dart';

List<Widget> tumPages = [
  const HomeScreen(),
  const MessageScreen(),
  const AddScreen(),
  const SearchScreen(),
  const ProfileScreen()
];
