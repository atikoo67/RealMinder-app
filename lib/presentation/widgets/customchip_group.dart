import 'package:flutter/material.dart';

class CustomChipsGroup extends StatefulWidget {
  final List<String> items;
  final List<String>? defaultSelected;
  final ValueChanged<List<String>> onSelectionChanged;
  final bool multiSelect;
  final EdgeInsetsGeometry? padding;
  final double? spacing;
  final double? runSpacing;
  final WrapAlignment alignment;
  final ChipBuilder? chipBuilder;

  const CustomChipsGroup({
    Key? key,
    required this.items,
    this.defaultSelected,
    required this.onSelectionChanged,
    this.multiSelect = true,
    this.padding,
    this.spacing,
    this.runSpacing,
    this.alignment = WrapAlignment.start,
    this.chipBuilder,
  }) : super(key: key);

  @override
  State<CustomChipsGroup> createState() => _CustomChipsGroupState();
}

class _CustomChipsGroupState extends State<CustomChipsGroup> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.defaultSelected ?? [];
  }

  void _toggleSelection(String item) {
    setState(() {
      if (widget.multiSelect) {
        if (_selectedItems.contains(item)) {
          _selectedItems.remove(item);
        } else {
          _selectedItems.add(item);
        }
      } else {
        _selectedItems = _selectedItems.contains(item) ? [] : [item];
      }
      widget.onSelectionChanged(_selectedItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing ?? 8.0,
      runSpacing: widget.runSpacing ?? 8.0,
      alignment: widget.alignment,
      children: widget.items.map((item) {
        final isSelected = _selectedItems.contains(item);

        if (widget.chipBuilder != null) {
          return widget.chipBuilder!(
            item,
            isSelected,
            () => _toggleSelection(item),
          );
        }

        return CustomSelectableChip(
          label: item,
          isSelected: isSelected,
          onSelected: (_) => _toggleSelection(item),
        );
      }).toList(),
    );
  }
}

typedef Widget ChipBuilder(String label, bool isSelected, VoidCallback onTap);

class CustomSelectableChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyle;
  final bool showCheckmark;
  final double? elevation;
  final Icon? icon;

  const CustomSelectableChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.padding,
    this.borderRadius,
    this.leading,
    this.trailing,
    this.textStyle,
    this.showCheckmark = true,
    this.elevation,
    this.icon,
  }) : super(key: key);

  @override
  State<CustomSelectableChip> createState() => _CustomSelectableChipState();
}

class _CustomSelectableChipState extends State<CustomSelectableChip> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor = widget.isSelected
        ? widget.selectedColor ?? theme.primaryColor
        : widget.unselectedColor ??
              theme.unselectedWidgetColor.withOpacity(0.1);

    final textColor = widget.isSelected
        ? widget.selectedTextColor ?? Colors.white
        : widget.unselectedTextColor ?? theme.unselectedWidgetColor;

    return GestureDetector(
      onTap: () => widget.onSelected(!widget.isSelected),
      child: Container(
        padding:
            widget.padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),

          boxShadow: widget.elevation != null
              ? [BoxShadow(blurRadius: widget.elevation!)]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: 4),
            ],
            if (widget.showCheckmark &&
                widget.isSelected &&
                widget.icon != null) ...[
              widget.icon!,
              const SizedBox(width: 4),
            ],
            Text(
              widget.label,
              style: (widget.textStyle ?? TextStyle(fontSize: 14)).copyWith(
                color: textColor,
                fontWeight: widget.isSelected
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            if (widget.trailing != null) ...[
              const SizedBox(width: 4),
              widget.trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
