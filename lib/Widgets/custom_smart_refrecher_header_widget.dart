import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomSmartRefrecherHeaderWidget extends StatelessWidget {
  const CustomSmartRefrecherHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? const ClassicHeader()
        :  MaterialClassicHeader(
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor);
  }
}
