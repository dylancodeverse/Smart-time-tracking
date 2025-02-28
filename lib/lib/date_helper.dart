class Date {

  static int getTimestampNow(){
    return DateTime.now().millisecondsSinceEpoch ;
  }

  static String formatTimeFromMillis(int timestampMillis) {
      // Convertir le timestamp en DateTime
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMillis);

      // Extraire les heures, minutes et secondes
      String hours = dateTime.hour.toString().padLeft(2, '0');
      String minutes = dateTime.minute.toString().padLeft(2, '0');
      String seconds = dateTime.second.toString().padLeft(2, '0');

      return "$hours:$minutes:$seconds";
  }
  static DateTime convertStringToDateTime(String timeString) {
    DateTime now = DateTime.now(); // Date actuelle
    List<String> parts = timeString.split(':'); // Séparer hh, mm, ss
    
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    return DateTime(now.year, now.month, now.day, hours, minutes, seconds);
  }



}