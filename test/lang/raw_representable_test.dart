/*
 * Created by Archer on 2022/12/13.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:levir/src/lang/raw_representable.dart';

enum MockWidgetState implements RawEnum<int> {
  init(1),
  activate(2),
  deactivate(3),
  ;

  @override
  final int rawValue;

  const MockWidgetState(this.rawValue);
}

void main() {
  group("RawEnum", () {
    test(
        "byRawValue() when match returns corresponding enum value",
        () => {
              expect(
                MockWidgetState.values.byRawValue(1),
                MockWidgetState.init,
              ),
              expect(
                MockWidgetState.values.byRawValue(2),
                MockWidgetState.activate,
              ),
              expect(
                MockWidgetState.values.byRawValue(3),
                MockWidgetState.deactivate,
              ),
            });

    test(
        "byRawValue() when not match returns null",
        () => {
              expect(
                MockWidgetState.values.byRawValue(0),
                null,
              ),
              expect(
                MockWidgetState.values.byRawValue(4),
                null,
              ),
            });

    test(
        "byRequiredRawValue() when match returns corresponding enum value",
        () => {
              expect(
                MockWidgetState.values.byRequiredRawValue(1),
                MockWidgetState.init,
              ),
              expect(
                MockWidgetState.values.byRequiredRawValue(2),
                MockWidgetState.activate,
              ),
              expect(
                MockWidgetState.values.byRequiredRawValue(3),
                MockWidgetState.deactivate,
              ),
            });

    test(
        "byRequiredRawValue() when not match throws ArgumentError",
        () => {
              expect(
                () => MockWidgetState.values.byRequiredRawValue(-1),
                throwsArgumentError,
              ),
              expect(
                () => MockWidgetState.values.byRequiredRawValue(4),
                throwsArgumentError,
              ),
            });
  });
}
