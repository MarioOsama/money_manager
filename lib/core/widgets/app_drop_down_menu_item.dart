import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class AppDropDownMenuItem extends StatefulWidget {
  final String title;
  final List<dynamic> items;
  final TextEditingController controller;
  final String titleText;
  final List<Color>? itemColors;
  final bool? itemsHaveColorProperty;
  final double? width;
  final double? height;
  final Function(BuildContext context, TextEditingController controller)?
      onChanged;

  const AppDropDownMenuItem({
    super.key,
    required this.title,
    required this.items,
    required this.controller,
    this.onChanged,
    this.itemColors,
    this.itemsHaveColorProperty,
    this.width,
    this.height,
    required this.titleText,
  });

  @override
  State<AppDropDownMenuItem> createState() => _AppDropDownMenuItemState();
}

class _AppDropDownMenuItemState extends State<AppDropDownMenuItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _initializeControllerValue();
  }

  void _initializeControllerValue() {
    _controller.text = widget.items
        .where((element) => element.toString() == _controller.text)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    _handleControllerText();
    final List<DropdownMenuItem<String>> items = widget.items.map((item) {
      final bool itemsHaveColor = widget.itemsHaveColorProperty ?? false;
      final List<Color> colors = widget.itemColors ??
          List.generate(widget.items.length, (_) => Colors.transparent);

      return DropdownMenuItem(
        value: item.toString(),
        child: _buildDropDownItemContainer(item, itemsHaveColor, colors),
      );
    }).toList();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: widget.height ?? 50.h,
      width: widget.width ?? 180.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          borderRadius: BorderRadius.circular(8.0),
          dropdownColor: Colors.grey[200],
          isDense: true,
          isExpanded: true,
          value: _controller.text,
          items: items,
          onChanged: (newValue) {
            setState(() {
              _controller.text = newValue.toString();
            });
            widget.onChanged?.call(context, _controller);
          },
        ),
      ),
    );
  }

  Widget _buildDropDownItemContainer(
      dynamic item, bool itemsHaveColor, List<Color> colors) {
    return Center(
      child: Container(
        width: 130.w,
        decoration: BoxDecoration(
          color: itemsHaveColor ? Color(item.colorCode) : Colors.transparent,
          border: Border(
              left: BorderSide(
                  color: itemsHaveColor
                      ? Color(item.colorCode)
                      : colors[widget.items.indexOf(item)],
                  width: 5.w)),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(3.0),
        child: Text(
          item.toString(),
          overflow: TextOverflow.ellipsis,
          style: TextStyles.f16LightPrimaryMedium.copyWith(
            color: itemsHaveColor
                ? Color(item.colorCode + item.colorCode * 3)
                : Colors.indigo,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _handleControllerText() {
    _controller.text = _controller.text.replaceAll('(', '');
    _controller.text = _controller.text.replaceAll(')', '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
