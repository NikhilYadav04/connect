import 'package:flutter/material.dart';
import 'package:connect/core/constants/fontfamily.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final double verticalPadding;
  final double horizontalPadding;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.verticalPadding,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: controller,
      style: textStyle2.copyWith(
        letterSpacing: 1,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade500,
        fontSize: sh * 0.022,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(
            Icons.search,
            size: sh * 0.03,
            color: Colors.grey.shade500,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Text(
          "Search experts, skills...",
          style: textStyle2.copyWith(
            letterSpacing: 0.8,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade500,
            fontSize: sh * 0.022,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
