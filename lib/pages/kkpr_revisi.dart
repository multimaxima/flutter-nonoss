import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
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
import 'kkpr_revisi_lahan.dart';
import 'map_kordinat.dart';

class KkprRevisi extends StatefulWidget {
  final int id;

  const KkprRevisi(this.id, {super.key});

  @override
  State<KkprRevisi> createState() => _KkprRevisiState();
}

class _KkprRevisiState extends State<KkprRevisi> {
  List<LatLng> locationList = [];
  List<KkprTanahModels> legalList = [];
  List legalitasLahan = [];

  final baseUrl = ApiContainer.baseUrl;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _permohonanKey = GlobalKey<FormState>();
  final _dokumenKey = GlobalKey<FormState>();

  Map<String, dynamic> user = {};
  Map<String, dynamic> izin = {};
  Map<String, dynamic> permohonan = {};
  Map<String, dynamic> pkkpr = {};
  Map<String, dynamic> air = {};
  Map<String, dynamic> jenis = {};

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
  final TextEditingController _kategoriPkkpr = TextEditingController();
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

  File? fotoPemohon;
  File? ktpPemohon;
  List<XFile>? scanSitePlan;
  List<XFile>? scanFotoLokasi;
  List<XFile>? scanAkta;

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
  bool isKegiatan = true;
  bool isKategori = true;
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

  Future getPermohonan() async {
    loadingData();
    var result = await http.get(Uri.parse(
        "$baseUrl/api/kkpr-revisi?id=${widget.id}&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();

      setState(() {
        user = json.decode(result.body)["user"];
        permohonan = json.decode(result.body)["permohonan"];
        izin = json.decode(result.body)["izin"];
        pkkpr = json.decode(result.body)["pkkpr"];
        air = json.decode(result.body)["air"];
        jenis = json.decode(result.body)["jenis"];

        _idPemohon.text = user["id"].toString();
        _uidPemohon.text = user["uid"] ?? "";
        _namaPemohon.text = user["nama"] ?? "";
        _gelarDepan.text = user["gelar_depan"] ?? "";
        _gelarBelakang.text = user["gelar_belakang"] ?? "";
        _alamatPemohon.text = user["alamat"] ?? "";
        _dusunPemohon.text = user["dusun"] ?? "";
        _rtPemohon.text = user["rt"] ?? "";
        _rwPemohon.text = user["rw"] ?? "";
        _nopropPemohon.text = user["no_prop"] ?? "";
        _nokabPemohon.text = user["no_kab"] ?? "";
        _nokecPemohon.text = user["no_kec"] ?? "";
        _nokelPemohon.text = user["no_kel"] ?? "";
        _propinsiPemohon.text = user["propinsi"] ?? "";
        _kotaPemohon.text = user["kota"] ?? "";
        _kecamatanPemohon.text = user["kecamatan"] ?? "";
        _desaPemohon.text = user["kelurahan"] ?? "";
        _kodeposPemohon.text = user["kodepos"] ?? "";
        _latPemohon.text = user["lat"] ?? "";
        _lngPemohon.text = user["lng"] ?? "";
        _tempLahirPemohon.text = user["temp_lahir"] ?? "";
        _tglLahirPemohon.text = user["tgl_lahir"] ?? "";
        _tglLahirPemohon1.text = _tglLahirPemohon.text != ""
            ? DateFormat("d MMMM yyyy", "id")
                .format(DateTime.parse(_tglLahirPemohon.text))
            : DateFormat("d MMMM yyyy", "id").format(DateTime.now());

        _kelaminPemohon.text = user["kelamin"].toString();
        _jenisKelaminPemohon.text = user["kelamin"] == 1
            ? 'LAKI-LAKI'
            : user["kelamin"] == 2
                ? 'PEREMPUAN'
                : '';
        _pekerjaanPemohon.text = user["pekerjaan"] ?? "";
        _wniPemohon.text = user["warganegara"].toString();
        _negaraPemohon.text = user["negara"] ?? "";
        _jenisWniPemohon.text = user["warganegara"] == 1
            ? 'INDONESIA'
            : user["warganegara"] == 2
                ? 'ASING'
                : '';
        _hpPemohon.text = user["hp"] ?? "";
        _waPemohon.text = user["whatsapp"] ?? "";
        _emailPemohon.text = user["email"] ?? "";
        _nikPemohon.text = user["nik"] ?? "";
        _fotoPemohon.text = user["foto"] ?? "";
        _ktpPemohon.text = user["dok_ktp"] ?? "";

        _idBadan.text =
            user["id_badan"] != null ? user["id_badan"].toString() : "";
        _idKetBadan.text = user["KET"] ?? "";
        _namaBadan.text = user["nama_badan"] ?? "";
        _alamatBadan.text = user["alamat_badan"] ?? "";
        _dusunBadan.text = user["dusun_badan"] ?? "";
        _rtBadan.text = user["rt_badan"] ?? "";
        _rwBadan.text = user["rw_badan"] ?? "";
        _nopropBadan.text = user["no_prop_badan"] ?? "";
        _propinsiBadan.text = user["propinsi_badan"] ?? "";
        _nokabBadan.text = user["no_kab_badan"] ?? "";
        _kotaBadan.text = user["kota_badan"] ?? "";
        _nokecBadan.text = user["no_kec_badan"] ?? "";
        _kecamatanBadan.text = user["kecamatan_badan"] ?? "";
        _nokelBadan.text = user["no_kel_badan"] ?? "";
        _desaBadan.text = user["kelurahan_badan"] ?? "";
        _jabatanPemohon.text = user["jabatan"] ?? "";

        _idJenisPemohon.text = pkkpr['id_jenis_pemohon'].toString();

        pkkpr['id_jenis_pemohon'].toString() == "1"
            ? _jenisPemohon.text = "PERORANGAN"
            : pkkpr['id_jenis_pemohon'].toString() == "2"
                ? _jenisPemohon.text = "BADAN USAHA"
                : pkkpr['id_jenis_pemohon'].toString() == "3"
                    ? _jenisPemohon.text = "YAYASAN"
                    : _jenisPemohon.text = "PEMERINTAH";

        idPkkpr = pkkpr['id_pkkpr'];
        _idPkkpr.text = pkkpr['id_pkkpr'].toString();
        _jenisPkkpr.text = pkkpr['jenis'] ?? "";

        _rencanaPeruntukan.text =
            _idPkkpr.text = pkkpr['rencana_peruntukan'] ?? "";
        _alamatLokasi.text = pkkpr['alamat'] ?? "";
        _dusunLokasi.text = pkkpr['dusun'] ?? "";
        _rtLokasi.text = pkkpr['rt'] ?? "";
        _rwLokasi.text = pkkpr['rw'] ?? "";
        _nokecLokasi.text = pkkpr['NO_KEC'] ?? "";
        kecamatan = pkkpr['kecamatan'] ?? "";
        _nokelLokasi.text = pkkpr['NO_KEL'] ?? "";
        desa = pkkpr['desa'] ?? "";
        _luasTanah.text = pkkpr['luas_lahan_dimohon'] ?? "";
        _luasTanahSesuaiBukti.text = pkkpr['luas_lahan_milik'] ?? "";
        _luasTanahBangunan.text = pkkpr['luas_lahan_bangunan'] ?? "";
        _penggunaanSekarang.text = pkkpr['penggunaan_sekarang'] ?? "";
        _jumlahLantai.text = pkkpr['rencana_lantai'].toString();
        _tinggiBangunan.text = pkkpr['tinggi_bangunan'] ?? "";
        _luasLantaiBangunan.text = pkkpr['rencana_luas_lantai'] ?? "";
        _latLokasi.text = pkkpr['lat'] ?? "";
        _lngLokasi.text = pkkpr['lng'] ?? "";
        _idNeracaAir.text = pkkpr['id_neraca_air'].toString();
        _neracaAir.text = pkkpr['variabel'] ?? "";
        _penghuni.text = pkkpr['penghuni'].toString();
        _jamaah.text = pkkpr['jamaah'].toString();
        _siswa.text = pkkpr['siswa'].toString();
        _karyawan.text = pkkpr['karyawan'].toString();
        _lBangunan.text = pkkpr['l_bangunan'].toString();
        _kursi.text = pkkpr['kursi'].toString();
        _kebutuhan.text = pkkpr['kebutuhan'].toString();
        _sd.text = pkkpr['sd'].toString();
        _smp.text = pkkpr['smp'].toString();
        _sma.text = pkkpr['sma'].toString();
        _mahasiswa.text = pkkpr['pt'].toString();
        _luasTambak.text = pkkpr['luas_tambak'].toString();
        _intensitasTambak.text = pkkpr['insensitas_tambak'].toString();
        _luasToko.text = pkkpr['luas_toko'].toString();
        _airBersih.text = pkkpr['air_bersih'].toString();
        _airBersihM.text = pkkpr['air_bersihM'].toString();
        _masakCuci.text = pkkpr['masak_cuci'].toString();
        _masakCuciM.text = pkkpr['masak_cuciM'].toString();
        _penyiraman.text = pkkpr['penyiraman'].toString();
        _penyiramanM.text = pkkpr['penyiramanM'].toString();
        _ipal.text = pkkpr['ipal'].toString();
        _ipalM.text = pkkpr['ipalM'].toString();
        _polygonList.text = pkkpr['polygon_ori'] ?? "";
        _catatan.text = pkkpr['catatan'] ?? "";
        _nomorAkta.text = user['sk_badan'] ?? "";

        for (var element in jsonDecode(pkkpr['polygon_ori'])) {
          locationList.add(LatLng(element[0], element[1]));
        }

        for (var element in json.decode(result.body)["tanah"]) {
          legalList.add(KkprTanahModels.fromJson(element));
        }

        _lokasiPolygon.text = pkkpr['lokasi_poligon'].toString();
        _kordinatPolygon.text = pkkpr['kordinat_poligon'].toString();

        varPenghuni = air['penghuni'];
        varPenghuniX = air['penghuni_x'];
        varJamaah = air['jamaah'];
        varJamaahMandiX = air['jamaah_mandi_x'];
        varJamaahWudluX = air['jamaah_wudlu_x'];
        varSiswa = air['siswa'];
        varSiswaX = air['siswa_x'];
        varKaryawan = air['karyawan'];
        varKaryawanX = air['karyawan_x'];
        varLBangunan = air['l_bangunan'];
        varLBangunanX = air['l_bangunan_x'];
        varKursi = air['kursi'];
        varKursiX = air['kursi_x'];
        varKebutuhan = air['kebutuhan'];
        varSd = air['sd'];
        varSdX = air['sd_x'];
        varSmp = air['smp'];
        varSmpX = air['smp_x'];
        varSma = air['sma'];
        varSmaX = air['sma_x'];
        varPt = air['pt'];
        varPtX = air['pt_x'];
        varTambakLuas = air['tambak_luas'];
        varTambakIntensitas = air['tambak_intensitas'];
        varTambakX = air['tambak_x'];
        varTokoLuas = air['toko_luas'];
        varTokoLuasX = air['toko_luas_x'];

        idKategori = jenis['id_kategori'];
        _kategoriPkkpr.text = jenis['kategori'].toString();

        _dokSitePlan.text = pkkpr['rencana_teknis'] ?? "";
        _dokFotoLokasi.text = pkkpr['foto_lokasi'] ?? "";
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
    getPermohonan();
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
            "Revisi KKPR",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Kesesuaian Kegiatan Pemanfaatan Ruang",
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
                    if (pkkpr["hasil_staf"] == 2) ...[
                      Html(data: "<b>${pkkpr["catatan_staf"].toString()}</b>"),
                      const SizedBox(height: 10),
                      Html(
                        data:
                            "<span style='font-size: 13px;'>Apabila sampai dengan <b>${permohonan['jth_tempo_revisi'].toString()}</b> Anda masih belum mengirim hasil revisi, permohonan Anda akan batal secara otomatis.</span>",
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (pkkpr["hasil_staf_pnbp"] == 2) ...[
                      Html(
                          data:
                              "<b>${pkkpr["catatan_staf_pnbp"].toString()}</b>"),
                      const SizedBox(height: 10),
                      Html(
                        data:
                            "<span style='font-size: 13px;'>Apabila sampai dengan <b>${permohonan['jth_tempo_revisi'].toString()}</b> Anda masih belum mengirim hasil revisi, permohonan Anda akan batal secara otomatis.</span>",
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (pkkpr["hasil_staf_bpn"] == 2) ...[
                      Html(
                          data:
                              "<b>${pkkpr["catatan_staf_bpn"].toString()}</b>"),
                      const SizedBox(height: 10),
                      Html(
                        data:
                            "<span style='font-size: 13px;'>Apabila sampai dengan <b>${permohonan['jth_tempo_revisi'].toString()}</b> Anda masih belum mengirim hasil revisi, permohonan Anda akan batal secara otomatis.</span>",
                      ),
                      const SizedBox(height: 10),
                    ],
                    DropdownSearch<Map<String, dynamic>>(
                      items: const [
                        {"id": 1, "id_jenis_pemohon": "PERORANGAN"},
                        {"id": 2, "id_jenis_pemohon": "YAYASAN"},
                        {"id": 3, "id_jenis_pemohon": "PERUSAHAAN"},
                        {"id": 4, "id_jenis_pemohon": "PEMERINTAH"},
                      ],
                      enabled: false,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Jenis Pemohon",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _idJenisPemohon.text =
                              value?["id"].toString() as String;
                          _jenisPemohon.text = value?["id_jenis_pemohon"] ?? "";

                          isJenisPemohon = false;
                        });
                      },
                      selectedItem: {
                        "id": pkkpr['id_jenis_permohonan'].toString(),
                        "id_jenis_pemohon": _jenisPemohon.text
                      },
                      popupProps: PopupProps.dialog(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            item["id_jenis_pemohon"],
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?["id_jenis_pemohon"] ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?["id"] == "") {
                          return 'Jenis pemohon wajib diisi';
                        }
                        return null;
                      },
                    ),
                    if (_idJenisPemohon.text == "2") buildYayasan(),
                    if (_idJenisPemohon.text == "3") buildPerusahaan(),
                    if (_idJenisPemohon.text != "") ...[
                      const SizedBox(height: 15),
                      const Text("PAS FOTO PEMOHON"),
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
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title:
                                          const Text("Ambil File Dari Gallery"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        getFoto(ImageSource.gallery);
                                      },
                                    )
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
                          controller: _fotoPemohon,
                          validator: (value) {
                            if (value == "") {
                              return "Error";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
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
                            hapusLoader();
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
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  label: const Text(
                                    'KORDINAT RUMAH',
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
                        textCapitalization: TextCapitalization.words,
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
                      const SizedBox(height: 10),
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
                                    title:
                                        const Text("Ambil File Dari Gallery"),
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
                                "id": widget.id.toString(),
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

                              var request = http.MultipartRequest('POST',
                                  Uri.parse("$baseUrl/api/kkpr-revisi-user"));

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
                    ]
                  ],
                ),
              ),
            ),
            Step(
              isActive: currentStep >= 1,
              state: currentStep >= 1 ? StepState.disabled : StepState.complete,
              title: const Text("DATA PERMOHONAN"),
              subtitle: const Text("Rincian Permohonan KKPR"),
              content: Form(
                key: _permohonanKey,
                child: Column(
                  children: [
                    if (_idJenisPemohon.text != "") ...[
                      DropdownSearch<JenisKegiatanKkpr>(
                        asyncItems: (String filter) async {
                          var response = await http.get(
                            Uri.parse(
                                "$baseUrl/api/jenis-kegiatan-pkkpr?id_jenis_pemohon=${_idJenisPemohon.text}&key=${ApiContainer.baseKey}"),
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
                        enabled: false,
                        popupProps: PopupProps.dialog(
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
                          labelText: "Kegiatan",
                          labelStyle: TextStyle(fontSize: 13),
                        )),
                        onChanged: (value) {
                          setState(() {
                            idPkkpr = value?.id;
                            _idPkkpr.text = value?.id.toString() as String;
                            _jenisPkkpr.text = value?.jenis ?? "";

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
                            return 'Kegiatan wajib diisi';
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
                          labelText: "Kode KBLI",
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
                          labelText: "Judul KBLI",
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
                            labelText: "Penanaman Modal",
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
                        labelText: "Rencana Peruntukan",
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
                        labelText: "Alamat Lokasi Jalan",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
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
                            labelText: "Desa/Kelurahan",
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
                        labelText: "Luas Tanah Dimohon",
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
                        labelText: "Luas Tanah Sesuai Bukti Kepemilikan",
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
                        labelText: "Luas Tanah Untuk Bangunan",
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
                        labelText: "Penggunaan Tanah Sekarang",
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
                        labelText: "Rencana Jumlah Lantai",
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
                        labelText: "Rencana Tinggi Bangunan",
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
                        labelText: "Rencana Luas Lantai Bangunan",
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
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                label: const Text(
                                  'KORDINAT LOKASI',
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
                    const SizedBox(height: 15),
                    TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _polygonList,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Kordinat dimohon",
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value == "") {
                          return 'Kordinat dimohon wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
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
                          labelText: "Jenis Kegiatan Baku Air",
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
                                labelText: "Air Bersih",
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
                                labelText: "Air Bersih",
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
                                labelText: "Masak Cuci Kakus",
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
                                labelText: "Masak Cuci Kakus",
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
                                labelText: "Lain-lain",
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
                                labelText: "Lain-lain",
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
                                labelText: "Kapasitas IPAL",
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
                                labelText: "Kapasitas IPAL",
                                labelStyle: TextStyle(fontSize: 13),
                                suffixText: "m\u00B3/Hari",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                        height: 50, thickness: 1, color: Colors.black),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_permohonanKey.currentState!.validate()) {
                            loadingData();

                            var request = await http.post(
                              Uri.parse("$baseUrl/api/kkpr-revisi-permohonan"),
                              body: {
                                "key": ApiContainer.baseKey,
                                "uid": _uidPemohon.text,
                                "id": widget.id.toString(),
                                "id_pkkpr": _idPkkpr.text,
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
              isActive: currentStep >= 2,
              state: currentStep >= 2 ? StepState.disabled : StepState.complete,
              title: const Text("LEGALITAS LAHAN"),
              subtitle: const Text("Dokumen Legalitas Lahan Dimohon"),
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
                                const Text(
                                  "Status Tanah : ",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "${legalList[itemIndex].statusTanah.toString()} (${legalList[itemIndex].kode.toString()})",
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "No. ${legalList[itemIndex].nomorAkta.toString()} Tahun ${legalList[itemIndex].tahunAkta.toString()}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Atas Nama : ",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  legalList[itemIndex].atasNamaAkta.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Surat Ukur : ",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "No. ${legalList[itemIndex].suratUkur.toString()}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "Tanggal ${DateFormat("d MMMM yyyy", "id").format(DateTime.parse(legalList[itemIndex].suratUkurTgl.toString()))}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "Luas Lahan : ${legalList[itemIndex].luasAkta.toString()} m\u00B2",
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Keadaan Tanah : ",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  legalList[itemIndex].keadaanTanah.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
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
                                legalList[itemIndex].dokAkta.toString() != "[]"
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
                                if (legalList[itemIndex]
                                        .suketKematian
                                        .toString() !=
                                    "[]") ...[
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
                                ],
                                if (legalList[itemIndex]
                                        .suketWaris
                                        .toString() !=
                                    "[]") ...[
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
                                ],
                                if (legalList[itemIndex]
                                        .perjanjianSewa
                                        .toString() !=
                                    "[]") ...[
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
                                ],
                                if (legalList[itemIndex]
                                        .perikatanJualBeli
                                        .toString() !=
                                    "[]") ...[
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
                                ],
                                if (legalList[itemIndex].ajb.toString() !=
                                    "[]") ...[
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
                                        legalList[itemIndex]
                                            .ajb
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
                                ],
                                if (legalList[itemIndex]
                                        .pernyataanPemilikTanah
                                        .toString() !=
                                    "[]") ...[
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
                                ],
                                if (legalList[itemIndex].akteHibah.toString() !=
                                    "[]") ...[
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
                                ],
                                if (legalList[itemIndex]
                                        .pinjamPakai
                                        .toString() !=
                                    "[]") ...[
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
                  ElevatedButton(
                    onPressed: () async {
                      var result = await Get.to(() =>
                          KkprLahanRevisi(pkkpr['id'], _namaPemohon.text));

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
                              suratUkurTgl:
                                  DateTime.parse(result['surat_ukur_tgl']),
                              keadaanTanah: result['keadaan_tanah'],
                              namaSendiri: result['nama_sendiri'],
                            ),
                          );
                        });
                      }
                    },
                    child: const Text("TAMBAH LEGALITAS LAHAN"),
                  ),
                  const Divider(height: 50, thickness: 1, color: Colors.black),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        currentStep++;
                      });
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
              subtitle: const Text("Dokumen Permohonan KKPR"),
              content: Form(
                key: _dokumenKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Align(
                      child: Text(
                        "SITEPLAN / MASTERPLAN",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        : _dokSitePlan.text != ""
                            ? Wrap(children: [
                                for (String im
                                    in jsonDecode(_dokSitePlan.text)) ...[
                                  Card(
                                    child: SizedBox(
                                      height: 110,
                                      width: 90,
                                      child: Image.network(
                                        im,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
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
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () => getSitePlan(),
                        label: const Text("UNGGAH DOKUMEN"),
                        icon: const Icon(Icons.upload),
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
                        height: 30, thickness: 1, color: Colors.black),
                    const Align(
                      child: Text(
                        "FOTO LOKASI MINIMAL 3",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        : _dokFotoLokasi.text != ""
                            ? Wrap(children: [
                                for (String im
                                    in jsonDecode(_dokFotoLokasi.text)) ...[
                                  Card(
                                    child: SizedBox(
                                      height: 110,
                                      width: 90,
                                      child: Image.network(
                                        im,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
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
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () => getFotoLokasi(),
                        label: const Text("UNGGAH DOKUMEN"),
                        icon: const Icon(Icons.upload),
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
                      buildPerusahaan(),
                    const Divider(
                        height: 50, thickness: 1, color: Colors.black),
                    TextFormField(
                      style: const TextStyle(fontSize: 14),
                      controller: _catatan,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Catatan Pemohon",
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                          if (_dokumenKey.currentState!.validate()) {
                            loadingData();

                            Map<String, String> headers = {
                              'Content-Type': 'multipart/form-data',
                              'Accept': 'application/json',
                            };

                            Map<String, String> body = {
                              "uid": _uidPemohon.text,
                              "key": ApiContainer.baseKey,
                              "id": widget.id.toString(),
                              "catatan": _catatan.text,
                              "legal": _nomorAkta.text,
                            };

                            var request = http.MultipartRequest('POST',
                                Uri.parse("$baseUrl/api/kkpr-revisi-kirim"));

                            request.headers.addAll(headers);
                            request.fields.addAll(body);

                            if (scanSitePlan != null) {
                              for (int i = 0; i < scanSitePlan!.length; i++) {
                                request.files.add(http.MultipartFile.fromBytes(
                                    'rencana_teknis[]',
                                    File(scanSitePlan![i].path)
                                        .readAsBytesSync(),
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
                                    filename: scanFotoLokasi![i]
                                        .path
                                        .split("/")
                                        .last));
                              }
                            }

                            if (scanAkta != null) {
                              for (int i = 0; i < scanAkta!.length; i++) {
                                request.files.add(http.MultipartFile.fromBytes(
                                    'dok_akta[]',
                                    File(scanAkta![i].path).readAsBytesSync(),
                                    filename:
                                        scanAkta![i].path.split("/").last));
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
                            errorPesan("Silahkan melengkapi semua data");
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

  Widget buildPenghuni() => Column(
        children: [
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _penghuni,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "Jumlah Penghuni",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Orang",
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
              labelText: "Estimasi Jumlah Jamaah",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Orang",
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
              labelText: "Jumlah Siswa",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Orang",
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
              labelText: "Jumlah Karyawan",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Orang",
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
              labelText: "Luas Bangunan",
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
              labelText: "Jumlah Kursi",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Kursi",
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
              labelText: "Kebutuhan Air",
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
              labelText: "Jumlah Murid SD",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Orang",
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
              labelText: "Jumlah Murid SMP",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Orang",
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
              labelText: "Jumlah Murid SMA",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Orang",
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
              labelText: "Jumlah Mahasiswa",
              labelStyle: TextStyle(fontSize: 13),
              suffixText: "Orang",
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
              labelText: "Luas Tambak",
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
              labelText: "Luas Tambak",
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
              labelText: "Luas Toko",
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
          const Divider(height: 30, thickness: 1, color: Colors.black),
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
            decoration: const InputDecoration(
              labelText: "Alamat",
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
          const SizedBox(height: 10),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _jabatanPemohon,
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
          const SizedBox(height: 5),
        ],
      );

  Widget buildYayasan() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "DATA YAYASAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _namaBadan,
            decoration: const InputDecoration(
              labelText: "Nama Yayasan",
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
              labelText: "Alamat",
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
          const SizedBox(height: 10),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _jabatanPemohon,
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
          const SizedBox(height: 5),
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
          const SizedBox(height: 15),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _nomorAkta,
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
            height: 50,
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
