import 'package:flutter/material.dart';




class ExpirationFormField extends StatefulWidget {
  //TODO make controller optional
   ExpirationFormField({
    required this.controller,
    required this.decoration,
    this.obscureText = false,
    this.enabled = true,

  });

  final TextEditingController controller;
  final InputDecoration decoration;
  final bool obscureText;
  final bool enabled;
  @override
  _ExpirationFormFieldState createState() => _ExpirationFormFieldState();
}

class _ExpirationFormFieldState extends State<ExpirationFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
      const TextInputType.numberWithOptions(signed: false, decimal: false),
      controller: widget.controller,
      decoration: widget.decoration,

      style: Themes.gothamRegularTextStyle(
          fontSize: Themes.getTextSize("L")),
      onChanged: (value) {
        setState(() {
          value = value.replaceAll(RegExp(r"\D"), "");
          switch (value.length) {
            case 0:
            widget.controller.text = "MM/YY";
              widget.controller.selection = const TextSelection.collapsed(offset: 0);
              break;
            case 1:
            widget.controller.text = "${value}M/YY";
              widget.controller.selection = const TextSelection.collapsed(offset: 1);
              break;
            case 2:
              widget.controller.text = "$value/YY";
              widget.controller.selection = const TextSelection.collapsed(offset: 2);
              break;
            case 3:
              widget.controller.text =
              "${value.substring(0, 2)}/${value.substring(2)}Y";
              widget.controller.selection = const TextSelection.collapsed(offset: 4);
              break;
            case 4:
              widget.controller.text =
              "${value.substring(0, 2)}/${value.substring(2, 4)}";
              widget.controller.selection = const TextSelection.collapsed(offset: 5);
              break;
          }
          if (value.length > 4) {
            widget.controller.text =
            "${value.substring(0, 2)}/${value.substring(2, 4)}";
            widget.controller.selection = const TextSelection.collapsed(offset: 5);
          }
        });
      },
      cursorWidth: 2.0,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
    );
  }
}