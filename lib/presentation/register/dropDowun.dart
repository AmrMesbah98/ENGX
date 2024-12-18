import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

buildDropDown({required String title,required List listItem,required String selectedValue})
{
  return DropdownButtonHideUnderline(
    child: DropdownButton2(
      isExpanded: true,
      hint: Row(
        children: [
          Icon(
            Icons.list,
            size: 16,
            color: ColorManager.Black,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorManager.Black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: listItem.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ColorManager.Black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      )).toList(),
      value: selectedValue,
      onChanged: (value) {

          selectedValue = value as String;

      },
      buttonStyleData: ButtonStyleData(
        height: 50,
        width: 200,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: ColorManager.white,
          ),
          color: ColorManager.white,
        ),
        elevation: 2,
      ),
      iconStyleData: IconStyleData(
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: ColorManager.Black,
        iconDisabledColor: ColorManager.Black,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: 200,
        padding: null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: ColorManager.white,
        ),
        elevation: 8,
        offset: const Offset(-20, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility:
          MaterialStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    ),
  ) ;
}