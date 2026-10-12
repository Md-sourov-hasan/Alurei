import 'package:alurei/src/imports/imports.dart';

class RelationshipDropdown extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const RelationshipDropdown({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<RelationshipDropdown> createState() => _RelationshipDropdownState();
}

class _RelationshipDropdownState extends State<RelationshipDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late TextEditingController _controller;
  late _RelationshipOption _selectedOption;

  final options = [
    _RelationshipOption('Father', () => LangKey.editProfile.father),
    _RelationshipOption('Mother', () => LangKey.editProfile.mother),
    _RelationshipOption('Guardian', () => LangKey.editProfile.guardian),
    _RelationshipOption('Sibling', () => LangKey.editProfile.sibling),
    _RelationshipOption('Grandfather', () => LangKey.editProfile.grandfather),
    _RelationshipOption('Grandmother', () => LangKey.editProfile.grandmother),
    _RelationshipOption('Uncle', () => LangKey.editProfile.uncle),
    _RelationshipOption('Aunt', () => LangKey.editProfile.aunt),
    _RelationshipOption('Relative', () => LangKey.editProfile.relative),
  ];

  @override
  void initState() {
    super.initState();
    _selectedOption = _optionFor(widget.initialValue);
    _controller = TextEditingController(text: _selectedOption.label);
  }

  @override
  void dispose() {
    _closeDropdown();
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _closeDropdown,
            behavior: HitTestBehavior.opaque,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomRight,
              followerAnchor: Alignment.topRight,
              offset: Offset(0, 8.h),
              child: Material(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  side: const BorderSide(color: AppColors.brandGrayBorder),
                ),
                color: context.appColors.primaryBackground,
                child: Container(
                  width: 220.w,
                  constraints: BoxConstraints(maxHeight: 320.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: options.map((option) {
                        final isSelected =
                            _selectedOption.apiValue == option.apiValue;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedOption = option;
                              _controller.text = option.label;
                            });
                            widget.onChanged(option.apiValue);
                            _closeDropdown();
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.colors.primary
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? context.colors.primary
                                    : AppColors.brandGrayBorder,
                              ),
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  option.label,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : context.appColors.secondaryText,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                                Container(
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.brandGrayBorder,
                                      width: isSelected ? 4.w : 1.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  _RelationshipOption _optionFor(String value) {
    final normalizedValue = value.trim().toUpperCase();
    return options.firstWhere(
      (option) =>
          option.apiValue.toUpperCase() == normalizedValue ||
          option.label.toUpperCase() == normalizedValue,
      orElse: () => options.first,
    );
  }

  void _closeDropdown() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      setState(() => _isOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: AppTextField(
        label: LangKey.editProfile.relationship,
        controller: _controller,
        readOnly: true,
        onTap: _toggleDropdown,
        suffixIcon: Icon(
          _isOpen ? IconsaxPlusLinear.arrow_up_1 : IconsaxPlusLinear.arrow_down,
          color: context.colors.onSurface,
        ),
      ),
    );
  }
}

class _RelationshipOption {
  const _RelationshipOption(this.apiValue, this._labelBuilder);

  final String apiValue;
  final String Function() _labelBuilder;

  String get label => _labelBuilder();
}
