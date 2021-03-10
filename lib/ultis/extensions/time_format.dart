extension formatHHSS on int{
  String formatMMSS() {
    int seconds = this;
    seconds = (seconds % 3600).truncate();
    final int minutes = (seconds / 60).truncate();

    final String minutesStr = (minutes).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}