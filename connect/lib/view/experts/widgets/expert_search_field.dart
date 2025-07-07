// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:connect/core/constants/fontfamily.dart';

// ignore: must_be_immutable
class CategorySearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final double verticalPadding;
  final double horizontalPadding;
  String label = "Search experts, skills...";
  final ValueChanged<String>? onChanged;

  CategorySearchTextField({
    Key? key,
    required this.controller,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;

    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: isFocused
                      ? Colors.deepPurple.withOpacity(0.25)
                      : Colors.grey.withOpacity(0.15),
                  blurRadius: 6,
                  spreadRadius: isFocused ? 1 : 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              style: textStyle2.copyWith(
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
                fontSize: sh * 0.02,
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
                    size: sh * 0.028,
                    color: Colors.grey.shade600,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Text(
                  label,
                  style: textStyle2.copyWith(
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                    fontSize: sh * 0.02,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 2,
                      style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: Colors.deepPurple, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
