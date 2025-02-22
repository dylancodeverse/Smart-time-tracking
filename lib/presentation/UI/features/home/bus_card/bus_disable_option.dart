import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/config/theme.dart';


class BusDisableOption extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.scaff,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4)],
      ),
      child: Icon(Icons.cancel, color: const Color.fromARGB(255, 222, 52, 26), size: 16),
    );
  }
}
