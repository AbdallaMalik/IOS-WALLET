import 'package:flutter/services.dart';

String showEllipse(String string) {
  int length = string.length;
  if (length > 6) {
    String prefix = string.substring(0, 5);
    String suffix = string.substring(length - 5, length);
    return "$prefix...$suffix";
  }
  return string;
}

copyToClipboard(String text) async {
  await Clipboard.setData(
    ClipboardData(text: text),
  );
}
