class DateUtilsFunctions{
 static String  addHoursAndFormat(String dateString) {
    // Parse the date string
    DateTime originalDate = DateTime.parse(dateString);

    // Add 3 hours
    DateTime newDate = originalDate.add(const Duration(hours: 3));

    // Format the new date
    String formattedDate = "${newDate.day.toString().padLeft(2, '0')}:"
        "${newDate.month.toString().padLeft(2, '0')}:"
        "${newDate.year} ${newDate.hour.toString().padLeft(2, '0')}:"
        "${newDate.minute.toString().padLeft(2, '0')}";

    return formattedDate;
  }
}