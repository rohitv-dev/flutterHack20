import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

getDateAndTime(Timestamp timeObj, {String selector = 'dateTime'}) {
  if (selector == 'time') {
    DateTime curTime = timeObj.toDate().toUtc().add(Duration(hours: 5, minutes: 30));
    int hour = curTime.hour;
    int minute = curTime.minute;
    int second = curTime.second;

    if (hour < 13) {
      if (minute == 0) {
        return '$hour:$minute$second AM';
      } else {
        return '$hour:$minute AM';
      }
    }
    else if (hour > 12) {
      hour = hour - 12;
      if (minute == 0) {
        return '$hour:$minute$second PM';
      } else {
        return '$hour:$minute PM';
      }
    }
    else if (hour == 0) {
      hour = 12;
      if (minute == 0) {
        return '$hour:$minute$second AM';
      } else {
        return '$hour:$minute AM';
      }
    }
  } else if (selector == 'date') {
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(timeObj.toDate());
  } else if (selector == 'dateTime') {
    var formatter = DateFormat('dd-MM-yyyy');
    return '${formatter.format(timeObj.toDate())} ${getDateAndTime(timeObj, selector: 'time')}';
  }
}
