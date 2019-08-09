import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String leadingImage;
  final String title;
  final AppBar appBar;
  final List<Widget> widgets;

  /// you can add more fields that meet your needs

  const BaseAppBar(
      {Key key, this.title, this.appBar, this.widgets, this.leadingImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: appBarTextStyle),
      leading: Image.asset(leadingImage),
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
