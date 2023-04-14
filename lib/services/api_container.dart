//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

String? idUser;

class ApiContainer {
  static String baseKey =
      'be6j3ojtLzgAlC7LnDMg1X2ZgtvWzxm2X6iGs99Uzww0rCYtz1HrfBbNVWictUy3GZkgowmWnfcmu3oVR6obqayffcnIoee06HoC';

  //static String baseUrl = 'https://nonoss.multimaxima.com';
  //static String baseUrl = 'https://nonoss.banyuwangikab.go.id';
  static String baseUrl = 'https://nonossdev.banyuwangikab.go.id';

  //static String smartUrl = "https://smartkampung.id";
  static String smartUrl = "https://smartdev.banyuwangikab.go.id";
}

Future getUserId() async {
  // final prefs = await SharedPreferences.getInstance();
  // String userId = prefs.getString('uid') ?? '';
  String userId = "9XYZFEU5esZvSvCNHdUw985WJ4t2";
  //String userId = "lNL9gWbs2Eg2oHdmdm78AWrxMQw2";
  return userId;
}

Future getUserDetil() async {
  // final prefs = await SharedPreferences.getInstance();
  // String userId = prefs.getString('uid') ?? '';
  String userId = "9XYZFEU5esZvSvCNHdUw985WJ4t2";
  //String userId = "lNL9gWbs2Eg2oHdmdm78AWrxMQw2";

  var result = await http.get(Uri.parse(
      "${ApiContainer.baseUrl}/api/get-user?uid=$userId&key=${ApiContainer.baseKey}"));
  return result;
}

Future getUserNakes() async {
  // final prefs = await SharedPreferences.getInstance();
  // String userId = prefs.getString('uid') ?? '';
  String userId = "9XYZFEU5esZvSvCNHdUw985WJ4t2";
  //String userId = "lNL9gWbs2Eg2oHdmdm78AWrxMQw2";

  var result = await http.get(Uri.parse(
      "${ApiContainer.baseUrl}/api/get-user-nakes?uid=$userId&key=${ApiContainer.baseKey}"));
  return result;
}

Future loadingData() {
  return EasyLoading.show(
    status: 'Mohon tunggu...',
    maskType: EasyLoadingMaskType.black,
  );
}

Future hapusLoader() {
  return EasyLoading.dismiss();
}

Future pesanData(String pesan) {
  return EasyLoading.showToast(pesan);
}

Future errorPesan(String pesan) {
  return EasyLoading.showError(pesan);
}

Future errorData() {
  return EasyLoading.showError(
      "Gagal mendapatkan data, silahkan ulangi kembali.");
}
