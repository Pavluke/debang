import 'dart:math';

import 'package:debang/debang.dart';

void main() {
  while (true) {
    final random = Random();
    int? value = random.nextBool() ? random.nextInt(10) : null;
    int result = value.debang("I'm sure value is not be null!");
    print('Random result: $result');
  }
}
