import 'package:intl/intl.dart';

String formatJoinedDate(String isoDate) {
  try {
    final date = DateTime.parse(isoDate);
    return DateFormat("dd MMMM yyyy", "id_ID").format(date);
  } catch (e) {
    return isoDate; // fallback jika gagal parsing
  }
}
