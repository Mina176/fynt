import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/currency/logic/currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayAmount extends ConsumerWidget {
  const DisplayAmount({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyCode = ref.watch(currencyCodeProvider);
    return Column(
      children: [
        Text(
          "Amount ($currencyCode)",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          style: TextStyles.amount,
          showCursor: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            hintText: "0.00",
            hintStyle: WidgetStateTextStyle.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                );
              }
              return const TextStyle(
                color: Colors.grey,
              );
            }),
          ),
        ),
      ],
    );
  }
}
