import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_container.dart';
import '../models/fasyankes_kategori.dart';
import '../models/fasyankes.dart';
import '../models/propinsi.dart';
import '../models/kota.dart';
import '../models/kecamatan.dart';
import '../models/desa.dart';
import '../models/negara.dart';
import '../models/fasyankes_str.dart';
import 'map_kordinat.dart';

class NakesRevisi extends StatefulWidget {
  final int id;

  const NakesRevisi(this.id, {super.key});

  @override
  State<NakesRevisi> createState() => _NakesRevisiState();
}

class _NakesRevisiState extends State<NakesRevisi> {
  final baseUrl = ApiContainer.baseUrl;

  final TextEditingController _uidPemohon = TextEditingController();
  final TextEditingController _namaPemohon = TextEditingController();
  final TextEditingController _gelarDepan = TextEditingController();
  final TextEditingController _gelarBelakang = TextEditingController();
  final TextEditingController _alamatPemohon = TextEditingController();
  final TextEditingController _dusunPemohon = TextEditingController();
  final TextEditingController _rtPemohon = TextEditingController();
  final TextEditingController _rwPemohon = TextEditingController();
  final TextEditingController _nopropPemohon = TextEditingController();
  final TextEditingController _nokabPemohon = TextEditingController();
  final TextEditingController _nokecPemohon = TextEditingController();
  final TextEditingController _nokelPemohon = TextEditingController();
  final TextEditingController _propinsiPemohon = TextEditingController();
  final TextEditingController _kotaPemohon = TextEditingController();
  final TextEditingController _kecamatanPemohon = TextEditingController();
  final TextEditingController _desaPemohon = TextEditingController();
  final TextEditingController _kodeposPemohon = TextEditingController();
  final TextEditingController _latPemohon = TextEditingController();
  final TextEditingController _lngPemohon = TextEditingController();
  final TextEditingController _tempLahirPemohon = TextEditingController();
  final TextEditingController _tglLahirPemohon = TextEditingController();
  final TextEditingController _tglLahirPemohon1 = TextEditingController();
  final TextEditingController _kelaminPemohon = TextEditingController();
  final TextEditingController _jenisKelaminPemohon = TextEditingController();
  final TextEditingController _pekerjaanPemohon = TextEditingController();
  final TextEditingController _wniPemohon = TextEditingController();
  final TextEditingController _negaraPemohon = TextEditingController();
  final TextEditingController _jenisWniPemohon = TextEditingController();
  final TextEditingController _hpPemohon = TextEditingController();
  final TextEditingController _waPemohon = TextEditingController();
  final TextEditingController _emailPemohon = TextEditingController();
  final TextEditingController _nikPemohon = TextEditingController();
  final TextEditingController _fotoPemohon = TextEditingController();
  final TextEditingController _ktpPemohon = TextEditingController();
  final TextEditingController _pendidikanTerakhir = TextEditingController();
  final TextEditingController _lembagaPendidikan = TextEditingController();
  final TextEditingController _noIjasah = TextEditingController();
  final TextEditingController _tglIjasah = TextEditingController();
  final TextEditingController _tglIjasah1 = TextEditingController();
  final TextEditingController _dokIjasah = TextEditingController();
  final TextEditingController _sertKompetensi = TextEditingController();
  final TextEditingController _tglSertKompetensi = TextEditingController();
  final TextEditingController _tglSertKompetensi1 = TextEditingController();
  final TextEditingController _dokSertKompetensi = TextEditingController();
  final TextEditingController _strNo = TextEditingController();
  final TextEditingController _strBerlaku = TextEditingController();
  final TextEditingController _strBerlaku1 = TextEditingController();
  final TextEditingController _strTanggal = TextEditingController();
  final TextEditingController _strTanggal1 = TextEditingController();
  final TextEditingController _strAsal = TextEditingController();
  final TextEditingController _dokStr = TextEditingController();
  final TextEditingController _rekomOp = TextEditingController();
  final TextEditingController _tglRekomOp = TextEditingController();
  final TextEditingController _tglRekomOp1 = TextEditingController();
  final TextEditingController _dokRekomOp = TextEditingController();

  final TextEditingController _nokecPraktek = TextEditingController();
  final TextEditingController _kecamatanPraktek = TextEditingController();
  final TextEditingController _nokelPraktek = TextEditingController();
  final TextEditingController _kelurahanPraktek = TextEditingController();
  final TextEditingController _kodeposPraktek = TextEditingController();
  final TextEditingController _imbNomor = TextEditingController();
  final TextEditingController _perpanjangan = TextEditingController();
  final TextEditingController _lamaNomor = TextEditingController();
  final TextEditingController _lamaTanggal = TextEditingController();
  final TextEditingController _lamaTanggal1 = TextEditingController();
  final TextEditingController _lamaBerlaku = TextEditingController();
  final TextEditingController _lamaBerlaku1 = TextEditingController();
  final TextEditingController _lamaAn = TextEditingController();
  final TextEditingController _catatan = TextEditingController();
  final TextEditingController _nomorRekomDinkes = TextEditingController();
  final TextEditingController _tglRekomDinkes = TextEditingController();
  final TextEditingController _tglRekomDinkes1 = TextEditingController();
  final TextEditingController _idIzinNakes = TextEditingController();
  final TextEditingController _tempatPraktek = TextEditingController();
  final TextEditingController _idFasyankes = TextEditingController();
  final TextEditingController _namaFasyankes = TextEditingController();
  final TextEditingController _latFasyankes = TextEditingController();
  final TextEditingController _lngFasyankes = TextEditingController();
  final TextEditingController _alamatPraktek = TextEditingController();
  final TextEditingController _dusunPraktek = TextEditingController();
  final TextEditingController _rtPraktek = TextEditingController();
  final TextEditingController _rwPraktek = TextEditingController();
  final TextEditingController _latPraktek = TextEditingController();
  final TextEditingController _lngPraktek = TextEditingController();
  final TextEditingController _idKategoriFasyankes = TextEditingController();
  final TextEditingController _kategoriFasyankes = TextEditingController();

  final TextEditingController _dokKetSehat = TextEditingController();
  final TextEditingController _dokSuperPatuh = TextEditingController();
  final TextEditingController _dokSuperPraktik = TextEditingController();
  final TextEditingController _dokSuperAtasan = TextEditingController();
  final TextEditingController _dokSuketPraktik = TextEditingController();
  final TextEditingController _dokSuketIntern = TextEditingController();
  final TextEditingController _dokSuketFasyankes = TextEditingController();
  final TextEditingController _dokRekomDinkes = TextEditingController();
  final TextEditingController _dokSppl = TextEditingController();
  final TextEditingController _dokSipLama = TextEditingController();
  final TextEditingController _dokImb = TextEditingController();
  final TextEditingController _dokPernyataanImb = TextEditingController();
  final TextEditingController _dokIzinSebelum = TextEditingController();

  int currentStep = 0;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _permohonanKey = GlobalKey<FormState>();
  final _dokumenKey = GlobalKey<FormState>();

  File? fotoPemohon;
  File? ktpPemohon;
  List<XFile>? scanIjasah;
  List<XFile>? scanSertifikat;
  List<XFile>? scanStr;
  List<XFile>? scanRekomOp;
  List<XFile>? scanKetSehat;
  List<XFile>? scanSuperPatuh;
  List<XFile>? scanSuperPraktik;
  List<XFile>? scanSuketPraktik;
  List<XFile>? scanSuperAtasan;
  List<XFile>? scanSuketIntern;
  List<XFile>? scanSuketFasyankes;
  List<XFile>? scanRekomDinkes;
  List<XFile>? scanSppl;
  List<XFile>? scanSipLama;
  List<XFile>? scanImb;
  List<XFile>? scanPernyataanImb;
  List<XFile>? scanKkpr;
  List<XFile>? scanSlf;
  List<XFile>? scanIzinSebelum;

  Future getFoto(ImageSource source) async {
    loadingData();
    try {
      final fotoPemohon = await _picker.pickImage(
        source: source,
      );
      if (fotoPemohon == null) {
        hapusLoader();
        return;
      }

      final fotoPicked = File(fotoPemohon.path);
      hapusLoader();

      setState(() {
        _fotoPemohon.text = fotoPicked.toString();
        this.fotoPemohon = fotoPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil gambar :$e");
    }
  }

  Future getKtp(ImageSource source) async {
    loadingData();
    try {
      final ktpPemohon = await _picker.pickImage(
        source: source,
      );
      if (ktpPemohon == null) {
        hapusLoader();
        return;
      }

      final ktpPicked = File(ktpPemohon.path);
      hapusLoader();
      setState(() {
        _ktpPemohon.text = ktpPicked.toString();
        this.ktpPemohon = ktpPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil gambar :$e");
    }
  }

  Future getIjasah() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanIjasah = pickedfiles;
        hapusLoader();

        setState(() {
          _dokIjasah.text = scanIjasah.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSertifikat() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSertifikat = pickedfiles;
        hapusLoader();

        setState(() {
          _dokSertKompetensi.text = scanSertifikat.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getStr() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanStr = pickedfiles;
        hapusLoader();
        setState(() {
          _dokStr.text = scanStr.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getRekomOp() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanRekomOp = pickedfiles;
        hapusLoader();
        setState(() {
          _dokRekomOp.text = scanRekomOp.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getKetSehat() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanKetSehat = pickedfiles;
        hapusLoader();
        setState(() {
          _dokKetSehat.text = scanKetSehat.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSuperPatuh() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSuperPatuh = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSuperPatuh.text = scanSuperPatuh.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSuperPraktik() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSuperPraktik = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSuperPraktik.text = scanSuperPraktik.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSuketPraktik() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSuketPraktik = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSuketPraktik.text = scanSuketPraktik.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSuperAtasan() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSuperAtasan = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSuperAtasan.text = scanSuperAtasan.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSuketIntern() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSuketIntern = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSuketIntern.text = scanSuketIntern.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSuketFasyankes() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSuketFasyankes = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSuketFasyankes.text = scanSuketFasyankes.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getRekomDinkes() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanRekomDinkes = pickedfiles;
        hapusLoader();
        setState(() {
          _dokRekomDinkes.text = scanRekomDinkes.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSppl() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSppl = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSppl.text = scanSppl.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSipLama() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSipLama = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSipLama.text = scanSipLama.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getImb() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanImb = pickedfiles;
        hapusLoader();
        setState(() {
          _dokImb.text = scanImb.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getPernyataanImb() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanPernyataanImb = pickedfiles;
        hapusLoader();
        setState(() {
          _dokPernyataanImb.text = scanPernyataanImb.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getIzinSebelum() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanIzinSebelum = pickedfiles;
        hapusLoader();
        setState(() {
          _dokIzinSebelum.text = scanIzinSebelum.toString();
        });
      } else {
        hapusLoader();
        errorPesan("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  String? nakesIzin;
  String? nakesKode;
  int? idFasyankes;
  int? idMandiri;
  int? idDistribusi;
  int? idProduksi;
  String? praktek;
  int? mandiri;

  String? kecamatan;
  String? idKel;
  String? desa;
  String? strOleh;

  String jenisIzin = "";
  String kodeIzin = "";
  String tempatPraktik = "";

  String? perpanjangan;

  bool isPerpanjangan = true;
  bool isIdNakes = true;
  bool isKategoriNakes = true;
  bool isKategoriFasyankes = true;
  bool isIdFasyankes = true;
  bool isPermohonan = true;
  bool isTerbatas = true;

  bool isPemohonKirim = true;
  bool isPermohonanKirim = true;

  String? errorMessage;

  int? varPendTerakhir;
  int? varNoSertifikat;
  int? varNoStr;
  int? varNoRekomOp;
  int? varKetSehat;
  int? varSpMematuhi;
  int? varSpTempPraktek;
  int? varSkFasyankes;
  int? varSpAtasan;
  int? varSkKomiteInterensif;
  int? varRekomDinkes;
  int? varSuratIzinSebelum;
  int? varSebelum;
  int? varCekFasyankes;

  Map<String, dynamic> user = {};
  Map<String, dynamic> permohonan = {};
  Map<String, dynamic> nakes = {};
  Map<String, dynamic> izin = {};
  Map<String, dynamic> fasyankes = {};

  Future getPermohonan() async {
    loadingData();

    var result = await http.get(Uri.parse(
        "$baseUrl/api/nakes-revisi?id=${widget.id}&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();

      setState(() {
        user = json.decode(result.body)["user"];
        permohonan = json.decode(result.body)["permohonan"];
        nakes = json.decode(result.body)["nakes"];
        izin = json.decode(result.body)["izin"];

        jenisIzin =
            izin["izin"].toString() != "null" ? izin["izin"].toString() : "";
        kodeIzin =
            izin["kode"].toString() != "null" ? izin["kode"].toString() : "";

        _uidPemohon.text =
            user["uid"].toString() != "null" ? user["uid"].toString() : "";

        _namaPemohon.text =
            user["nama"].toString() != "null" ? user["nama"].toString() : "";
        _gelarDepan.text = user["gelar_depan"].toString() != "null"
            ? user["gelar_depan"].toString()
            : "";
        _gelarBelakang.text = user["gelar_belakang"].toString() != "null"
            ? user["gelar_belakang"].toString()
            : "";
        _alamatPemohon.text = user["alamat"].toString() != "null"
            ? user["alamat"].toString()
            : "";
        _dusunPemohon.text =
            user["dusun"].toString() != "null" ? user["dusun"].toString() : "";
        _rtPemohon.text =
            user["rt"].toString() != "null" ? user["rt"].toString() : "";
        _rwPemohon.text =
            user["rw"].toString() != "null" ? user["rw"].toString() : "";
        _nopropPemohon.text = user["no_prop"].toString() != "null"
            ? user["no_prop"].toString()
            : "";
        _nokabPemohon.text = user["no_kab"].toString() != "null"
            ? user["no_kab"].toString()
            : "";
        _nokecPemohon.text = user["no_kec"].toString() != "null"
            ? user["no_kec"].toString()
            : "";
        _nokelPemohon.text = user["no_kel"].toString() != "null"
            ? user["no_kel"].toString()
            : "";
        _propinsiPemohon.text = user["propinsi"].toString() != "null"
            ? user["propinsi"].toString()
            : "";
        _kotaPemohon.text =
            user["kota"].toString() != "null" ? user["kota"].toString() : "";
        _kecamatanPemohon.text = user["kecamatan"].toString() != "null"
            ? user["kecamatan"].toString()
            : "";
        _desaPemohon.text = user["kelurahan"].toString() != "null"
            ? user["kelurahan"].toString()
            : "";
        _kodeposPemohon.text = user["kodepos"].toString() != "null"
            ? user["kodepos"].toString()
            : "";
        _latPemohon.text =
            user["lat"].toString() != "null" ? user["lat"].toString() : "";
        _lngPemohon.text =
            user["lng"].toString() != "null" ? user["lng"].toString() : "";
        _tempLahirPemohon.text = user["temp_lahir"].toString() != "null"
            ? user["temp_lahir"].toString()
            : "";
        _tglLahirPemohon.text = user["tgl_lahir"].toString() != "null"
            ? user["tgl_lahir"].toString()
            : "";
        _tglLahirPemohon1.text = _tglLahirPemohon.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglLahirPemohon.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());

        _kelaminPemohon.text = user["kelamin"].toString() != "null"
            ? user["kelamin"].toString()
            : "";
        _jenisKelaminPemohon.text = user["kelamin"].toString() == "1"
            ? 'LAKI-LAKI'
            : user["kelamin"].toString() == "2"
                ? 'PEREMPUAN'
                : '';
        _pekerjaanPemohon.text = user["pekerjaan"].toString() != "null"
            ? user["pekerjaan"].toString()
            : "";
        _wniPemohon.text = user["warganegara"].toString() != "null"
            ? user["warganegara"].toString()
            : "";
        _negaraPemohon.text = user["negara"].toString() != "null"
            ? user["negara"].toString()
            : "";
        _jenisWniPemohon.text = user["warganegara"] == 1
            ? 'INDONESIA'
            : user["warganegara"] == 2
                ? 'ASING'
                : '';
        _hpPemohon.text =
            user["hp"].toString() != "null" ? user["hp"].toString() : "";
        _waPemohon.text = user["whatsapp"].toString() != "null"
            ? user["whatsapp"].toString()
            : "";
        _emailPemohon.text =
            user["email"].toString() != "null" ? user["email"].toString() : "";
        _nikPemohon.text =
            user["nik"].toString() != "null" ? user["nik"].toString() : "";
        _fotoPemohon.text =
            user["foto"].toString() != "null" ? user["foto"].toString() : "";
        _ktpPemohon.text = user["dok_ktp"].toString() != "null"
            ? user["dok_ktp"].toString()
            : "";
        _pendidikanTerakhir.text =
            user["pendidikan_terakhir"].toString() != "null"
                ? user["pendidikan_terakhir"].toString()
                : "";
        _lembagaPendidikan.text =
            user["lembaga_pendidikan"].toString() != "null"
                ? user["lembaga_pendidikan"].toString()
                : "";
        _noIjasah.text = user["no_ijasah"].toString() != "null"
            ? user["no_ijasah"].toString()
            : "";
        _tglIjasah.text = user["tgl_ijasah"].toString() != "null"
            ? user["tgl_ijasah"].toString()
            : "";

        _tglIjasah1.text = _tglIjasah.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglIjasah.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());

        _dokIjasah.text = user["dok_ijasah"].toString() != "null"
            ? user["dok_ijasah"].toString()
            : "";
        _sertKompetensi.text = user["sert_kompetensi"].toString() != "null"
            ? user["sert_kompetensi"].toString()
            : "";
        _tglSertKompetensi.text =
            user["tgl_sert_kompetensi"].toString() != "null"
                ? user["tgl_sert_kompetensi"].toString()
                : "";
        _tglSertKompetensi1.text = _tglSertKompetensi.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglSertKompetensi.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());
        _dokSertKompetensi.text =
            user["dok_sert_kompetensi"].toString() != "null"
                ? user["dok_sert_kompetensi"].toString()
                : "";
        _strNo.text = user["str_no"].toString() != "null"
            ? user["str_no"].toString()
            : "";
        _strBerlaku.text = user["str_berlaku"].toString() != "null"
            ? user["str_berlaku"].toString()
            : "";
        _strBerlaku1.text = _strBerlaku.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_strBerlaku.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());

        _strTanggal.text = user["str_tanggal"].toString() != "null"
            ? user["str_tanggal"].toString()
            : "";
        _strTanggal1.text = _strTanggal.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_strTanggal.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());
        _strAsal.text = user["str_asal"].toString() != "null"
            ? user["str_asal"].toString()
            : "";
        _dokStr.text = user["dok_str"].toString() != "null"
            ? user["dok_str"].toString()
            : "";
        _rekomOp.text = user["rekom_op"].toString() != "null"
            ? user["rekom_op"].toString()
            : "";
        _tglRekomOp.text = user["tgl_rekom_op"].toString() != "null"
            ? user["tgl_rekom_op"].toString()
            : "";
        _tglRekomOp1.text = _tglRekomOp.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglRekomOp.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());
        _dokRekomOp.text = user["dok_rekom_op"].toString() != "null"
            ? user["dok_rekom_op"].toString()
            : "";

        _nokecPraktek.text = nakes["NO_KEC"].toString() != "null"
            ? nakes["NO_KEC"].toString()
            : "";
        _kecamatanPraktek.text = nakes["kecamatan"].toString() != "null"
            ? nakes["kecamatan"].toString()
            : "";
        _nokelPraktek.text = nakes["NO_KEL"].toString() != "null"
            ? nakes["NO_KEL"].toString()
            : "";
        _kelurahanPraktek.text =
            nakes["desa"].toString() != "null" ? nakes["desa"].toString() : "";
        _kodeposPraktek.text = nakes["kodepos"].toString() != "null"
            ? nakes["kodepos"].toString()
            : "";
        _imbNomor.text = nakes["imb_no"].toString() != "null"
            ? nakes["imb_no"].toString()
            : "";
        _perpanjangan.text = nakes["perpanjangan"].toString() != "null"
            ? nakes["perpanjangan"].toString()
            : "";
        _lamaNomor.text = nakes["lama_nomor"].toString() != "null"
            ? nakes["lama_nomor"].toString()
            : "";
        _lamaTanggal.text = nakes["lama_tanggal"].toString() != "null"
            ? nakes["lama_tanggal"].toString()
            : "";
        _lamaTanggal1.text = _lamaTanggal.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_lamaTanggal.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());
        _lamaBerlaku.text = nakes["lama_berlaku"].toString() != "null"
            ? nakes["lama_berlaku"].toString()
            : "";
        _lamaBerlaku1.text = _lamaBerlaku.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_lamaBerlaku.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());
        _lamaAn.text = nakes["lama_an"].toString() != "null"
            ? nakes["lama_an"].toString()
            : "";
        _catatan.text = permohonan["keterangan"].toString() != "null"
            ? permohonan["keterangan"].toString()
            : "";
        _nomorRekomDinkes.text = nakes["rekom_dinkes_no"].toString() != "null"
            ? nakes["rekom_dinkes_no"].toString()
            : "";
        _tglRekomDinkes.text = nakes["rekom_dinkes_tgl"].toString() != "null"
            ? nakes["rekom_dinkes_tgl"].toString()
            : "";
        _tglRekomDinkes1.text = _tglRekomDinkes.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglRekomDinkes.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());

        _idIzinNakes.text = nakes["id_izin_nakes"].toString() != "null"
            ? nakes["id_izin_nakes"].toString()
            : "";
        _tempatPraktek.text = nakes["temp_praktik"].toString() != "null"
            ? nakes["temp_praktik"].toString()
            : "";
        tempatPraktik = nakes["temp_praktik"].toString() == "1"
            ? "MANDIRI"
            : nakes["temp_praktik"].toString() == "2"
                ? "FASYANKES"
                : nakes["temp_praktik"].toString() == "3"
                    ? "DISTRIBUSI"
                    : "PRODUKSI";
        _idFasyankes.text = nakes["id_fasyankes"].toString() != "null"
            ? nakes["id_fasyankes"].toString()
            : "";
        _alamatPraktek.text = nakes["alamat"].toString() != "null"
            ? nakes["alamat"].toString()
            : "";
        _dusunPraktek.text = nakes["dusun"].toString() != "null"
            ? nakes["dusun"].toString()
            : "";
        _rtPraktek.text =
            nakes["rt"].toString() != "null" ? nakes["rt"].toString() : "";
        _rwPraktek.text =
            nakes["rw"].toString() != "null" ? nakes["rw"].toString() : "";
        _latPraktek.text =
            nakes["lat"].toString() != "null" ? nakes["lat"].toString() : "";
        _lngPraktek.text =
            nakes["lng"].toString() != "null" ? nakes["lng"].toString() : "";

        _dokKetSehat.text = nakes["ket_sehat"].toString() != "null"
            ? nakes["ket_sehat"].toString()
            : "";
        _dokSuperPatuh.text = nakes["sp_mematuhi"].toString() != "null"
            ? nakes["sp_mematuhi"].toString()
            : "";
        _dokSuperPraktik.text = nakes["sp_temp_praktek"].toString() != "null"
            ? nakes["sp_temp_praktek"].toString()
            : "";
        _dokSuperAtasan.text = nakes["sp_atasan"].toString() != "null"
            ? nakes["sp_atasan"].toString()
            : "";
        _dokSuketPraktik.text = nakes["sk_fasyankes"].toString() != "null"
            ? nakes["sk_fasyankes"].toString()
            : "";
        _dokSuketIntern.text =
            nakes["sk_komite_interensif"].toString() != "null"
                ? nakes["sk_komite_interensif"].toString()
                : "";
        _dokSuketFasyankes.text = nakes["sk_fasyankes"].toString() != "null"
            ? nakes["sk_fasyankes"].toString()
            : "";
        _dokRekomDinkes.text = nakes["rekom_dinkes"].toString() != "null"
            ? nakes["rekom_dinkes"].toString()
            : "";
        _dokSppl.text = nakes["dok_sppl"].toString() != "null"
            ? nakes["dok_sppl"].toString()
            : "";
        _dokSipLama.text = nakes["lama_dok"].toString() != "null"
            ? nakes["lama_dok"].toString()
            : "";
        _dokImb.text = nakes["dok_imb"].toString() != "null"
            ? nakes["dok_imb"].toString()
            : "";
        _dokIzinSebelum.text = nakes["surat_izin_sebelum"].toString() != "null"
            ? nakes["surat_izin_sebelum"].toString()
            : "";

        varPendTerakhir = json.decode(result.body)["pend_terakhir"];
        varNoSertifikat = json.decode(result.body)["no_sertifikat"];
        varNoStr = json.decode(result.body)["no_str"];
        varNoRekomOp = json.decode(result.body)["no_rekom_op"];
        varKetSehat = json.decode(result.body)["ket_sehat"];
        varSpMematuhi = json.decode(result.body)["sp_mematuhi"];
        varSpTempPraktek = json.decode(result.body)["sp_temp_praktek"];
        varSkFasyankes = json.decode(result.body)["sk_fasyankes"];
        varSpAtasan = json.decode(result.body)["sp_atasan"];
        varSkKomiteInterensif =
            json.decode(result.body)["sk_komite_interensif"];
        varRekomDinkes = json.decode(result.body)["rekom_dinkes"];
        varSuratIzinSebelum = json.decode(result.body)["surat_izin_sebelum"];
        varSebelum = json.decode(result.body)["sebelum"];
        varCekFasyankes = json.decode(result.body)["cek_fasyankes"];

        if (nakes["temp_praktik"].toString() != "1") {
          fasyankes = json.decode(result.body)["fasyankes"];

          _idKategoriFasyankes.text =
              fasyankes["id_kategori"].toString() != "null"
                  ? fasyankes["id_kategori"].toString()
                  : "";
          _kategoriFasyankes.text = fasyankes["kategori"].toString() != "null"
              ? fasyankes["kategori"].toString()
              : "";
          _namaFasyankes.text = fasyankes["nama"].toString() != "null"
              ? fasyankes["nama"].toString()
              : "";
          _latFasyankes.text = fasyankes["lat"].toString() != "null"
              ? fasyankes["lat"].toString()
              : "";
          _lngFasyankes.text = fasyankes["lng"].toString() != "null"
              ? fasyankes["lng"].toString()
              : "";
        }
      });
    } else {
      hapusLoader();
      errorPesan("Gagal mendapatkan data permohonan");
      Get.offAllNamed("/home");
    }
  }

  @override
  void initState() {
    super.initState();
    getPermohonan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            "NAKES",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Izin Tenaga Kesehatan",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 135, 45),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        foregroundColor: Colors.black87,
        bottomOpacity: 0.0,
        elevation: 1.0,
        titleTextStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
          ),
        ),
        child: Stepper(
          controlsBuilder: (context, details) {
            return const SizedBox();
          },
          currentStep: currentStep,
          steps: [
            Step(
              isActive: currentStep >= 0,
              state: currentStep >= 0 ? StepState.disabled : StepState.complete,
              title: const Text("DATA PEMOHON"),
              subtitle: const Text("Data Profil Pemohon"),
              content: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (nakes["hasil_staf"] == 2) ...[
                      Html(data: "<b>${nakes["hasil_staf"].toString()}</b>"),
                      const SizedBox(height: 10),
                      Html(
                        data:
                            "<span style='font-size: 13px;'>Apabila sampai dengan <b>${DateFormat('EEEE, d MMMM yyyy', 'id').format(DateTime.parse(nakes['jth_tempo_revisi'].toString()))}</b> Anda masih belum melengkapi berkas yang diminta, permohonan Anda akan batal secara otomatis.</span>",
                      ),
                    ],
                    if (nakes["hasil_dinkes"] == 2) ...[
                      Html(
                          data: "<b>${nakes["catatan_dinkes"].toString()}</b>"),
                      const SizedBox(height: 10),
                      Html(
                        data:
                            "<span style='font-size: 13px;'>Apabila sampai dengan <b>${DateFormat('EEEE, d MMMM yyyy', 'id').format(DateTime.parse(nakes['jth_tempo_revisi'].toString()))}</b> Anda masih belum melengkapi berkas yang diminta, permohonan Anda akan batal secara otomatis.</span>",
                      ),
                    ],
                    const SizedBox(height: 20),
                    const Text(
                      "PAS FOTO PEMOHON \n(UNTUK SK)",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    fotoPemohon != null
                        ? Image.file(
                            fotoPemohon!,
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : _fotoPemohon.text != ""
                            ? DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  _fotoPemohon.text,
                                  height: 200,
                                  width: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Text('Loading foto...');
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Image.asset(
                                'assets/images/noimage.jpg',
                                height: 200,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                              height: 125,
                              color: Colors.white,
                              child: ListView(
                                children: [
                                  ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text("Foto Dari Kamera"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        getFoto(ImageSource.camera);
                                      }),
                                  ListTile(
                                      leading: const Icon(Icons.image),
                                      title:
                                          const Text("Ambil File Dari Gallery"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        getFoto(ImageSource.gallery);
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.upload,
                          size: 18,
                        ),
                        label: const Text(
                          "UNGGAH FOTO",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: TextFormField(
                        controller: _fotoPemohon,
                        validator: (value) {
                          if (value == "") {
                            return "Error";
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_fotoPemohon.text == '') const Text("Foto wajib diisi"),
                    const SizedBox(height: 25),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _namaPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "Nama Lengkap Pemohon",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return 'Nama pemohon wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13),
                              controller: _gelarDepan,
                              decoration: const InputDecoration(
                                labelText: "Gelar Depan",
                                labelStyle: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13),
                              controller: _gelarBelakang,
                              decoration: const InputDecoration(
                                labelText: "Gelar Belakang",
                                labelStyle: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 1),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _alamatPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "Alamat Rumah Jalan",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _dusunPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "Dusun/Lingkungan",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 5),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13),
                              controller: _rtPemohon,
                              decoration: const InputDecoration(
                                labelText: "RT",
                                labelStyle: TextStyle(fontSize: 13),
                              ),
                              validator: (value) {
                                if (value == "") {
                                  return 'RT wajib diisi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13),
                              controller: _rwPemohon,
                              decoration: const InputDecoration(
                                labelText: "RW",
                                labelStyle: TextStyle(fontSize: 13),
                              ),
                              validator: (value) {
                                if (value == "") {
                                  return 'RW wajib diisi';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    DropdownSearch<PropinsiModels>(
                      asyncItems: (String filter) async {
                        var response = await http.get(
                          Uri.parse(
                              "$baseUrl/api/propinsi?key=${ApiContainer.baseKey}"),
                        );

                        if (response.statusCode != 200) {
                          errorData();
                          return [];
                        } else {
                          List propinsi = (json.decode(response.body)
                              as Map<String, dynamic>)["data"];

                          List<PropinsiModels> propinsiList = [];

                          for (var element in propinsi) {
                            propinsiList.add(PropinsiModels.fromJson(element));
                          }

                          return propinsiList;
                        }
                      },
                      popupProps: PopupProps.dialog(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            '${item.namaProp}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Propinsi",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _nopropPemohon.text = value?.noProp ?? "";
                          _propinsiPemohon.text = value?.namaProp ?? "";
                          _nokabPemohon.text = "";
                          _kotaPemohon.text = "";
                          _nokecPemohon.text = "";
                          _kecamatanPemohon.text = "";
                          _nokelPemohon.text = "";
                          _desaPemohon.text = "";
                        });
                      },
                      selectedItem: PropinsiModels(
                        noProp: _nopropPemohon.text,
                        namaProp: _propinsiPemohon.text,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?.namaProp ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?.noProp == "") {
                          return 'Propinsi tempat tinggal wajib diisi';
                        }
                        return null;
                      },
                    ),
                    if (_nopropPemohon.text != "") ...[
                      const SizedBox(height: 5),
                      DropdownSearch<KotaModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/kota?no_prop=${_nopropPemohon.text}&key=${ApiContainer.baseKey}"),
                          );

                          if (response.statusCode != 200) {
                            errorData();
                            return [];
                          } else {
                            List kota = (json.decode(response.body)
                                as Map<String, dynamic>)["data"];

                            List<KotaModels> kotaList = [];

                            for (var element in kota) {
                              kotaList.add(KotaModels.fromJson(element));
                            }

                            return kotaList;
                          }
                        },
                        popupProps: PopupProps.dialog(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              '${item.namaKab}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Kota",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _nokabPemohon.text = value?.noKab ?? "";
                            _kotaPemohon.text = value?.namaKab ?? "";

                            _nokecPemohon.text = "";
                            _kecamatanPemohon.text = "";
                            _nokelPemohon.text = "";
                            _desaPemohon.text = "";
                          });
                        },
                        selectedItem: KotaModels(
                          noKab: _nokabPemohon.text,
                          namaKab: _kotaPemohon.text,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.namaKab ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?.noKab == "") {
                            return 'Kota tempat tinggal wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                    if (_nopropPemohon.text != "" &&
                        _nokabPemohon.text != "") ...[
                      const SizedBox(height: 5),
                      DropdownSearch<KecamatanModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/kecamatan?no_prop=${_nopropPemohon.text}&no_kab=${_nokabPemohon.text}&key=${ApiContainer.baseKey}"),
                          );

                          if (response.statusCode != 200) {
                            errorData();
                            return [];
                          } else {
                            List kecamatan = (json.decode(response.body)
                                as Map<String, dynamic>)["data"];

                            List<KecamatanModels> kecamatanList = [];

                            for (var element in kecamatan) {
                              kecamatanList
                                  .add(KecamatanModels.fromJson(element));
                            }

                            return kecamatanList;
                          }
                        },
                        popupProps: PopupProps.dialog(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              '${item.namaKec}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Kecamatan",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _nokecPemohon.text = value?.noKec ?? "";
                            _kecamatanPemohon.text = value?.namaKec ?? "";

                            _nokelPemohon.text = "";
                            _desaPemohon.text = "";
                          });
                        },
                        selectedItem: KecamatanModels(
                          noKec: _nokecPemohon.text,
                          namaKec: _kecamatanPemohon.text,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.namaKec ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?.noKec == "") {
                            return 'Kecamatan tempat tinggal wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                    if (_nopropPemohon.text != "" &&
                        _nokabPemohon.text != "" &&
                        _nokecPemohon.text != "") ...[
                      const SizedBox(height: 5),
                      DropdownSearch<DesaModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/desa?no_prop=${_nopropPemohon.text}&no_kab=${_nokabPemohon.text}&no_kec=${_nokecPemohon.text}&key=${ApiContainer.baseKey}"),
                          );

                          if (response.statusCode != 200) {
                            errorData();
                            return [];
                          } else {
                            List desa = (json.decode(response.body)
                                as Map<String, dynamic>)["data"];

                            List<DesaModels> desaList = [];

                            for (var element in desa) {
                              desaList.add(DesaModels.fromJson(element));
                            }

                            return desaList;
                          }
                        },
                        popupProps: PopupProps.dialog(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              '${item.namaKel}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Desa/Kelurahan",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _nokelPemohon.text = value?.noKel ?? "";
                            _desaPemohon.text = value?.namaKel ?? "";
                          });
                        },
                        selectedItem: DesaModels(
                          noKel: _nokelPemohon.text,
                          namaKel: _desaPemohon.text,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.namaKel ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?.noKel == "") {
                            return 'Desa/Kelurahan tempat tinggal wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _kodeposPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "Kodepos",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _latPemohon,
                      decoration: const InputDecoration(
                        labelText: "Latitude",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      enabled: false,
                      validator: (value) {
                        if (value == "") {
                          return 'Kordinat latitude wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _lngPemohon,
                      decoration: const InputDecoration(
                        labelText: "Longitude",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      enabled: false,
                      validator: (value) {
                        if (value == "") {
                          return 'Kordinat longitude wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                label: const Text(
                                  'KORDINAT RUMAH',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.location_pin,
                                  size: 18,
                                ),
                                onPressed: () async {
                                  LatLng kordinat;
                                  kordinat = LatLng(
                                      double.parse(_latPemohon.text),
                                      double.parse(_lngPemohon.text));
                                  final result =
                                      await Get.to(() => MapKordinat(kordinat));

                                  setState(() {
                                    if (result != null) {
                                      _latPemohon.text =
                                          result.latitude.toString();
                                      _lngPemohon.text =
                                          result.longitude.toString();
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _tempLahirPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "Tempat Lahir",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return 'Tempat lahir wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      decoration: const InputDecoration(
                        labelText: "Tanggal Lahir",
                        labelStyle: TextStyle(fontSize: 13),
                        suffixIcon: Icon(Icons.calendar_month),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return 'Tanggal lahir wajib diisi';
                        }
                        return null;
                      },
                      controller: _tglLahirPemohon1,
                      autocorrect: false,
                      readOnly: true,
                      onTap: () async {
                        DateTime? newDateLahir = await showDatePicker(
                          context: context,
                          initialDate: _tglLahirPemohon.text != ""
                              ? DateTime.parse(_tglLahirPemohon.text)
                              : DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        if (newDateLahir != null) {
                          setState(() {
                            _tglLahirPemohon.text =
                                DateFormat("yyyy-MM-dd").format(newDateLahir);
                            _tglLahirPemohon1.text =
                                DateFormat("d MMMM yyyy", "id")
                                    .format(newDateLahir);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 5),
                    DropdownSearch<Map<String, dynamic>>(
                      items: const [
                        {"id": 1, "kelamin": "LAKI-LAKI"},
                        {"id": 2, "kelamin": "PEREMPUAN"},
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Jenis Kelamin",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _kelaminPemohon.text =
                              value?["id"].toString() as String;
                          _jenisKelaminPemohon.text = value?["kelamin"] ?? "";
                        });
                      },
                      selectedItem: {
                        "id": _kelaminPemohon.text,
                        "kelamin": _jenisKelaminPemohon.text
                      },
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            item["kelamin"],
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?["kelamin"] ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?["id"] == "") {
                          return 'Jenis kelamin wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _pekerjaanPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "Pekerjaan",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return 'Pekerjaan wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    DropdownSearch<Map<String, dynamic>>(
                      items: const [
                        {"id": 1, "warganegara": "INDONESIA"},
                        {"id": 2, "warganegara": "ASING"},
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Warganegara",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _wniPemohon.text = value?["id"].toString() ?? "";
                          _jenisWniPemohon.text = value?["warganegara"] ?? "";
                        });
                      },
                      selectedItem: {
                        "id": _wniPemohon.text,
                        "warganegara": _jenisWniPemohon.text,
                      },
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            item["warganegara"],
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?["warganegara"] ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?.toString() == "") {
                          return 'Kewarganegaraan wajib diisi';
                        }
                        return null;
                      },
                    ),
                    if (_wniPemohon.text == '2') ...[
                      const SizedBox(height: 5),
                      DropdownSearch<NegaraModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/negara?key=${ApiContainer.baseKey}"),
                          );

                          if (response.statusCode != 200) {
                            errorData();
                            return [];
                          } else {
                            List negara = (json.decode(response.body)
                                as Map<String, dynamic>)["data"];

                            List<NegaraModels> negaraList = [];

                            for (var element in negara) {
                              negaraList.add(NegaraModels.fromJson(element));
                            }

                            return negaraList;
                          }
                        },
                        popupProps: PopupProps.dialog(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              '${item.namaNegara}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Negara Asal",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _negaraPemohon.text = value?.namaNegara ?? "";
                          });
                        },
                        selectedItem: NegaraModels(
                          namaNegara: _negaraPemohon.text,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.namaNegara ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?.namaNegara == "") {
                            return 'Negara asal wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _emailPemohon,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == "") {
                          return 'Alamat email wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _hpPemohon,
                      decoration: const InputDecoration(
                        labelText: "Nomor HP",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      enabled: false,
                      validator: (value) {
                        if (value == "") {
                          return 'Nomor HP wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _nikPemohon,
                      decoration: const InputDecoration(
                        labelText: "NIK",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      enabled: false,
                      validator: (value) {
                        if (value == "") {
                          return 'NIK wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    ktpPemohon != null
                        ? Image.file(
                            ktpPemohon!,
                            fit: BoxFit.cover,
                          )
                        : _ktpPemohon.text != ""
                            ? DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  _ktpPemohon.text,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Text('Loading foto...');
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Image.asset(
                                'assets/images/noimg.png',
                                height: 200,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.bottomSheet(Container(
                            height: 125,
                            color: Colors.white,
                            child: ListView(
                              children: [
                                ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text("Foto Dari Kamera"),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      getKtp(ImageSource.camera);
                                    }),
                                ListTile(
                                    leading: const Icon(Icons.image),
                                    title:
                                        const Text("Ambil File Dari Gallery"),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      getKtp(ImageSource.gallery);
                                    })
                              ],
                            ),
                          ));
                        },
                        icon: const Icon(
                          Icons.upload,
                          size: 18,
                        ),
                        label: const Text(
                          "UNGGAH KTP",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: TextFormField(
                        controller: _ktpPemohon,
                        validator: (value) {
                          if (value == "") {
                            return "Error";
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_ktpPemohon.text == '')
                      const Text("Foto KTP wajib diisi"),
                    const Divider(
                      height: 50,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              isPemohonKirim == true) {
                            isPemohonKirim == false;
                            loadingData();

                            Map<String, String> headers = {
                              'Content-Type': 'multipart/form-data',
                            };

                            Map<String, String> body = {
                              "key": ApiContainer.baseKey,
                              "id_permohonan": widget.id.toString(),
                              "nama": _namaPemohon.text,
                              "gelar_depan": _gelarDepan.text,
                              "gelar_belakang": _gelarBelakang.text,
                              "alamat": _alamatPemohon.text,
                              "dusun": _dusunPemohon.text,
                              "rt": _rtPemohon.text,
                              "rw": _rwPemohon.text,
                              "noprop": _nopropPemohon.text,
                              "nokab": _nokabPemohon.text,
                              "nokec": _nokecPemohon.text,
                              "nokel": _nokelPemohon.text,
                              "temp_lahir": _tempLahirPemohon.text,
                              "tgl_lahir": _tglLahirPemohon.text,
                              "kelamin": _kelaminPemohon.text,
                              "pekerjaan": _pekerjaanPemohon.text,
                              "warganegara": _wniPemohon.text,
                              "negara": _negaraPemohon.text,
                              "email": _emailPemohon.text,
                              "lat": _latPemohon.text,
                              "lng": _lngPemohon.text,
                            };

                            var request = http.MultipartRequest('POST',
                                Uri.parse("$baseUrl/api/nakes-user-revisi"));

                            request.headers.addAll(headers);
                            request.fields.addAll(body);

                            if (fotoPemohon != null) {
                              request.files.add(
                                  await http.MultipartFile.fromPath(
                                      'foto', fotoPemohon?.path ?? ""));
                            }

                            if (ktpPemohon != null) {
                              request.files.add(
                                  await http.MultipartFile.fromPath(
                                      'ktp', ktpPemohon?.path ?? ""));
                            }

                            var response = await request.send();

                            if (response.statusCode == 200) {
                              hapusLoader();

                              setState(() {
                                currentStep++;
                              });
                            } else {
                              hapusLoader();
                              errorData();
                            }
                          } else {
                            hapusLoader();
                            errorPesan("Silahkan melengkapi semua data");
                          }
                        },
                        label: const Text('SELANJUTNYA'),
                        icon: const Icon(Icons.check),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Step(
              isActive: currentStep >= 1,
              state: currentStep >= 1 ? StepState.disabled : StepState.complete,
              title: const Text("DATA PERMOHONAN"),
              subtitle: const Text("Rincian Permohonan Izin Nakes"),
              content: Form(
                key: _permohonanKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _perpanjangan.text == "0"
                          ? "PERMOHONAN IZIN BARU"
                          : "PERPANJANGAN IZIN LAMA",
                      decoration: const InputDecoration(
                        labelText: "Status Permohonan",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      style: const TextStyle(fontSize: 13),
                      enabled: false,
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      initialValue: "$jenisIzin ($kodeIzin)",
                      decoration: const InputDecoration(
                        labelText: "Jenis Izin",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      style: const TextStyle(fontSize: 13),
                      enabled: false,
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      initialValue: tempatPraktik,
                      decoration: const InputDecoration(
                        labelText: "Tempat Praktik",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      style: const TextStyle(fontSize: 13),
                      enabled: false,
                    ),
                    if (_tempatPraktek.text != "1") ...[
                      const SizedBox(height: 5),
                      DropdownSearch<FasyankesKategoriModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/fasyankes-kategori?jenis=$tempatPraktik&key=${ApiContainer.baseKey}"),
                          );

                          if (response.statusCode != 200) {
                            errorData();
                            return [];
                          } else {
                            List kategoriFasyankes = (json.decode(response.body)
                                as Map<String, dynamic>)["data"];

                            List<FasyankesKategoriModels>
                                kategoriFasyankesList = [];

                            for (var element in kategoriFasyankes) {
                              kategoriFasyankesList.add(
                                  FasyankesKategoriModels.fromJson(element));
                            }

                            return kategoriFasyankesList;
                          }
                        },
                        popupProps: PopupProps.dialog(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              item.kategori.toString().toUpperCase(),
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Kategori Fasyankes",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        enabled: isKategoriFasyankes,
                        selectedItem: FasyankesKategoriModels(
                          id: int.tryParse(_idKategoriFasyankes.text),
                          kategori: _kategoriFasyankes.text,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _idKategoriFasyankes.text =
                                value?.id.toString() as String;
                            _kategoriFasyankes.text = value?.kategori ?? "";
                            isKategoriFasyankes = false;

                            _idFasyankes.text = "";
                            _namaFasyankes.text = "";
                            _latFasyankes.text = "";
                            _lngFasyankes.text = "";
                          });
                        },
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.kategori.toString().toUpperCase() ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?.id == null) {
                            return 'Kategori fasyankes wajib diisi';
                          }
                          return null;
                        },
                      ),
                      if (_idKategoriFasyankes.text != "") ...[
                        const SizedBox(height: 5),
                        DropdownSearch<FasyankesModels>(
                          asyncItems: (String filter) async {
                            var response = await http.get(
                              Uri.parse(
                                  "$baseUrl/api/fasyankes?id_kategori=${_idKategoriFasyankes.text}&key=${ApiContainer.baseKey}"),
                            );

                            if (response.statusCode != 200) {
                              errorData();
                              return [];
                            } else {
                              List fasyankes = (json.decode(response.body)
                                  as Map<String, dynamic>)["data"];

                              List<FasyankesModels> fasyankesList = [];

                              for (var element in fasyankes) {
                                fasyankesList
                                    .add(FasyankesModels.fromJson(element));
                              }

                              return fasyankesList;
                            }
                          },
                          popupProps: PopupProps.dialog(
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(
                                item.nama.toString().toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Fasyankes",
                              labelStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                          enabled: isIdFasyankes,
                          selectedItem: FasyankesModels(
                            id: int.tryParse(_idFasyankes.text),
                            nama: _namaFasyankes.text,
                            lat: _latFasyankes.text,
                            lng: _lngFasyankes.text,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _idFasyankes.text =
                                  value?.id.toString() as String;

                              _namaFasyankes.text = value?.nama ?? "";
                              _latFasyankes.text = value?.lat ?? "";
                              _lngFasyankes.text = value?.lng ?? "";

                              isIdFasyankes = false;
                            });
                          },
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?.nama.toString().toUpperCase() ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          validator: (value) {
                            if (value?.id == null) {
                              return 'Fasyankes wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                    ],
                    if (_tempatPraktek.text == "1") ...[
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _alamatPraktek,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Alamat Praktik",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        style: const TextStyle(fontSize: 13),
                        validator: (value) {
                          if (value == "") {
                            return 'Alamat praktik wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _dusunPraktek,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Dusun/Lingkungan",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 15),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(fontSize: 13),
                                controller: _rtPraktek,
                                decoration: const InputDecoration(
                                  labelText: "RT",
                                  labelStyle: TextStyle(fontSize: 13),
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return 'RT wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(fontSize: 13),
                                controller: _rwPraktek,
                                decoration: const InputDecoration(
                                  labelText: "RW",
                                  labelStyle: TextStyle(fontSize: 13),
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return 'RW wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      DropdownSearch<KecamatanModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/kecamatan-permohonan?key=${ApiContainer.baseKey}"),
                          );

                          if (response.statusCode != 200) {
                            errorData();
                            return [];
                          } else {
                            List kecamatan = (json.decode(response.body)
                                as Map<String, dynamic>)["data"];

                            List<KecamatanModels> kecamatanList = [];

                            for (var element in kecamatan) {
                              kecamatanList
                                  .add(KecamatanModels.fromJson(element));
                            }

                            return kecamatanList;
                          }
                        },
                        popupProps: PopupProps.dialog(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              '${item.namaKec}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Kecamatan",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _nokecPraktek.text = value?.noKec as String;
                            _kecamatanPraktek.text = value?.namaKec ?? "";

                            _nokelPraktek.text = "";
                            _kelurahanPraktek.text = "";
                          });
                        },
                        selectedItem: KecamatanModels(
                          noKec: _nokecPraktek.text,
                          namaKec: _kecamatanPraktek.text,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.namaKec ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?.noKec == "") {
                            return 'Kecamatan tempat praktik wajib diisi';
                          }
                          return null;
                        },
                      ),
                      if (_nokecPraktek.text != "") ...[
                        const SizedBox(height: 5),
                        DropdownSearch<DesaModels>(
                          asyncItems: (String filter) async {
                            var response = await http.get(
                              Uri.parse(
                                  "$baseUrl/api/desa-permohonan?no_kec=${_nokecPraktek.text}&key=${ApiContainer.baseKey}"),
                            );

                            if (response.statusCode != 200) {
                              errorData();
                              return [];
                            } else {
                              List desa = (json.decode(response.body)
                                  as Map<String, dynamic>)["data"];

                              List<DesaModels> desaList = [];

                              for (var element in desa) {
                                desaList.add(DesaModels.fromJson(element));
                              }

                              return desaList;
                            }
                          },
                          popupProps: PopupProps.dialog(
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(
                                '${item.namaKel}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Desa/Kelurahan",
                              labelStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _nokelPraktek.text = value?.noKel as String;
                              _kelurahanPraktek.text = value?.namaKel ?? "";
                            });
                          },
                          selectedItem: DesaModels(
                            noKel: _nokelPraktek.text,
                            namaKel: _kelurahanPraktek.text,
                          ),
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?.namaKel ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          validator: (value) {
                            if (value?.noKel == "") {
                              return 'Desa/Kelurahan tempat praktik wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _kodeposPraktek,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Kodepos",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _latPraktek,
                        decoration: const InputDecoration(
                          labelText: "Latitude",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        enabled: false,
                        validator: (value) {
                          if (value == "") {
                            return 'Kordinat latitude wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _lngPraktek,
                        decoration: const InputDecoration(
                          labelText: "Longitude",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        enabled: false,
                        validator: (value) {
                          if (value == "") {
                            return 'Kordinat longitude wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  label: const Text(
                                    'KORDINAT PRAKTIK',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  icon: const Icon(
                                    Icons.location_pin,
                                    size: 18,
                                  ),
                                  onPressed: () async {
                                    LatLng kordinat;

                                    if (_latPraktek.text != "") {
                                      kordinat = LatLng(
                                          double.parse(_latPraktek.text),
                                          double.parse(_lngPraktek.text));
                                    } else {
                                      kordinat = const LatLng(
                                          -8.223600593616215,
                                          114.36705853790045);
                                    }

                                    final result = await Get.to(
                                        () => MapKordinat(kordinat));

                                    setState(() {
                                      if (result != null) {
                                        _latPraktek.text =
                                            result.latitude.toString();
                                        _lngPraktek.text =
                                            result.longitude.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const Divider(
                      height: 50,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    if (isTerbatas == true) ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (_permohonanKey.currentState!.validate()) {
                              loadingData();

                              if (_tempatPraktek.text == "1") {
                                var request = await http.post(
                                  Uri.parse("$baseUrl/api/nakes-sppl"),
                                  body: {
                                    "key": ApiContainer.baseKey,
                                    "uid": _uidPemohon.text,
                                    "no_kec": _nokecPraktek.text,
                                    "no_kel": _nokelPraktek.text,
                                    "id_izin_nakes": _idIzinNakes.text,
                                    "alamat_praktik": _alamatPraktek.text,
                                    "dusun": _dusunPraktek.text,
                                    "rt": _rtPraktek.text,
                                    "rw": _rwPraktek.text,
                                  },
                                );

                                if (request.statusCode == 200) {
                                  hapusLoader();
                                  setState(() {
                                    currentStep++;
                                  });
                                } else {
                                  hapusLoader();
                                  errorData();
                                }
                              } else {
                                hapusLoader();
                                setState(() {
                                  currentStep++;
                                });
                              }
                            } else {
                              hapusLoader();
                              errorPesan("Silahkan melengkapi semua data");
                            }
                          },
                          label: const Text('SELANJUTNYA'),
                          icon: const Icon(Icons.check),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
            if (isTerbatas == true) ...[
              Step(
                isActive: currentStep >= 2,
                state:
                    currentStep >= 2 ? StepState.disabled : StepState.complete,
                title: const Text("DOKUMEN"),
                subtitle: const Text("Dokumen Permohonan Izin Nakes"),
                content: Form(
                  key: _dokumenKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      if (varPendTerakhir == 1) buildPendidikanTerakhir(),
                      if (varNoSertifikat == 1) buildSertKomptensi(),
                      if (varNoStr == 1) buildStr(),
                      if (varNoRekomOp == 1) buildRekomOp(),
                      if (varKetSehat == 1) buildKetSehat(),
                      if (varSpMematuhi == 1) buildPatuhFarmasi(),
                      if (varSpTempPraktek == 1) buildTempatPraktik(),
                      if (varSkFasyankes == 1 && _tempatPraktek.text != '1')
                        buildKetPimpinanFasyankes(),
                      if (varSpAtasan == 1 && varSebelum! > 0)
                        buildPersetujuanAtasan(),
                      if (varSkKomiteInterensif == 1) buildKomiteInternship(),
                      if (varSuratIzinSebelum == 1 &&
                          varCekFasyankes != 0 &&
                          _tempatPraktek.text != '1')
                        buildFasyankesSebelum(),
                      if (_perpanjangan.text == "1") buildIzinLama(),
                      if (_tempatPraktek.text == '1') ...[
                        buildSppl(),
                        buildImb(),
                      ],
                      if (varRekomDinkes == 1) buildRekomendasiDinkes(),
                      const Divider(
                        height: 50,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _catatan,
                        maxLines: 2,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Catatan Permohonan",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      const Divider(
                        height: 50,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (_dokumenKey.currentState!.validate() &&
                                isPermohonanKirim == true) {
                              isPermohonanKirim == false;

                              loadingData();

                              Map<String, String> headers = {
                                'Content-Type': 'multipart/form-data',
                              };

                              Map<String, String> body = {
                                "key": ApiContainer.baseKey,
                                "id_permohonan": widget.id.toString(),
                                "pendidikan_terakhir": _pendidikanTerakhir.text,
                                "lembaga_pendidikan": _lembagaPendidikan.text,
                                "no_ijasah": _noIjasah.text,
                                "tgl_ijasah": _tglIjasah.text,
                                "sert_kompetensi": _sertKompetensi.text,
                                "tgl_sert_kompetensi": _tglSertKompetensi.text,
                                "str_no": _strNo.text,
                                "str_berlaku": _strBerlaku.text,
                                "str_asal": _strAsal.text,
                                "str_tanggal": _strTanggal.text,
                                "rekom_op": _rekomOp.text,
                                "tgl_rekom_op": _tglRekomOp.text,
                                "id_fasyankes": _idFasyankes.text,
                                "alamat_praktik": _alamatPraktek.text,
                                "dusun": _dusunPraktek.text,
                                "rt": _rtPraktek.text,
                                "rw": _rwPraktek.text,
                                "no_kec": _nokecPraktek.text,
                                "no_kel": _nokelPraktek.text,
                                "kodepos": _kodeposPraktek.text,
                                "lat": _latPraktek.text,
                                "lng": _lngPraktek.text,
                                "imb_no": _imbNomor.text,
                                "lama_nomor": _lamaNomor.text,
                                "lama_tanggal": _lamaTanggal.text,
                                "lama_berlaku": _lamaBerlaku.text,
                                "lama_an": _lamaAn.text,
                                "catatan": _catatan.text,
                                "rekom_dinkes_no": _nomorRekomDinkes.text,
                                "rekom_dinkes_tgl": _tglRekomDinkes.text,
                              };

                              var request = http.MultipartRequest('POST',
                                  Uri.parse("$baseUrl/api/nakes-revisi"));

                              request.headers.addAll(headers);
                              request.fields.addAll(body);

                              if (scanIjasah != null) {
                                for (int i = 0; i < scanIjasah!.length; i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'dok_ijasah[]',
                                        File(scanIjasah![i].path)
                                            .readAsBytesSync(),
                                        filename: scanIjasah![i]
                                            .path
                                            .split("/")
                                            .last),
                                  );
                                }
                              }

                              if (scanSertifikat != null) {
                                for (int i = 0;
                                    i < scanSertifikat!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'dok_sert_kompetensi[]',
                                          File(scanSertifikat![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSertifikat![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanStr != null) {
                                for (int i = 0; i < scanStr!.length; i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'dok_str[]',
                                          File(scanStr![i].path)
                                              .readAsBytesSync(),
                                          filename: scanStr![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanRekomOp != null) {
                                for (int i = 0; i < scanRekomOp!.length; i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'dok_rekom_op[]',
                                          File(scanRekomOp![i].path)
                                              .readAsBytesSync(),
                                          filename: scanRekomOp![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanKetSehat != null) {
                                for (int i = 0; i < scanKetSehat!.length; i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'ket_sehat[]',
                                          File(scanKetSehat![i].path)
                                              .readAsBytesSync(),
                                          filename: scanKetSehat![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSuperPatuh != null) {
                                for (int i = 0;
                                    i < scanSuperPatuh!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'sp_mematuhi[]',
                                          File(scanSuperPatuh![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSuperPatuh![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSuperPraktik != null) {
                                for (int i = 0;
                                    i < scanSuperPraktik!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'sp_temp_praktek[]',
                                          File(scanSuperPraktik![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSuperPraktik![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSuketPraktik != null) {
                                for (int i = 0;
                                    i < scanSuketPraktik!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'sk_fasyankes[]',
                                          File(scanSuketPraktik![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSuketPraktik![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSuperAtasan != null) {
                                for (int i = 0;
                                    i < scanSuperAtasan!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'sp_atasan[]',
                                          File(scanSuperAtasan![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSuperAtasan![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSuketIntern != null) {
                                for (int i = 0;
                                    i < scanSuketIntern!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'sk_komite_interensif[]',
                                          File(scanSuketIntern![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSuketIntern![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanIzinSebelum != null) {
                                for (int i = 0;
                                    i < scanIzinSebelum!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'surat_izin_sebelum[]',
                                          File(scanIzinSebelum![i].path)
                                              .readAsBytesSync(),
                                          filename: scanIzinSebelum![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSuketFasyankes != null) {
                                for (int i = 0;
                                    i < scanSuketFasyankes!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'sk_fasyankes[]',
                                          File(scanSuketFasyankes![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSuketFasyankes![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanRekomDinkes != null) {
                                for (int i = 0;
                                    i < scanRekomDinkes!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'rekom_dinkes[]',
                                          File(scanRekomDinkes![i].path)
                                              .readAsBytesSync(),
                                          filename: scanRekomDinkes![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSppl != null) {
                                for (int i = 0; i < scanSppl!.length; i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'dok_sppl[]',
                                          File(scanSppl![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSppl![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSipLama != null) {
                                for (int i = 0; i < scanSipLama!.length; i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'lama_dok[]',
                                          File(scanSipLama![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSipLama![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanImb != null) {
                                for (int i = 0; i < scanImb!.length; i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'dok_imb[]',
                                          File(scanImb![i].path)
                                              .readAsBytesSync(),
                                          filename: scanImb![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanPernyataanImb != null) {
                                for (int i = 0;
                                    i < scanPernyataanImb!.length;
                                    i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'dok_pernyataan_imb[]',
                                          File(scanPernyataanImb![i].path)
                                              .readAsBytesSync(),
                                          filename: scanPernyataanImb![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanKkpr != null) {
                                for (int i = 0; i < scanKkpr!.length; i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'dok_kkpr[]',
                                          File(scanKkpr![i].path)
                                              .readAsBytesSync(),
                                          filename: scanKkpr![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              if (scanSlf != null) {
                                for (int i = 0; i < scanSlf!.length; i++) {
                                  request.files.add(
                                      http.MultipartFile.fromBytes(
                                          'dok_slf[]',
                                          File(scanSlf![i].path)
                                              .readAsBytesSync(),
                                          filename: scanSlf![i]
                                              .path
                                              .split("/")
                                              .last));
                                }
                              }

                              var response = await request.send();

                              if (response.statusCode == 200) {
                                hapusLoader();
                                pesanData(
                                    "Revisi Permohonan Izin Nakes Berhasil Dikirim");
                                Get.offAllNamed("/home");
                              } else {
                                hapusLoader();
                                errorData();
                              }
                            } else {
                              hapusLoader();
                              errorPesan("Silahkan melengkapi semua data");
                            }
                          },
                          label: const Text("KIRIM HASIL REVISI"),
                          icon: const Icon(Icons.check),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size(double.infinity, 50)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  //PENDIDIKAN TERAKHIR
  Widget buildPendidikanTerakhir() => Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            "PENDIDIKAN TERAKHIR",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Pendidikan Terakhir",
              labelStyle: TextStyle(fontSize: 13),
            ),
            textCapitalization: TextCapitalization.words,
            controller: _pendidikanTerakhir,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 13),
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Lembaga Pendidikan",
              labelStyle: TextStyle(fontSize: 13),
            ),
            textCapitalization: TextCapitalization.words,
            controller: _lembagaPendidikan,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 13),
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Nomor Ijasah",
              labelStyle: TextStyle(fontSize: 13),
            ),
            textCapitalization: TextCapitalization.words,
            controller: _noIjasah,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 13),
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 1),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Tanggal Ijasah",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglIjasah1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(fontSize: 13),
            onTap: () async {
              DateTime? newDateIjasah = await showDatePicker(
                context: context,
                initialDate: _tglIjasah.text != ""
                    ? DateTime.parse(_tglIjasah.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateIjasah != null) {
                setState(() {
                  _tglIjasah.text =
                      DateFormat("yyyy-MM-dd").format(newDateIjasah);
                  _tglIjasah1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateIjasah);
                });
              }
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          scanIjasah != null
              ? Wrap(
                  children: scanIjasah!.map((imageone) {
                    return Card(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(File(imageone.path)),
                      ),
                    );
                  }).toList(),
                )
              : _dokIjasah.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokIjasah.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getIjasah(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokIjasah,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokIjasah.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //SERTIFIKAT KOMPETENSI
  Widget buildSertKomptensi() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SERTIFIKAT KOMPETENSI",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Nomor Sertifikat",
              labelStyle: TextStyle(fontSize: 13),
            ),
            controller: _sertKompetensi,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(fontSize: 13),
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 13),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Tanggal Sertifikat",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglSertKompetensi1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(fontSize: 13),
            onTap: () async {
              DateTime? newDateSertifikat = await showDatePicker(
                context: context,
                initialDate: _tglSertKompetensi.text != ""
                    ? DateTime.parse(_tglSertKompetensi.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateSertifikat != null) {
                setState(() {
                  _tglSertKompetensi.text =
                      DateFormat("yyyy-MM-dd").format(newDateSertifikat);
                  _tglSertKompetensi1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateSertifikat);
                });
              }
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          scanSertifikat != null
              ? Wrap(
                  children: scanSertifikat!.map((imageone) {
                    return Card(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(File(imageone.path)),
                      ),
                    );
                  }).toList(),
                )
              : _dokSertKompetensi.text != ""
                  ? Wrap(children: [
                      for (String im
                          in jsonDecode(_dokSertKompetensi.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSertifikat(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokSertKompetensi,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokSertKompetensi.text == '')
            const Text("Dokumen wajib diunggah"),
        ],
      );

  //SURAT TANDA REGISTER
  Widget buildStr() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT TANDA REGISTER (STR)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _strNo,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Nomor STR",
              labelStyle: TextStyle(fontSize: 13),
            ),
            style: const TextStyle(fontSize: 13),
            validator: (value) {
              if (value == "") {
                return 'Nomor STR diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "STR Berlaku Sampai",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _strBerlaku1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(fontSize: 13),
            onTap: () async {
              DateTime? newDateBerlakuStr = await showDatePicker(
                context: context,
                initialDate: _strBerlaku.text != ""
                    ? DateTime.parse(_strBerlaku.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateBerlakuStr != null) {
                setState(() {
                  _strBerlaku.text =
                      DateFormat("yyyy-MM-dd").format(newDateBerlakuStr);
                  _strBerlaku1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateBerlakuStr);
                });
              }
            },
            validator: (value) {
              if (value == "") {
                return 'Masa berlaku STR diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          DropdownSearch<StrModels>(
            asyncItems: (String filter) async {
              var response = await http.get(
                Uri.parse(
                    "$baseUrl/api/fasyankes-str?key=${ApiContainer.baseKey}"),
              );

              if (response.statusCode != 200) {
                errorData();
                return [];
              } else {
                List str = (json.decode(response.body)
                    as Map<String, dynamic>)["data"];

                List<StrModels> strList = [];

                for (var element in str) {
                  strList.add(StrModels.fromJson(element));
                }

                return strList;
              }
            },
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  item.asal,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              fit: FlexFit.loose,
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Dikeluarkan Oleh",
                labelStyle: TextStyle(fontSize: 13),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _strAsal.text = value?.asal ?? "";
              });
            },
            selectedItem: StrModels(
              asal: _strAsal.text,
            ),
            dropdownBuilder: (context, selectedItem) => Text(
              selectedItem?.asal ?? "",
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
            validator: (value) {
              if (value?.asal == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Tanggal STR",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _strTanggal1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(fontSize: 13),
            onTap: () async {
              DateTime? newDateStrTanggal = await showDatePicker(
                context: context,
                initialDate: _strTanggal.text != ""
                    ? DateTime.parse(_strTanggal.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateStrTanggal != null) {
                setState(() {
                  _strTanggal.text =
                      DateFormat("yyyy-MM-dd").format(newDateStrTanggal);

                  _strTanggal1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateStrTanggal);
                });
              }
            },
            validator: (value) {
              if (value == "") {
                return 'Tanggal wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          scanStr != null
              ? Wrap(
                  children: scanStr!.map((imageone) {
                    return Card(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(File(imageone.path)),
                      ),
                    );
                  }).toList(),
                )
              : _dokStr.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokStr.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getStr(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokStr,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokStr.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //REKOM ORGANISASI PROFESI
  Widget buildRekomOp() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "REKOMENDASI ORGANISASI PROFESI",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Nomor Rekomendasi",
              labelStyle: TextStyle(fontSize: 13),
            ),
            controller: _rekomOp,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(fontSize: 13),
            validator: (value) {
              if (value == "") {
                return 'Nomor Rekom wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Tanggal Rekomendasi",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglRekomOp1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(fontSize: 13),
            onTap: () async {
              DateTime? newdateRekomOP = await showDatePicker(
                context: context,
                initialDate: _tglRekomOp.text != ""
                    ? DateTime.parse(_tglRekomOp.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newdateRekomOP != null) {
                setState(() {
                  _tglRekomOp.text =
                      DateFormat("yyyy-MM-dd").format(newdateRekomOP);

                  _tglRekomOp1.text =
                      DateFormat("d MMMM yyyy", "id").format(newdateRekomOP);
                });
              }
            },
            validator: (value) {
              if (value == "") {
                return 'Tanggal rekom wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          scanRekomOp != null
              ? Wrap(
                  children: scanRekomOp!.map((imageone) {
                    return Card(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(File(imageone.path)),
                      ),
                    );
                  }).toList(),
                )
              : _dokRekomOp.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokRekomOp.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getRekomOp(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokRekomOp,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokRekomOp.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //SURAT KETERANGAN SEHAT
  Widget buildKetSehat() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT KETERANGAN SEHAT DARI DOKTER YANG MEMILIKI SURAT IZIN PRAKTIK",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanKetSehat != null
              ? Wrap(
                  children: scanKetSehat!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokKetSehat.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokKetSehat.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getKetSehat(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokKetSehat,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokKetSehat.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //SURAT PATUH KEFARMASIAN
  Widget buildPatuhFarmasi() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT PERNYATAAN AKAN MEMATUHI DAN MELAKSANAKAN KETENTUAN ETIKA KEFARMASIAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanSuperPatuh != null
              ? Wrap(
                  children: scanSuperPatuh!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokSuperPatuh.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokSuperPatuh.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuperPatuh(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokSuperPatuh,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokSuperPatuh.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //SURAT PERNYATAAN MEMILIKI TEMPAT PRAKTIK
  Widget buildTempatPraktik() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT PERNYATAAN MEMPUNYAI TEMPAT PRAKTIK/KERJA DI FASILITAS PELAYANAN KESEHATAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanSuperPraktik != null
              ? Wrap(
                  children: scanSuperPraktik!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokSuperPraktik.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokSuperPraktik.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuperPraktik(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokSuperPraktik,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokSuperPraktik.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //SURAT KETERANGAN PIMPINAN FASYANKES
  Widget buildKetPimpinanFasyankes() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT KETERANGAN DARI PIMPINAN FASILITAS PELAYANAN KESEHATAN SEBAGAI TEMPAT PRAKTI/BEKERJA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanSuketPraktik != null
              ? Wrap(
                  children: scanSuketPraktik!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokSuketFasyankes.text != ""
                  ? Wrap(children: [
                      for (String im
                          in jsonDecode(_dokSuketFasyankes.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuketPraktik(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokSuketPraktik,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokSuketPraktik.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //SURAT PERSETUJUAN ATASAN
  Widget buildPersetujuanAtasan() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT PERSETUJUAN DARI ATASAN LANGSUNG BAGI YANG BEKERJA PADA INSTANSI/FASILITAS PELAYANAN KESEHATAN PEMERINTAH ATAU PADA INSTANSI/FASILITAS PELAYANAN KESEHATAN LAIN SECARA PURNA WAKTU",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanSuperAtasan != null
              ? Wrap(
                  children: scanSuperAtasan!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokSuperAtasan.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokSuperAtasan.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuperAtasan(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokSuperAtasan,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokSuperAtasan.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //SURAT KETERANGAN KOMITE INTERNSHIP
  Widget buildKomiteInternship() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT KETERANGAN DARI KOMITE INTERNSIP DOKTER INDONESIA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanSuketIntern != null
              ? Wrap(
                  children: scanSuketIntern!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokSuketIntern.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokSuketIntern.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuketIntern(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokSuketIntern,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokSuketIntern.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //IZIN FASYANKES SEBELUM
  Widget buildFasyankesSebelum() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT IZIN DARI FASYANKES SEBELUMNYA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanIzinSebelum != null
              ? Wrap(
                  children: scanIzinSebelum!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokIzinSebelum.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokIzinSebelum.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getIzinSebelum(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokIzinSebelum,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokIzinSebelum.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  //REKOMENDASI DINKES
  Widget buildRekomendasiDinkes() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "REKOMENDASI DINAS KESEHATAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "(KOSONGKAN APABILA BELUM ADA)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Nomor Rekomendasi",
              labelStyle: TextStyle(fontSize: 13),
            ),
            controller: _nomorRekomDinkes,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Tanggal Rekomendasi",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglRekomDinkes1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(fontSize: 13),
            onTap: () async {
              DateTime? newdateRekomDinkes = await showDatePicker(
                context: context,
                initialDate: _tglRekomDinkes.text != ""
                    ? DateTime.parse(_tglRekomDinkes.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newdateRekomDinkes != null) {
                setState(() {
                  _tglRekomDinkes.text =
                      DateFormat("yyyy-MM-dd").format(newdateRekomDinkes);

                  _tglRekomDinkes1.text = DateFormat("d MMMM yyyy", "id")
                      .format(newdateRekomDinkes);
                });
              }
            },
          ),
          const SizedBox(height: 15),
          scanRekomDinkes != null
              ? Wrap(
                  children: scanRekomDinkes!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokRekomDinkes.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokRekomDinkes.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getRekomDinkes(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      );

  //IZIN LAMA UNTUK PERPANJANGAN
  Widget buildIzinLama() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SIP LAMA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _lamaNomor,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Nomor Izin",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Nomor Izin wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _lamaAn,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Atas Nama",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Atas nama wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              labelText: "Tanggal SIP",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _lamaTanggal1,
            autocorrect: false,
            readOnly: true,
            onTap: () async {
              DateTime? newDateLahir = await showDatePicker(
                context: context,
                initialDate: _lamaTanggal.text != ""
                    ? DateTime.parse(_lamaTanggal.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateLahir != null) {
                setState(() {
                  _lamaTanggal.text =
                      DateFormat("yyyy-MM-dd").format(newDateLahir);

                  _lamaTanggal1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateLahir);
                });
              }
            },
            validator: (value) {
              if (value == "") {
                return 'Tanggal SIP wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              labelText: "Berlaku Sampai",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _lamaBerlaku1,
            autocorrect: false,
            readOnly: true,
            onTap: () async {
              DateTime? newDateLahir = await showDatePicker(
                context: context,
                initialDate: _lamaBerlaku.text != ""
                    ? DateTime.parse(_lamaBerlaku.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateLahir != null) {
                setState(() {
                  _lamaBerlaku.text =
                      DateFormat("yyyy-MM-dd").format(newDateLahir);

                  _lamaBerlaku1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateLahir);
                });
              }
            },
            validator: (value) {
              if (value == "") {
                return 'Tanggal Berlaku wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          scanSipLama != null
              ? Wrap(
                  children: scanSipLama!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokSipLama.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokSipLama.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSipLama(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokSipLama,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokSipLama.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  Widget buildImb() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "IZIN MENDIRIKAN BANGUNAN (IMB) / PERSETUJUAN BANGUNAN GEDUNG (PBG)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _imbNomor,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Nomor IMB",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Nomor IMB wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          scanImb != null
              ? Wrap(
                  children: scanImb!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : _dokImb.text != ""
                  ? Wrap(children: [
                      for (String im in jsonDecode(_dokImb.text)) ...[
                        Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              im,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ])
                  : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getImb(),
              icon: const Icon(
                Icons.upload,
                size: 13,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokImb,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokImb.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  Widget buildSppl() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT PERNYATAAN KESANGGUPAN PENGELOLAAN DAN PEMANTAUAN LINGKUNGAN HIDUP (SPPL)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          IntrinsicHeight(
            child: SfPdfViewer.network(
                "$baseUrl/dokumen/permohonan/nakes/temp/${_uidPemohon.text}.pdf"),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(
                      "$baseUrl/dokumen/permohonan/nakes/temp/${_uidPemohon.text}.pdf"),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file.';
                }
              },
              icon: const Icon(Icons.download),
              label: const Text("DOWNLOAD"),
            ),
          ),
        ],
      );
}
