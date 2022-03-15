// ignore_for_file: file_names, non_constant_identifier_names

import 'package:get/get.dart';

class PhyscologyObject extends GetxController {
  String name;
  String imageAsset;
  PhyscologyObject({
    required this.name,
    required this.imageAsset,
  });
}

class Variable extends GetxController {
  List<String> PHYSCOLOGYOBJECTNAME = [
    "Depresyon Dönemleri",
    "Anksiyete Bozukluğu",
    "Bipolar Bozuklukları",
    "Yeme Bozukluğu",
    "Sosyal Medya Bağımlılığı",
    "Özgüven Kayıpları",
    "Stress Bozuklukları",
    "OKB dönemleri",
    "+18 Konular"
  ];

  List<String> AssetImage = [
    "assets/images/Psikoz/depresyon.svg",
    "assets/images/Psikoz/anksiyette.svg",
    "assets/images/Psikoz/bipolar.svg",
    "assets/images/Psikoz/yemekBozukluklari.svg",
    "assets/images/Psikoz/sosyalmedya.svg",
    "assets/images/Psikoz/ozguvenEksikliği.svg",
    "assets/images/Psikoz/strestBozuklugu.svg",
    "assets/images/Psikoz/okb.svg",
    "assets/images/Psikoz/onSekiz.svg"
  ];

  
}
