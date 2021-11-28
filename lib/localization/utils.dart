import 'package:easy_localization/easy_localization.dart';

String translate(String key, {Map<String, String?>? args}) {
  return key.tr(namedArgs: args as Map<String, String>?);
}
