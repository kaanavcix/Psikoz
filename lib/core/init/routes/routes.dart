import 'package:get/get.dart';
import 'package:psikoz_me/Home/View/homePage.dart';
import 'package:psikoz_me/Home/bindings/homeBinding.dart';
import 'package:psikoz_me/Message/bindings/messagebinding.dart';
import 'package:psikoz_me/Message/view/message_screen.dart';
import 'package:psikoz_me/Profile/view/settings.dart';
import 'package:psikoz_me/Search/binding/searchBinding.dart';
import 'package:psikoz_me/Search/view/search_Screen.dart';
import 'package:psikoz_me/core/constants/routes_constant.dart';
import 'package:psikoz_me/newPost/bindings/NewPost.dart';
import 'package:psikoz_me/newPost/view/addScreen.dart';
import 'package:psikoz_me/onboard/Login/bindings/LoginBinding.dart';
import 'package:psikoz_me/onboard/Login/view/login_screen.dart';
import 'package:psikoz_me/onboard/Register/bindings/registerBinding.dart';
import 'package:psikoz_me/onboard/Register/view/register_screen.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
      name: Routes_Constant.LOGIN,
      page: () => const Login_Screen(),
      binding: LoginControllerBinding()),
  GetPage(
      name: Routes_Constant.REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterControllerBinding()),
  GetPage(
      name: Routes_Constant.ADDPOST,
      page: () => const AddScreen(),
      binding: NewPostBinding()),
  GetPage(name: Routes_Constant.SETTINGS, page: () => const SettingsScreen()),
  GetPage(
      name: Routes_Constant.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding()),
  GetPage(
      name: Routes_Constant.MESSAGE,
      page: () => const MessageScreen(),
      binding: MessageBinding()),
  GetPage(
      name: Routes_Constant.SEARCH,
      page: () => const SearchScreen(),
      binding: SearchBinding())
];
