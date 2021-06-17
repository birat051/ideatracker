import 'package:flutter/material.dart';
import 'package:idea_tracker/utilities/constants.dart';

class IdeaCount extends StatelessWidget {
  final int ideacount;
  final Function getCount;
  IdeaCount(this.ideacount,this.getCount);
  @override
  Widget build(BuildContext context) {
    return Text(
      '$ideacount ideas',
      style: kideastyle,
    );
  }
}
