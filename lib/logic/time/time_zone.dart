// Vaqtni kamaytirish va formatlash logikasi
int decreaseTime(int currentTime) {
  if (currentTime > 0) {
    return currentTime - 1; // Har daqiqada 1 soniya kamaytirish
  }
  return 0;
}

String formatTime(int totalSeconds) {
  int minutes = totalSeconds ~/ 60;
  int seconds = totalSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}
