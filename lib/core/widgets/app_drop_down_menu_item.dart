import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class AppDropDownMenuItem extends StatefulWidget {
  final String title;
  final List<dynamic> items;
  final TextEditingController controller;
  final List<Color>? itemColors;
  final bool? itemsHaveColorProperty;
  final Function(BuildContext context, TextEditingController controller)?
      onChanged;
  const AppDropDownMenuItem({
    super.key,
    required this.items,
    required this.title,
    required this.controller,
    this.onChanged,
    this.itemColors,
    this.itemsHaveColorProperty,
  });

  @override
  State<AppDropDownMenuItem> createState() => _AppDropDownMenuItemState();
}

class _AppDropDownMenuItemState extends State<AppDropDownMenuItem> {
  int selectedItemIndex = 0;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.itemColors ??
        widget.items.map((e) => Colors.transparent).toList();
    final itemsHaveColor = widget.itemsHaveColorProperty ?? false;

    final List<DropdownMenuItem<String>> items = [
      for (var item in widget.items)
        _buildDropDownMenuItem(item, itemsHaveColor, colors)
    ];

    if (items.where((item) => item.value == _controller.text).isEmpty) {
      _controller.text = widget.items.first.toString();
    }

    return Container(
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          left: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 50.h,
      width: 180.w,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
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
                final selectedItem = widget.items.firstWhere(
                    (value) => value.toString() == newValue.toString());
                selectedItemIndex = widget.items.indexOf(selectedItem);
              });
              widget.onChanged?.call(context, _controller);
            },
          ),
        ),
      ),
    );
  }

  _buildDropDownMenuItem(item, itemsHaveColor, colors) {
    return DropdownMenuItem(
      value: item.toString(),
      child: Container(
        width: 130.w,
        decoration: BoxDecoration(
          color: itemsHaveColor ? Color(item.colorCode) : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: itemsHaveColor
                  ? Color(item.colorCode)
                  : colors[widget.items.indexOf(item)],
              width: 5.w,
            ),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(3.0),
        child: Text(
          item.toString(),
          overflow: TextOverflow.ellipsis,
          style: TextStyles.f16PrimaryLightMedium.copyWith(
              color: itemsHaveColor
                  ? Color(item.colorCode + item.colorCode * 3)
                  : Colors.indigo),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
