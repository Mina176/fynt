import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart' hide SlidableAction;
import 'package:ios_multi_slidable/ios_multi_slidable.dart';

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
    return IosMultiSlidable(
      key: itemKey,
      rightActions: [
        SlidableAction(
          onTap: onDeleteTapped,
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      ],
      child: child,
    );
  }
}
