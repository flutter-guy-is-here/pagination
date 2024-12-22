import 'package:get/get.dart';

class Langs extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_AE': {
          "year": "السنة",
          "hours": "الساعات",
          "change_the_languge": "تفير اللفة",
          "no_element": "لم يتم العثور على أي عنصر",
          "loading_more": "تحميل المزيد",
          "end_of_list": "نهاية العرض"
        },
        'en_US': {
          "year": "Year",
          "hours": "Hours",
          "change_the_languge": "Change the languge",
          "no_element": "No elements found!",
          "loading_more": "LOEADING MORE....",
          "end_of_list": "You reached the end of the list"
        }
      };
}
