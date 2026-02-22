import 'package:flutter/material.dart';

extension ColorARGB32 on Color {
  int toARGB32() {
    final int ai = (a * 255.0).round().clamp(0, 255).toInt();
    final int ri = (r * 255.0).round().clamp(0, 255).toInt();
    final int gi = (g * 255.0).round().clamp(0, 255).toInt();
    final int bi = (b * 255.0).round().clamp(0, 255).toInt();
    return (ai << 24) | (ri << 16) | (gi << 8) | bi;
  }
}
