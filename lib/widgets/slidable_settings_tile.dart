import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableSettingsTile extends StatelessWidget {
  const SlidableSettingsTile({
    super.key,
    required this.itemKey,
    required this.child,
    required this.onDeleteTapped,
  });

  final Key itemKey;
  final Widget child;
  final VoidCallback onDeleteTapped;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: itemKey,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.45,
        dismissible: DismissiblePane(
          onDismissed: onDeleteTapped,
        ),
        children: [
          CustomSlidableAction(
            autoClose: false,
            onPressed: (context) {
              final slidable = Slidable.of(context);
              if (slidable != null) {
                slidable.dismiss(
                  ResizeRequest(
                    const Duration(milliseconds: 300),
                    onDeleteTapped,
                  ),
                );
              } else {
                onDeleteTapped();
              }
            },
            backgroundColor: Colors.transparent,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
