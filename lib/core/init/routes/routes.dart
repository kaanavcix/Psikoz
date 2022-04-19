import 'package:get/get.dart';
import 'package:psikoz_me/Home/View/homePage.dart';
import 'package:psikoz_me/Home/bindings/homeBinding.dart';
import 'package:psikoz_me/Message/bindings/messagebinding.dart';
import 'package:psikoz_me/Message/view/message_screen.dart';
import 'package:psikoz_me/Profile/view/settings.dart';
import 'package:psikoz_me/Search/view/search_Screen.dart';
import 'package:psikoz_me/core/constants/RouteConstants.dart';
import 'package:psikoz_me/newPost/bindings/NewPost.dart';
import 'package:psikoz_me/newPost/view/addScreen.dart';
import 'package:psikoz_me/onboard/Login/bindings/LoginBinding.dart';
import 'package:psikoz_me/onboard/Login/view/loginscreen.dart';
import 'package:psikoz_me/onboard/Register/bindings/registerBinding.dart';
import 'package:psikoz_me/onboard/Register/view/registerscreen.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
      name: Routes_Constant.LOGIN,
      page: () => const LoginView(),
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
     ),
 /* GetPage(name: settingToNamed[0], page: () => HesapAyalari()),
  GetPage(name: settingToNamed[1], page: () => AnonimPage()),
  GetPage(name: settingToNamed[2], page: () => Kaydedilenler()),
  GetPage(name: settingToNamed[3], page: () => Gizlilik()),
  GetPage(name: settingToNamed[4], page: () => Guvenlik()),
  GetPage(name: settingToNamed[5], page: () => NasilKullanilir()),
  GetPage(name: settingToNamed[6], page: () => Sozlesmeler()),
  GetPage(name: settingToNamed[7], page: () => Hakkimizda()),  */
];
