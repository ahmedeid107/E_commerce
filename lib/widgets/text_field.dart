import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      this.hintText,
      this.onChanged,
      this.cont,
      this.password,
      this.email = false,
      this.obscure,
      this.prefix = const Text("")});
  final Function(String)? onChanged;
  final String? hintText;
  final TextEditingController? cont;
  final TextEditingController? password;
  final bool email;
  final Widget? prefix;
  bool? obscure;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.cont,
      obscureText: widget.obscure ?? false,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        } else if (widget.password != null) {
          if (data != widget.password!.text) {
            return ' Passwords do not match ';
          }
        } else if (widget.email) {
          if (!data.isEmail) {
            return ' enter a valid email ';
          }
        }
        return null;
      },
      onChanged: widget.onChanged,
      style: const MyStyles().formtextfill(MyColors.neutralGrey),
      decoration: InputDecoration(
        suffixIcon: widget.obscure != null
            ? InkWell(
                onTap: () {
                  widget.obscure = !widget.obscure!;
                  setState(() {});
                },
                child: Icon(
                    !widget.obscure! ? Icons.visibility : Icons.visibility_off))
            : const Text(""),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: MyColors.primaryRed,
          ),
        ),
        errorStyle: const MyStyles().headingH6(MyColors.primaryRed),
        hintText: widget.hintText,
        prefixIcon: widget.prefix,
        hintStyle: const MyStyles().formtextnormal(MyColors.neutralGrey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: secColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: primColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: MyColors.primaryRed,
          ),
        ),
      ),
    );
  }
}
