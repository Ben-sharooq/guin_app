class ConstantText {
  static int adminRoleId = 1;
  static int navaltRoleId = 2;
  static int clientRoleId = 3;
  static String openWeatherApiToken = "fb44150289e06f7e5d47c0b8c7515e20";
  static String? token;

  //battery box names
  static String batteryBox1 = "Port";
  static String batteryBox2 = "StarBoad";

  static const String baseUrl = "http://103.119.241.252:5200";
  
  // static const String baseUrl = "http://192.168.54.180:5200";
}

Map<String, String> getHeaders(String? token) {
  return {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Authorization": "Bearer ${ConstantText.token}"
  };
}
