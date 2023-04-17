import 'package:flutter/material.dart';
import 'package:toponymy/src/theme/toponymy_theme.dart';

class ToponymyBottomDropDown<T> extends StatefulWidget {
  final String? title;
  final dynamic value;
  final List<CustomeCheckBox<T>> items;

  ToponymyBottomDropDown(
      {Key? key, required this.title, required this.value, required this.items})
      : super(key: key);

  @override
  _ToponymyBottomDropDown createState() => _ToponymyBottomDropDown<T>();
}

class _ToponymyBottomDropDown<T> extends State<ToponymyBottomDropDown<T>> {
  //To Component
  bool checkDarkMode(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildDropDown(context),
        buildListBottom(context),
      ],
    );
  }

  bool isExpanded = false;
  bool isChecked = false;
  Widget buildDropDown(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? "",
              style: ToponymyTheme.regular('bold').copyWith(
                  color: checkDarkMode(context)
                      ? ToponymyTheme.skyWhite
                      : ToponymyTheme.inkDarkest),
            ),
            isExpanded
                ? const SizedBox()
                : Text(
                    "${widget.value}",
                    style: ToponymyTheme.small('none').copyWith(
                        color: checkDarkMode(context)
                            ? ToponymyTheme.skyDark
                            : ToponymyTheme.inkLight),
                  ),
          ],
        )),
        IconButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            icon: Icon(
                isExpanded ? Icons.expand_less_sharp : Icons.expand_more_sharp,
                size: 26)),
      ],
    );
  }

  Widget buildListBottom(BuildContext context) {
    return AnimatedSize(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 300),
        child: isExpanded
            ? Container(
                child: isExpanded
                    ? Column(
                        children: widget.items.map((CustomeCheckBox item) {
                          return buildItemBottom(context, item);
                        }).toList(),
                      )
                    : const SizedBox(key: Key("hide")),
              )
            : const SizedBox(
                width: double.infinity,
              ));
  }

  Widget buildItemBottom(BuildContext context, CustomeCheckBox wgt) {
    return wgt;
  }
}

class CustomeCheckBox<T> extends StatelessWidget {
  final dynamic value;
  final Widget child;
  final bool isChecked;
  final Function(T?) onChange; //callback
  final bool showBox;

  CustomeCheckBox(
      {Key? key,
      required this.value,
      required this.child,
      required this.onChange,
      required this.isChecked,
      this.showBox = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // for event full element lebih besar
    return GestureDetector(
      onTap: () {
        onChange(this.value);
      },
      child: Row(
        children: [
          Expanded(
            child: child,
          ),
          Container(
            width: 26,
            height: 26,
            margin: const EdgeInsets.all(12.0),
            child: OutlinedButton(
              onPressed: () {
                onChange(this.value);
              },
              /*setState(
            () => isChecked = !isChecked,
          );*/
              //},
              child: isChecked
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: showBox
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
                    )
                  : const SizedBox(),
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(26, 26), //
                backgroundColor: isChecked && showBox
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                padding: const EdgeInsets.all(0), // is needed
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(width: 5, color: ToponymyTheme.skyDark)),
                side: BorderSide(
                  width: showBox ? 1 : 0,
                  color: showBox
                      ? isChecked
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey
                      : Colors.transparent,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


