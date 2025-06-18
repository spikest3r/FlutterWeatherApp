import 'package:weather/data.dart';

String determineIcon(int code, bool isNight) {
  String fileName = "24a"; // default sun icon
  switch(code) {
    case 0:
      if (isNight) { fileName = "24b"; break; }
      fileName = "24a"; break;
    case 1:
      if(isNight) { fileName = "22b"; break; }
      fileName = "22a"; break;
    case 2:
      if(isNight) { fileName = "21b"; break; }
      fileName = "21a"; break;
    case 3:
      fileName = "20"; break;
    case 45:
    case 48:
      fileName = "16"; break;
    case 51:
    case 53:
    case 55:
      fileName = "15"; break;
    case 56:
    case 57:
    case 66:
    case 67:
      fileName = "13"; break;
    case 61: // slight rain
    case 63:
    case 65:
      fileName = "14"; break;
    case 71:
      fileName = "7"; break;
    case 73:
    case 75:
    case 77:
      fileName = "6"; break;
    case 80:
      fileName = "10"; break;
    case 81:
    case 82:
      fileName = "12"; break;
    case 85:
    case 86:
      fileName = "5"; break;
    case 95:
      fileName = "2"; break;
    case 96:
    case 99:
      fileName = "3"; break; // thunderstorms with hail but here graphics with only hail
  }
  return "assets/$fileName.png";
}

String getUnit() {
  return LocationStorage.fahrenheit ? "F" : "C";
}