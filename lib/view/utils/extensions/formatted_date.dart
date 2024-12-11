extension DateTimeExtension on DateTime {
  String get formattedDate {
    // Extract the year, month, and day
    final year = this.year;
    final month = this.month.toString().padLeft(2, '0'); // Ensure 2 digits
    final day = this.day.toString().padLeft(2, '0');     // Ensure 2 digits

    // Format as YYYY-MM-DD
    return '$year-$month-$day';
  }
}