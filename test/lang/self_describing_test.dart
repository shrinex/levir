/*
 * Created by Archer on 2022/12/13.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:levir/src/lang/self_describing.dart';

class MockPet implements SelfDescribing {
  final String name;

  final String owner;

  @override
  String get description => "$owner's pet $name";

  const MockPet(this.owner, this.name);
}

void main() {
  test("description", () {
    const pet = MockPet("archer", "labubu");
    expect(pet.description, "archer's pet labubu");
  });
}
