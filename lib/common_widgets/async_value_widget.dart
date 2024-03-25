import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.data, required this.value});

  final Widget Function(T) data;
  final AsyncValue<T> value;

  @override
  Widget build(BuildContext context) {
    return value.when(
        data: data,
        error: ((error, stackTrace) => Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
