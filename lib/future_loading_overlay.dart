library future_loading_overlay;

import 'package:flutter/material.dart';

/// A helper function that run a future
/// and display loading dialog and hide when future is completed
Future<T?> showFutureLoadingOverlay<T>({
  required BuildContext context,
  required Future<T> future,
  bool barrierDismissible = false,
  bool expanded = false,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => FutureLoadingOverlayDialog(
      future: future,
      expanded: expanded,
    ),
  );
}

/// A loading overlay dialog
class FutureLoadingOverlayDialog<T> extends StatefulWidget {
  final Future<T> future;
  final bool expanded;

  const FutureLoadingOverlayDialog({
    Key? key,
    required this.future,
    required this.expanded,
  }) : super(key: key);

  @override
  State<FutureLoadingOverlayDialog<T>> createState() =>
      _FutureLoadingOverlayDialogState<T>();
}

class _FutureLoadingOverlayDialogState<T>
    extends State<FutureLoadingOverlayDialog<T>> {
  @override
  void initState() {
    super.initState();

    _excuteFuture();
  }

  Future<void> _excuteFuture() async {
    try {
      final result = await widget.future;

      if (mounted) {
        Navigator.pop(context, result);
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.expanded
        ? _buildLoadingDialogExpanded()
        : _buildLoadingDialog();
  }

  Widget _buildLoadingDialog() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingDialogExpanded() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
