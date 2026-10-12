import 'package:alurei/src/shared/wrappers/screen_util_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the 440px Figma design width', () {
    const wrapper = ScreenUtilWrapper(child: SizedBox.shrink());

    expect(wrapper.designSize, const Size(440, 956));
  });
}
