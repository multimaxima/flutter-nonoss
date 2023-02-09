import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_container.dart';
import '../models/jenis_nakes.dart';
import '../models/fasyankes_kategori.dart';
import '../models/fasyankes.dart';
import '../models/propinsi.dart';
import '../models/kota.dart';
import '../models/kecamatan.dart';
import '../models/desa.dart';
import '../models/negara.dart';
import '../models/fasyankes_str.dart';
import 'map_kordinat.dart';

class Nakes extends StatefulWidget {
  const Nakes({super.key});

  @override
  State<Nakes> createState() => _NakesState();
}

class _NakesState extends State<Nakes> {
  final baseUrl = ApiContainer.baseUrl;
  Map<String, dynamic> izin = {};

  final TextEditingController _idPemohon = TextEditingController();
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
  final TextEditingController _adaImb = TextEditingController();
  final TextEditingController _nokecPraktek = TextEditingController();
  final TextEditingController _nokelPraktek = TextEditingController();
  final TextEditingController _kodeposPraktek = TextEditingController();
  final TextEditingController _imbNomor = TextEditingController();
  final TextEditingController _kkprNomor = TextEditingController();
  final TextEditingController _slfNomor = TextEditingController();
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
  final TextEditingController _alamatPraktek = TextEditingController();
  final TextEditingController _dusunPraktek = TextEditingController();
  final TextEditingController _rtPraktek = TextEditingController();
  final TextEditingController _rwPraktek = TextEditingController();
  final TextEditingController _latPraktek = TextEditingController();
  final TextEditingController _lngPraktek = TextEditingController();

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
  final TextEditingController _dokKkpr = TextEditingController();
  final TextEditingController _dokSlf = TextEditingController();
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

  Future getKkpr() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanKkpr = pickedfiles;
        hapusLoader();
        setState(() {
          _dokKkpr.text = scanKkpr.toString();
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

  Future getSlf() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSlf = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSlf.text = scanSlf.toString();
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
  int? tempatpraktek;
  int? mandiri;
  int? idKategori;
  String? kategori;
  String? kecamatan;
  String? idKel;
  String? desa;
  String? strOleh;

  String? perpanjangan;

  int? idDataFasyankes;
  String? namaFasyankes;

  String? latFasyankes;
  String? lngFasyankes;

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
  String? disclaimer;

  Future getUser() async {
    loadingData();

    var result = await getUserNakes();

    if (result.statusCode == 200) {
      hapusLoader();
      var data = json.decode(result.body)["data"];

      setState(() {
        _idPemohon.text = data["id"].toString();
        _uidPemohon.text = data["uid"] ?? "";
        _namaPemohon.text = data["nama"] ?? "";
        _gelarDepan.text = data["gelar_depan"] ?? "";
        _gelarBelakang.text = data["gelar_belakang"] ?? "";
        _alamatPemohon.text = data["alamat"] ?? "";
        _dusunPemohon.text = data["dusun"] ?? "";
        _rtPemohon.text = data["rt"] ?? "";
        _rwPemohon.text = data["rw"] ?? "";
        _nopropPemohon.text = data["NO_PROP"] ?? "";
        _nokabPemohon.text = data["NO_KAB"] ?? "";
        _nokecPemohon.text = data["NO_KEC"] ?? "";
        _nokelPemohon.text = data["NO_KEL"] ?? "";
        _propinsiPemohon.text = data["propinsi"] ?? "";
        _kotaPemohon.text = data["kota"] ?? "";
        _kecamatanPemohon.text = data["kecamatan"] ?? "";
        _desaPemohon.text = data["kelurahan"] ?? "";
        _kodeposPemohon.text = data["kodepos"] ?? "";
        _latPemohon.text = data["lat"] ?? "";
        _lngPemohon.text = data["lng"] ?? "";
        _tempLahirPemohon.text = data["temp_lahir"] ?? "";
        _tglLahirPemohon.text = data["tgl_lahir"] ?? "";
        _tglLahirPemohon1.text = _tglLahirPemohon.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglLahirPemohon.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());

        _kelaminPemohon.text = data["kelamin"].toString();
        _jenisKelaminPemohon.text = data["kelamin"] == 1
            ? 'LAKI-LAKI'
            : data["kelamin"] == 2
                ? 'PEREMPUAN'
                : '';
        _pekerjaanPemohon.text = data["pekerjaan"] ?? "";
        _wniPemohon.text = data["warganegara"].toString();
        _negaraPemohon.text = data["negara"] ?? "";
        _jenisWniPemohon.text = data["warganegara"] == 1
            ? 'INDONESIA'
            : data["warganegara"] == 2
                ? 'ASING'
                : '';
        _hpPemohon.text = data["hp"] ?? "";
        _waPemohon.text = data["whatsapp"] ?? "";
        _emailPemohon.text = data["email"] ?? "";
        _nikPemohon.text = data["nik"] ?? "";
        _fotoPemohon.text = data["foto"] ?? "";
        _ktpPemohon.text = data["dok_ktp"] ?? "";

        _pendidikanTerakhir.text = json.decode(result.body)["pendidikan"];
        _lembagaPendidikan.text = json.decode(result.body)["lembaga"];
        _noIjasah.text = json.decode(result.body)["no_ijasah"];
        _tglIjasah.text = data["tgl_ijasah"] ?? "";

        _tglIjasah1.text = _tglIjasah.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglIjasah.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());

        _dokIjasah.text = data["dok_ijasah"] ?? "";
        _sertKompetensi.text = data["sert_kompetensi"] ?? "";
        _tglSertKompetensi.text = data["tgl_sert_kompetensi"] ?? "";
        _tglSertKompetensi1.text = _tglSertKompetensi.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglSertKompetensi.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());
        _dokSertKompetensi.text = data["dok_sert_kompetensi"] ?? "";

        _strNo.text = json.decode(result.body)["str_no"];
        _strBerlaku.text = json.decode(result.body)["str_berlaku"];
        _strBerlaku1.text = _strBerlaku.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_strBerlaku.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());

        _strTanggal.text = json.decode(result.body)["str_tgl"];
        _strTanggal1.text = _strTanggal.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_strTanggal.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());
        _strAsal.text = data["str_asal"] ?? "";
        _dokStr.text = data["dok_str"] ?? "";
        _rekomOp.text = data["rekom_op"] ?? "";
        _tglRekomOp.text = data["tgl_rekom_op"] ?? "";
        _tglRekomOp1.text = _tglRekomOp.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglRekomOp.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());
        _dokRekomOp.text = data["dok_rekom_op"] ?? "";
      });
    } else {
      hapusLoader();
      errorPesan("Gagal mendapatkan data pemohon");
      Get.offAllNamed("/home");
    }
  }

  void cekIzinNakes(String uid, String idIzinNakes, String perpanjangan) async {
    loadingData();
    var result = await http.get(Uri.parse(
        "$baseUrl/api/nakes-cek?uid=$uid&id_izin_nakes=$idIzinNakes&perpanjangan=$perpanjangan&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();
      var data = json.decode(result.body);

      setState(() {
        if (data["message"].toString() == "lanjut") {
          isTerbatas = true;
        } else {
          isTerbatas = false;
        }
      });
    } else {
      hapusLoader();
      errorPesan("Terjadi kegagalan koneksi, silahkan ulangi kembali.");
    }
  }

  Future getNakes(String uid, String idIzinNakes, String tempatPraktik) async {
    loadingData();

    var result = await http.get(Uri.parse(
        "$baseUrl/api/nakes-dokumen?uid=$uid&id_nakes=$idIzinNakes&temp_praktik=$tempatPraktik&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();
      var data = json.decode(result.body);

      setState(() {
        varPendTerakhir = data["pend_terakhir"];
        varNoSertifikat = data["no_sertifikat"];
        varNoStr = data["no_str"];
        varNoRekomOp = data["no_rekom_op"];
        varKetSehat = data["ket_sehat"];
        varSpMematuhi = data["sp_mematuhi"];
        varSpTempPraktek = data["sp_temp_praktek"];
        varSkFasyankes = data["sk_fasyankes"];
        varSpAtasan = data["sp_atasan"];
        varSkKomiteInterensif = data["sk_komite_interensif"];
        varRekomDinkes = data["rekom_dinkes"];
        varSuratIzinSebelum = data["surat_izin_sebelum"];
        varSebelum = data["sebelum"];
        varCekFasyankes = data["cek_fasyankes"];
      });
    } else {
      hapusLoader();
      errorPesan("Terjadi kegagalan koneksi, silahkan ulangi kembali.");
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    initializeDateFormatting();
  }

  @override
  void dispose() {
    super.dispose();
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
                    const SizedBox(height: 10),
                    const Text(
                      "PAS FOTO PEMOHON\n(UNTUK SK)",
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
                        icon: const Icon(Icons.upload, size: 18),
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
                    const SizedBox(height: 5),
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
                    const SizedBox(height: 5),
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
                          style: TextStyle(fontSize: 13),
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
                              "uid": _uidPemohon.text,
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
                              "kodepos": _kodeposPemohon.text,
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

                            var request = http.MultipartRequest(
                                'POST', Uri.parse("$baseUrl/api/nakes-user"));

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
                    DropdownSearch<Map<String, dynamic>>(
                      items: const [
                        {"id": 0, "jenis": "PERMOHONAN IZIN BARU"},
                        {"id": 1, "jenis": "PERPANJANGAN IZIN LAMA"},
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Status Permohonan",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      enabled: isPerpanjangan,
                      selectedItem: {
                        "id": _perpanjangan.text,
                        "jenis": perpanjangan ?? "",
                      },
                      onChanged: (value) {
                        setState(() {
                          _perpanjangan.text = value?["id"].toString() ?? "";
                          perpanjangan = value?["jenis"];
                          isPerpanjangan = false;
                        });
                      },
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            item["jenis"].toString(),
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?["jenis"].toString().toUpperCase() ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?["id"].toString() == "") {
                          return 'Status permohonan wajib diisi';
                        }
                        return null;
                      },
                    ),
                    if (_perpanjangan.text != "") ...[
                      const SizedBox(height: 5),
                      DropdownSearch<JenisNakesModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/jenis-nakes?key=${ApiContainer.baseKey}"),
                          );

                          if (response.statusCode != 200) {
                            errorData();
                            return [];
                          } else {
                            izin = json.decode(response.body)["izin"];
                            disclaimer = izin["disclaimer"].toString();
                            List jenisNakes = (json.decode(response.body)
                                as Map<String, dynamic>)["data"];

                            List<JenisNakesModels> jenisNakesList = [];

                            for (var element in jenisNakes) {
                              jenisNakesList
                                  .add(JenisNakesModels.fromJson(element));
                            }

                            return jenisNakesList;
                          }
                        },
                        enabled: isIdNakes,
                        popupProps: PopupProps.dialog(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              '${item.izin.toString().toUpperCase()} (${item.kode.toString().toUpperCase()})',
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Jenis Izin",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        selectedItem: JenisNakesModels(
                          id: int.tryParse(_idIzinNakes.text),
                          izin: nakesIzin ?? "",
                          kode: nakesKode ?? "",
                          fasyankes: idFasyankes,
                          mandiri: idMandiri,
                          distribusi: idDistribusi,
                          produksi: idProduksi,
                        ),
                        onChanged: (value) {
                          setState(() {
                            nakesIzin = value?.izin;
                            nakesKode = value?.kode;
                            idFasyankes = value?.fasyankes;
                            idMandiri = value?.mandiri;
                            idDistribusi = value?.distribusi;
                            idProduksi = value?.produksi;
                            _idIzinNakes.text = value?.id.toString() as String;
                            isIdNakes = false;

                            cekIzinNakes(_uidPemohon.text, _idIzinNakes.text,
                                _perpanjangan.text);
                          });
                        },
                        dropdownBuilder: (context, selectedItem) => Text(
                          "${selectedItem?.izin.toString().toUpperCase()} (${selectedItem?.kode.toString().toUpperCase()})",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?.id == null) {
                            return 'Jenis nakes wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                    if (_idIzinNakes.text != "" && isTerbatas == true) ...[
                      const SizedBox(height: 5),
                      DropdownSearch<Map<String, dynamic>>(
                        items: [
                          if (idMandiri == 1)
                            {"praktek": "MANDIRI", "mandiri": 1, "id": 1},
                          if (idFasyankes == 1)
                            {"praktek": "FASYANKES", "mandiri": 0, "id": 2},
                          if (idDistribusi == 1)
                            {"praktek": "DISTRIBUSI", "mandiri": 0, "id": 3},
                          if (idProduksi == 1)
                            {"praktek": "PRODUKSI", "mandiri": 0, "id": 4}
                        ],
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Tempat Praktik",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        enabled: isKategoriNakes,
                        onChanged: (value) {
                          setState(() {
                            tempatpraktek = value?["id"];
                            praktek = value?["praktek"];
                            mandiri = value?["mandiri"];

                            _tempatPraktek.text = tempatpraktek.toString();
                            isKategoriNakes = false;
                          });
                        },
                        selectedItem: {
                          "praktek": praktek ?? "",
                          "mandiri": mandiri,
                          "id": tempatpraktek,
                        },
                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              item["praktek"],
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?["praktek"] ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?["id"] == null) {
                            return 'Tempat praktik wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                    if (isTerbatas == false) ...[
                      const SizedBox(height: 15),
                      const Text(
                        "Mohon maaf, jumlah izin yang Anda miliki telah mencapai batas maksimal yang telah ditentukan",
                      )
                    ],
                    if (tempatpraktek != null &&
                        tempatpraktek != 1 &&
                        isTerbatas == true) ...[
                      const SizedBox(height: 5),
                      DropdownSearch<FasyankesKategoriModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/fasyankes-kategori?jenis=$praktek&key=${ApiContainer.baseKey}"),
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
                          id: idKategori,
                          kategori: kategori ?? "",
                        ),
                        onChanged: (value) {
                          setState(() {
                            idKategori = value?.id;
                            kategori = value?.kategori;
                            isKategoriFasyankes = false;
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
                      if (idKategori != null) ...[
                        const SizedBox(height: 5),
                        DropdownSearch<FasyankesModels>(
                          asyncItems: (String filter) async {
                            var response = await http.get(
                              Uri.parse(
                                  "$baseUrl/api/fasyankes?id_kategori=$idKategori&key=${ApiContainer.baseKey}"),
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
                            id: idDataFasyankes,
                            nama: namaFasyankes ?? "",
                            lat: latFasyankes,
                            lng: lngFasyankes,
                          ),
                          onChanged: (value) {
                            setState(() {
                              idDataFasyankes = value?.id;
                              namaFasyankes = value?.nama;
                              latFasyankes = value?.lat;
                              lngFasyankes = value?.lng;

                              _idFasyankes.text = idDataFasyankes.toString();
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
                    if (tempatpraktek != null && tempatpraktek == 1) ...[
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
                      const SizedBox(height: 5),
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
                            kecamatan = value?.namaKec;

                            _nokelPraktek.text = "";
                            desa = "";
                          });
                        },
                        selectedItem: KecamatanModels(
                          noKec: _nokecPraktek.text,
                          namaKec: kecamatan,
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
                              desa = value?.namaKel;
                            });
                          },
                          selectedItem: DesaModels(
                            noKel: _nokelPraktek.text,
                            namaKel: desa,
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
                                    'KORDINAT TEMPAT PRAKTIK',
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

                              getNakes(_uidPemohon.text, _idIzinNakes.text,
                                  tempatpraktek.toString());

                              if (tempatpraktek == 1) {
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
            Step(
              isActive: currentStep >= 2,
              state: currentStep >= 2 ? StepState.disabled : StepState.complete,
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
                    if (varSkFasyankes == 1 && tempatpraktek != 1)
                      buildKetPimpinanFasyankes(),
                    if (varSpAtasan == 1 && varSebelum! > 0)
                      buildPersetujuanAtasan(),
                    if (varSkKomiteInterensif == 1) buildKomiteInternship(),
                    if (varSuratIzinSebelum == 1 &&
                        varCekFasyankes != 0 &&
                        tempatpraktek != 1)
                      buildFasyankesSebelum(),
                    if (_perpanjangan.text == "1") buildIzinLama(),
                    if (tempatpraktek == 1) ...[
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
                            Get.dialog(
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView(
                                    children: [
                                      const SizedBox(height: 15),
                                      const Text(
                                        "SYARAT & KETENTUAN",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Html(
                                        data: ("$disclaimer"),
                                        style: {
                                          "ol": Style(
                                            fontSize: const FontSize(13),
                                          ),
                                          "li": Style(
                                            fontSize: const FontSize(13),
                                          ),
                                        },
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      const Text(
                                        "Dengan ini saya menyatakan bahwa saya bersedia dan sanggup untuk mematuhi semua peraturan dan ketentuan yang berlaku.",
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.justify,
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () async {
                                            if (_dokumenKey.currentState!
                                                    .validate() &&
                                                isPermohonanKirim == true) {
                                              isPermohonanKirim == false;

                                              loadingData();

                                              Map<String, String> headers = {
                                                'Content-Type':
                                                    'multipart/form-data',
                                              };

                                              Map<String, String> body = {
                                                "key": ApiContainer.baseKey,
                                                "uid": _uidPemohon.text,
                                                "id_izin": "2",
                                                "id_izin_nakes":
                                                    _idIzinNakes.text,
                                                "pendidikan_terakhir":
                                                    _pendidikanTerakhir.text,
                                                "lembaga_pendidikan":
                                                    _lembagaPendidikan.text,
                                                "no_ijasah": _noIjasah.text,
                                                "tgl_ijasah": _tglIjasah.text,
                                                "sert_kompetensi":
                                                    _sertKompetensi.text,
                                                "tgl_sert_kompetensi":
                                                    _tglSertKompetensi.text,
                                                "str_no": _strNo.text,
                                                "str_berlaku": _strBerlaku.text,
                                                "str_asal": _strAsal.text,
                                                "str_tanggal": _strTanggal.text,
                                                "rekom_op": _rekomOp.text,
                                                "tgl_rekom_op":
                                                    _tglRekomOp.text,
                                                "temp_praktik":
                                                    _tempatPraktek.text,
                                                "id_fasyankes":
                                                    _idFasyankes.text,
                                                "ada_imb": _adaImb.text,
                                                "alamat_praktik":
                                                    _alamatPraktek.text,
                                                "dusun": _dusunPraktek.text,
                                                "rt": _rtPraktek.text,
                                                "rw": _rwPraktek.text,
                                                "no_kec": _nokecPraktek.text,
                                                "no_kel": _nokelPraktek.text,
                                                "kodepos": _kodeposPraktek.text,
                                                "lat": _latPraktek.text,
                                                "lng": _lngPraktek.text,
                                                "imb_no": _imbNomor.text,
                                                "kkpr_no": _kkprNomor.text,
                                                "slf_no": _slfNomor.text,
                                                "perpanjangan":
                                                    _perpanjangan.text,
                                                "lama_nomor": _lamaNomor.text,
                                                "lama_tanggal":
                                                    _lamaTanggal.text,
                                                "lama_berlaku":
                                                    _lamaBerlaku.text,
                                                "lama_an": _lamaAn.text,
                                                "catatan": _catatan.text,
                                                "rekom_dinkes_no":
                                                    _nomorRekomDinkes.text,
                                                "rekom_dinkes_tgl":
                                                    _tglRekomDinkes.text,
                                              };

                                              var request = http.MultipartRequest(
                                                  'POST',
                                                  Uri.parse(
                                                      "$baseUrl/api/nakes-kirim"));

                                              request.headers.addAll(headers);
                                              request.fields.addAll(body);

                                              if (scanIjasah != null) {
                                                for (int i = 0;
                                                    i < scanIjasah!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_ijasah[]',
                                                          File(scanIjasah![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanIjasah![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanSertifikat != null) {
                                                for (int i = 0;
                                                    i < scanSertifikat!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_sert_kompetensi[]',
                                                          File(scanSertifikat![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanSertifikat![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanStr != null) {
                                                for (int i = 0;
                                                    i < scanStr!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
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
                                                for (int i = 0;
                                                    i < scanRekomOp!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_rekom_op[]',
                                                          File(scanRekomOp![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanRekomOp![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanKetSehat != null) {
                                                for (int i = 0;
                                                    i < scanKetSehat!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'ket_sehat[]',
                                                          File(scanKetSehat![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanKetSehat![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanSuperPatuh != null) {
                                                for (int i = 0;
                                                    i < scanSuperPatuh!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'sp_mematuhi[]',
                                                          File(scanSuperPatuh![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanSuperPatuh![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanSuperPraktik != null) {
                                                for (int i = 0;
                                                    i <
                                                        scanSuperPraktik!
                                                            .length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'sp_temp_praktek[]',
                                                          File(scanSuperPraktik![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanSuperPraktik![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanSuketPraktik != null) {
                                                for (int i = 0;
                                                    i <
                                                        scanSuketPraktik!
                                                            .length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'sk_fasyankes[]',
                                                          File(scanSuketPraktik![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanSuketPraktik![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanSuperAtasan != null) {
                                                for (int i = 0;
                                                    i < scanSuperAtasan!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'sp_atasan[]',
                                                          File(scanSuperAtasan![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanSuperAtasan![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanSuketIntern != null) {
                                                for (int i = 0;
                                                    i < scanSuketIntern!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'sk_komite_interensif[]',
                                                          File(scanSuketIntern![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanSuketIntern![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanIzinSebelum != null) {
                                                for (int i = 0;
                                                    i < scanIzinSebelum!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'surat_izin_sebelum[]',
                                                          File(scanIzinSebelum![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanIzinSebelum![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanSuketFasyankes != null) {
                                                for (int i = 0;
                                                    i <
                                                        scanSuketFasyankes!
                                                            .length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'sk_fasyankes[]',
                                                          File(scanSuketFasyankes![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanSuketFasyankes![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanRekomDinkes != null) {
                                                for (int i = 0;
                                                    i < scanRekomDinkes!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'rekom_dinkes[]',
                                                          File(scanRekomDinkes![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanRekomDinkes![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanSipLama != null) {
                                                for (int i = 0;
                                                    i < scanSipLama!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'lama_dok[]',
                                                          File(scanSipLama![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanSipLama![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanImb != null) {
                                                for (int i = 0;
                                                    i < scanImb!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
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
                                                    i <
                                                        scanPernyataanImb!
                                                            .length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_pernyataan_imb[]',
                                                          File(scanPernyataanImb![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanPernyataanImb![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanKkpr != null) {
                                                for (int i = 0;
                                                    i < scanKkpr!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_kkpr[]',
                                                          File(scanKkpr![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename: scanKkpr![i]
                                                              .path
                                                              .split("/")
                                                              .last));
                                                }
                                              }

                                              if (scanSlf != null) {
                                                for (int i = 0;
                                                    i < scanSlf!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_slf[]',
                                                          File(scanSlf![i].path)
                                                              .readAsBytesSync(),
                                                          filename: scanSlf![i]
                                                              .path
                                                              .split("/")
                                                              .last));
                                                }
                                              }

                                              //var response = await request.send();
                                              http.Response response =
                                                  await http.Response
                                                      .fromStream(
                                                          await request.send());

                                              if (response.statusCode == 200) {
                                                hapusLoader();
                                                pesanData(
                                                    "Permohonan Izin Nakes Berhasil Dikirim");
                                                Get.offAllNamed("/home");
                                              } else {
                                                hapusLoader();
                                                errorData();
                                              }
                                            } else {
                                              hapusLoader();
                                              errorPesan(
                                                  "Silahkan melengkapi semua data");
                                            }
                                          },
                                          label: const Text('KIRIM PERMOHONAN'),
                                          icon: const Icon(Icons.check),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            minimumSize:
                                                const Size(double.infinity, 50),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        label: const Text("KIRIM PERMOHONAN"),
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
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Pendidikan Terakhir",
              labelStyle: TextStyle(fontSize: 13),
            ),
            controller: _pendidikanTerakhir,
            style: const TextStyle(
              fontSize: 13,
            ),
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
            controller: _lembagaPendidikan,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(
              fontSize: 13,
            ),
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
            controller: _noIjasah,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(
              fontSize: 13,
            ),
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
              labelText: "Tanggal Ijasah",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglIjasah1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(
              fontSize: 13,
            ),
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
                        height: 120,
                        width: 90,
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
                            height: 120,
                            width: 90,
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
                size: 18,
              ),
              label: const Text(
                "UNGGAH DOKUMEN",
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
            style: const TextStyle(
              fontSize: 13,
            ),
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
              labelText: "Tanggal Sertifikat",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglSertKompetensi1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(
              fontSize: 13,
            ),
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
                        height: 120,
                        width: 90,
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
                            height: 120,
                            width: 90,
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
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
            style: const TextStyle(
              fontSize: 13,
            ),
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
              labelText: "Tanggal STR",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _strTanggal1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(
              fontSize: 13,
            ),
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
            style: const TextStyle(
              fontSize: 14,
            ),
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
          const SizedBox(height: 15),
          scanStr != null
              ? Wrap(
                  children: scanStr!.map((imageone) {
                    return Card(
                      child: SizedBox(
                        height: 120,
                        width: 90,
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
                            height: 120,
                            width: 90,
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
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
            style: const TextStyle(
              fontSize: 13,
            ),
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
            style: const TextStyle(
              fontSize: 13,
            ),
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
                        height: 120,
                        width: 90,
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
                            height: 120,
                            width: 90,
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
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getKetSehat(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuperPatuh(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuperPraktik(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuketPraktik(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuperAtasan(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSuketIntern(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getIzinSebelum(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Tanggal Rekomendasi",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglRekomDinkes1,
            autocorrect: false,
            readOnly: true,
            style: const TextStyle(
              fontSize: 13,
            ),
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getRekomDinkes(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
          const SizedBox(height: 15),
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getSipLama(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
                          height: 120,
                          width: 90,
                          child: Image.file(File(imageone.path)),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => getImb(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: const Icon(
                Icons.upload,
                size: 18,
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
              icon: const Icon(
                Icons.download,
                size: 18,
              ),
              label: const Text(
                "DOWNLOAD",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      );
}
