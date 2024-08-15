 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';


class CustomDropdownIos extends StatelessWidget {
  int? indexselected;

  String? hint;
  Color? color;

  Color? textcolor;

  Color? iconcolor;


  double? opacity;
  double? width;
  dynamic value;
  final Map<String, dynamic>? dropdownItems;
  ValueChanged<dynamic>? onChanged;
  Function(dynamic)? onConfirm;

  CustomDropdownIos(
      {super.key,
      this.indexselected = 0,
      this.hint,
      this.value,
      this.color,
      this.width,
      this.opacity,

      this.iconcolor,
      required this.dropdownItems,
      this.onChanged,
      this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hint!.isNotEmpty) ...[
          Row(
            children: [
              const Icon(
                Icons.circle,
                color: Colors.black,
                size: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    hint!,

                  ),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xff999999),
                              width: 0.0,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CupertinoButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 5.0,
                              ),
                              child: const Text('Cancel',
                                   ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                onConfirm!(indexselected);
                                Navigator.pop(context);
                              },
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 5.0,
                              ),
                              child: const Text(
                                'ok' ,

                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: indexselected!,
                            ),
                            itemExtent: 32.0,
                            backgroundColor: Colors.white,
                            onSelectedItemChanged: (a) {
                              indexselected = a;
                              onChanged!(a);
                            },
                            children: dropdownItems!
                                .map((key, value) {
                                  return MapEntry(
                                      key,
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Text(value,
                                               ),
                                        ),
                                      ));
                                })
                                .values
                                .toList()),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            width: width ?? MediaQuery.of(context).size.width * .9,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color:  ColorConstant.fromHex("#D6D6D6"),
                width: 1,
              ),
              color: opacity == -1
                  ? Colors.white
                  : const Color.fromRGBO(255, 255, 255, 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:   Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            value,

                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: iconcolor ?? Colors.black,
                  ),
                ),
              ],
            )),
          ),
        )
      ],
    );
  }
}
