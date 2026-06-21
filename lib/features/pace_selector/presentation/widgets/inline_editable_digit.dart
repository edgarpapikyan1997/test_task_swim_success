import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import 'pace_display_styles.dart';

/// Using setState here because [_isEditing] is trivial local UI state — it
/// only controls whether the inline text field is visible, not business data.
class InlineEditableDigit extends StatefulWidget {
  const InlineEditableDigit({
    super.key,
    required this.value,
    required this.onSubmitted,
    required this.maxLength,
    this.semanticLabel,
  });

  final int value;
  final ValueChanged<int> onSubmitted;
  final int maxLength;
  final String? semanticLabel;

  @override
  State<InlineEditableDigit> createState() => _InlineEditableDigitState();
}

class _InlineEditableDigitState extends State<InlineEditableDigit> {
  bool _isEditing = false;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formattedValue);
    _focusNode = FocusNode()..addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant InlineEditableDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditing && oldWidget.value != widget.value) {
      _controller.text = _formattedValue;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  String get _formattedValue => widget.value.toString().padLeft(2, '0');

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && _isEditing) {
      _commitValue();
    }
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
      _controller.text = _formattedValue;
    });
    _focusNode.requestFocus();
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );
  }

  void _commitValue() {
    final parsed = int.tryParse(_controller.text.trim());
    if (parsed != null) {
      widget.onSubmitted(parsed);
    }
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      button: !_isEditing,
      child: GestureDetector(
        onTap: _isEditing ? null : _startEditing,
        child: Container(
          width: 88,
          height: 72,
          alignment: Alignment.center,
          decoration: _isEditing ? PaceDisplayStyles.editingDecoration : null,
          child: _isEditing ? _buildTextField() : Text(_formattedValue, style: PaceDisplayStyles.digit),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: PaceDisplayStyles.digit,
      cursorColor: AppColors.accent,
      maxLength: widget.maxLength,
      decoration: const InputDecoration(
        counterText: '',
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onSubmitted: (_) => _commitValue(),
    );
  }
}
