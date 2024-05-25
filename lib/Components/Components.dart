import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
  //bool isUpperCase = true,
  double radius = 12,
}) =>
    Container(
      width: width,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );

Widget defaultFormFailed({
  required TextEditingController controller,
  required TextInputType type,
  VoidCallback? onChanged,
  String? label,
  String? hint,
  Widget? prefix,
  Widget? suffix,
  bool enabled = true,
  bool isPassword = false,
  Function? suffixPressed,
  String? hintColor,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onChanged: (s) {
          onChanged;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please complete the form';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: HexColor(hintColor!),
            ),
            enabled: enabled,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: HexColor("#5F33E1"),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: HexColor("#BABABA"),
                )),
            suffixIcon: suffix,
            prefixIcon: prefix,
            border: InputBorder.none),
      ),
    );
