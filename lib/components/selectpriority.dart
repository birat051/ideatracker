import 'package:flutter/material.dart';


class SelectPriority extends StatelessWidget {
  final String selectedvalue;
  final Function changePriority;
  SelectPriority(this.selectedvalue,this.changePriority);
  @override
  Widget build(BuildContext context) {
 //   Widget<DropdownButton> getDropDown(){
      return DropdownButton<String>(items: [
        DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Low'),
              Icon(
                Icons.circle,
                color: Colors.green,
              )
            ],
          ),
          value: 'Low',
        ),
        DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Normal'),
              Icon(
                Icons.circle,
                color: Colors.amberAccent,
              )
            ],
          ),
          value: 'Normal',
        ),
        DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('High'),
              Icon(
                Icons.circle,
                color: Colors.red,
              )
            ],
          ),
          value: 'High',
        ),
      ],
        onChanged: changePriority,
        value: selectedvalue,
      );
    }
 // }
}

