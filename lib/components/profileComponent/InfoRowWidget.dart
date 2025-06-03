import 'package:flutter/material.dart';

class InfoRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;

  // Constructor
  InfoRowWidget({
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: iconColor ?? Colors.lightGreen[400],
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(10.0),
          child: Icon(
            icon,
            color: Colors.white, // White color for the icon
            size: 24, // Icon size
          ),
        ),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15.0),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),
            ),
          ],
        ),
      ],
    );
  }
}
