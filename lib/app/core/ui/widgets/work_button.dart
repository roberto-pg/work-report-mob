import 'package:flutter/material.dart';

class WorkButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double fontSize;
  final double width;
  final double height;

  const WorkButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.fontSize = 20,
      required this.width,
      required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          primary: const Color(0XFF3a4750),
        ),
      ),
    );
  }
}
