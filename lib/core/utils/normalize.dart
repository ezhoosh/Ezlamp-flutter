class Normalize {
  static int normalizeValue(int originalValue) {
    const double minValue = 0.0;
    const double maxValue = 255.0;
    const double normalizedMin = 0.0;
    const double normalizedMax = 99.0;

    double normalizedValue =
        ((originalValue - minValue) / (maxValue - minValue)) *
                (normalizedMax - normalizedMin) +
            normalizedMin;

    return normalizedValue.toInt();
  }
}
