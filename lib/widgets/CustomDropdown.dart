 import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/core/utils/color_constant.dart';


class CustomDropdown extends StatelessWidget {
  final String? hint;
  final dynamic value;

  final Color? iconcolor;
  final double? opacity;


  final double? width;
  final Map<String, dynamic>? dropdownItems;
  final ValueChanged<dynamic>? onChanged;

  const CustomDropdown(
      {Key? key,
      this.hint,
      this.width,
      this.opacity,

      this.iconcolor,
      this.value,
      required this.dropdownItems,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        value != null
            ? Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: dropdownItems!
                        .map((key, value) {
                          return MapEntry(
                              key,
                              DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(value,
                                     ),
                                ),
                              ));
                        })
                        .values
                        .toList(),
                    value: value,
                    onChanged: onChanged,

                    iconStyleData:   IconStyleData(
                      icon:    Icon(
                        Icons.keyboard_arrow_down_outlined,
                          color: iconcolor ?? Colors.black
                      ),
                      iconSize: 14,
                      iconEnabledColor: iconcolor ?? Colors.black,
                      iconDisabledColor: iconcolor ?? Colors.black,
                    ),
                    buttonStyleData: ButtonStyleData(
                      height: 60,

                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:  ColorConstant.fromHex("#D6D6D6"),
                          width: 1,
                        ),
                        color:   Colors.white
                             ,
                      ),
                      elevation: 2,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      padding: const EdgeInsets.all(8),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.all(8),

                      height:60,
                    ),





                  ),
                ),
              )
            : Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(hint!,
                           ),
                    ),
                    isExpanded: true,
                    items: dropdownItems!
                        .map((key, value) {
                          return MapEntry(
                              key,
                              DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(value,
                                       ),
                                ),
                              ));
                        })
                        .values
                        .toList(),
                    onChanged: onChanged,

                    iconStyleData:   IconStyleData(
                      icon:    Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: iconcolor ?? Colors.black
                      ),
                      iconSize: 14,
                      iconEnabledColor: iconcolor ?? Colors.black,
                      iconDisabledColor: iconcolor ?? Colors.black,
                    ),
                    buttonStyleData: ButtonStyleData(
                      height: 60,

                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ColorConstant.primaryColor,
                          width: 1,
                        ),
                        color:  Colors.white
                             ,
                      ),
                      elevation: 2,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      padding: const EdgeInsets.all(8),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.all(8),

                      height:60,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
