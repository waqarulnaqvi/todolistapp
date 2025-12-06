/// Returns the current date and time in the format:
/// `YYYY/MM/DD | HH:MM AM/PM`
///
/// Example output:
/// `2025/12/03 | 08:45 PM`
///
/// This method:
/// - Gets the current system DateTime
/// - Converts it to `YYYY/MM/DD` format
/// - Converts 24-hour time to 12-hour format
/// - Appends `AM` or `PM`
/// - Returns a fully formatted datetime string
String formatDateTimeNow({bool isDueDate=false,DateTime? customDateTime}) {
  // If it's due date → add 10 minutes
  DateTime date = isDueDate
      ? DateTime.now().add(const Duration(minutes: 10))
      : DateTime.now();

  // DateTime format
  final List dateTime = (customDateTime ?? date).toString().split(".")[0].split(" ");
  dateTime[0] = dateTime[0].replaceAll("-", "/");
  var twelveHoursSystem = int.parse(dateTime[1].substring(0, 2));

  if (twelveHoursSystem == 12) {
    dateTime[1] = "${dateTime[1]} PM";
  } else if (twelveHoursSystem > 12) {
    twelveHoursSystem = twelveHoursSystem - 12;
    dateTime[1] =
    "$twelveHoursSystem${dateTime[1].substring(2, dateTime[1].length)} PM";
  } else {
    dateTime[1] = "${dateTime[1]} AM";
  }

  return "${dateTime[0]} | ${dateTime[1]}";
}


/// Converts a formatted string like:
///   "2025/12/06 | 03:45 PM"
/// back into a DateTime object.
///
/// This is the reverse of your `formatDateTimeNow` function.
/// Steps performed:
/// 1. Split the string into date + time parts.
/// 2. Convert date "yyyy/MM/dd" → "yyyy-MM-dd".
/// 3. Convert 12-hour time with AM/PM → 24-hour time.
/// 4. Construct a valid DateTime object using DateTime.parse().
DateTime parseFormattedDateTime(String formatted) {
  // Split formatted string into date and time
  final parts = formatted.split(" | ");
  final datePart = parts[0]; // Example: 2025/12/06
  final timePart = parts[1]; // Example: 03:45 PM

  // Convert date formatting to yyyy-MM-dd (required for DateTime.parse)
  final date = datePart.replaceAll("/", "-");

  // Check if time is AM or PM
  final isPM = timePart.contains("PM");

  // Remove AM/PM text so only HH:mm remains
  final timeClean = timePart.replaceAll(" AM", "").replaceAll(" PM", "");
  final timeSplit = timeClean.split(":");

  int hour = int.parse(timeSplit[0]);
  int minute = int.parse(timeSplit[1]);

  // Convert 12-hour → 24-hour format
  if (isPM && hour != 12) {
    hour += 12;
  } else if (!isPM && hour == 12) {
    hour = 0; // midnight case
  }

  // Build valid DateTime string
  final dateTimeString =
      "$date ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00";

  // Convert to DateTime object
  return DateTime.parse(dateTimeString);
}
