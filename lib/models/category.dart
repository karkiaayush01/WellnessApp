import 'package:flutter/cupertino.dart';

class Category{
  String title;
  String iconPath;
  String? quote;
  String? saidBy;
  void Function(BuildContext)? onClick;

  Category(this.title, this.iconPath, {this.quote, this.saidBy, this.onClick});
}