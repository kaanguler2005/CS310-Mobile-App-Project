import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';

/// The small window that asks the user to confirm: "Send this answer?" on
/// S10 and "Delete account" on S7.
///
/// The decks have not covered AlertDialog or showDialog, so this is built
/// from widgets they have covered: a Stack puts this on top of the screen,
/// Container and BoxDecoration draw the white box, and the two buttons are
/// a FilledButton and a TextButton.
///
/// Use it inside a Stack and show or hide it with a bool in your State:
///
///   body: Stack(
///     children: [
///       _content(),
///       askSend ? ConfirmationDialog(...) : const SizedBox(width: 0, height: 0),
///     ],
///   )
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onCancel,
    required this.onConfirm,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(28),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(fontSize: 14, color: AppColors.mutedText),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: onCancel,
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: onConfirm,
                    child: Text(confirmLabel),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
