/*
 * Created by Archer on 2022/12/3.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter/material.dart';
import 'package:levir/src/viewmodel/view_model_types.dart';

/// A factory that produces [ViewModel]
abstract class ViewModelProvider<T extends ViewModel> {
  const ViewModelProvider();

  @factory
  T createViewModel();
}

/// Helps manage the lifecycle of [ViewModel]
mixin ViewModelProviderStateMixin<T extends StatefulWidget, U extends ViewModel>
    on State<T> implements ViewModelProvider<U> {
  late U viewModel;

  @override
  void initState() {
    viewModel = createViewModel();
    super.initState();
    bindViewModel();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void bindViewModel() {}
}
