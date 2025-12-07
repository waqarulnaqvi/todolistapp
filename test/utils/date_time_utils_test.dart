import 'package:flutter_test/flutter_test.dart';
import 'package:todolistapp/core/utils/date_time_utils.dart';

void main() {
  group("formatDateTimeNow Tests", () {

    test("formats PM time correctly", () {
      final custom = DateTime(2025, 12, 03, 20, 45); // 8:45 PM

      final result = formatDateTimeNow(customDateTime: custom);

      expect(result, "2025/12/03 | 8:45:00 PM");
    });

    test("formats AM time correctly", () {
      final custom = DateTime(2025, 12, 03, 8, 10); // 8:10 AM

      final result = formatDateTimeNow(customDateTime: custom);

      expect(result, "2025/12/03 | 08:10:00 AM");
    });

    test("handles 12 PM (noon)", () {
      final custom = DateTime(2025, 12, 03, 12, 30);

      final result = formatDateTimeNow(customDateTime: custom);

      expect(result, "2025/12/03 | 12:30:00 PM");
    });

    test("handles 12 AM (midnight)", () {
      final custom = DateTime(2025, 12, 03, 0, 20);

      final result = formatDateTimeNow(customDateTime: custom);

      expect(result, "2025/12/03 | 00:20:00 AM");
    });

    test("adds 2 minutes when isDueDate = true", () {
      final custom = DateTime(2025, 12, 03, 9, 58);

      final result = formatDateTimeNow(
        isDueDate: true,
        customDateTime: custom,
      );

      // custom time + 2 minutes → 10:00
      expect(result, "2025/12/03 | 09:58:00 AM");
    });
  });
}
