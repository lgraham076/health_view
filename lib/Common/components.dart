import 'package:flutter/material.dart';
import 'package:healthview/Common/properties.dart';


class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Properties.primaryColor,
        title: Center(child: Text(Properties.displayName)));
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(40);
  }
}