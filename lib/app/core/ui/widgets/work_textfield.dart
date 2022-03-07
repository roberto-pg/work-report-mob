import 'package:flutter/material.dart';

class WorkTextfield extends StatefulWidget {
  final IconData icon;
  final Widget? suffix;
  final String hint;
  final TextInputType keyboardType;
  final bool? obscuredTextPassword;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;

  const WorkTextfield(
      {Key? key,
      required this.icon,
      this.suffix,
      required this.hint,
      required this.keyboardType,
      this.obscuredTextPassword,
      this.validator,
      this.onSaved})
      : super(key: key);

  @override
  State<WorkTextfield> createState() => _WorkTextfieldState();
}

class _WorkTextfieldState extends State<WorkTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.suffix,
          labelText: widget.hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: const TextStyle(color: Colors.white)),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscuredTextPassword ?? false,
      onSaved: widget.onSaved,
      validator: widget.validator,
      textAlignVertical: TextAlignVertical.bottom,
    );
  }
}
