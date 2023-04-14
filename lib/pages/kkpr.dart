import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nonoss/pages/map_polygon.dart';

import '../services/api_container.dart';
import '../models/jenis_kegiatan_kkpr.dart';
import '../models/propinsi.dart';
import '../models/kota.dart';
import '../models/kecamatan.dart';
import '../models/desa.dart';
import '../models/negara.dart';
import '../models/bentuk_badan_kkpr.dart';
import '../models/baku_air.dart';
import '../models/kkpr_tanah.dart';
import '../models/pemohon_kkpr.dart';
import 'kkpr_lahan.dart';
import 'map_kordinat.dart';

class KKPR extends StatefulWidget {
  const KKPR({super.key});

  @override
  State<KKPR> createState() => _KKPRState();
}

class _KKPRState extends State<KKPR> {
  List<LatLng> locationList = [];
  List<KkprTanahModels> legalList = [];
  List legalitasLahan = [];

  final baseUrl = ApiContainer.baseUrl;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _permohonanKey = GlobalKey<FormState>();
  final _dokumenKey = GlobalKey<FormState>();

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

  final TextEditingController _idBadan = TextEditingController();
  final TextEditingController _idKetBadan = TextEditingController();
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

  final TextEditingController _idJenisPemohon = TextEditingController();
  final TextEditingController _jenisPemohon = TextEditingController();
  final TextEditingController _idPenanamanModal = TextEditingController();
  final TextEditingController _penanamanModal = TextEditingController();
  final TextEditingController _kodeKbli = TextEditingController();
  final TextEditingController _judulKbli = TextEditingController();
  final TextEditingController _idPkkpr = TextEditingController();
  final TextEditingController _jenisPkkpr = TextEditingController();
  final TextEditingController _rencanaPeruntukan = TextEditingController();
  final TextEditingController _alamatLokasi = TextEditingController();
  final TextEditingController _dusunLokasi = TextEditingController();
  final TextEditingController _rtLokasi = TextEditingController();
  final TextEditingController _rwLokasi = TextEditingController();
  final TextEditingController _nokecLokasi = TextEditingController();
  final TextEditingController _nokelLokasi = TextEditingController();
  final TextEditingController _luasTanah = TextEditingController();
  final TextEditingController _luasTanahSesuaiBukti = TextEditingController();
  final TextEditingController _luasTanahBangunan = TextEditingController();
  final TextEditingController _penggunaanSekarang = TextEditingController();
  final TextEditingController _jumlahLantai = TextEditingController();
  final TextEditingController _tinggiBangunan = TextEditingController();
  final TextEditingController _luasLantaiBangunan = TextEditingController();
  final TextEditingController _latLokasi = TextEditingController();
  final TextEditingController _lngLokasi = TextEditingController();
  final TextEditingController _idNeracaAir = TextEditingController();
  final TextEditingController _neracaAir = TextEditingController();
  final TextEditingController _penghuni = TextEditingController();
  final TextEditingController _jamaah = TextEditingController();
  final TextEditingController _siswa = TextEditingController();
  final TextEditingController _karyawan = TextEditingController();
  final TextEditingController _lBangunan = TextEditingController();
  final TextEditingController _kursi = TextEditingController();
  final TextEditingController _kebutuhan = TextEditingController();
  final TextEditingController _sd = TextEditingController();
  final TextEditingController _smp = TextEditingController();
  final TextEditingController _sma = TextEditingController();
  final TextEditingController _mahasiswa = TextEditingController();
  final TextEditingController _luasTambak = TextEditingController();
  final TextEditingController _intensitasTambak = TextEditingController();
  final TextEditingController _luasToko = TextEditingController();
  final TextEditingController _airBersih = TextEditingController();
  final TextEditingController _airBersihM = TextEditingController();
  final TextEditingController _masakCuci = TextEditingController();
  final TextEditingController _masakCuciM = TextEditingController();
  final TextEditingController _penyiraman = TextEditingController();
  final TextEditingController _penyiramanM = TextEditingController();
  final TextEditingController _ipal = TextEditingController();
  final TextEditingController _ipalM = TextEditingController();
  final TextEditingController _polygonList = TextEditingController();
  final TextEditingController _dokSitePlan = TextEditingController();
  final TextEditingController _dokFotoLokasi = TextEditingController();
  final TextEditingController _catatan = TextEditingController();
  final TextEditingController _nomorAkta = TextEditingController();
  final TextEditingController _dokAkta = TextEditingController();
  final TextEditingController _kordinatPolygon = TextEditingController();
  final TextEditingController _lokasiPolygon = TextEditingController();
  final TextEditingController _nomorNib = TextEditingController();
  final TextEditingController _dokNib = TextEditingController();
  final TextEditingController _dokPernyataanMandiri = TextEditingController();
  final TextEditingController _nomorKkprOtomatis = TextEditingController();
  final TextEditingController _tglKkprOtomatis = TextEditingController();
  final TextEditingController _tglKkprOtomatis1 = TextEditingController();
  final TextEditingController _dokKkprOtomatis = TextEditingController();
  final TextEditingController _nomorIzinPrinsip = TextEditingController();
  final TextEditingController _tglIzinPrinsip = TextEditingController();
  final TextEditingController _tglIzinPrinsip1 = TextEditingController();
  final TextEditingController _dokIzinPrinsip = TextEditingController();
  final TextEditingController _nomorIzinLokasi = TextEditingController();
  final TextEditingController _tglIzinLokasi = TextEditingController();
  final TextEditingController _tglIzinLokasi1 = TextEditingController();
  final TextEditingController _dokIzinLokasi = TextEditingController();
  final TextEditingController _nomorIppt = TextEditingController();
  final TextEditingController _tglIppt = TextEditingController();
  final TextEditingController _tglIppt1 = TextEditingController();
  final TextEditingController _dokIppt = TextEditingController();

  File? fotoPemohon;
  File? ktpPemohon;
  List<XFile>? scanSitePlan;
  List<XFile>? scanFotoLokasi;
  List<XFile>? scanAkta;
  List<XFile>? scanNib;
  List<XFile>? scanPernyataanMandiri;
  List<XFile>? scanKkprOtomatis;
  List<XFile>? scanIzinPrinsip;
  List<XFile>? scanIzinLokasi;
  List<XFile>? scanIppt;

  int idPermohonan = 0;

  int idKategori = 1;
  int? idPkkpr;
  int? idBadan;
  String? kecamatan;
  String? desa;

  int? idJenisPemohon;
  int? idNeracaAir;
  int? varPenghuni;
  int? varPenghuniX;
  int? varJamaah;
  int? varJamaahMandiX;
  int? varJamaahWudluX;
  int? varSiswa;
  int? varSiswaX;
  int? varKaryawan;
  int? varKaryawanX;
  int? varLBangunan;
  int? varLBangunanX;
  int? varKursi;
  int? varKursiX;
  int? varKebutuhan;
  int? varSd;
  int? varSdX;
  int? varSmp;
  int? varSmpX;
  int? varSma;
  int? varSmaX;
  int? varPt;
  int? varPtX;
  int? varTambakLuas;
  int? varTambakIntensitas;
  int? varTambakX;
  int? varTokoLuas;
  int? varTokoLuasX;

  int? varNib;
  int? varNpwp;
  int? varNpwpd;

  int? varPernyataanMandiri;
  int? varKkprOtomatis;
  int? varIprLama;

  double penghuniAir = 0.0;
  double penghuniMck = 0.0;
  double penghuniSrm = 0.0;
  double penghuniIpal = 0.0;
  double jamaahAir = 0.0;
  double jamaahMck = 0.0;
  double jamaahSrm = 0.0;
  double jamaahIpal = 0.0;
  double siswaAir = 0.0;
  double siswaMck = 0.0;
  double siswaSrm = 0.0;
  double siswaIpal = 0.0;
  double karyawanAir = 0.0;
  double karyawanMck = 0.0;
  double karyawanSrm = 0.0;
  double karyawanIpal = 0.0;
  double lBangunanAir = 0.0;
  double lBangunanMck = 0.0;
  double lBangunanSrm = 0.0;
  double lBangunanIpal = 0.0;
  double kursiAir = 0.0;
  double kursiMck = 0.0;
  double kursiSrm = 0.0;
  double kursiIpal = 0.0;
  double kebutuhanAir = 0.0;
  double kebutuhanIpal = 0.0;
  double sdAir = 0.0;
  double sdMck = 0.0;
  double sdSrm = 0.0;
  double sdIpal = 0.0;
  double smpAir = 0.0;
  double smpMck = 0.0;
  double smpSrm = 0.0;
  double smpIpal = 0.0;
  double smaAir = 0.0;
  double smaMck = 0.0;
  double smaSrm = 0.0;
  double smaIpal = 0.0;
  double ptAir = 0.0;
  double ptMck = 0.0;
  double ptSrm = 0.0;
  double ptIpal = 0.0;
  double tambakAir = 0.0;
  double tambakIpal = 0.0;
  double tokoLuasAir = 0.0;
  double tokoLuasMck = 0.0;
  double tokoLuasSrm = 0.0;
  double tokoLuasIpal = 0.0;

  LatLng? kordinatPemohon;

  bool isJenisPemohon = true;
  bool isKategori = true;
  bool isKegiatan = true;
  int currentStep = 0;

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

  Future getSitePlan() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanSitePlan = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSitePlan.text = scanSitePlan.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getFotoLokasi() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanFotoLokasi = pickedfiles;
        hapusLoader();
        setState(() {
          _dokFotoLokasi.text = scanFotoLokasi.toString();
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
        scanAkta = pickedfiles;
        hapusLoader();
        setState(() {
          _dokAkta.text = scanAkta.toString();
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
        scanNib = pickedfiles;
        hapusLoader();
        setState(() {
          _dokNib.text = scanNib.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getPernyataanMandiri() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanPernyataanMandiri = pickedfiles;
        hapusLoader();
        setState(() {
          _dokPernyataanMandiri.text = scanPernyataanMandiri.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getKkprOtomatis() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanKkprOtomatis = pickedfiles;
        hapusLoader();
        setState(() {
          _dokKkprOtomatis.text = scanKkprOtomatis.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getIzinPrinsip() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanIzinPrinsip = pickedfiles;
        hapusLoader();
        setState(() {
          _dokIzinPrinsip.text = scanIzinPrinsip.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getIzinLokasi() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanIzinLokasi = pickedfiles;
        hapusLoader();
        setState(() {
          _dokIzinLokasi.text = scanIzinLokasi.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getIppt() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanIppt = pickedfiles;
        hapusLoader();
        setState(() {
          _dokIppt.text = scanIppt.toString();
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

        _idBadan.text =
            data["id_badan"] != null ? data["id_badan"].toString() : "";
        _idKetBadan.text = data["KET"] ?? "";
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
        _nomorAkta.text = data["sk_badan"] ?? "";
        _dokAkta.text = data["dok_akta"] ?? "";
        _nomorNib.text = data["nib"] ?? "";
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
    locationList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            "KKPR",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "KESESUAIAN KEGIATAN PEMANFAATAN RUANG",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [
        //           Color.fromARGB(255, 0, 135, 45),
        //           Color.fromARGB(255, 255, 255, 255),
        //         ],
        //         begin: FractionalOffset(0.0, 0.0),
        //         end: FractionalOffset(0.0, 1.0),
        //         stops: [0.0, 1.0],
        //         tileMode: TileMode.clamp),
        //   ),
        // ),
        // foregroundColor: Colors.black87,
        // bottomOpacity: 0.0,
        // elevation: 1.0,
        titleTextStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
      body: Stepper(
        controlsBuilder: (context, details) {
          return const SizedBox();
        },
        currentStep: currentStep,
        steps: [
          Step(
            isActive: currentStep >= 0,
            state: currentStep >= 0 ? StepState.disabled : StepState.complete,
            title: const Text("PEMOHON"),
            subtitle: const Text(
              "DATA LENGKAP PROFIL PEMOHON",
              style: TextStyle(fontSize: 10),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownSearch<PemohonKkprModels>(
                    asyncItems: (String filter) async {
                      var response = await http.get(
                        Uri.parse(
                            "$baseUrl/api/pemohon-pkkpr?key=${ApiContainer.baseKey}"),
                      );

                      if (response.statusCode != 200) {
                        errorData();
                        return [];
                      } else {
                        List pemohon = (json.decode(response.body)
                            as Map<String, dynamic>)["data"];

                        List<PemohonKkprModels> pemohonList = [];

                        for (var element in pemohon) {
                          pemohonList.add(PemohonKkprModels.fromJson(element));
                        }

                        return pemohonList;
                      }
                    },
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, item, isSelected) => ListTile(
                        title: Text(
                          item.jenis.toString(),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      fit: FlexFit.loose,
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "JENIS PEMOHON",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        idJenisPemohon = value?.id;
                        _idJenisPemohon.text = idJenisPemohon.toString();
                        _jenisPemohon.text = value?.jenis.toString() as String;
                        varNib = value?.nib;
                        varNpwp = value?.npwp;
                        varNpwpd = value?.npwpd;
                      });
                    },
                    selectedItem: PemohonKkprModels(
                      id: idJenisPemohon,
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
                        return 'Jenis Pemohon wajib diisi';
                      }
                      return null;
                    },
                  ),
                  if (_idJenisPemohon.text == "2") buildYayasan(),
                  if (_idJenisPemohon.text == "3") buildPerusahaan(),
                  if (_idJenisPemohon.text != "") ...[
                    // const SizedBox(height: 15),
                    // const Text(
                    //   "PAS FOTO PEMOHON",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(height: 10),
                    // fotoPemohon != null
                    //     ? Image.file(
                    //         fotoPemohon!,
                    //         width: 150,
                    //         height: 200,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : _fotoPemohon.text != ""
                    //         ? DecoratedBox(
                    //             decoration: const BoxDecoration(
                    //               color: Colors.white,
                    //             ),
                    //             child: Image.network(
                    //               _fotoPemohon.text,
                    //               height: 200,
                    //               width: 150,
                    //               fit: BoxFit.cover,
                    //               errorBuilder: (BuildContext context,
                    //                   Object exception,
                    //                   StackTrace? stackTrace) {
                    //                 return const Text('Loading foto...');
                    //               },
                    //               loadingBuilder: (BuildContext context,
                    //                   Widget child,
                    //                   ImageChunkEvent? loadingProgress) {
                    //                 if (loadingProgress == null) return child;
                    //                 return Center(
                    //                   child: CircularProgressIndicator(
                    //                     value: loadingProgress
                    //                                 .expectedTotalBytes !=
                    //                             null
                    //                         ? loadingProgress
                    //                                 .cumulativeBytesLoaded /
                    //                             loadingProgress
                    //                                 .expectedTotalBytes!
                    //                         : null,
                    //                   ),
                    //                 );
                    //               },
                    //             ),
                    //           )
                    //         : Image.asset(
                    //             'assets/images/noimage.jpg',
                    //             height: 200,
                    //             width: 150,
                    //             fit: BoxFit.cover,
                    //           ),
                    // const SizedBox(height: 5),
                    // SizedBox(
                    //   child: ElevatedButton.icon(
                    //     onPressed: () {
                    //       Get.bottomSheet(
                    //         Container(
                    //           height: 125,
                    //           color: Colors.white,
                    //           child: ListView(
                    //             children: [
                    //               ListTile(
                    //                 leading: const Icon(Icons.camera_alt),
                    //                 title: const Text("Foto Dari Kamera"),
                    //                 onTap: () {
                    //                   Navigator.of(context).pop();
                    //                   getFoto(ImageSource.camera);
                    //                 },
                    //               ),
                    //               ListTile(
                    //                 leading: const Icon(Icons.image),
                    //                 title:
                    //                     const Text("Ambil File Dari Gallery"),
                    //                 onTap: () {
                    //                   Navigator.of(context).pop();
                    //                   getFoto(ImageSource.gallery);
                    //                 },
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     icon: const Icon(
                    //       Icons.upload,
                    //       size: 18,
                    //     ),
                    //     label: const Text(
                    //       "UNGGAH FOTO",
                    //       style: TextStyle(fontSize: 13),
                    //     ),
                    //   ),
                    // ),
                    // Visibility(
                    //   visible: false,
                    //   maintainState: true,
                    //   child: TextFormField(
                    //     controller: _fotoPemohon,
                    //     validator: (value) {
                    //       if (value == "") {
                    //         return "Error";
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // const SizedBox(height: 25),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _namaPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "NAMA LENGKAP PEMOHON",
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
                                labelText: "GELAR DEPAN",
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
                                labelText: "GELAR BELAKANG",
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
                        labelText: "ALAMAT RUMAH JALAN",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _dusunPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "DUSUN / LINGKUNGAN",
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
                              textCapitalization: TextCapitalization.words,
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
                              textCapitalization: TextCapitalization.words,
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
                          title: Text('${item.namaProp}',
                              style: const TextStyle(fontSize: 13)),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "PROPINSI",
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
                            labelText: "KOTA",
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
                            labelText: "KECAMATAN",
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
                            labelText: "DESA / KELURAHAN",
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
                        labelText: "KODE POS",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _latPemohon,
                      decoration: const InputDecoration(
                        labelText: "GARIS LINTANG",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      enabled: false,
                      validator: (value) {
                        if (value == "") {
                          return 'Garis Lintang wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _lngPemohon,
                      decoration: const InputDecoration(
                        labelText: "GARIS BUJUR",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      enabled: false,
                      validator: (value) {
                        if (value == "") {
                          return 'Garis Bujur wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                label: const Text(
                                  'KOORDINAT RUMAH',
                                  style: TextStyle(fontSize: 13),
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
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _tempLahirPemohon,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "TEMPAT LAHIR",
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
                        labelText: "TANGGAL LAHIR",
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
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: TextFormField(
                        controller: _tglLahirPemohon,
                        validator: (value) {
                          if (value == "") {
                            return "Error";
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_tglLahirPemohon.text == '') const Text("Wajib diisi"),
                    const SizedBox(height: 5),
                    DropdownSearch<Map<String, dynamic>>(
                      items: const [
                        {"id": 1, "kelamin": "LAKI-LAKI"},
                        {"id": 2, "kelamin": "PEREMPUAN"},
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "JENIS KELAMIN",
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
                        labelText: "PEKERJAAN",
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
                          labelText: "WARGANEGARA",
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
                            labelText: "NEGARA ASAL",
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
                        labelText: "ALAMAT EMAIL",
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
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "NOMOR HANDPHONE",
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
                        labelText: "NOMOR INDUK KEPENDUDUKAN",
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
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text("Foto Dari Kamera"),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    getKtp(ImageSource.camera);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text("Ambil File Dari Gallery"),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    getKtp(ImageSource.gallery);
                                  },
                                )
                              ],
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
                    const Divider(
                      height: 50,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
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
                                'POST', Uri.parse("$baseUrl/api/kkpr-user"));

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
                            errorPesan("ISIAN DATA BELUM LENGKAP");
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
            isActive: currentStep >= 1,
            state: currentStep >= 1 ? StepState.disabled : StepState.complete,
            title: const Text("DATA PERMOHONAN"),
            subtitle: const Text(
              "RINCIAN DATA PERMOHONAN KKPR",
              style: TextStyle(fontSize: 10),
            ),
            content: Form(
              key: _permohonanKey,
              child: Column(
                children: [
                  if (_idJenisPemohon.text != "") ...[
                    DropdownSearch<JenisKegiatanKkpr>(
                      asyncItems: (String filter) async {
                        var response = await http.get(
                          Uri.parse(
                              "$baseUrl/api/jenis-kegiatan-pkkpr?id_jenis_pemohon=${_idJenisPemohon.text}&key=${ApiContainer.baseKey}&id_kategori=1"),
                        );

                        if (response.statusCode != 200) {
                          errorData();
                          return [];
                        } else {
                          List jenisKegiatan = (json.decode(response.body)
                              as Map<String, dynamic>)["data"];

                          List<JenisKegiatanKkpr> jenisKegiatanList = [];

                          for (var element in jenisKegiatan) {
                            jenisKegiatanList
                                .add(JenisKegiatanKkpr.fromJson(element));
                          }

                          return jenisKegiatanList;
                        }
                      },
                      enabled: isKegiatan,
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text('${item.jenis}',
                              style: const TextStyle(fontSize: 13)),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "JENIS KEGIATAN",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          idPkkpr = value?.id;
                          _idPkkpr.text = value?.id.toString() as String;
                          _jenisPkkpr.text = value?.jenis ?? "";

                          varPernyataanMandiri = value?.pernyataanMandiri;
                          varKkprOtomatis = value?.kkprOtomatis;
                          varIprLama = value?.iprLama;

                          isKegiatan = false;
                        });
                      },
                      selectedItem: JenisKegiatanKkpr(
                        id: idPkkpr,
                        jenis: _jenisPkkpr.text,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?.jenis ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?.id == null) {
                          return 'Jenis Kegiatan wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                  if (idKategori != 1) ...[
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _kodeKbli,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "KODE KBLI",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return 'Kode KBLI wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _judulKbli,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "JUDUL KBLI",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return 'Judul KBLI wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    DropdownSearch<Map<String, dynamic>>(
                      items: const [
                        {"modal": "PMDN", "status_modal": "PMDN"},
                        {"modal": "PMA", "status_modal": "PMA"},
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "PENANAMAN MODAL",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _idPenanamanModal.text =
                              value?["modal"].toString() as String;
                          _penanamanModal.text = value?["status_modal"] ?? "";

                          isJenisPemohon = false;
                        });
                      },
                      selectedItem: {
                        "modal": _idPenanamanModal.text,
                        "status_modal": _penanamanModal.text
                      },
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            item["status_modal"],
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?["status_modal"] ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?["modal"] == "") {
                          return 'Penanaman Modal wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5)
                  ],
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _rencanaPeruntukan,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: "RENCANA PERUNTUKAN",
                      labelStyle: TextStyle(fontSize: 13),
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Rencana peruntukan wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _alamatLokasi,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: "ALAMAT LOKASI JALAN",
                      labelStyle: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _dusunLokasi,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: "DUSUN / LINGKUNGAN",
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
                            textCapitalization: TextCapitalization.words,
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
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: "RW",
                              labelStyle: TextStyle(fontSize: 13),
                            ),
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
                        labelText: "KECAMATAN",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _nokecLokasi.text = value?.noKec as String;
                        kecamatan = value?.namaKec;

                        _nokelLokasi.text = "";
                        desa = "";
                      });
                    },
                    selectedItem: KecamatanModels(
                      noKec: _nokecLokasi.text,
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
                        return 'Kecamatan lokasi dimohon wajib diisi';
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
                          labelText: "DESA / KELURAHAN",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _nokelLokasi.text = value?.noKel as String;
                          desa = value?.namaKel;
                        });
                      },
                      selectedItem: DesaModels(
                        noKel: _nokelLokasi.text,
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
                          return 'Desa/Kelurahan lokasi dimohon wajib diisi';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _luasTanah,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                    decoration: const InputDecoration(
                      labelText: "LUAS TANAH DIMOHON",
                      labelStyle: TextStyle(fontSize: 13),
                      suffixText: "m\u00B2",
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Luas tanah dimohon wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _luasTanahSesuaiBukti,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                    decoration: const InputDecoration(
                      labelText: "LUAS TANAH SESUAI BUKTI KEPEMILIKAN",
                      labelStyle: TextStyle(fontSize: 13),
                      suffixText: "m\u00B2",
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Luas tanah sesuai bukti kepemilikan wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _luasTanahBangunan,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                    decoration: const InputDecoration(
                      labelText: "LUAS TANAH UNTUK BANGUNAN",
                      labelStyle: TextStyle(fontSize: 13),
                      suffixText: "m\u00B2",
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Luas tanah untuk bangunan wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _penggunaanSekarang,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: "PENGGUNAAN TANAH SEKARANG",
                      labelStyle: TextStyle(fontSize: 13),
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Penggunaan tanah sekarang wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _jumlahLantai,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: "RENCANA JUMLAH LANTAI",
                      labelStyle: TextStyle(fontSize: 13),
                      suffixText: "lantai",
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Rencana jumlah lantai wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _tinggiBangunan,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                    decoration: const InputDecoration(
                      labelText: "RENCANA TINGGI BANGUNAN",
                      labelStyle: TextStyle(fontSize: 13),
                      suffixText: "m",
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Rencana tinggi bangunan wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _luasLantaiBangunan,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                    decoration: const InputDecoration(
                      labelText: "RENCANA LUAS LANTAI BANGUNAN",
                      labelStyle: TextStyle(fontSize: 13),
                      suffixText: "m\u00B2",
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Rencana luas lantai bangunan wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _latLokasi,
                    decoration: const InputDecoration(
                      labelText: "GARIS LINTANG",
                      labelStyle: TextStyle(fontSize: 13),
                    ),
                    enabled: false,
                    validator: (value) {
                      if (value == "") {
                        return 'Garis Lintang wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _lngLokasi,
                    decoration: const InputDecoration(
                      labelText: "GARIS BUJUR",
                      labelStyle: TextStyle(fontSize: 13),
                    ),
                    enabled: false,
                    validator: (value) {
                      if (value == "") {
                        return 'Garis Bujur wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              label: const Text(
                                'KOORDINAT LOKASI',
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
                                      -8.223600593616215, 114.36705853790045);
                                }

                                final result =
                                    await Get.to(() => MapKordinat(kordinat));

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
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              label: const Text(
                                'BUAT POLYGON LOKASI',
                                style: TextStyle(fontSize: 13),
                              ),
                              icon: const Icon(
                                Icons.map,
                                size: 18,
                              ),
                              onPressed: _latLokasi.text != ""
                                  ? () async {
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

                                      final result = await Get.to(() =>
                                          MapPolygon(kordinat, locationList));

                                      setState(() {
                                        if (result != null) {
                                          locationList = result;
                                          int item = 0;
                                          String lokasi =
                                              '{"type":"Feature","properties":{},"geometry":{"type":"Polygon","coordinates":[[';
                                          String hasil = "[[";

                                          for (var element in result) {
                                            //hasil = result.join(",");
                                            item++;
                                            if (item == result.length) {
                                              hasil =
                                                  '$hasil{"lat":${element.latitude.toString()},"lng":${element.longitude.toString()}}';
                                              lokasi =
                                                  '$lokasi[${element.longitude.toString()},${element.latitude.toString()}]';
                                            } else {
                                              hasil =
                                                  '$hasil{"lat":${element.latitude.toString()},"lng":${element.longitude.toString()}},';
                                              lokasi =
                                                  '$lokasi[${element.longitude.toString()},${element.latitude.toString()}],';
                                            }
                                          }

                                          hasil = "$hasil]]";
                                          lokasi = '$lokasi]]}}';

                                          _lokasiPolygon.text = lokasi;
                                          _kordinatPolygon.text = hasil;

                                          _polygonList.text =
                                              jsonEncode(result);
                                        }
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                minimumSize: const Size(double.infinity, 40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Center(
                  //         child: SizedBox(
                  //           width: double.infinity,
                  //           child: ElevatedButton.icon(
                  //             label: const Text(
                  //               'UNGGAH FILE KMZ',
                  //               style: TextStyle(fontSize: 13),
                  //             ),
                  //             icon: const Icon(
                  //               Icons.file_upload,
                  //               size: 18,
                  //             ),
                  //             onPressed:
                  //                 _latLokasi.text != "" ? () async {} : null,
                  //             style: ElevatedButton.styleFrom(
                  //               backgroundColor: Colors.teal,
                  //               minimumSize: const Size(double.infinity, 40),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 5),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _polygonList,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: "KOORDINAT DIMOHON",
                      labelStyle: TextStyle(fontSize: 13),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (value == "") {
                        return 'Koordinat dimohon wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  DropdownSearch<BakuAirModels>(
                    asyncItems: (String filter) async {
                      var response = await http.get(
                        Uri.parse(
                            "$baseUrl/api/baku-air?key=${ApiContainer.baseKey}"),
                      );

                      if (response.statusCode != 200) {
                        errorData();
                        return [];
                      } else {
                        List bentuk = (json.decode(response.body)
                            as Map<String, dynamic>)["data"];

                        List<BakuAirModels> bentukList = [];

                        for (var element in bentuk) {
                          bentukList.add(BakuAirModels.fromJson(element));
                        }

                        return bentukList;
                      }
                    },
                    popupProps: PopupProps.dialog(
                      itemBuilder: (context, item, isSelected) => ListTile(
                        title: Text(
                          '${item.variabel}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      fit: FlexFit.loose,
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "JENIS KEGIATAN BAKU AIR",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                    onChanged: (value) {
                      hapusBakuAir();

                      setState(() {
                        idNeracaAir = value?.id;
                        _idNeracaAir.text = idNeracaAir.toString();
                        _neracaAir.text = value?.variabel ?? "";
                        varPenghuni = value?.penghuni;
                        varPenghuniX = value?.penghuniX;
                        varJamaah = value?.jamaah;
                        varJamaahMandiX = value?.jamaahMandiX;
                        varJamaahWudluX = value?.jamaahWudluX;
                        varSiswa = value?.siswa;
                        varSiswaX = value?.siswaX;
                        varKaryawan = value?.karyawan;
                        varKaryawanX = value?.karyawanX;
                        varLBangunan = value?.lBangunan;
                        varLBangunanX = value?.lBangunanX;
                        varKursi = value?.kursi;
                        varKursiX = value?.kursiX;
                        varKebutuhan = value?.kebutuhan;
                        varSd = value?.sd;
                        varSdX = value?.sdX;
                        varSmp = value?.smp;
                        varSmpX = value?.smpX;
                        varSma = value?.sma;
                        varSmaX = value?.smaX;
                        varPt = value?.pt;
                        varPtX = value?.ptX;
                        varTambakLuas = value?.tambakLuas;
                        varTambakIntensitas = value?.tambakIntensitas;
                        varTambakX = value?.tambakX;
                        varTokoLuas = value?.tokoLuas;
                        varTokoLuasX = value?.tokoLuasX;
                      });
                    },
                    selectedItem: BakuAirModels(
                      id: idNeracaAir,
                      variabel: _neracaAir.text,
                      penghuni: varPenghuni,
                      penghuniX: varPenghuniX,
                      jamaah: varJamaah,
                      jamaahMandiX: varJamaahMandiX,
                      jamaahWudluX: varJamaahWudluX,
                      siswa: varSiswa,
                      siswaX: varSiswaX,
                      karyawan: varKaryawan,
                      karyawanX: varKaryawanX,
                      lBangunan: varLBangunan,
                      lBangunanX: varLBangunanX,
                      kursi: varKursi,
                      kursiX: varKursiX,
                      kebutuhan: varKebutuhan,
                      sd: varSd,
                      sdX: varSdX,
                      smp: varSmp,
                      smpX: varSmpX,
                      sma: varSma,
                      smaX: varSmaX,
                      pt: varPt,
                      ptX: varPtX,
                      tambakLuas: varTambakLuas,
                      tambakIntensitas: varTambakIntensitas,
                      tambakX: varTambakX,
                      tokoLuas: varTokoLuas,
                      tokoLuasX: varTokoLuasX,
                    ),
                    dropdownBuilder: (context, selectedItem) => Text(
                      selectedItem?.variabel ?? "",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    validator: (value) {
                      if (value?.variabel == "") {
                        return 'Neraca Baku Air wajib diisi';
                      }
                      return null;
                    },
                  ),
                  if (varPenghuni == 1) buildPenghuni(),
                  if (varJamaah == 1) buildJamaah(),
                  if (varSiswa == 1) buildSiswa(),
                  if (varKaryawan == 1) buildKaryawan(),
                  if (varLBangunan == 1) buildLuasBangunan(),
                  if (varKursi == 1) buildKursi(),
                  if (varKebutuhan == 1) buildKebutuhan(),
                  if (varSd == 1) buildSd(),
                  if (varSmp == 1) buildSmp(),
                  if (varSma == 1) buildSma(),
                  if (varPt == 1) buildMahasiswa(),
                  if (varTambakLuas == 1) buildLuasTambak(),
                  if (varTokoLuas == 1) buildLuasToko(),
                  const SizedBox(height: 20),
                  const Text(
                    "KEBUTUHAN AIR",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13),
                            controller: _airBersih,
                            decoration: const InputDecoration(
                              labelText: "AIR BERSIH",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixText: "L\u00B3/Hari",
                            ),
                            enabled: false,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13),
                            controller: _airBersihM,
                            decoration: const InputDecoration(
                              labelText: "AIR BERSIH",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixText: "m\u00B3/Hari",
                            ),
                            enabled: false,
                          ),
                        ),
                      ],
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
                            controller: _masakCuci,
                            decoration: const InputDecoration(
                              labelText: "MASAK CUCI KAKUS",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixText: "L\u00B3/Hari",
                            ),
                            enabled: false,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13),
                            controller: _masakCuciM,
                            decoration: const InputDecoration(
                              labelText: "MASAK CUCI KAKUS",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixText: "m\u00B3/Hari",
                            ),
                            enabled: false,
                          ),
                        ),
                      ],
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
                            controller: _penyiraman,
                            decoration: const InputDecoration(
                              labelText: "LAIN-LAIN",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixText: "L\u00B3/Hari",
                            ),
                            enabled: false,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13),
                            controller: _penyiramanM,
                            decoration: const InputDecoration(
                              labelText: "LAIN-LAIN",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixText: "m\u00B3/Hari",
                            ),
                            enabled: false,
                          ),
                        ),
                      ],
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
                            controller: _ipal,
                            decoration: const InputDecoration(
                              labelText: "KAPASITAS IPAL",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixText: "L\u00B3/Hari",
                            ),
                            enabled: false,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13),
                            controller: _ipalM,
                            decoration: const InputDecoration(
                              labelText: "KAPASITAS IPAL",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixText: "m\u00B3/Hari",
                            ),
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 50, thickness: 1, color: Colors.black),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_permohonanKey.currentState!.validate()) {
                          loadingData();

                          var request = await http.post(
                            Uri.parse("$baseUrl/api/kkpr-permohonan"),
                            body: {
                              "key": ApiContainer.baseKey,
                              "uid": _uidPemohon.text,
                              "id_pkkpr": _idPkkpr.text,
                              "penanaman_modal": _penanamanModal.text,
                              "kbli": _judulKbli.text,
                              "kode_kbli": _kodeKbli.text,
                              "rencana_peruntukan": _rencanaPeruntukan.text,
                              "alamat": _alamatLokasi.text,
                              "dusun": _dusunLokasi.text,
                              "rt": _rtLokasi.text,
                              "rw": _rwLokasi.text,
                              "no_kec": _nokecLokasi.text,
                              "no_kel": _nokelLokasi.text,
                              "lat": _latLokasi.text,
                              "lng": _lngLokasi.text,
                              "luas_lahan_dimohon": _luasTanah.text,
                              "luas_lahan_milik": _luasTanahSesuaiBukti.text,
                              "luas_lahan_bangunan": _luasTanahBangunan.text,
                              "penggunaan_sekarang": _penggunaanSekarang.text,
                              "rencana_lantai": _jumlahLantai.text,
                              "tinggi_bangunan": _tinggiBangunan.text,
                              "rencana_luas_lantai": _luasLantaiBangunan.text,
                              "lokasi_poligon": _lokasiPolygon.text,
                              "kordinat_poligon": _kordinatPolygon.text,
                              "polygon_ori": _polygonList.text,
                              "id_neraca_air": _idNeracaAir.text,
                              "penghuni": _penghuni.text,
                              "jamaah": _jamaah.text,
                              "siswa": _siswa.text,
                              "karyawan": _karyawan.text,
                              "l_bangunan": _lBangunan.text,
                              "kursi": _kursi.text,
                              "kebutuhan": _kebutuhan.text,
                              "sd": _sd.text,
                              "smp": _smp.text,
                              "sma": _sma.text,
                              "pt": _mahasiswa.text,
                              "luas_tambak": _luasTambak.text,
                              "insensitas_tambak": _intensitasTambak.text,
                              "luas_toko": _luasToko.text,
                              "air_bersih": _airBersih.text,
                              "masak_cuci": _masakCuci.text,
                              "penyiraman": _penyiraman.text,
                              "ipal": _ipal.text,
                              "id_jenis_pemohon": _idJenisPemohon.text,
                            },
                          );

                          Map<String, dynamic> hasil =
                              json.decode(request.body) as Map<String, dynamic>;

                          if (request.statusCode == 200) {
                            hapusLoader();
                            setState(() {
                              idPermohonan = hasil['data'];
                              currentStep++;
                            });
                          } else {
                            hapusLoader();
                            errorData();
                          }
                        } else {
                          hapusLoader();
                          errorPesan("ISIAN DATA BELUM LENGKAP");
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
            isActive: currentStep >= 2,
            state: currentStep >= 2 ? StepState.disabled : StepState.complete,
            title: const Text("LEGALITAS LAHAN"),
            subtitle: const Text(
              "DOKUMEN LEGALITAS LAHAN DIMOHON",
              style: TextStyle(fontSize: 10),
            ),
            content: Column(
              children: [
                const SizedBox(height: 10),
                if (legalList.isNotEmpty) ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: legalList.length,
                    itemBuilder: (context, itemIndex) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "LEGALITAS LAHAN ${itemIndex + 1}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(
                                  height: 20,
                                  thickness: 1,
                                  color: Colors.black),
                              Text(
                                "Luas tanah ${legalList[itemIndex].luasAkta.toString()} m\u00B2 dari total luas tanah ${_luasTanah.text} m\u00B2 dengan status kepemilikan tanah ${legalList[itemIndex].statusTanah.toString().toUpperCase()} atas nama ${legalList[itemIndex].atasNamaAkta.toString().toUpperCase()} tercantum dalam ${legalList[itemIndex].kode.toString()} No. ${legalList[itemIndex].nomorAkta.toString()} tahun ${legalList[itemIndex].tahunAkta.toString()} Surat Ukur No. ${legalList[itemIndex].suratUkur.toString()} tanggal ${DateFormat("d MMMM yyyy", "id").format(DateTime.parse(legalList[itemIndex].suratUkurTgl.toString()))} dan status lahan ${legalList[itemIndex].keadaanTanah.toString().toUpperCase()}.",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.justify,
                              ),
                              const Divider(
                                  height: 20,
                                  thickness: 1,
                                  color: Colors.black),
                              Text(
                                "DOKUMEN ${legalList[itemIndex].statusTanah.toString()}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              legalList[itemIndex].dokAkta != null
                                  ? Wrap(children: [
                                      for (String im in jsonDecode(
                                          legalList[itemIndex]
                                              .dokAkta
                                              .toString())) ...[
                                        Card(
                                          child: SizedBox(
                                            height: 100,
                                            width: 80,
                                            child: Image.network(
                                              im,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                              if (legalList[itemIndex].suketKematian !=
                                  null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "SURAT KETERANGAN KEMATIAN",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex]
                                          .suketKematian
                                          .toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              if (legalList[itemIndex].suketWaris != null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "SURAT KETERANGAN AHLI WARIS",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex]
                                          .suketWaris
                                          .toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              if (legalList[itemIndex].perjanjianSewa !=
                                  null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "SURAT PERJANJIAN SEWA",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex]
                                          .perjanjianSewa
                                          .toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              if (legalList[itemIndex].perikatanJualBeli !=
                                  null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "SURAT PERIKATAN JUAL BELI",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex]
                                          .perikatanJualBeli
                                          .toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              if (legalList[itemIndex].ajb != null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "AKTA JUAL BELI (AJB)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex].ajb.toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              if (legalList[itemIndex].pernyataanPemilikTanah !=
                                  null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "SURAT PERNYATAAN PEMILIK TANAH",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex]
                                          .pernyataanPemilikTanah
                                          .toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              if (legalList[itemIndex].akteHibah != null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "AKTA HIBAH",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex]
                                          .akteHibah
                                          .toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              if (legalList[itemIndex].pinjamPakai != null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "SURAT KETERANGAN PINJAM PAKAI",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex]
                                          .pinjamPakai
                                          .toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              if (legalList[itemIndex].petaBidang != null) ...[
                                const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: Colors.black),
                                const Text(
                                  "PETA BIDANG",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(children: [
                                  for (String im in jsonDecode(
                                      legalList[itemIndex]
                                          .petaBidang
                                          .toString())) ...[
                                    Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 80,
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
                              ],
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    loadingData();

                                    var response = await http.get(Uri.parse(
                                        "$baseUrl/api/kkpr-hapus-lahan?id=${legalList[itemIndex].id}&key=${ApiContainer.baseKey}"));

                                    if (response.statusCode == 200) {
                                      hapusLoader();
                                      setState(() {
                                        legalList.removeAt(itemIndex);
                                      });
                                    } else {
                                      hapusLoader();
                                      errorData();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  label: const Text("HAPUS"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
                ElevatedButton.icon(
                  onPressed: () async {
                    var result = await Get.to(
                        () => KkprLahan(idPermohonan, _namaPemohon.text));

                    if (result != null) {
                      setState(() {
                        legalList.add(
                          KkprTanahModels(
                            statusTanah: result['status_tanah'],
                            kode: result['kode'],
                            nomorAkta: result['nomor_akta'],
                            tahunAkta: result['tahun_akta'],
                            atasNamaAkta: result['atas_nama_akta'],
                            luasAkta: result['luas_akta'],
                            suratUkur: result['surat_ukur'],
                            dokAkta: result['dok_akta'],
                            suketKematian: result['suket_kematian'],
                            suketWaris: result['suket_waris'],
                            perjanjianSewa: result['perjanjian_sewa'],
                            perikatanJualBeli: result['perikatan_jual_beli'],
                            ajb: result['ajb'],
                            pernyataanPemilikTanah:
                                result['pernyataan_pemilik_tanah'],
                            akteHibah: result['akte_hibah'],
                            pinjamPakai: result['pinjam_pakai'],
                            petaBidang: result['peta_bidang'],
                            suratUkurTgl:
                                DateTime.parse(result['surat_ukur_tgl']),
                            keadaanTanah: result['keadaan_tanah'],
                            namaSendiri: result['nama_sendiri'],
                          ),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 35),
                  ),
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                  ),
                  label: const Text(
                    "TAMBAH LEGALITAS LAHAN",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const Divider(
                  height: 50,
                  thickness: 1,
                  color: Colors.black,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    var result = await http.get(Uri.parse(
                        "${ApiContainer.baseUrl}/api/kkpr-cek-legalitas?key=${ApiContainer.baseKey}&id=${idPermohonan.toString()}"));

                    if (result.statusCode != 200) {
                      errorData();
                      return;
                    } else {
                      if (json.decode(result.body)["data"] > 0) {
                        setState(() {
                          currentStep++;
                        });
                      } else {
                        return EasyLoading.showError(
                            "Anda belum menambahkan data legalitas lahan.");
                      }
                    }
                  },
                  label: const Text('SELANJUTNYA'),
                  icon: const Icon(Icons.check),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
          Step(
            isActive: currentStep >= 3,
            state: currentStep >= 3 ? StepState.disabled : StepState.complete,
            title: const Text("DOKUMEN"),
            subtitle: const Text(
              "DOKUMEN PERMOHONAN KKPR",
              style: TextStyle(fontSize: 10),
            ),
            content: Form(
              key: _dokumenKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    child: Text(
                      "SITEPLAN / MASTERPLAN",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  scanSitePlan != null
                      ? Wrap(
                          children: scanSitePlan!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 110,
                                  width: 90,
                                  child: Image.file(
                                    File(imageone.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => getSitePlan(),
                      label: const Text(
                        "UNGGAH DOKUMEN",
                        style: TextStyle(fontSize: 13),
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
                      controller: _dokSitePlan,
                      validator: (value) {
                        if (value == "") {
                          return "Error";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (_dokSitePlan.text == '')
                    const Align(
                      child: Text(
                        "Dokumen wajib diunggah",
                      ),
                    ),
                  const Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  const Align(
                    child: Text(
                      "FOTO LOKASI MINIMAL 3",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  scanFotoLokasi != null
                      ? Wrap(
                          children: scanFotoLokasi!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 110,
                                  width: 90,
                                  child: Image.file(
                                    File(imageone.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => getFotoLokasi(),
                      label: const Text(
                        "UNGGAH DOKUMEN",
                        style: TextStyle(fontSize: 13),
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
                      controller: _dokFotoLokasi,
                      validator: (value) {
                        if (value == "") {
                          return "Error";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (_dokFotoLokasi.text == '')
                    const Align(
                      child: Text(
                        "Dokumen wajib diunggah",
                      ),
                    ),
                  if (_idJenisPemohon.text == "2" ||
                      _idJenisPemohon.text == "3")
                    buildAkta(),
                  if (idKategori != 1) buildNib(),
                  if (varPernyataanMandiri == 1) buildPernyataanMandiri(),
                  if (varKkprOtomatis == 1) buildKkprOtomatis(),
                  if (varIprLama == 1) buildIprLama(),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: _catatan,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: "CATATAN PERMOHONAN",
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
                          loadingData();

                          Map<String, String> headers = {
                            'Content-Type': 'multipart/form-data',
                            'Accept': 'application/json',
                          };

                          Map<String, String> body = {
                            "uid": _uidPemohon.text,
                            "key": ApiContainer.baseKey,
                            "id": idPermohonan.toString(),
                            "catatan": _catatan.text,
                            "legal": _nomorAkta.text,
                            "kkpr_otomatis_nomor": _nomorKkprOtomatis.text,
                            "kkpr_otomatis_tgl": _tglKkprOtomatis.text,
                            "izin_prinsip_nomor": _nomorIzinPrinsip.text,
                            "izin_prinsip_tgl": _tglIzinPrinsip.text,
                            "izin_lokasi_nomor": _nomorIzinLokasi.text,
                            "izin_lokasi_tgl": _tglIzinLokasi.text,
                            "ippt_nomor": _nomorIppt.text,
                            "ippt_tgl": _tglIppt.text,
                          };

                          var request = http.MultipartRequest('POST',
                              Uri.parse("$baseUrl/api/kkpr-kirim-permohonan"));

                          request.headers.addAll(headers);
                          request.fields.addAll(body);

                          if (scanSitePlan != null) {
                            for (int i = 0; i < scanSitePlan!.length; i++) {
                              request.files.add(http.MultipartFile.fromBytes(
                                  'rencana_teknis[]',
                                  File(scanSitePlan![i].path).readAsBytesSync(),
                                  filename:
                                      scanSitePlan![i].path.split("/").last));
                            }
                          }

                          if (scanFotoLokasi != null) {
                            for (int i = 0; i < scanFotoLokasi!.length; i++) {
                              request.files.add(http.MultipartFile.fromBytes(
                                  'foto_lokasi[]',
                                  File(scanFotoLokasi![i].path)
                                      .readAsBytesSync(),
                                  filename:
                                      scanFotoLokasi![i].path.split("/").last));
                            }
                          }

                          if (scanAkta != null) {
                            for (int i = 0; i < scanAkta!.length; i++) {
                              request.files.add(http.MultipartFile.fromBytes(
                                  'dok_akta[]',
                                  File(scanAkta![i].path).readAsBytesSync(),
                                  filename: scanAkta![i].path.split("/").last));
                            }
                          }

                          if (scanPernyataanMandiri != null) {
                            for (int i = 0;
                                i < scanPernyataanMandiri!.length;
                                i++) {
                              request.files.add(http.MultipartFile.fromBytes(
                                  'pernyataan_mandiri[]',
                                  File(scanPernyataanMandiri![i].path)
                                      .readAsBytesSync(),
                                  filename: scanPernyataanMandiri![i]
                                      .path
                                      .split("/")
                                      .last));
                            }
                          }

                          if (scanKkprOtomatis != null) {
                            for (int i = 0; i < scanKkprOtomatis!.length; i++) {
                              request.files.add(http.MultipartFile.fromBytes(
                                  'kkpr_otomatis[]',
                                  File(scanKkprOtomatis![i].path)
                                      .readAsBytesSync(),
                                  filename: scanKkprOtomatis![i]
                                      .path
                                      .split("/")
                                      .last));
                            }
                          }

                          if (scanIzinPrinsip != null) {
                            for (int i = 0; i < scanIzinPrinsip!.length; i++) {
                              request.files.add(http.MultipartFile.fromBytes(
                                  'izin_prinsip[]',
                                  File(scanIzinPrinsip![i].path)
                                      .readAsBytesSync(),
                                  filename: scanIzinPrinsip![i]
                                      .path
                                      .split("/")
                                      .last));
                            }
                          }

                          if (scanIzinLokasi != null) {
                            for (int i = 0; i < scanIzinLokasi!.length; i++) {
                              request.files.add(http.MultipartFile.fromBytes(
                                  'izin_lokasi[]',
                                  File(scanIzinLokasi![i].path)
                                      .readAsBytesSync(),
                                  filename:
                                      scanIzinLokasi![i].path.split("/").last));
                            }
                          }

                          if (scanIppt != null) {
                            for (int i = 0; i < scanIppt!.length; i++) {
                              request.files.add(http.MultipartFile.fromBytes(
                                  'ippt[]',
                                  File(scanIppt![i].path).readAsBytesSync(),
                                  filename: scanIppt![i].path.split("/").last));
                            }
                          }

                          var response = await request.send();

                          if (response.statusCode == 200) {
                            hapusLoader();
                            pesanData("Permohonan KKPR Berhasil Dikirim");
                            Get.offAllNamed("/home");
                          } else {
                            hapusLoader();
                            errorData();
                          }
                        } else {
                          hapusLoader();
                          errorPesan("ISIAN DATA BELUM LENGKAP");
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
    );
  }

  Widget buildPenghuni() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _penghuni,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "JUMLAH PENGHUNI",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "ORANG",
            ),
            onChanged: (value) {
              setState(() {
                if (_penghuni.text != "") {
                  penghuniAir =
                      double.parse(_penghuni.text) * varPenghuniX!.toDouble();
                  penghuniMck = (double.parse(_penghuni.text) *
                          varPenghuniX!.toDouble()) *
                      0.7;
                  penghuniSrm = (double.parse(_penghuni.text) *
                          varPenghuniX!.toDouble()) *
                      0.3;
                  penghuniIpal = ((double.parse(_penghuni.text) *
                              varPenghuniX!.toDouble()) *
                          0.7) *
                      0.8;
                } else {
                  penghuniAir = 0;
                  penghuniMck = 0;
                  penghuniSrm = 0;
                  penghuniIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildJamaah() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _jamaah,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "ESTIMASI JUMLAH JAMAAH",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "ORANG",
            ),
            onChanged: (value) {
              setState(() {
                if (_jamaah.text != "") {
                  jamaahAir = (double.parse(_jamaah.text) *
                          varJamaahMandiX!.toDouble()) +
                      (double.parse(_jamaah.text) *
                          varJamaahWudluX!.toDouble());
                  jamaahMck = ((double.parse(_jamaah.text) *
                              varJamaahMandiX!.toDouble()) *
                          0.7) +
                      ((double.parse(_jamaah.text) *
                              varJamaahWudluX!.toDouble()) *
                          0.7);
                  jamaahSrm = ((double.parse(_jamaah.text) *
                              varJamaahMandiX!.toDouble()) *
                          0.3) +
                      ((double.parse(_jamaah.text) *
                              varJamaahWudluX!.toDouble()) *
                          0.3);
                  jamaahIpal = (((double.parse(_jamaah.text) *
                                  varJamaahMandiX!.toDouble()) *
                              0.7) *
                          0.8) +
                      (((double.parse(_jamaah.text) *
                                  varJamaahWudluX!.toDouble()) *
                              0.7) *
                          0.8);
                } else {
                  jamaahAir = 0;
                  jamaahMck = 0;
                  jamaahSrm = 0;
                  jamaahIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildSiswa() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _siswa,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "JUMLAH SISWA",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "ORANG",
            ),
            onChanged: (value) {
              setState(() {
                if (_siswa.text != "") {
                  siswaAir = double.parse(_siswa.text) * varSiswaX!.toDouble();
                  siswaMck =
                      (double.parse(_siswa.text) * varSiswaX!.toDouble()) * 0.7;
                  siswaSrm =
                      (double.parse(_siswa.text) * varSiswaX!.toDouble()) * 0.3;
                  siswaIpal =
                      ((double.parse(_siswa.text) * varSiswaX!.toDouble()) *
                              0.7) *
                          0.8;
                } else {
                  siswaAir = 0;
                  siswaMck = 0;
                  siswaSrm = 0;
                  siswaIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildKaryawan() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _karyawan,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "JUMLAH KARYAWAN",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "ORANG",
            ),
            onChanged: (value) {
              setState(() {
                if (_karyawan.text != "") {
                  karyawanAir =
                      double.parse(_karyawan.text) * varKaryawanX!.toDouble();
                  karyawanMck = (double.parse(_karyawan.text) *
                          varKaryawanX!.toDouble()) *
                      0.7;
                  karyawanSrm = (double.parse(_karyawan.text) *
                          varKaryawanX!.toDouble()) *
                      0.3;
                  karyawanIpal = ((double.parse(_karyawan.text) *
                              varKaryawanX!.toDouble()) *
                          0.7) *
                      0.8;
                } else {
                  karyawanAir = 0;
                  karyawanMck = 0;
                  karyawanSrm = 0;
                  karyawanIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildLuasBangunan() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _lBangunan,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            decoration: const InputDecoration(
              labelText: "LUAS BANGUNAN",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "m\u00B2",
            ),
            onChanged: (value) {
              setState(() {
                if (_lBangunan.text != "") {
                  lBangunanAir =
                      double.parse(_lBangunan.text) * varLBangunanX!.toDouble();
                  lBangunanMck = (double.parse(_lBangunan.text) *
                          varLBangunanX!.toDouble()) *
                      0.7;
                  lBangunanSrm = (double.parse(_lBangunan.text) *
                          varLBangunanX!.toDouble()) *
                      0.3;
                  lBangunanIpal = ((double.parse(_lBangunan.text) *
                              varLBangunanX!.toDouble()) *
                          0.7) *
                      0.8;
                } else {
                  lBangunanAir = 0;
                  lBangunanMck = 0;
                  lBangunanSrm = 0;
                  lBangunanIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildKursi() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _kursi,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "JUMLAH KURSI",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "KURSI",
            ),
            onChanged: (value) {
              setState(() {
                if (_kursi.text != "") {
                  kursiAir = double.parse(_kursi.text) * varKursiX!.toDouble();
                  kursiMck =
                      (double.parse(_kursi.text) * varKursiX!.toDouble()) * 0.7;
                  kursiSrm =
                      (double.parse(_kursi.text) * varKursiX!.toDouble()) * 0.3;
                  kursiIpal =
                      ((double.parse(_kursi.text) * varKursiX!.toDouble()) *
                              0.7) *
                          0.8;
                } else {
                  kursiAir = 0;
                  kursiMck = 0;
                  kursiSrm = 0;
                  kursiIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildKebutuhan() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _kebutuhan,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            decoration: const InputDecoration(
              labelText: "KEBUTUHAN AIR",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "L/Hari",
            ),
            onChanged: (value) {
              setState(() {
                if (_kebutuhan.text != "") {
                  kebutuhanAir = double.parse(_kebutuhan.text);
                  kebutuhanIpal = double.parse(_kebutuhan.text) * 0.8;
                } else {
                  kebutuhanAir = 0;
                  kebutuhanIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildSd() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _sd,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "JUMLAH MURID SD",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "ORANG",
            ),
            onChanged: (value) {
              setState(() {
                if (_sd.text != "") {
                  sdAir = double.parse(_sd.text) * varSdX!.toDouble();
                  sdMck = (double.parse(_sd.text) * varSdX!.toDouble()) * 0.7;
                  sdSrm = (double.parse(_sd.text) * varSdX!.toDouble()) * 0.3;
                  sdIpal =
                      ((double.parse(_sd.text) * varSdX!.toDouble()) * 0.7) *
                          0.8;
                } else {
                  sdAir = 0;
                  sdMck = 0;
                  sdSrm = 0;
                  sdIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildSmp() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _smp,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "JUMLAH MURID SMP",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "ORANG",
            ),
            onChanged: (value) {
              setState(() {
                if (_smp.text != "") {
                  smpAir = double.parse(_smp.text) * varSmpX!.toDouble();
                  smpMck =
                      (double.parse(_smp.text) * varSmpX!.toDouble()) * 0.7;
                  smpSrm =
                      (double.parse(_smp.text) * varSmpX!.toDouble()) * 0.3;
                  smpIpal =
                      ((double.parse(_smp.text) * varSmpX!.toDouble()) * 0.7) *
                          0.8;
                } else {
                  smpAir = 0;
                  smpMck = 0;
                  smpSrm = 0;
                  smpIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildSma() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _sma,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "JUMLAH MURID SMA",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "ORANG",
            ),
            onChanged: (value) {
              setState(() {
                if (_sma.text != "") {
                  smaAir = double.parse(_sma.text) * varSmaX!.toDouble();
                  smaMck =
                      (double.parse(_sma.text) * varSmaX!.toDouble()) * 0.7;
                  smaSrm =
                      (double.parse(_sma.text) * varSmaX!.toDouble()) * 0.3;
                  smaIpal =
                      ((double.parse(_sma.text) * varSmaX!.toDouble()) * 0.7) *
                          0.8;
                } else {
                  smaAir = 0;
                  smaMck = 0;
                  smaSrm = 0;
                  smaIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildMahasiswa() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _mahasiswa,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "JUMLAH MAHASISWA",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "ORANG",
            ),
            onChanged: (value) {
              setState(() {
                if (_mahasiswa.text != "") {
                  ptAir = double.parse(_mahasiswa.text) * varPtX!.toDouble();
                  ptMck = (double.parse(_mahasiswa.text) * varPtX!.toDouble()) *
                      0.7;
                  ptSrm = (double.parse(_mahasiswa.text) * varPtX!.toDouble()) *
                      0.3;
                  ptIpal =
                      ((double.parse(_mahasiswa.text) * varPtX!.toDouble()) *
                              0.7) *
                          0.8;
                } else {
                  ptAir = 0;
                  ptMck = 0;
                  ptSrm = 0;
                  ptIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildLuasTambak() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _luasTambak,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            decoration: const InputDecoration(
              labelText: "LUAS TAMBAK",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "m\u00B2",
            ),
            onChanged: (value) {
              setState(() {
                if (_luasTambak.text != "") {
                  tambakAir = double.parse(_luasTambak.text) *
                      double.parse(_intensitasTambak.text) *
                      varTambakX!.toDouble();
                  tambakIpal = (double.parse(_luasTambak.text) *
                          double.parse(_intensitasTambak.text) *
                          varTambakX!.toDouble()) *
                      0.8;
                } else {
                  tambakAir = 0;
                  tambakIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildIntensitasTambak() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _intensitasTambak,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "KAPASITAS TAMBAK",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Musim/Tahun",
            ),
            onChanged: (value) {
              setState(() {
                if (_intensitasTambak.text != "") {
                  tambakAir = double.parse(_luasTambak.text) *
                      double.parse(_intensitasTambak.text) *
                      varTambakX!.toDouble();
                  tambakIpal = (double.parse(_luasTambak.text) *
                          double.parse(_intensitasTambak.text) *
                          varTambakX!.toDouble()) *
                      0.8;
                } else {
                  tambakAir = 0;
                  tambakIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildLuasToko() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _luasToko,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            decoration: const InputDecoration(
              labelText: "LUAS TOKO",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "m\u00B2",
            ),
            onChanged: (value) {
              setState(() {
                if (_luasToko.text != "") {
                  tokoLuasAir =
                      double.parse(_luasToko.text) * varTokoLuasX!.toDouble();
                  tokoLuasMck = (double.parse(_luasToko.text) *
                          varTokoLuasX!.toDouble()) *
                      0.7;
                  tokoLuasSrm = (double.parse(_luasToko.text) *
                          varTokoLuasX!.toDouble()) *
                      0.3;
                  tokoLuasIpal = ((double.parse(_luasToko.text) *
                              varTokoLuasX!.toDouble()) *
                          0.7) *
                      0.8;
                } else {
                  tokoLuasAir = 0;
                  tokoLuasMck = 0;
                  tokoLuasSrm = 0;
                  tokoLuasIpal = 0;
                }

                jumlahBakuAir();
              });
            },
            validator: (value) {
              if (value == "") {
                return 'Wajib diisi';
              }
              return null;
            },
          ),
        ],
      );

  Widget buildPerusahaan() => Column(
        children: [
          const SizedBox(height: 15),
          const Text(
            "DATA PERUSAHAAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          DropdownSearch<BentukBadanKkprModels>(
            asyncItems: (String filter) async {
              var response = await http.get(
                Uri.parse(
                    "$baseUrl/api/bentuk-badan-pkkpr?key=${ApiContainer.baseKey}"),
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
                labelText: "BENTUK BADAN",
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
            decoration: const InputDecoration(
              labelText: "NAMA PERUSAHAAN TANPA BENTUK BADAN",
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
            decoration: const InputDecoration(
              labelText: "ALAMAT PERUSAHAAN JALAN",
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
            decoration: const InputDecoration(
              labelText: "DUSUN / LINGKUNGAN",
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
                labelText: "PROPINSI",
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
            const SizedBox(height: 1),
            DropdownSearch<KotaModels>(
              asyncItems: (String filter) async {
                var response = await http.get(
                  Uri.parse(
                      "$baseUrl/api/kota?no_prop=${_nopropBadan.text}&key=${ApiContainer.baseKey}"),
                );

                if (response.statusCode != 200) {
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
                  labelText: "KOTA",
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
                  labelText: "KECAMATAN",
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
            const SizedBox(height: 5),
            DropdownSearch<DesaModels>(
              asyncItems: (String filter) async {
                var response = await http.get(
                  Uri.parse(
                      "$baseUrl/api/desa?no_prop=${_nopropBadan.text}&no_kab=${_nokabBadan.text}&no_kec=${_nokecBadan.text}&key=${ApiContainer.baseKey}"),
                );

                if (response.statusCode != 200) {
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
                  labelText: "DESA / KELURAHAN",
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
          const SizedBox(height: 15),
          const Text(
            "DATA PEMOHON",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _jabatanPemohon,
            decoration: const InputDecoration(
              labelText: "JABATAN PEMOHON",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Jabatan wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
        ],
      );

  Widget buildYayasan() => Column(
        children: [
          const SizedBox(height: 15),
          const Text(
            "DATA YAYASAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _namaBadan,
            decoration: const InputDecoration(
              labelText: "NAMA YAYASAN",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Nama Yayasan wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _alamatBadan,
            decoration: const InputDecoration(
              labelText: "ALAMAT YAYASAN JALAN",
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
            decoration: const InputDecoration(
              labelText: "DUSUN / LINGKUNGAN",
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
                labelText: "PROPINSI",
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
                  labelText: "KOTA",
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
                  labelText: "KECAMATAN",
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
            const SizedBox(height: 5),
            DropdownSearch<DesaModels>(
              asyncItems: (String filter) async {
                var response = await http.get(
                  Uri.parse(
                      "$baseUrl/api/desa?no_prop=${_nopropBadan.text}&no_kab=${_nokabBadan.text}&no_kec=${_nokecBadan.text}&key=${ApiContainer.baseKey}"),
                );

                if (response.statusCode != 200) {
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
                  labelText: "DESA / KELURAHAN",
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
          const SizedBox(height: 15),
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
            decoration: const InputDecoration(
              labelText: "JABATAN PEMOHON",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Jabatan wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
        ],
      );

  Widget buildAkta() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "AKTA PENDIRIAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _nomorAkta,
            decoration: const InputDecoration(
              labelText: "NOMOR AKTA PENDIRIAN",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Nomor Akta wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          scanAkta != null
              ? Wrap(
                  children: scanAkta!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 110,
                          width: 90,
                          child: Image.file(
                            File(imageone.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getAkta(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
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
              controller: _dokAkta,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
        ],
      );

  Widget buildNib() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "NOMOR INDUK BERUSAHA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _nomorNib,
            decoration: const InputDecoration(
              labelText: "NOMOR INDUK BERUSAHA",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Nomor NIB wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          scanNib != null
              ? Wrap(
                  children: scanNib!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 110,
                          width: 90,
                          child: Image.file(
                            File(imageone.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getNib(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
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
              controller: _dokNib,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
        ],
      );

  Widget buildPernyataanMandiri() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "PERNYATAAN MANDIRI",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          scanPernyataanMandiri != null
              ? Wrap(
                  children: scanPernyataanMandiri!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 110,
                          width: 90,
                          child: Image.file(
                            File(imageone.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getPernyataanMandiri(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
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
              controller: _dokPernyataanMandiri,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
        ],
      );

  Widget buildKkprOtomatis() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "KKPR TERBIT OTOMATIS",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _nomorKkprOtomatis,
            decoration: const InputDecoration(
              labelText: "NOMOR KKPR TERBIT OTOMATIS",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Nomor KKPR wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              labelText: "TANGGAL",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            validator: (value) {
              if (value == "") {
                return 'Tanggal wajib diisi';
              }
              return null;
            },
            controller: _tglKkprOtomatis1,
            autocorrect: false,
            readOnly: true,
            onTap: () async {
              DateTime? newDateLahir = await showDatePicker(
                context: context,
                initialDate: _tglKkprOtomatis.text != ""
                    ? DateTime.parse(_tglKkprOtomatis.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateLahir != null) {
                setState(() {
                  _tglKkprOtomatis.text =
                      DateFormat("yyyy-MM-dd").format(newDateLahir);
                  _tglKkprOtomatis1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateLahir);
                });
              }
            },
          ),
          const SizedBox(height: 10),
          scanKkprOtomatis != null
              ? Wrap(
                  children: scanKkprOtomatis!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 110,
                          width: 90,
                          child: Image.file(
                            File(imageone.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getKkprOtomatis(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
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
              controller: _dokKkprOtomatis,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
        ],
      );

  Widget buildIprLama() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "IZIN PRINSIP",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _nomorIzinPrinsip,
            decoration: const InputDecoration(
              labelText: "NOMOR IZIN PRINSIP",
              labelStyle: TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              labelText: "TANGGAL",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglIzinPrinsip1,
            autocorrect: false,
            readOnly: true,
            onTap: () async {
              DateTime? newDateLahir = await showDatePicker(
                context: context,
                initialDate: _tglIzinPrinsip.text != ""
                    ? DateTime.parse(_tglIzinPrinsip.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateLahir != null) {
                setState(() {
                  _tglIzinPrinsip.text =
                      DateFormat("yyyy-MM-dd").format(newDateLahir);
                  _tglIzinPrinsip1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateLahir);
                });
              }
            },
          ),
          const SizedBox(height: 10),
          scanIzinPrinsip != null
              ? Wrap(
                  children: scanIzinPrinsip!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 110,
                          width: 90,
                          child: Image.file(
                            File(imageone.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getIzinPrinsip(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
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
              controller: _dokIzinPrinsip,
            ),
          ),
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "IZIN LOKASI",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _nomorIzinLokasi,
            decoration: const InputDecoration(
              labelText: "NOMOR IZIN LOKASI",
              labelStyle: TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              labelText: "TANGGAL",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglIzinLokasi1,
            autocorrect: false,
            readOnly: true,
            onTap: () async {
              DateTime? newDateLahir = await showDatePicker(
                context: context,
                initialDate: _tglIzinLokasi.text != ""
                    ? DateTime.parse(_tglIzinLokasi.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateLahir != null) {
                setState(() {
                  _tglIzinLokasi.text =
                      DateFormat("yyyy-MM-dd").format(newDateLahir);
                  _tglIzinLokasi1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateLahir);
                });
              }
            },
          ),
          const SizedBox(height: 10),
          scanIzinLokasi != null
              ? Wrap(
                  children: scanIzinLokasi!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 110,
                          width: 90,
                          child: Image.file(
                            File(imageone.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getIzinLokasi(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
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
              controller: _dokIzinLokasi,
            ),
          ),
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "IPPT",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _nomorIppt,
            decoration: const InputDecoration(
              labelText: "NOMOR IPPT",
              labelStyle: TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              labelText: "TANGGAL",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            controller: _tglIppt1,
            autocorrect: false,
            readOnly: true,
            onTap: () async {
              DateTime? newDateLahir = await showDatePicker(
                context: context,
                initialDate: _tglIppt.text != ""
                    ? DateTime.parse(_tglIppt.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateLahir != null) {
                setState(() {
                  _tglIppt.text = DateFormat("yyyy-MM-dd").format(newDateLahir);
                  _tglIppt1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateLahir);
                });
              }
            },
          ),
          const SizedBox(height: 10),
          scanIppt != null
              ? Wrap(
                  children: scanIppt!.map(
                    (imageone) {
                      return Card(
                        child: SizedBox(
                          height: 110,
                          width: 90,
                          child: Image.file(
                            File(imageone.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getIppt(),
              label: const Text(
                "UNGGAH DOKUMEN",
                style: TextStyle(fontSize: 13),
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
              controller: _dokIppt,
            ),
          ),
        ],
      );

  Future hapusBakuAir() async {
    setState(() {
      penghuniAir = 0.0;
      penghuniMck = 0.0;
      penghuniSrm = 0.0;
      penghuniIpal = 0.0;
      jamaahAir = 0.0;
      jamaahMck = 0.0;
      jamaahSrm = 0.0;
      jamaahIpal = 0.0;
      siswaAir = 0.0;
      siswaMck = 0.0;
      siswaSrm = 0.0;
      siswaIpal = 0.0;
      karyawanAir = 0.0;
      karyawanMck = 0.0;
      karyawanSrm = 0.0;
      karyawanIpal = 0.0;
      lBangunanAir = 0.0;
      lBangunanMck = 0.0;
      lBangunanSrm = 0.0;
      lBangunanIpal = 0.0;
      kursiAir = 0.0;
      kursiMck = 0.0;
      kursiSrm = 0.0;
      kursiIpal = 0.0;
      kebutuhanAir = 0.0;
      kebutuhanIpal = 0.0;
      sdAir = 0.0;
      sdMck = 0.0;
      sdSrm = 0.0;
      sdIpal = 0.0;
      smpAir = 0.0;
      smpMck = 0.0;
      smpSrm = 0.0;
      smpIpal = 0.0;
      smaAir = 0.0;
      smaMck = 0.0;
      smaSrm = 0.0;
      smaIpal = 0.0;
      ptAir = 0.0;
      ptMck = 0.0;
      ptSrm = 0.0;
      ptIpal = 0.0;
      tambakAir = 0.0;
      tambakIpal = 0.0;
      tokoLuasAir = 0.0;
      tokoLuasMck = 0.0;
      tokoLuasSrm = 0.0;
      tokoLuasIpal = 0.0;

      _airBersih.text = "";
      _airBersihM.text = "";
      _masakCuci.text = "";
      _masakCuciM.text = "";
      _penyiraman.text = "";
      _penyiramanM.text = "";
      _ipal.text = "";
      _ipalM.text = "";

      _penghuni.text = "";
      _jamaah.text = "";
      _siswa.text = "";
      _karyawan.text = "";
      _lBangunan.text = "";
      _kursi.text = "";
      _kebutuhan.text = "";
      _sd.text = "";
      _smp.text = "";
      _sma.text = "";
      _mahasiswa.text = "";
      _luasTambak.text = "";
      _intensitasTambak.text = "";
      _luasToko.text = "";
    });
  }

  Future jumlahBakuAir() async {
    setState(() {
      _airBersih.text = (penghuniAir +
              jamaahAir +
              siswaAir +
              karyawanAir +
              lBangunanAir +
              kursiAir +
              kebutuhanAir +
              sdAir +
              smpAir +
              smaAir +
              ptAir +
              tambakAir +
              tokoLuasAir)
          .toString();

      _masakCuci.text = (penghuniMck +
              jamaahMck +
              siswaMck +
              karyawanMck +
              lBangunanMck +
              kursiMck +
              sdMck +
              smpMck +
              smaMck +
              ptMck +
              tokoLuasMck)
          .toString();
      _penyiraman.text = (penghuniSrm +
              jamaahSrm +
              siswaSrm +
              karyawanSrm +
              lBangunanSrm +
              kursiSrm +
              sdSrm +
              smpSrm +
              smaSrm +
              ptSrm +
              tokoLuasSrm)
          .toString();
      _ipal.text = (penghuniIpal +
              jamaahIpal +
              siswaIpal +
              karyawanIpal +
              lBangunanIpal +
              kursiIpal +
              kebutuhanIpal +
              sdIpal +
              smpIpal +
              smaIpal +
              ptIpal +
              tambakIpal +
              tokoLuasIpal)
          .toString();

      _airBersihM.text = (double.parse(_airBersih.text) / 1000).toString();
      _masakCuciM.text = (double.parse(_masakCuci.text) / 1000).toString();
      _penyiramanM.text = (double.parse(_penyiraman.text) / 1000).toString();
      _ipalM.text = (double.parse(_ipal.text) / 1000).toString();
    });
  }
}
