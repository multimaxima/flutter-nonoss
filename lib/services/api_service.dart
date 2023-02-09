import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/jenis_nakes.dart';
import '../models/smart.dart';
import 'api_response.dart';
import 'api_container.dart';

import '../models/user.dart';
import '../models/propinsi.dart';
import '../models/kota.dart';
import '../models/kecamatan.dart';
import '../models/desa.dart';

final baseUrl = ApiContainer.baseUrl;
final baseSmart = ApiContainer.smartUrl;
late SharedPreferences prefs;

class SmartService {
  Future<APIResponse<List<SmartModels>>> getSmartList(String uId) {
    loadingData();
    return http.get(Uri.parse("$baseSmart/App2/getUser?uid=$uId")).then((data) {
      if (data.statusCode == 200) {
        hapusLoader();
        final jsonData = json.decode(data.body);
        final user = <SmartModels>[];
        for (var item in jsonData) {
          user.add(SmartModels.fromJson(item));
        }
        return APIResponse<List<SmartModels>>(data: user);
      } else {
        hapusLoader();
      }
      return APIResponse<List<SmartModels>>(error: true, errorMessage: "Tidak dapat mengambil data");
    }).catchError((_) => APIResponse<List<SmartModels>>(error: true, errorMessage: "Tidak dapat mengambil data"));
  }
}

class UserService {
  Future<APIResponse<UserModels>> getUser() async {
    //final prefs = await SharedPreferences.getInstance();
    //var userId = prefs.getString('uid') ?? '';
    var userId = "st1nbBRptAZYYde2IK0t1q173sm2";

    return await http.get(Uri.parse("$baseUrl/api/get-user?uid=$userId")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<UserModels>(data: UserModels.fromJson(jsonData));
      }
      return APIResponse<UserModels>(error: true, errorMessage: "Tidak dapat mengambil data");
    }).catchError((_) => APIResponse<UserModels>(error: true, errorMessage: "Tidak dapat mengambil data"));
  }
}

class PropinsiService {
  Future<APIResponse<List<PropinsiModels>>> getPropinsiList() {
    return http.get(Uri.parse("$baseUrl/api/propinsi")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final propinsi = <PropinsiModels>[];
        for (var item in jsonData) {
          propinsi.add(PropinsiModels.fromJson(item));
        }
        return APIResponse<List<PropinsiModels>>(data: propinsi);
      }
      return APIResponse<List<PropinsiModels>>(error: true, errorMessage: "Tidak dapat mengambil data");
    }).catchError((_) => APIResponse<List<PropinsiModels>>(error: true, errorMessage: "Tidak dapat mengambil data"));
  }
}

class KotaService {
  Future<APIResponse<List<KotaModels>>> getKotaList(String noprop) {
    return http.get(Uri.parse("$baseUrl/api/kota?no_prop=$noprop")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final kota = <KotaModels>[];
        for (var item in jsonData) {
          kota.add(KotaModels.fromJson(item));
        }
        return APIResponse<List<KotaModels>>(data: kota);
      }
      return APIResponse<List<KotaModels>>(error: true, errorMessage: "Tidak dapat mengambil data");
    }).catchError((_) => APIResponse<List<KotaModels>>(error: true, errorMessage: "Tidak dapat mengambil data"));
  }
}

class KecamatanService {
  Future<APIResponse<List<KecamatanModels>>> getKecamatanList(String noprop, String nokab) {
    return http.get(Uri.parse("$baseUrl/api/kecamatan?no_prop=$noprop&no_kab=$nokab")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final kecamatan = <KecamatanModels>[];
        for (var item in jsonData) {
          kecamatan.add(KecamatanModels.fromJson(item));
        }
        return APIResponse<List<KecamatanModels>>(data: kecamatan);
      }
      return APIResponse<List<KecamatanModels>>(error: true, errorMessage: "Tidak dapat mengambil data");
    }).catchError((_) => APIResponse<List<KecamatanModels>>(error: true, errorMessage: "Tidak dapat mengambil data"));
  }
}

class DesaService {
  Future<APIResponse<List<DesaModels>>> getDesaList(String noprop, String nokab, String nokec) {
    return http.get(Uri.parse("$baseUrl/api/desa?no_prop=$noprop&no_kab=$nokab&no_kec=$nokec")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final desa = <DesaModels>[];
        for (var item in jsonData) {
          desa.add(DesaModels.fromJson(item));
        }
        return APIResponse<List<DesaModels>>(data: desa);
      }
      return APIResponse<List<DesaModels>>(error: true, errorMessage: "Tidak dapat mengambil data");
    }).catchError((_) => APIResponse<List<DesaModels>>(error: true, errorMessage: "Tidak dapat mengambil data"));
  }
}

class JenisNakes {
  Future<APIResponse<List<JenisNakesModels>>> getNakesList() {
    return http.get(Uri.parse("$baseUrl/api/jenis-nakes")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final nakes = <JenisNakesModels>[];
        for (var item in jsonData) {
          nakes.add(JenisNakesModels.fromJson(item));
        }
        return APIResponse<List<JenisNakesModels>>(data: nakes);
      }
      return APIResponse<List<JenisNakesModels>>(error: true, errorMessage: "Tidak dapat mengambil data");
    }).catchError((_) => APIResponse<List<JenisNakesModels>>(error: true, errorMessage: "Tidak dapat mengambil data"));
  }
}

class Upload {
  Future<bool> addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = '<domain-name>/api/imageadd';
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));

    var response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
