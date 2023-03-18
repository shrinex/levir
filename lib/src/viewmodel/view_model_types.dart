/*
 * Created by Archer on 2022/12/3.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/src/viewmodel/disposable.dart';

/// Represents input events, such as clicks the button
/// or fires a HTTP request, etc
abstract class ViewModelInputs {}

/// Represent output events, such as enters another page
/// in response of clicks the button, or receives new data
/// through the network, etc
abstract class ViewModelOutputs {}

/// ViewModel acts as a bridge connecting input and output
abstract class ViewModel extends Disposable {
  ViewModelInputs get inputs;

  ViewModelOutputs get outputs;
}
