import 'package:flutter/material.dart';

class ExpenseCategory {
  ExpenseCategory({
    required this.id,
    required this.name,
    required this.color,
  });
  final String id;
  final String name;
  final Color color;
}
