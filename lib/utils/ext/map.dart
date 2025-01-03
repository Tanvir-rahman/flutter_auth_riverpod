extension MapExtension on Map<String, bool> {
  bool validate() {
    bool isValid = isNotEmpty;
    final values = this.values.toList();
    for (final item in values) {
      if (!item) {
        isValid = false;
        break;
      }
    }
    return isValid;
  }
}

// var validMap = {
//   'condition1': true,
//   'condition2': true,
//   'condition3': true
// };
// print(validMap.validate()); // true
