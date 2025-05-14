import 'package:flutter/material.dart';

class AppSearchTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onClear;
  final ValueChanged<String>? onFieldSubmitted;
  final bool showPrefixIcon;
  final bool showNoteText;

  const AppSearchTextInput({
    Key? key,
    this.controller,
    required this.hintText,
    this.onClear,
    this.onFieldSubmitted,
    this.showPrefixIcon = true,
    this.showNoteText = true,
  }) : super(key: key);

  @override
  _AppSearchTextInputState createState() => _AppSearchTextInputState();
}

class _AppSearchTextInputState extends State<AppSearchTextInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          onFieldSubmitted:
              widget.onFieldSubmitted, // Use onFieldSubmitted here
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            hintText: widget.hintText,
            prefixIcon: widget.showPrefixIcon ? const Icon(Icons.search) : null,
            suffixIcon:
                _controller.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        if (widget.onClear != null) {
                          widget.onClear!();
                        }
                      },
                    )
                    : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        if (widget.showNoteText)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Note: Press Enter to search',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
