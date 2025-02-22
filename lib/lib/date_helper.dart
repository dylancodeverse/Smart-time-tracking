class Date {

  static int getTimestampNow(){
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;

  }

}