import 'package:flutter/material.dart';
class FilledTextField extends StatefulWidget {
  const FilledTextField({Key? key, required this.hint, this.suffix, this.preffix, this.maxLine, this.inputType, this.validator, this.controller}) : super(key: key);
  final String hint;
  final Widget? suffix;
  final Widget? preffix;
  final TextEditingController? controller ;
  final int? maxLine;
  final TextInputType? inputType;
  final String? Function(String?)? validator;

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: widget.validator ,
        controller: widget.controller,
        maxLines: widget.maxLine ,
        keyboardType:widget.inputType ,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
                gapPadding: 2,
                borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
            fillColor: Colors.white,
            hintText: widget.hint,
            suffixIcon: widget.suffix,
            prefixIcon: widget.preffix,
            prefixIconColor: Colors.blueGrey,
            contentPadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            suffixIconColor: Colors.indigo,
            hintStyle: TextStyle(color: Colors.grey.shade500)),
      ),
    );
  }
}
