import 'package:flutter/material.dart';

class Trans {
  ///1 color,180 degrees
  static Color complementary(Color color) {
    final hsv = HSVColor.fromColor(color);
    return hsv.withHue((hsv.hue + 180) % 360).toColor();
  }

  ///2 colors,30 degrees
  static List<Color> analogous(Color color) {
    final hsv = HSVColor.fromColor(color);
    return [
      hsv.withHue((hsv.hue - 30 + 360) % 360).toColor(),
      hsv.withHue((hsv.hue + 30) % 360).toColor(),
    ];
  }

  ///2 color, less light
  static List<Color> monochromatic(Color color) {
    final hsv = HSVColor.fromColor(color);
    return [
      hsv.withValue((hsv.value * 0.8).clamp(0, 1)).toColor(),
      hsv.withSaturation((hsv.saturation * 0.5).clamp(0, 1)).toColor(),
    ];
  }

  ///2 colors, 120 degrees
  static List<Color> triadic(Color color) {
    final hsv = HSVColor.fromColor(color);
    return [
      hsv.withHue((hsv.hue + 120) % 360).toColor(),
      hsv.withHue((hsv.hue + 240) % 360).toColor(),
    ];
  }

  ///3 colors, 90 degrees
  static List<Color> tetradic(Color color) {
    final hsv = HSVColor.fromColor(color);
    return [
      hsv.withHue((hsv.hue + 90) % 360).toColor(),
      hsv.withHue((hsv.hue + 180) % 360).toColor(),
      hsv.withHue((hsv.hue + 270) % 360).toColor(),
    ];
  }
}
