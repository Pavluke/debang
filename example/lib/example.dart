import 'dart:math';

import 'package:debang/debang.dart';

void main() {
  int? value;
  while (Random().nextBool()) {
    value = Random().nextInt(10);
    int result = value.debang('It looks like a null assignment');
    print('result: $result');
  }
  value = null;
  int result = value.debang('It looks like a null assignment');
}
