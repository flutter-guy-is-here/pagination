import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class formatters {
  static String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "";
    // Convert Firestore Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime to a readable string
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

    return formattedDate;
  }
}
