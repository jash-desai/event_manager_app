String timeMode(time) {
  if (time == null) {
    return "";
  }
  if (time.periodOffset == 0) {
    return " am";
  } else {
    return " pm";
  }
}

String minutes(time) {
  if (time == null) {
    return "";
  }
  if (time.minute < 10) {
    return "0${time.minute}";
  } else {
    return '${time.minute}';
  }
}

String hours(time) {
  if (time == null) {
    return "";
  }
  if (time.hour - time.periodOffset == 0) {
    return '12';
  }

  return "${time.hour - time.periodOffset}";
}
