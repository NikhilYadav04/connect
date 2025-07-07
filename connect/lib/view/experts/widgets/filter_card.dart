import 'package:connect/core/constants/colors.dart';
import 'package:connect/core/constants/fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FilterBar extends StatelessWidget {
  final List<String> priceRanges;
  final String selectedPrice;
  final ValueChanged<String?> onPriceChanged;

  final List<String> ratingOptions;
  final String selectedRating;
  final ValueChanged<String?> onRatingChanged;

  final List<String> sortOptions;
  final String selectedSort;
  final ValueChanged<String?> onSortChanged;

  final double h;
  final double w;

  const FilterBar({
    Key? key,
    required this.priceRanges,
    required this.selectedPrice,
    required this.onPriceChanged,
    required this.ratingOptions,
    required this.selectedRating,
    required this.onRatingChanged,
    required this.sortOptions,
    required this.selectedSort,
    required this.onSortChanged,
    required this.h,
    required this.w,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Base text style with explicit black color
    final baseStyle = TextStyle(
      fontFamily: 'Jakarta-Medium',
      fontSize: w * 0.032,
      color: Colors.black,
    );

    Widget buildField({
      required String label,
      required String value,
      required List<String> items,
      required ValueChanged<String?> onChanged,
    }) {
      return Expanded(
        child: DropdownButtonFormField2<String>(
          buttonStyleData: ButtonStyleData(
            overlayColor: WidgetStatePropertyAll(Colors.white)
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: Colors.white
            )
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            labelText: label,
            labelStyle: baseStyle.copyWith(
                color: Colors.black,
                fontSize: h * 0.02,
                fontWeight: FontWeight.bold),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(
              vertical: h * 0.017,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade800, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.colorPurple, width: 2),
            ),
          ),
          isExpanded: true,
          style: baseStyle.copyWith(color: Colors.black, fontSize: h * 0.025),
          iconStyleData: IconStyleData(
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
              iconSize: h * 0.03),
          hint: Text(items.first,
              style:
                  baseStyle.copyWith(color: Colors.black, fontSize: h * 0.025)),
          value: value.isNotEmpty ? value : null,
          items: items
              .map((opt) => DropdownMenuItem<String>(
                    value: opt,
                    child: FittedBox(
                      child: Text(
                        opt,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle3.copyWith(
                            wordSpacing: 0.5,
                            color: Colors.black,
                            fontSize: h * 0.015,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.0, vertical: h * 0.01),
      child: Row(
        children: [
          buildField(
            label: 'Price',
            value: selectedPrice,
            items: priceRanges,
            onChanged: onPriceChanged,
          ),
          SizedBox(width: w * 0.02),
          buildField(
            label: 'Rating',
            value: selectedRating,
            items: ratingOptions,
            onChanged: onRatingChanged,
          ),
          SizedBox(width: w * 0.02),
          buildField(
            label: 'Sort by',
            value: selectedSort,
            items: sortOptions,
            onChanged: onSortChanged,
          ),
        ],
      ),
    );
  }
}
