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

import '../services/api_container.dart';
import '../models/propinsi.dart';
import '../models/kota.dart';
import '../models/kecamatan.dart';
import '../models/desa.dart';
import '../models/negara.dart';
import '../models/bentuk_badan_kkpr.dart';
import '../models/kategori_reklame.dart';
import '../models/jenis_reklame.dart';
import '../models/jalan.dart';
import '../models/area.dart';
import '../models/lahan.dart';
import '../models/pemohon_reklame.dart';
import 'map_kordinat.dart';

class SIPR extends StatefulWidget {
  const SIPR({super.key});

  @override
  State<SIPR> createState() => _SIPRState();
}

class _SIPRState extends State<SIPR> {
  final baseUrl = ApiContainer.baseUrl;
  String autocompletePlace = "";

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
  final TextEditingController _catatan = TextEditingController();

  final TextEditingController _idBadan = TextEditingController();
  final TextEditingController _idKetBadan = TextEditingController();
  final TextEditingController _idKodeBadan = TextEditingController();
  final TextEditingController _namaBadan = TextEditingController();
  final TextEditingController _alamatBadan = TextEditingController();
  final TextEditingController _dusunBadan = TextEditingController();
  final TextEditingController _rtBadan = TextEditingController();
  final TextEditingController _rwBadan = TextEditingController();
  final TextEditingController _nopropBadan = TextEditingController();
  final TextEditingController _propinsiBadan = TextEditingController();
  final TextEditingController _nokabBadan = TextEditingController();
  final TextEditingController _kotaBadan = TextEditingController();
  final TextEditingController _nokecBadan = TextEditingController();
  final TextEditingController _kecamatanBadan = TextEditingController();
  final TextEditingController _nokelBadan = TextEditingController();
  final TextEditingController _desaBadan = TextEditingController();
  final TextEditingController _jabatanPemohon = TextEditingController();
  final TextEditingController _noNpwp = TextEditingController();
  final TextEditingController _dokNpwp = TextEditingController();
  final TextEditingController _noNpwpd = TextEditingController();
  final TextEditingController _dokNpwpd = TextEditingController();

  final TextEditingController _idJenisPemohon = TextEditingController();
  final TextEditingController _jenisPemohon = TextEditingController();
  final TextEditingController _idKategoriReklame = TextEditingController();
  final TextEditingController _kategoriReklame = TextEditingController();
  final TextEditingController _idJenisReklame = TextEditingController();
  final TextEditingController _jenisReklame = TextEditingController();
  final TextEditingController _materiReklame = TextEditingController();
  final TextEditingController _idIklanRokok = TextEditingController();
  final TextEditingController _iklanRokok = TextEditingController();
  final TextEditingController _namaUsaha = TextEditingController();
  final TextEditingController _skBadan = TextEditingController();
  final TextEditingController _dokAkta = TextEditingController();
  final TextEditingController _nib = TextEditingController();
  final TextEditingController _dokNib = TextEditingController();

  final TextEditingController _nokecLokasi = TextEditingController();
  final TextEditingController _kecamatanLokasi = TextEditingController();
  final TextEditingController _nokelLokasi = TextEditingController();
  final TextEditingController _desaLokasi = TextEditingController();
  final TextEditingController _idJalan = TextEditingController();
  final TextEditingController _namaJalan = TextEditingController();
  final TextEditingController _nomorLokasi = TextEditingController();
  final TextEditingController _dusunLokasi = TextEditingController();
  final TextEditingController _rtLokasi = TextEditingController();
  final TextEditingController _rwLokasi = TextEditingController();
  final TextEditingController _latLokasi = TextEditingController();
  final TextEditingController _lngLokasi = TextEditingController();
  final TextEditingController _idArea = TextEditingController();
  final TextEditingController _namaArea = TextEditingController();
  final TextEditingController _idLahan = TextEditingController();
  final TextEditingController _namaLahan = TextEditingController();
  final TextEditingController _panjang = TextEditingController();
  final TextEditingController _luas = TextEditingController();
  final TextEditingController _lebar = TextEditingController();
  final TextEditingController _tinggi = TextEditingController();
  final TextEditingController _diameter = TextEditingController();
  final TextEditingController _lembar = TextEditingController();
  final TextEditingController _sisi = TextEditingController();
  final TextEditingController _sisiReklame = TextEditingController();
  final TextEditingController _posisi = TextEditingController();
  final TextEditingController _fotoDepan = TextEditingController();
  final TextEditingController _fotoBelakang = TextEditingController();
  final TextEditingController _fotoKanan = TextEditingController();
  final TextEditingController _fotoKiri = TextEditingController();
  final TextEditingController _fotoMateri = TextEditingController();
  final TextEditingController _dokLegal = TextEditingController();
  final TextEditingController _noImb = TextEditingController();
  final TextEditingController _dokImb = TextEditingController();
  final TextEditingController _noKontrak = TextEditingController();
  final TextEditingController _nilaiKontrak = TextEditingController();
  final TextEditingController _dokKontrak = TextEditingController();
  final TextEditingController _dokSewa = TextEditingController();
  final TextEditingController _dokLain = TextEditingController();
  final TextEditingController _dokPemangku = TextEditingController();
  final TextEditingController _dokAsuransi = TextEditingController();
  final TextEditingController _noKkpr = TextEditingController();
  final TextEditingController _dokKkpr = TextEditingController();

  File? fotoPemohon;
  File? ktpPemohon;
  File? npwpPemohon;
  File? npwpdPemohon;
  File? fotoDepan;
  File? fotoBelakang;
  File? fotoKanan;
  File? fotoKiri;
  List<XFile>? fotoMateri;
  List<XFile>? legalitasLahan;
  List<XFile>? dokumenPemangku;
  List<XFile>? dokumenNib;
  List<XFile>? dokumenKontrak;
  List<XFile>? dokumenImb;
  List<XFile>? dokumenKkpr;
  List<XFile>? dokumenAsuransi;
  List<XFile>? dokumenSewa;
  List<XFile>? dokumenLain;
  List<XFile>? dokumenAkta;

  bool isPemohonKirim = true;
  bool isJenisPemohon = true;
  bool isKategoriReklame = true;
  bool isJenisReklame = true;
  bool isSetuju = false;
  int currentStep = 0;

  int? varArea;
  int? varLahan;
  int? varZona;
  int? varSisi;
  int? varKetJenis;
  int? varUkuran;
  int? varTinggi;
  int? varDiameterTiang;
  int? varLembar;
  int? varItem;
  int? varKordinat;
  int? varImb;
  int? varKkpr;
  int? varAsuransi;
  int? varFotoLokasi;
  int? varFotoMateri;
  int? varNib;
  int? varNpwp;
  int? varNpwpd;
  int? varSkPenunjukan;
  double? luasBidang;
  double? panjangBidang;
  double? lebarBidang;
  String? disclaimer;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _permohonanKey = GlobalKey<FormState>();
  final _dokumenKey = GlobalKey<FormState>();

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
      errorPesan("Gagal mendapatkan gambar : $e");
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
      errorPesan("Gagal mendapatkan gambar : $e");
    }
  }

  Future getNpwp(ImageSource source) async {
    loadingData();
    try {
      final npwpPemohon = await _picker.pickImage(
        source: source,
      );

      if (npwpPemohon == null) {
        hapusLoader();
        return;
      }

      final npwpPicked = File(npwpPemohon.path);
      hapusLoader();
      setState(() {
        _dokNpwp.text = npwpPicked.toString();
        this.npwpPemohon = npwpPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Gagal mendapatkan gambar : $e");
    }
  }

  Future getNpwpd(ImageSource source) async {
    loadingData();
    try {
      final npwpdPemohon = await _picker.pickImage(
        source: source,
      );
      if (npwpdPemohon == null) {
        hapusLoader();
        return;
      }

      final npwpdPicked = File(npwpdPemohon.path);
      hapusLoader();
      setState(() {
        _dokNpwpd.text = npwpdPicked.toString();
        this.npwpdPemohon = npwpdPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Gagal mendapatkan gambar : $e");
    }
  }

  Future getDepan(ImageSource source) async {
    loadingData();
    try {
      final fotoDepan = await _picker.pickImage(
        source: source,
      );
      if (fotoDepan == null) {
        hapusLoader();
        return;
      }

      final depanPicked = File(fotoDepan.path);
      hapusLoader();
      setState(() {
        _fotoDepan.text = depanPicked.toString();
        this.fotoDepan = depanPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Gagal mendapatkan gambar : $e");
    }
  }

  Future getBelakang(ImageSource source) async {
    loadingData();
    try {
      final fotoBelakang = await _picker.pickImage(
        source: source,
      );
      if (fotoBelakang == null) {
        hapusLoader();
        return;
      }

      final belakangPicked = File(fotoBelakang.path);
      hapusLoader();
      setState(() {
        _fotoBelakang.text = belakangPicked.toString();
        this.fotoBelakang = belakangPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Gagal mendapatkan gambar : $e");
    }
  }

  Future getKanan(ImageSource source) async {
    loadingData();
    try {
      final fotoKanan = await _picker.pickImage(
        source: source,
      );
      if (fotoKanan == null) {
        hapusLoader();
        return;
      }

      final kananPicked = File(fotoKanan.path);
      hapusLoader();
      setState(() {
        _fotoKanan.text = kananPicked.toString();
        this.fotoKanan = kananPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Gagal mendapatkan gambar : $e");
    }
  }

  Future getKiri(ImageSource source) async {
    loadingData();
    try {
      final fotoKiri = await _picker.pickImage(
        source: source,
      );

      if (fotoKiri == null) {
        hapusLoader();
        return;
      }

      final kiriPicked = File(fotoKiri.path);
      hapusLoader();
      setState(() {
        _fotoKiri.text = kiriPicked.toString();
        this.fotoKiri = kiriPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Gagal mendapatkan gambar : $e");
    }
  }

  Future getMateri() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        fotoMateri = pickedfiles;
        hapusLoader();

        setState(() {
          _fotoMateri.text = fotoMateri.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getNib() async {
    loadingData();

    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        dokumenNib = pickedfiles;
        hapusLoader();

        setState(() {
          _dokNib.text = dokumenNib.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getLegalitasLahan() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        legalitasLahan = pickedfiles;
        hapusLoader();

        setState(() {
          _dokLegal.text = legalitasLahan.toString();
        });
      } else {
        hapusLoader();
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
        dokumenImb = pickedfiles;
        hapusLoader();

        setState(() {
          _dokImb.text = dokumenImb.toString();
        });
      } else {
        hapusLoader();
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
        dokumenKkpr = pickedfiles;
        hapusLoader();

        setState(() {
          _dokKkpr.text = dokumenKkpr.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getKontrak() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        dokumenKontrak = pickedfiles;
        hapusLoader();

        setState(() {
          _dokKontrak.text = dokumenKontrak.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getSewa() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        dokumenSewa = pickedfiles;
        hapusLoader();

        setState(() {
          _dokSewa.text = dokumenSewa.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getLain() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        dokumenLain = pickedfiles;
        hapusLoader();

        setState(() {
          _dokLain.text = dokumenLain.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getPemangku() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        dokumenPemangku = pickedfiles;
        hapusLoader();

        setState(() {
          _dokPemangku.text = dokumenPemangku.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getAsuransi() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        dokumenAsuransi = pickedfiles;
        hapusLoader();

        setState(() {
          _dokAsuransi.text = dokumenAsuransi.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getAkta() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        dokumenAkta = pickedfiles;
        hapusLoader();

        setState(() {
          _dokAkta.text = dokumenAkta.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getUser() async {
    loadingData();

    var result = await getUserDetil();

    if (result.statusCode == 200) {
      hapusLoader();
      var data = json.decode(result.body);

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
        _latPemohon.text = data["lat"];
        _lngPemohon.text = data["lng"];
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
        _noNpwp.text = data["npwp"] ?? "";
        _dokNpwp.text = data["dok_npwp"] ?? "";
        _noNpwpd.text = data["npwpd"] ?? "";
        _dokNpwpd.text = data["dok_npwpd"] ?? "";

        _idBadan.text = data["id_badan"].toString();
        _idKetBadan.text = data["KET"] ?? "";
        _idKodeBadan.text = data["KODE"] ?? "";
        _namaBadan.text = data["nama_badan"] ?? "";
        _alamatBadan.text = data["alamat_badan"] ?? "";
        _dusunBadan.text = data["dusun_badan"] ?? "";
        _rtBadan.text = data["rt_badan"] ?? "";
        _rwBadan.text = data["rw_badan"] ?? "";
        _nopropBadan.text = data["NO_PROP_BADAN"] ?? "";
        _propinsiBadan.text = data["propinsi_badan"] ?? "";
        _nokabBadan.text = data["NO_KAB_BADAN"] ?? "";
        _kotaBadan.text = data["kota_badan"] ?? "";
        _nokecBadan.text = data["NO_KEC_BADAN"] ?? "";
        _kecamatanBadan.text = data["kecamatan_badan"] ?? "";
        _nokelBadan.text = data["NO_KEL_BADAN"] ?? "";
        _desaBadan.text = data["kelurahan_badan"] ?? "";
        _jabatanPemohon.text = data["jabatan"] ?? "";
        _skBadan.text = data["sk_badan"] ?? "";
        _dokAkta.text = data["dok_akta"] ?? "";
        _nib.text = data["nib"] ?? "";
        _dokNib.text = data["dok_nib"] ?? "";
      });
    } else {
      hapusLoader();
      errorPesan("Gagal mendapatkan data pemohon");
      Get.offAllNamed("/home");
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            "SIPR",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Surat Izin Penyelenggaraan Reklame",
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
                    const SizedBox(height: 5),
                    DropdownSearch<PemohonReklameModels>(
                      asyncItems: (String filter) async {
                        var response = await http.get(
                          Uri.parse(
                              "$baseUrl/api/pemohon-reklame?key=${ApiContainer.baseKey}"),
                        );

                        if (response.statusCode != 200) {
                          errorData();
                          return [];
                        } else {
                          List pemohon = (json.decode(response.body)
                              as Map<String, dynamic>)["data"];

                          List<PemohonReklameModels> pemohonList = [];

                          for (var element in pemohon) {
                            pemohonList
                                .add(PemohonReklameModels.fromJson(element));
                          }

                          return pemohonList;
                        }
                      },
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            '${item.jenis}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Jenis Pemohon",
                          labelStyle: TextStyle(fontSize: 13),
                          contentPadding: EdgeInsets.only(bottom: 3),
                        ),
                      ),
                      enabled: isJenisPemohon,
                      onChanged: (value) {
                        setState(() {
                          _idJenisPemohon.text = value?.id.toString() as String;
                          _jenisPemohon.text = value?.jenis ?? "";
                          varNib = value?.nib;
                          varNpwp = value?.npwp;
                          varNpwpd = value?.npwpd;
                          varSkPenunjukan = value?.skPenunjukan;

                          isJenisPemohon = false;
                        });
                      },
                      selectedItem: PemohonReklameModels(
                        id: int.tryParse(_idJenisPemohon.text),
                        jenis: _jenisPemohon.text,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?.jenis ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?.jenis == "") {
                          return 'Jenis Pemohgon wajib diisi';
                        }
                        return null;
                      },
                    ),
                    if (_idJenisPemohon.text == "2" ||
                        _idJenisPemohon.text == "3")
                      buildPerusahaan(),
                    if (_idJenisPemohon.text != "") ...[
                      const SizedBox(height: 15),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _namaPemohon,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Nama Lengkap Pemohon",
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
                                textCapitalization: TextCapitalization.words,
                                decoration: const InputDecoration(
                                  labelText: "Gelar Depan",
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(fontSize: 13),
                                controller: _gelarBelakang,
                                textCapitalization: TextCapitalization.words,
                                decoration: const InputDecoration(
                                  labelText: "Gelar Belakang",
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
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _dusunPemohon,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Dusun/Lingkungan",
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
                              propinsiList
                                  .add(PropinsiModels.fromJson(element));
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
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
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
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
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
                        style: const TextStyle(fontSize: 14),
                        controller: _kodeposPemohon,
                        decoration: const InputDecoration(
                          labelText: "Kodepos",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      if (_idJenisPemohon.text == "1") ...[
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 14),
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
                          style: const TextStyle(fontSize: 14),
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
                                      'TENTUKAN KORDINAT RUMAH',
                                      style: TextStyle(fontSize: 12),
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
                                      final result = await Get.to(
                                          () => MapKordinat(kordinat));

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
                      ],
                      const SizedBox(height: 15),
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
                          if (value?["id"] == "null" || value?["id"] == "0") {
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
                          if (value?["id"] == "null" || value?["id"] == "0") {
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
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
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
                                          getKtp(ImageSource.camera);
                                        }),
                                    ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text(
                                            "Ambil File Dari Gallery"),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          getKtp(ImageSource.gallery);
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
                    ],
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
                              "nib": _nib.text,
                              "id_badan": _idBadan.text,
                              "nama_badan": _namaBadan.text,
                              "alamat_badan": _alamatBadan.text,
                              "dusun_badan": _dusunBadan.text,
                              "rt_badan": _rtBadan.text,
                              "rw_badan": _rwBadan.text,
                              "nopropbadan": _nopropBadan.text,
                              "nokabbadan": _nokabBadan.text,
                              "nokecbadan": _nokecBadan.text,
                              "nokelbadan": _nokelBadan.text,
                              "jabatan": _jabatanPemohon.text,
                            };

                            var request = http.MultipartRequest(
                                'POST', Uri.parse("$baseUrl/api/sipr-user"));

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
              subtitle: const Text("Rincian Permohonan Izin Reklame"),
              content: Form(
                key: _permohonanKey,
                child: Column(
                  children: [
                    DropdownSearch<KategoriReklameModels>(
                      asyncItems: (String filter) async {
                        var response = await http.get(
                          Uri.parse(
                              "$baseUrl/api/kategori-reklame?key=${ApiContainer.baseKey}"),
                        );

                        if (response.statusCode != 200) {
                          errorData();
                          return [];
                        } else {
                          List bentuk = (json.decode(response.body)
                              as Map<String, dynamic>)["data"];

                          List<KategoriReklameModels> bentukList = [];

                          for (var element in bentuk) {
                            bentukList
                                .add(KategoriReklameModels.fromJson(element));
                          }

                          return bentukList;
                        }
                      },
                      enabled: isKategoriReklame,
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            '${item.kategori}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Kategori Reklame",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _idKategoriReklame.text =
                              value?.id.toString() as String;
                          _kategoriReklame.text = value?.kategori ?? "";
                          disclaimer = value?.disclaimer ?? "";

                          isKategoriReklame = false;
                        });
                      },
                      selectedItem: KategoriReklameModels(
                        id: int.tryParse(_idKategoriReklame.text),
                        kategori: _kategoriReklame.text,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?.kategori ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?.kategori == "") {
                          return 'Kategori wajib diisi';
                        }
                        return null;
                      },
                    ),
                    if (_idKategoriReklame.text != "") ...[
                      const SizedBox(height: 5),
                      DropdownSearch<JenisReklameModels>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/jenis-reklame?kategori=${_idKategoriReklame.text}&key=${ApiContainer.baseKey}"),
                          );

                          if (response.statusCode != 200) {
                            errorData();
                            return [];
                          } else {
                            List jenis = (json.decode(response.body)
                                as Map<String, dynamic>)["data"];

                            List<JenisReklameModels> jenisList = [];

                            for (var element in jenis) {
                              jenisList
                                  .add(JenisReklameModels.fromJson(element));
                            }

                            return jenisList;
                          }
                        },
                        enabled: isJenisReklame,
                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              '${item.jenis}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Jenis Reklame",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _idJenisReklame.text =
                                value?.id.toString() as String;
                            _jenisReklame.text = value?.jenis ?? "";
                            isJenisReklame = false;

                            varArea = value?.area;
                            varLahan = value?.lahan;
                            varZona = value?.zona;
                            varSisi = value?.sisi;
                            varKetJenis = value?.ketJenis;
                            varUkuran = value?.ukuran;
                            varTinggi = value?.tinggi;
                            varDiameterTiang = value?.diameterTiang;
                            varLembar = value?.lembar;
                            varItem = value?.item;
                            varKordinat = value?.kordinat;
                            varImb = value?.imb;
                            varKkpr = value?.kkpr;
                            varAsuransi = value?.asuransi;
                            varFotoLokasi = value?.fotoLokasi;
                            varFotoMateri = value?.fotoMateri;
                          });
                        },
                        selectedItem: JenisReklameModels(
                          id: int.tryParse(_idJenisReklame.text),
                          jenis: _jenisReklame.text,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.jenis ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?.jenis == "") {
                            return 'Jenis wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                    if (_idJenisReklame.text != "") ...[
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _materiReklame,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Isi Materi Reklame",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Materi reklame wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      DropdownSearch<Map<String, dynamic>>(
                        items: const [
                          {"id": 0, "rokok": "TIDAK"},
                          {"id": 1, "rokok": "YA"},
                        ],
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Iklan Rokok",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _idIklanRokok.text =
                                value?["id"].toString() as String;
                            _iklanRokok.text = value?["rokok"] ?? "";
                          });
                        },
                        selectedItem: {
                          "id": _idIklanRokok.text,
                          "rokok": _iklanRokok.text
                        },
                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              item["rokok"],
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?["rokok"] ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?["id"] == "") {
                            return 'Iklan rokok wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _namaUsaha,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Nama Usaha",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Nama usaha wajib diisi';
                          }
                          return null;
                        },
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
                            _nokecLokasi.text = value?.noKec as String;
                            _kecamatanLokasi.text = value?.namaKec ?? "";

                            _nokelLokasi.text = "";
                            _desaLokasi.text = "";
                          });
                        },
                        selectedItem: KecamatanModels(
                          noKec: _nokecLokasi.text,
                          namaKec: _kecamatanLokasi.text,
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
                      if (_nokecLokasi.text != "") ...[
                        const SizedBox(height: 5),
                        DropdownSearch<DesaModels>(
                          asyncItems: (String filter) async {
                            var response = await http.get(
                              Uri.parse(
                                  "$baseUrl/api/desa-permohonan?no_kec=${_nokecLokasi.text}&key=${ApiContainer.baseKey}"),
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
                              _nokelLokasi.text = value?.noKel as String;
                              _desaLokasi.text = value?.namaKel ?? "";
                            });
                          },
                          selectedItem: DesaModels(
                            noKel: _nokelLokasi.text,
                            namaKel: _desaLokasi.text,
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
                      if (_nokecLokasi.text != "" &&
                          _nokelLokasi.text != "") ...[
                        const SizedBox(height: 5),
                        DropdownSearch<JalanModels>(
                          asyncItems: (String filter) async {
                            var response = await http.get(
                              Uri.parse(
                                  "$baseUrl/api/jalan?nokec=${_nokecLokasi.text}&nokel=${_nokelLokasi.text}&key=${ApiContainer.baseKey}"),
                            );

                            if (response.statusCode != 200) {
                              errorData();
                              return [];
                            } else {
                              List jalan = (json.decode(response.body)
                                  as Map<String, dynamic>)["data"];

                              List<JalanModels> jalanList = [];

                              for (var element in jalan) {
                                jalanList.add(JalanModels.fromJson(element));
                              }

                              return jalanList;
                            }
                          },
                          popupProps: PopupProps.dialog(
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(
                                '${item.nama}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Jalan",
                              labelStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _idJalan.text = value?.id.toString() as String;
                              _namaJalan.text = value?.nama ?? "";
                            });
                          },
                          selectedItem: JalanModels(
                            id: int.tryParse(_idJalan.text),
                            nama: _namaJalan.text,
                          ),
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?.nama ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          validator: (value) {
                            if (value?.id == null) {
                              return 'Nama jalan wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      if (_idJalan.text == "1") ...[
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _namaJalan,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: "Nama Jalan",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _nomorLokasi,
                          decoration: const InputDecoration(
                            labelText: "Nomor Rumah",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _dusunLokasi,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Dusun / Lingkungan",
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
                                controller: _rtLokasi,
                                decoration: const InputDecoration(
                                  labelText: "RT",
                                  labelStyle: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(fontSize: 13),
                                controller: _rwLokasi,
                                decoration: const InputDecoration(
                                  labelText: "RW",
                                  labelStyle: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (varKordinat == 1) ...[
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _latLokasi,
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
                          controller: _lngLokasi,
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
                                      'TENTUKAN KORDINAT LOKASI',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    icon: const Icon(
                                      Icons.location_pin,
                                      size: 18,
                                    ),
                                    onPressed: () async {
                                      LatLng kordinat;
                                      if (_latLokasi.text != "") {
                                        kordinat = LatLng(
                                            double.parse(_latLokasi.text),
                                            double.parse(_lngLokasi.text));
                                      } else {
                                        kordinat = const LatLng(
                                            -8.223600593616215,
                                            114.36705853790045);
                                      }

                                      final result = await Get.to(
                                          () => MapKordinat(kordinat));

                                      setState(() {
                                        if (result != null) {
                                          _latLokasi.text =
                                              result.latitude.toString();
                                          _lngLokasi.text =
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
                        const SizedBox(height: 5),
                      ],
                      if (varArea == 1) ...[
                        const SizedBox(height: 15),
                        DropdownSearch<AreaModels>(
                          asyncItems: (String filter) async {
                            var response = await http.get(
                              Uri.parse(
                                  "$baseUrl/api/area?key=${ApiContainer.baseKey}"),
                            );

                            if (response.statusCode != 200) {
                              errorData();
                              return [];
                            } else {
                              List area = (json.decode(response.body)
                                  as Map<String, dynamic>)["data"];

                              List<AreaModels> areaList = [];

                              for (var element in area) {
                                areaList.add(AreaModels.fromJson(element));
                              }

                              return areaList;
                            }
                          },
                          popupProps: PopupProps.dialog(
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(
                                '${item.area}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Area",
                              labelStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _idArea.text = value?.id.toString() as String;
                              _namaArea.text = value?.area ?? "";
                            });
                          },
                          selectedItem: AreaModels(
                            id: int.tryParse(_idArea.text),
                            area: _namaArea.text,
                          ),
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?.area ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          validator: (value) {
                            if (value?.area == "") {
                              return 'Area wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      if (varUkuran == 1) ...[
                        const SizedBox(height: 5),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 13),
                                  controller: _panjang,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'(^-?\d*\.?\d*)'))
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: "Panjang",
                                    labelStyle: TextStyle(fontSize: 13),
                                    suffixText: "m",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _panjang.text == ""
                                          ? panjangBidang = 0
                                          : panjangBidang =
                                              double.parse(_panjang.text);

                                      _lebar.text == ""
                                          ? lebarBidang = 0
                                          : lebarBidang =
                                              double.parse(_lebar.text);

                                      luasBidang =
                                          panjangBidang! * lebarBidang!;

                                      if (luasBidang! > 0) {
                                        if (_idKategoriReklame.text == "2" &&
                                            luasBidang! > 8) {
                                          _panjang.text = "";
                                          _lebar.text = "";
                                          _luas.text = "";
                                          errorPesan(
                                              "Luas bidang Reklame Permanen maksimal 8 m\u00B2");
                                        } else if (_idKategoriReklame.text ==
                                                "3" &&
                                            luasBidang! <= 8) {
                                          _panjang.text = "";
                                          _lebar.text = "";
                                          _luas.text = "";
                                          errorPesan(
                                              "Luas bidang Reklame Terbatas harus\n 8 m\u00B2 keatas");
                                        } else {
                                          _luas.text = luasBidang.toString();
                                        }
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value == "") {
                                      return 'Wajib diisi';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              const Text("X"),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 13),
                                  controller: _lebar,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'(^-?\d*\.?\d*)'))
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: "Lebar",
                                    labelStyle: TextStyle(fontSize: 13),
                                    suffixText: "m",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _panjang.text == ""
                                          ? panjangBidang = 0
                                          : panjangBidang =
                                              double.parse(_panjang.text);

                                      _lebar.text == ""
                                          ? lebarBidang = 0
                                          : lebarBidang =
                                              double.parse(_lebar.text);

                                      luasBidang =
                                          panjangBidang! * lebarBidang!;

                                      if (luasBidang! > 0) {
                                        if (_idKategoriReklame.text == "2" &&
                                            luasBidang! > 8) {
                                          _panjang.text = "";
                                          _lebar.text = "";
                                          _luas.text = "";
                                          errorPesan(
                                              "Luas bidang Reklame Permanen maksimal 8 m\u00B2");
                                        } else if (_idKategoriReklame.text ==
                                                "3" &&
                                            luasBidang! <= 8) {
                                          _panjang.text = "";
                                          _lebar.text = "";
                                          _luas.text = "";
                                          errorPesan(
                                              "Luas bidang Reklame Terbatas harus\n 8 m\u00B2 keatas");
                                        } else {
                                          _luas.text = luasBidang.toString();
                                        }
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value == "") {
                                      return 'Wajib diisi';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _luas,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^-?\d*\.?\d*)'))
                          ],
                          decoration: const InputDecoration(
                            labelText: "Luas Bidang",
                            labelStyle: TextStyle(fontSize: 13),
                            suffixText: "m\u00B2",
                          ),
                          enabled: false,
                          validator: (value) {
                            if (value == "") {
                              return 'Wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      if (varTinggi == 1) ...[
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _tinggi,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^-?\d*\.?\d*)'))
                          ],
                          decoration: const InputDecoration(
                            labelText: "Tinggi",
                            labelStyle: TextStyle(fontSize: 13),
                            suffixText: "m",
                          ),
                          validator: (value) {
                            if (value == "") {
                              return 'Ukuran tinggi wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      if (varDiameterTiang == 1) ...[
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _diameter,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^-?\d*\.?\d*)'))
                          ],
                          decoration: const InputDecoration(
                            labelText: "Diameter Tiang",
                            labelStyle: TextStyle(fontSize: 13),
                            suffixText: "cm",
                          ),
                          validator: (value) {
                            if (value == "") {
                              return 'Diameter tiang wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      if (varLembar == 1) ...[
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _lembar,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: "Lembar",
                            labelStyle: TextStyle(fontSize: 13),
                            suffixText: "lembar",
                          ),
                          validator: (value) {
                            if (value == "") {
                              return 'Jumlah lembar wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      if (varSisi == 1) ...[
                        const SizedBox(height: 5),
                        DropdownSearch<Map<String, dynamic>>(
                          items: const [
                            {"id": 1, "sisi": "1 SISI"},
                            {"id": 2, "sisi": "2 SISI"},
                            {"id": 3, "sisi": "3 SISI"},
                            {"id": 4, "sisi": "4 SISI"},
                          ],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Sisi/Sudut Pandang",
                              labelStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _sisi.text = value?["id"].toString() as String;
                              _sisiReklame.text = value?["sisi"] ?? "";
                            });
                          },
                          selectedItem: {
                            "id": _sisi.text,
                            "sisi": _sisiReklame.text,
                          },
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(
                                item["sisi"],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?["sisi"] ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          validator: (value) {
                            if (value?["id"] == "") {
                              return 'Jumlah sisi Wajib Diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 5),
                      DropdownSearch<Map<String, dynamic>>(
                        items: const [
                          {"posisi": "HORIZONTAL"},
                          {"posisi": "VERTIKAL"},
                        ],
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Posisi",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _posisi.text =
                                value?["posisi"].toString() as String;
                          });
                        },
                        selectedItem: {
                          "posisi": _posisi.text,
                        },
                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              item["posisi"],
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?["posisi"] ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?["posisi"] == "") {
                            return 'Posisi pemasangan Wajib Diisi';
                          }
                          return null;
                        },
                      ),
                      if (varLahan == 1) ...[
                        const SizedBox(height: 5),
                        DropdownSearch<LahanModels>(
                          asyncItems: (String filter) async {
                            var response = await http.get(
                              Uri.parse(
                                  "$baseUrl/api/lahan?key=${ApiContainer.baseKey}"),
                            );

                            if (response.statusCode != 200) {
                              errorData();
                              return [];
                            } else {
                              List lahan = (json.decode(response.body)
                                  as Map<String, dynamic>)["data"];

                              List<LahanModels> lahanList = [];

                              for (var element in lahan) {
                                lahanList.add(LahanModels.fromJson(element));
                              }

                              return lahanList;
                            }
                          },
                          popupProps: PopupProps.dialog(
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(
                                '${item.lahan}',
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Status Lahan",
                              labelStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _idLahan.text = value?.id.toString() as String;
                              _namaLahan.text = value?.lahan ?? "";
                            });
                          },
                          selectedItem: LahanModels(
                            id: int.tryParse(_idLahan.text),
                            lahan: _namaLahan.text,
                          ),
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?.lahan ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          validator: (value) {
                            if (value?.lahan == "") {
                              return 'Status lahan wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                      const Divider(
                        height: 50,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_permohonanKey.currentState!.validate()) {
                              setState(() {
                                currentStep++;
                              });
                            } else {
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
                  ],
                ),
              ),
            ),
            Step(
              isActive: currentStep >= 2,
              state: currentStep >= 2 ? StepState.disabled : StepState.complete,
              title: const Text("DOKUMEN"),
              subtitle: const Text("Dokumen Permohonan Izin Reklame"),
              content: Form(
                key: _dokumenKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "FOTO TAMPAK DEPAN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    fotoDepan != null
                        ? Image.file(
                            fotoDepan!,
                            fit: BoxFit.cover,
                          )
                        : _fotoDepan.text != ""
                            ? DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  _fotoDepan.text,
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
                            : const SizedBox(),
                    SizedBox(
                      width: double.infinity,
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
                                        getDepan(ImageSource.camera);
                                      }),
                                  ListTile(
                                      leading: const Icon(Icons.image),
                                      title:
                                          const Text("Ambil File Dari Gallery"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        getDepan(ImageSource.gallery);
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
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: TextFormField(
                        controller: _fotoDepan,
                        validator: (value) {
                          if (value == "") {
                            const Text("Foto wajib diisi");
                          }
                          return null;
                        },
                      ),
                    ),
                    const Divider(
                      height: 30,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const Text(
                      "FOTO TAMPAK BELAKANG",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    fotoBelakang != null
                        ? Image.file(
                            fotoBelakang!,
                            fit: BoxFit.cover,
                          )
                        : _fotoBelakang.text != ""
                            ? DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  _fotoBelakang.text,
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
                            : const SizedBox(),
                    SizedBox(
                      width: double.infinity,
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
                                        getBelakang(ImageSource.camera);
                                      }),
                                  ListTile(
                                      leading: const Icon(Icons.image),
                                      title:
                                          const Text("Ambil File Dari Gallery"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        getBelakang(ImageSource.gallery);
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
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: TextFormField(
                        controller: _fotoBelakang,
                        validator: (value) {
                          if (value == "") {
                            return "Error";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Divider(
                      height: 30,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const Text(
                      "FOTO SAMPING KANAN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    fotoKanan != null
                        ? Image.file(
                            fotoKanan!,
                            fit: BoxFit.cover,
                          )
                        : _fotoKanan.text != ""
                            ? DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  _fotoKanan.text,
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
                            : const SizedBox(),
                    SizedBox(
                      width: double.infinity,
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
                                        getKanan(ImageSource.camera);
                                      }),
                                  ListTile(
                                      leading: const Icon(Icons.image),
                                      title:
                                          const Text("Ambil File Dari Gallery"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        getKanan(ImageSource.gallery);
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
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: TextFormField(
                        controller: _fotoKanan,
                        validator: (value) {
                          if (value == "") {
                            return "Error";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Divider(
                      height: 30,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const Text(
                      "FOTO SAMPING KIRI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    fotoKiri != null
                        ? Image.file(
                            fotoKiri!,
                            fit: BoxFit.cover,
                          )
                        : _fotoKiri.text != ""
                            ? DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  _fotoKiri.text,
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
                            : const SizedBox(),
                    SizedBox(
                      width: double.infinity,
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
                                        getKiri(ImageSource.camera);
                                      }),
                                  ListTile(
                                      leading: const Icon(Icons.image),
                                      title:
                                          const Text("Ambil File Dari Gallery"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        getKiri(ImageSource.gallery);
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
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: TextFormField(
                        controller: _fotoKiri,
                        validator: (value) {
                          if (value == "") {
                            return "Error";
                          }
                          return null;
                        },
                      ),
                    ),
                    if (varNpwp == 1) ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Text(
                        _idJenisPemohon.text == "1" ? "NPWP" : "NPWP BADAN",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _noNpwp,
                        decoration: InputDecoration(
                          labelText: _idJenisPemohon.text == "1"
                              ? "Nomor NPWP"
                              : "Nomor NPWP Badan",
                          labelStyle: const TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'NPWPD wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      npwpPemohon != null
                          ? Image.file(
                              npwpPemohon!,
                              fit: BoxFit.cover,
                            )
                          : _dokNpwp.text != ""
                              ? DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Image.network(
                                    _dokNpwp.text,
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
                              : const SizedBox(),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
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
                                          getNpwp(ImageSource.camera);
                                        }),
                                    ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text(
                                            "Ambil File Dari Gallery"),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          getNpwp(ImageSource.gallery);
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
                            "UNGGAH NPWP",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        maintainState: true,
                        child: TextFormField(
                          controller: _dokNpwp,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokNpwp.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (varNpwpd == 1) ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Text(
                        _idJenisPemohon.text == "1" ? "NPWPD" : "NPWPD BADAN",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _noNpwpd,
                        decoration: InputDecoration(
                          labelText: _idJenisPemohon.text == "1"
                              ? "Nomor NPWPD"
                              : "Nomor NPWPD Badan",
                          labelStyle: const TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'NPWPD wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      npwpdPemohon != null
                          ? Image.file(
                              npwpdPemohon!,
                              fit: BoxFit.cover,
                            )
                          : _dokNpwpd.text != ""
                              ? DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Image.network(
                                    _dokNpwpd.text,
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
                              : const SizedBox(),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
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
                                          getNpwpd(ImageSource.camera);
                                        }),
                                    ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text(
                                            "Ambil File Dari Gallery"),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          getNpwpd(ImageSource.gallery);
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
                            "UNGGAH NPWPD",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        maintainState: true,
                        child: TextFormField(
                          controller: _dokNpwpd,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokNpwpd.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (_idJenisPemohon.text != "1") ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "AKTA PENDIRIAN PERUSAHAAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _skBadan,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Nomor Akta",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Nomor Akta wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      dokumenAkta != null
                          ? Wrap(
                              children: dokumenAkta!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokAkta.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokAkta.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                                      ),
                                    ),
                                  ]
                                ])
                              : const SizedBox(),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () => getAkta(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokAkta,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokAkta.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (varNib == 1) ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "NOMOR INDUK BERUSAHA (NIB)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _nib,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Nomor NIB",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'NIB wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      dokumenNib != null
                          ? Wrap(
                              children: dokumenNib!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokNib.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokNib.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                                      ),
                                    ),
                                  ]
                                ])
                              : const SizedBox(),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () => getNib(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokNib,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokNib.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (_idLahan.text == "1" || _idLahan.text == "2") ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "DOKUMEN LEGALITAS LAHAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      legalitasLahan != null
                          ? Wrap(
                              children: legalitasLahan!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokLegal.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokLegal.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                          onPressed: () => getLegalitasLahan(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokLegal,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokLegal.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (_idLahan.text == "2") ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "PERJANJIAN SEWA LAHAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      dokumenSewa != null
                          ? Wrap(
                              children: dokumenSewa!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokSewa.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokSewa.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                                      ),
                                    ),
                                  ]
                                ])
                              : const SizedBox(),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () => getSewa(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokSewa,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokSewa.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (_idLahan.text != "1" && _idLahan.text != "2") ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "DOKUMEN PEMANGKU JALAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      dokumenPemangku != null
                          ? Wrap(
                              children: dokumenPemangku!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokPemangku.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokPemangku.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                          onPressed: () => getPemangku(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokPemangku,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokPemangku.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (varImb == 1) ...[
                      const Divider(
                        height: 40,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "IZIN MENDIRIKAN BANGUNAN (IMB)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _noImb,
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
                      dokumenImb != null
                          ? Wrap(
                              children: dokumenImb!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokImb.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokImb.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                            size: 18,
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
                          controller: _dokImb,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokImb.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (varKkpr == 1) ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "DOKUMEN KKPR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _noKkpr,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Nomor KKPR",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Nomor KKPR wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      dokumenKkpr != null
                          ? Wrap(
                              children: dokumenKkpr!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokKkpr.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokKkpr.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                                      ),
                                    ),
                                  ]
                                ])
                              : const SizedBox(),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () => getKkpr(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokKkpr,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokKkpr.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (varAsuransi == 1) ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "DOKUMEN ASURANSI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      dokumenAsuransi != null
                          ? Wrap(
                              children: dokumenAsuransi!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokAsuransi.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokAsuransi.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                          onPressed: () => getAsuransi(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokAsuransi,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokAsuransi.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (varFotoMateri == 1) ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "FOTO MATERI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      fotoMateri != null
                          ? Wrap(
                              children: fotoMateri!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _fotoMateri.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_fotoMateri.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                          onPressed: () => getMateri(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _fotoMateri,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_fotoMateri.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (_idJenisPemohon.text == "3") ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "KONTRAK KERJASAMA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _noKontrak,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Nomor SPK",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Nomor SPK wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _nilaiKontrak,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^-?\d*\.?\d*)'))
                        ],
                        decoration: const InputDecoration(
                          labelText: "Nilai Kontrak",
                          labelStyle: TextStyle(fontSize: 13),
                          prefixText: "Rp. ",
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Nilai kontrak wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      dokumenKontrak != null
                          ? Wrap(
                              children: dokumenKontrak!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokKontrak.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokKontrak.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                          onPressed: () => getKontrak(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokKontrak,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokKontrak.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (varSkPenunjukan == 1) ...[
                      const Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                        "SK PENUNJUKAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      dokumenLain != null
                          ? Wrap(
                              children: dokumenLain!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 120,
                                    width: 90,
                                    child: Image.file(
                                      File(imageone.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : _dokLain.text != ""
                              ? Wrap(children: [
                                  for (String im
                                      in jsonDecode(_dokLain.text)) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 120,
                                        width: 90,
                                        child: Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                          onPressed: () => getLain(),
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
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
                          controller: _dokLain,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_dokLain.text == "") ...[
                        const SizedBox(height: 5),
                        const Text(
                          "Dokumen wajib diisi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    const Divider(
                      height: 30,
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
                      height: 30,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_dokumenKey.currentState!.validate()) {
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
                                                .validate()) {
                                              loadingData();

                                              Map<String, String> headers = {
                                                'Content-Type':
                                                    'multipart/form-data',
                                              };

                                              Map<String, String> body = {
                                                "key": ApiContainer.baseKey,
                                                "uid": _uidPemohon.text,
                                                "id_jenis":
                                                    _idJenisReklame.text,
                                                "alamat": _namaJalan.text,
                                                "id_jalan": _idJalan.text,
                                                "nomor": _nomorLokasi.text,
                                                "dusun": _dusunLokasi.text,
                                                "rt": _rtLokasi.text,
                                                "rw": _rwLokasi.text,
                                                "no_kec": _nokecLokasi.text,
                                                "no_kel": _nokelLokasi.text,
                                                "id_area": _idArea.text,
                                                "posisi": _posisi.text,
                                                "id_lahan": _idLahan.text,
                                                "lat": _latLokasi.text,
                                                "lng": _lngLokasi.text,
                                                "sisi": _sisi.text,
                                                "rokok": _idIklanRokok.text,
                                                "materi": _materiReklame.text,
                                                "panjang": _panjang.text,
                                                "lebar": _lebar.text,
                                                "luas": _luas.text,
                                                "tinggi": _tinggi.text,
                                                "diameter": _diameter.text,
                                                "lembar": _lembar.text,
                                                "imb_no": _noImb.text,
                                                "kkpr": _noKkpr.text,
                                                "nama_usaha": _namaUsaha.text,
                                                "id_kategori":
                                                    _idKategoriReklame.text,
                                                "kontrak": _nilaiKontrak.text,
                                                "no_spk": _noKontrak.text,
                                                "catatan": _catatan.text,
                                                "id_jenis_pemohon":
                                                    _idJenisPemohon.text,
                                                "nib": _nib.text,
                                                "npwp": _noNpwp.text,
                                                "npwpd": _noNpwpd.text,
                                                "id_badan": _idBadan.text,
                                                "nama_badan": _namaBadan.text,
                                                "alamat_badan":
                                                    _alamatBadan.text,
                                                "dusun_badan": _dusunBadan.text,
                                                "rt_badan": _rtBadan.text,
                                                "rw_badan": _rwBadan.text,
                                                "no_prop_badan":
                                                    _nopropBadan.text,
                                                "no_kab_badan":
                                                    _nokabBadan.text,
                                                "no_kec_badan":
                                                    _nokecBadan.text,
                                                "no_kel_badan":
                                                    _nokelBadan.text,
                                                "jabatan_badan":
                                                    _jabatanPemohon.text,
                                                "sk_badan": _skBadan.text,
                                              };

                                              var request = http.MultipartRequest(
                                                  'POST',
                                                  Uri.parse(
                                                      "$baseUrl/api/sipr-kirim"));

                                              request.headers.addAll(headers);
                                              request.fields.addAll(body);

                                              if (npwpPemohon != null) {
                                                request.files.add(
                                                    await http.MultipartFile
                                                        .fromPath(
                                                            'dok_npwp',
                                                            npwpPemohon?.path ??
                                                                ""));
                                              }

                                              if (npwpdPemohon != null) {
                                                request.files.add(await http
                                                        .MultipartFile
                                                    .fromPath(
                                                        'dok_npwpd',
                                                        npwpdPemohon?.path ??
                                                            ""));
                                              }

                                              if (fotoDepan != null) {
                                                request.files.add(await http
                                                        .MultipartFile
                                                    .fromPath('depan',
                                                        fotoDepan?.path ?? ""));
                                              }

                                              if (fotoBelakang != null) {
                                                request.files.add(await http
                                                        .MultipartFile
                                                    .fromPath(
                                                        'belakang',
                                                        fotoBelakang?.path ??
                                                            ""));
                                              }

                                              if (fotoKanan != null) {
                                                request.files.add(await http
                                                        .MultipartFile
                                                    .fromPath('kanan',
                                                        fotoKanan?.path ?? ""));
                                              }

                                              if (fotoKiri != null) {
                                                request.files.add(await http
                                                        .MultipartFile
                                                    .fromPath('kiri',
                                                        fotoKiri?.path ?? ""));
                                              }

                                              if (fotoMateri != null) {
                                                for (int i = 0;
                                                    i < fotoMateri!.length;
                                                    i++) {
                                                  request.files.add(
                                                    http.MultipartFile.fromBytes(
                                                        'foto_materi[]',
                                                        File(fotoMateri![i]
                                                                .path)
                                                            .readAsBytesSync(),
                                                        filename: fotoMateri![i]
                                                            .path
                                                            .split("/")
                                                            .last),
                                                  );
                                                }
                                              }

                                              if (legalitasLahan != null) {
                                                for (int i = 0;
                                                    i < legalitasLahan!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_legal[]',
                                                          File(legalitasLahan![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              legalitasLahan![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenPemangku != null) {
                                                for (int i = 0;
                                                    i < dokumenPemangku!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_pemangku[]',
                                                          File(dokumenPemangku![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenPemangku![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenNib != null) {
                                                for (int i = 0;
                                                    i < dokumenNib!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_nib[]',
                                                          File(dokumenNib![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenNib![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenKontrak != null) {
                                                for (int i = 0;
                                                    i < dokumenKontrak!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_kontrak[]',
                                                          File(dokumenKontrak![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenKontrak![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenImb != null) {
                                                for (int i = 0;
                                                    i < dokumenImb!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_imb[]',
                                                          File(dokumenImb![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenImb![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenKkpr != null) {
                                                for (int i = 0;
                                                    i < dokumenKkpr!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_kkpr[]',
                                                          File(dokumenKkpr![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenKkpr![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenAsuransi != null) {
                                                for (int i = 0;
                                                    i < dokumenAsuransi!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_asuransi[]',
                                                          File(dokumenAsuransi![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenAsuransi![
                                                                      i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenSewa != null) {
                                                for (int i = 0;
                                                    i < dokumenSewa!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_sewa[]',
                                                          File(dokumenSewa![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenSewa![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenLain != null) {
                                                for (int i = 0;
                                                    i < dokumenLain!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_lain[]',
                                                          File(dokumenLain![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenLain![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (dokumenAkta != null) {
                                                for (int i = 0;
                                                    i < dokumenAkta!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'dok_akta[]',
                                                          File(dokumenAkta![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              dokumenAkta![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              var response =
                                                  await request.send();

                                              if (response.statusCode == 200) {
                                                hapusLoader();
                                                pesanData(
                                                    "Permohonan Izin Reklame Berhasil Dikirim");
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
                        label: const Text('KIRIM PERMOHONAN'),
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
          ],
        ),
      ),
    );
  }

  Widget buildPerusahaan() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "DATA PERUSAHAAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          DropdownSearch<BentukBadanKkprModels>(
            asyncItems: (String filter) async {
              var response = await http.get(
                Uri.parse(
                    "$baseUrl/api/bentuk-badan-reklame?key=${ApiContainer.baseKey}"),
              );

              if (response.statusCode != 200) {
                errorData();
                return [];
              } else {
                List bentuk = (json.decode(response.body)
                    as Map<String, dynamic>)["data"];

                List<BentukBadanKkprModels> bentukList = [];

                for (var element in bentuk) {
                  bentukList.add(BentukBadanKkprModels.fromJson(element));
                }

                return bentukList;
              }
            },
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  '${item.ket}',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              fit: FlexFit.loose,
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Bentuk Badan",
                labelStyle: TextStyle(fontSize: 13),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _idBadan.text = value?.id.toString() as String;
                _idKetBadan.text = value?.ket ?? "";
              });
            },
            selectedItem: BentukBadanKkprModels(
              id: int.tryParse(_idBadan.text),
              ket: _idKetBadan.text,
            ),
            dropdownBuilder: (context, selectedItem) => Text(
              selectedItem?.ket ?? "",
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
            validator: (value) {
              if (value?.ket == "") {
                return 'Bentuk Badan wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _namaBadan,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Nama Perusahaan Tanpa Bentuk Badan",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Nama Perusahaan wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _alamatBadan,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Alamat Jalan",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Alamat Perusahaan wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _dusunBadan,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Dusun / Lingkungan",
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
                    controller: _rtBadan,
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
                    controller: _rwBadan,
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
                Uri.parse("$baseUrl/api/propinsi?key=${ApiContainer.baseKey}"),
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
                title: Text('${item.namaProp}',
                    style: const TextStyle(fontSize: 13)),
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
                _nopropBadan.text = value?.noProp ?? "";
                _propinsiBadan.text = value?.namaProp ?? "";
                _nokabBadan.text = "";
                _kotaBadan.text = "";
                _nokecBadan.text = "";
                _kecamatanBadan.text = "";
                _nokelBadan.text = "";
                _desaBadan.text = "";
              });
            },
            selectedItem: PropinsiModels(
              noProp: _nopropBadan.text,
              namaProp: _propinsiBadan.text,
            ),
            dropdownBuilder: (context, selectedItem) => Text(
              selectedItem?.namaProp ?? "",
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
            validator: (value) {
              if (value?.noProp == "") {
                return 'Propinsi wajib diisi';
              }
              return null;
            },
          ),
          if (_nopropBadan.text != "") ...[
            const SizedBox(height: 5),
            DropdownSearch<KotaModels>(
              asyncItems: (String filter) async {
                var response = await http.get(
                  Uri.parse(
                      "$baseUrl/api/kota?no_prop=${_nopropBadan.text}&key=${ApiContainer.baseKey}"),
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
                  _nokabBadan.text = value?.noKab ?? "";
                  _kotaBadan.text = value?.namaKab ?? "";

                  _nokecBadan.text = "";
                  _kecamatanBadan.text = "";
                  _nokelBadan.text = "";
                  _desaBadan.text = "";
                });
              },
              selectedItem: KotaModels(
                noKab: _nokabBadan.text,
                namaKab: _kotaBadan.text,
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
          if (_nopropBadan.text != "" && _nokabBadan.text != "") ...[
            const SizedBox(height: 5),
            DropdownSearch<KecamatanModels>(
              asyncItems: (String filter) async {
                var response = await http.get(
                  Uri.parse(
                      "$baseUrl/api/kecamatan?no_prop=${_nopropBadan.text}&no_kab=${_nokabBadan.text}&key=${ApiContainer.baseKey}"),
                );

                if (response.statusCode != 200) {
                  errorData();
                  return [];
                } else {
                  List kecamatan = (json.decode(response.body)
                      as Map<String, dynamic>)["data"];

                  List<KecamatanModels> kecamatanList = [];

                  for (var element in kecamatan) {
                    kecamatanList.add(KecamatanModels.fromJson(element));
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
                  _nokecBadan.text = value?.noKec ?? "";
                  _kecamatanBadan.text = value?.namaKec ?? "";

                  _nokelBadan.text = "";
                  _desaBadan.text = "";
                });
              },
              selectedItem: KecamatanModels(
                noKec: _nokecBadan.text,
                namaKec: _kecamatanBadan.text,
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
          if (_nopropBadan.text != "" &&
              _nokabBadan.text != "" &&
              _nokecBadan.text != "") ...[
            const SizedBox(height: 15),
            DropdownSearch<DesaModels>(
              asyncItems: (String filter) async {
                var response = await http.get(
                  Uri.parse(
                      "$baseUrl/api/desa?no_prop=${_nopropBadan.text}&no_kab=${_nokabBadan.text}&no_kec=${_nokecBadan.text}&key=${ApiContainer.baseKey}"),
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
                  _nokelBadan.text = value?.noKel ?? "";
                  _desaBadan.text = value?.namaKel ?? "";
                });
              },
              selectedItem: DesaModels(
                noKel: _nokelBadan.text,
                namaKel: _desaBadan.text,
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
                        'TENTUKAN KORDINAT KANTOR',
                        style: TextStyle(fontSize: 13),
                      ),
                      icon: const Icon(
                        Icons.location_pin,
                        size: 18,
                      ),
                      onPressed: () async {
                        LatLng kordinat;
                        kordinat = LatLng(double.parse(_latPemohon.text),
                            double.parse(_lngPemohon.text));
                        final result =
                            await Get.to(() => MapKordinat(kordinat));

                        setState(() {
                          if (result != null) {
                            _latPemohon.text = result.latitude.toString();
                            _lngPemohon.text = result.longitude.toString();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "DATA PEMOHON",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _jabatanPemohon,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Jabatan Pemohon",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Jabatan wajib diisi';
              }
              return null;
            },
          ),
        ],
      );
}
