import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final void Function(String) onChange;

  PasswordField({this.onChange});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  IconData getIcon(isVisible) {
    if (!isVisible) {
      return Icons.visibility_off;
    } else {
      return Icons.visibility;
    }
  }

  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChange,
      obscureText: isVisible,
      decoration: textFieldDecoration(
        hint: Strings.PASSWORD_HINT,
        icon: Icons.vpn_key_rounded,
      ).copyWith(
        suffixIcon: GestureDetector(
          child: Icon(getIcon(isVisible)),
          onTap: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
      ),
      style: textFieldStyle,
    );
  }
}
