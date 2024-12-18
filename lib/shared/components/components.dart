import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/values_manager.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        bool isUpperCase = true,
        double radius = 0.0,
        double sizeText = 15,
        required Function() function,
        required String text}) =>
    Container(
      width: width,
      height: 45.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: background),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text : text,
          style: TextStyle(color: Colors.black, fontSize: sizeText),
        ),
      ),
    );

//=======================================================================================================================================================

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        ValueChanged<String>? onSubmit,
        ValueChanged<String>? onChange,
        GestureTapCallback? onTap,
        bool isPassword = false,
        required FormFieldValidator<String>? validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        VoidCallback? suffixPressed,
        bool isClickable = true,
        int? lines}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      maxLines: lines,
      validator: validate,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
              : null,
          border: const OutlineInputBorder()),
    );

//=======================================================================================================================================================

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//=======================================================================================================================================================

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

//=======================================================================================================================================================

customDropDown(List listMap, String selectValue, String title) {
  return Padding(
    padding:  const EdgeInsets.symmetric(
        horizontal: AppSize.s16, vertical: AppSize.s8),
    child: Row(
      children: [
        DropdownButtonHideUnderline(
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
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.Black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: listMap
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.Black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectValue,
            onChanged: (value) {
              selectValue = value as String;
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 170,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: ColorManager.white,
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5899E2),
                      Color(0xFFFFFFFF),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              elevation: 4,
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
              maxHeight: 170,
              width: 170,
              padding: null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5899E2),
                      Color(0xFFFFFFFF),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              elevation: 8,
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    ),
  );
}
