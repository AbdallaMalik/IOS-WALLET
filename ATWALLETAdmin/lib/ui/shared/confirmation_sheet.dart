// ignore_for_file: use_build_context_synchronously

import 'package:cryptomask_admin/ui/shared/wallet_button.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text.dart';
import 'package:flutter/material.dart';

class ConfirmationSheetOptions {
  final String optionText;
  final bool isPrimary;
  final Function() onSelect;

  ConfirmationSheetOptions(this.optionText, this.onSelect, this.isPrimary);
}

class ConfirmationSheet extends StatefulWidget {
  final String question;
  final List<ConfirmationSheetOptions> options;
  const ConfirmationSheet(
      {super.key, required this.question, required this.options});

  @override
  State<ConfirmationSheet> createState() => _ConfirmationSheetState();
}

class _ConfirmationSheetState extends State<ConfirmationSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 40,
        ),
        WalletText(
          localizeKey: widget.question,
        ),
        const SizedBox(
          height: 30,
        ),
        const Expanded(child: SizedBox()),
        Column(
          children: widget.options
              .map(
                (option) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: WalletButton(
                    onPressed: option.onSelect,
                    localizeKey: option.optionText,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
