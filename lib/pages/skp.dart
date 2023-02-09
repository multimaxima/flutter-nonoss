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
import '../models/anggota_skp.dart';
import '../models/lokasi_skp.dart';
import 'map_kordinat.dart';

class SKP extends StatefulWidget {
  const SKP({super.key});

  @override
  State<SKP> createState() => _SKPState();
}

class _SKPState extends State<SKP> {
  final baseUrl = ApiContainer.baseUrl;
  String autocompletePlace = "";
  final _anggotaKey = GlobalKey<FormState>();
  final _lokasiKey = GlobalKey<FormState>();

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

  final TextEditingController _idJenisPeneliti = TextEditingController();
  final TextEditingController _jenisPeneliti = TextEditingController();
  final TextEditingController _idAsalPeneliti = TextEditingController();
  final TextEditingController _asalPeneliti = TextEditingController();
  final TextEditingController _namaAnggota = TextEditingController();
  final TextEditingController _alamatAnggota = TextEditingController();
  final TextEditingController _judulPenelitian = TextEditingController();
  final TextEditingController _tujuanPenelitian = TextEditingController();
  final TextEditingController _pimpinanLokasi = TextEditingController();
  final TextEditingController _lokasiLokasi = TextEditingController();
  final TextEditingController _tglMulai = TextEditingController();
  final TextEditingController _tglMulai1 = TextEditingController();
  final TextEditingController _tglSampai = TextEditingController();
  final TextEditingController _tglSampai1 = TextEditingController();
  final TextEditingController _tglProposal = TextEditingController();
  final TextEditingController _tglProposal1 = TextEditingController();
  final TextEditingController _nomorProposal = TextEditingController();
  final TextEditingController _dokProposal = TextEditingController();
  final TextEditingController _dokPengantar = TextEditingController();
  final TextEditingController _dokPengesahan = TextEditingController();
  final TextEditingController _dokTerdaftar = TextEditingController();
  final TextEditingController _catatan = TextEditingController();
  final TextEditingController _namaLembaga = TextEditingController();

  File? fotoPemohon;
  File? ktpPemohon;
  List<XFile>? scanProposal;
  List<XFile>? scanPengantar;
  List<XFile>? scanPengesahan;
  List<XFile>? scanTerdaftar;

  bool isJenisPeneliti = true;
  bool isAsalPeneliti = true;
  String? disclaimer;

  bool isPemohonKirim = true;
  int currentStep = 0;
  List<AnggotaSkpModels> anggotaList = [];
  List<LokasiSkpModels> lokasiList = [];

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

      hapusLoader();

      final fotoPicked = File(fotoPemohon.path);
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
      hapusLoader();

      final ktpPicked = File(ktpPemohon.path);
      setState(() {
        _ktpPemohon.text = ktpPicked.toString();
        this.ktpPemohon = ktpPicked;
      });
    } on PlatformException catch (e) {
      hapusLoader();
      errorPesan("Gagal mendapatkan gambar : $e");
    }
  }

  Future getProposal() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanProposal = pickedfiles;
        hapusLoader();
        setState(() {
          _dokProposal.text = scanProposal.toString();
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

  Future getPengantar() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanPengantar = pickedfiles;
        hapusLoader();
        setState(() {
          _dokPengantar.text = scanPengantar.toString();
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

  Future getPengesahan() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanPengesahan = pickedfiles;
        hapusLoader();
        setState(() {
          _dokPengesahan.text = scanPengesahan.toString();
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

  Future getTerdaftar() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanTerdaftar = pickedfiles;
        hapusLoader();
        setState(() {
          _dokTerdaftar.text = scanTerdaftar.toString();
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

  Future getUser() async {
    loadingData();

    var result = await getUserDetil();
    var izin = await http.get(Uri.parse(
        "${ApiContainer.baseUrl}/api/skp-izin?key=${ApiContainer.baseKey}"));

    if (izin.statusCode == 200) {
      var disc = json.decode(izin.body);

      setState(() {
        disclaimer = disc["disclaimer"].toString();
      });
    }

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
            "SKP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Surat Keterangan Penelitian",
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
                    ElevatedButton.icon(
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
                                  getFoto(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text("Ambil File Dari Gallery"),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  getFoto(ImageSource.gallery);
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
                        "UNGGAH FOTO",
                        style: TextStyle(fontSize: 13),
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
                    const SizedBox(height: 20),
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
                        style: const TextStyle(fontSize: 14),
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
                              "uid": _uidPemohon.text,
                              "key": ApiContainer.baseKey,
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
                                'POST', Uri.parse("$baseUrl/api/skp-user"));

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
              subtitle: const Text("Rincian Permohonan SKP"),
              content: Form(
                key: _permohonanKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    DropdownSearch<Map<String, dynamic>>(
                      items: const [
                        {"id": 1, "jenis": "PERSEORANGAN"},
                        {"id": 2, "jenis": "KELOMPOK WNI"},
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Jenis Peneliti",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                      enabled: isJenisPeneliti,
                      onChanged: (value) {
                        setState(() {
                          _idJenisPeneliti.text =
                              value?["id"].toString() as String;
                          _jenisPeneliti.text = value?["jenis"] ?? "";
                          isJenisPeneliti = false;
                        });
                      },
                      selectedItem: {
                        "id": _idJenisPeneliti.text,
                        "jenis": _jenisPeneliti.text
                      },
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) => ListTile(
                          title: Text(
                            item["jenis"],
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?["jenis"] ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value?["id"] == "") {
                          return 'Jenis peneliti wajib diisi';
                        }
                        return null;
                      },
                    ),
                    if (_idJenisPeneliti.text == "2") ...[
                      const SizedBox(height: 15),
                      const Text(
                        "ANGGOTA PENELITIAN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: anggotaList.length,
                        itemBuilder: (context, itemIndex) {
                          return Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: IconButton(
                                    alignment: Alignment.topLeft,
                                    onPressed: () {
                                      setState(() {
                                        anggotaList.removeAt(itemIndex);
                                      });
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  title: Text(
                                    anggotaList[itemIndex]
                                        .nama
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  subtitle: Text(
                                    anggotaList[itemIndex]
                                        .alamat
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _namaAnggota.text = "";
                            _alamatAnggota.text = "";

                            Get.dialog(buildAnggota());
                          },
                          icon: const Icon(
                            Icons.account_box,
                            size: 18,
                          ),
                          label: const Text(
                            "Tambah Anggota",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (_idJenisPeneliti.text != "") ...[
                      const SizedBox(height: 5),
                      DropdownSearch<Map<String, dynamic>>(
                        items: const [
                          {
                            "id": 1,
                            "asal": "LEMBAGA PENDIDIKAN/PERGURUAN TINGGI"
                          },
                          {"id": 2, "asal": "BADAN USAHA"},
                          {"id": 3, "asal": "ORGANISASI KEMASYARAKATAN"},
                        ],
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Asal Peneliti",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                        enabled: isAsalPeneliti,
                        onChanged: (value) {
                          setState(() {
                            _idAsalPeneliti.text =
                                value?["id"].toString() as String;
                            _asalPeneliti.text = value?["asal"] ?? "";
                            isAsalPeneliti = false;
                          });
                        },
                        selectedItem: {
                          "id": _idAsalPeneliti.text,
                          "asal": _asalPeneliti.text
                        },
                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) => ListTile(
                            title: Text(
                              item["asal"],
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?["asal"] ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          if (value?["id"] == "") {
                            return 'Asal peneliti wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _namaLembaga,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: _idAsalPeneliti.text == "1"
                              ? "Nama Lembaga"
                              : _idAsalPeneliti.text == "2"
                                  ? "Nama Badan Usaha"
                                  : "Nama Organisasi",
                          labelStyle: const TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Nama Lembaga wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _judulPenelitian,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Judul Penelitian",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Judul penelitian wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: _tujuanPenelitian,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: "Tujuan Penelitian",
                          labelStyle: TextStyle(fontSize: 13),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Tujuan penelitian wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "LOKASI PENELITIAN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lokasiList.length,
                        itemBuilder: (context, itemIndex) {
                          return Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: IconButton(
                                    alignment: Alignment.topLeft,
                                    onPressed: () {
                                      setState(() {
                                        lokasiList.removeAt(itemIndex);
                                      });
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  title: Text(
                                    lokasiList[itemIndex]
                                        .pimpinan
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  subtitle: Text(
                                    lokasiList[itemIndex]
                                        .lokasi
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _pimpinanLokasi.text = "";
                            _lokasiLokasi.text = "";

                            Get.dialog(buildLokasi());
                          },
                          icon: const Icon(
                            Icons.location_city,
                            size: 18,
                          ),
                          label: const Text(
                            "Tambah Lokasi",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          labelText: "Mulai Tanggal",
                          labelStyle: TextStyle(fontSize: 13),
                          suffixIcon: Icon(Icons.calendar_month),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Tanggal mulai wajib diisi';
                          }
                          return null;
                        },
                        controller: _tglMulai1,
                        autocorrect: false,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDateMulai = await showDatePicker(
                            context: context,
                            initialDate: _tglMulai.text != ""
                                ? DateTime.parse(_tglMulai.text)
                                : DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (newDateMulai != null) {
                            setState(() {
                              _tglMulai.text =
                                  DateFormat("yyyy-MM-dd").format(newDateMulai);
                              _tglMulai1.text = DateFormat("d MMMM yyyy", "id")
                                  .format(newDateMulai);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          labelText: "Sampai Tanggal",
                          labelStyle: TextStyle(fontSize: 13),
                          suffixIcon: Icon(Icons.calendar_month),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Tanggal selesai wajib diisi';
                          }
                          return null;
                        },
                        controller: _tglSampai1,
                        autocorrect: false,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDateSampai = await showDatePicker(
                            context: context,
                            initialDate: _tglSampai.text != ""
                                ? DateTime.parse(_tglSampai.text)
                                : DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (newDateSampai != null) {
                            setState(() {
                              _tglSampai.text = DateFormat("yyyy-MM-dd")
                                  .format(newDateSampai);
                              _tglSampai1.text = DateFormat("d MMMM yyyy", "id")
                                  .format(newDateSampai);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 15),
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
              subtitle: const Text("Dokumen Permohonan SKP"),
              content: Form(
                key: _dokumenKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    buildProposal(),
                    if (_idAsalPeneliti.text == "1") buildPengantar(),
                    if (_idAsalPeneliti.text == "2") buildPengesahan(),
                    if (_idAsalPeneliti.text == "3") buildTerdaftar(),
                    const Divider(
                      height: 50,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    TextFormField(
                      style: const TextStyle(fontSize: 14),
                      controller: _catatan,
                      maxLines: 2,
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
                          label: const Text("KIRIM PERMOHONAN"),
                          icon: const Icon(Icons.check),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () async {
                            if (_dokumenKey.currentState!.validate()) {
                              Get.dialog(
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ListView(children: [
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
                                                'Accept': 'application/json',
                                              };

                                              Map<String, String> body = {
                                                "uid": _uidPemohon.text,
                                                "key": ApiContainer.baseKey,
                                                "jenis": _idJenisPeneliti.text,
                                                "asal": _idAsalPeneliti.text,
                                                "lembaga": _namaLembaga.text,
                                                "judul": _judulPenelitian.text,
                                                "tujuan":
                                                    _tujuanPenelitian.text,
                                                "dari": _tglMulai.text,
                                                "sampai": _tglSampai.text,
                                                "proposal_nomor":
                                                    _nomorProposal.text,
                                                "proposal_tanggal":
                                                    _tglProposal.text,
                                                "catatan": _catatan.text,
                                                "anggota": anggotaList
                                                        .isNotEmpty
                                                    ? jsonEncode(anggotaList)
                                                    : "",
                                                "lokasi": lokasiList.isNotEmpty
                                                    ? jsonEncode(lokasiList)
                                                    : "",
                                              };

                                              var request = http.MultipartRequest(
                                                  'POST',
                                                  Uri.parse(
                                                      "$baseUrl/api/skp-kirim"));

                                              request.headers.addAll(headers);
                                              request.fields.addAll(body);

                                              if (scanProposal != null) {
                                                for (int i = 0;
                                                    i < scanProposal!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'proposal[]',
                                                          File(scanProposal![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanProposal![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanPengantar != null) {
                                                for (int i = 0;
                                                    i < scanPengantar!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'surat_pengantar[]',
                                                          File(scanPengantar![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanPengantar![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanPengesahan != null) {
                                                for (int i = 0;
                                                    i < scanPengesahan!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'surat_pengesahan[]',
                                                          File(scanPengesahan![
                                                                      i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanPengesahan![i]
                                                                  .path
                                                                  .split("/")
                                                                  .last));
                                                }
                                              }

                                              if (scanTerdaftar != null) {
                                                for (int i = 0;
                                                    i < scanTerdaftar!.length;
                                                    i++) {
                                                  request.files.add(http
                                                          .MultipartFile
                                                      .fromBytes(
                                                          'keterangan_terdaftar[]',
                                                          File(scanTerdaftar![i]
                                                                  .path)
                                                              .readAsBytesSync(),
                                                          filename:
                                                              scanTerdaftar![i]
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
                                                    "Permohonan SKP Berhasil Dikirim");
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
                                    ]),
                                  ),
                                ),
                              );
                            }
                          }),
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

  Widget buildAnggota() => Container(
        margin: const EdgeInsets.only(top: 100),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Form(
                  key: _anggotaKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          "TAMBAH ANGGOTA",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _namaAnggota,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: "Nama Anggota",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return 'Nama anggota wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _alamatAnggota,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: "Alamat Anggota",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return 'Alamat anggota wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_anggotaKey.currentState!.validate()) {
                                  setState(() {
                                    anggotaList.add(
                                      AnggotaSkpModels(
                                        nama: _namaAnggota.text,
                                        alamat: _alamatAnggota.text,
                                      ),
                                    );
                                  });
                                  Get.back();
                                }
                              },
                              child: const Text("TAMBAH"),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () => Get.back(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text("BATAL"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildLokasi() => Container(
        margin: const EdgeInsets.only(top: 100),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Form(
                  key: _lokasiKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          "TAMBAH LOKASI",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        DropdownSearch<Map<String, dynamic>>(
                          items: const [
                            {"pimpinan": "Kepala"},
                            {"pimpinan": "Pimpinan"},
                            {"pimpinan": "Direktur"},
                            {"pimpinan": "Ketua"},
                          ],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Pimpinan",
                              labelStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _pimpinanLokasi.text =
                                  value?["pimpinan"].toString() as String;
                            });
                          },
                          selectedItem: {
                            "pimpinan": _pimpinanLokasi.text,
                          },
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(
                                item["pimpinan"],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?["pimpinan"] ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          validator: (value) {
                            if (value?["pimpinan"] == "") {
                              return 'Pimpinan Lokasi wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: _lokasiLokasi,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: "Lokasi/Tempat Penelitian",
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return 'Lokasi/Tempat Penelitian wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_lokasiKey.currentState!.validate()) {
                                  setState(() {
                                    lokasiList.add(
                                      LokasiSkpModels(
                                        pimpinan: _pimpinanLokasi.text,
                                        lokasi: _lokasiLokasi.text,
                                      ),
                                    );
                                  });
                                  Get.back();
                                }
                              },
                              child: const Text("TAMBAH"),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () => Get.back(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text("BATAL"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildProposal() => Column(
        children: [
          const Text(
            "PROPOSAL PENELITIAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            controller: _nomorProposal,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Nomor Proposal",
              labelStyle: TextStyle(fontSize: 13),
            ),
            validator: (value) {
              if (value == "") {
                return 'Nomor proposal wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              labelText: "Tanggal Proposal",
              labelStyle: TextStyle(fontSize: 13),
              suffixIcon: Icon(Icons.calendar_month),
            ),
            validator: (value) {
              if (value == "") {
                return 'Tanggal proposal wajib diisi';
              }
              return null;
            },
            controller: _tglProposal1,
            autocorrect: false,
            readOnly: true,
            onTap: () async {
              DateTime? newDateProposal = await showDatePicker(
                context: context,
                initialDate: _tglProposal.text != ""
                    ? DateTime.parse(_tglProposal.text)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDateProposal != null) {
                setState(() {
                  _tglProposal.text =
                      DateFormat("yyyy-MM-dd").format(newDateProposal);
                  _tglProposal1.text =
                      DateFormat("d MMMM yyyy", "id").format(newDateProposal);
                });
              }
            },
          ),
          const SizedBox(height: 5),
          scanProposal != null
              ? Wrap(
                  children: scanProposal!.map(
                    (imageone) {
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
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getProposal(),
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
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokProposal,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokProposal.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  Widget buildPengantar() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT PENGANTAR DARI LEMBAGA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanPengantar != null
              ? Wrap(
                  children: scanPengantar!.map(
                    (imageone) {
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
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => getPengantar(),
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
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokPengantar,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokPengantar.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  Widget buildPengesahan() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "SURAT PENGESAHAN BADAN HUKUM",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanPengesahan != null
              ? Wrap(
                  children: scanPengesahan!.map(
                    (imageone) {
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
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => getPengesahan(),
              label: const Text("UNGGAH DOKUMEN"),
              icon: const Icon(Icons.upload),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokPengesahan,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokPengesahan.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );

  Widget buildTerdaftar() => Column(
        children: [
          const Divider(
            height: 50,
            thickness: 1,
            color: Colors.black,
          ),
          const Text(
            "KETERANGAN TERDAFTAR",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          scanTerdaftar != null
              ? Wrap(
                  children: scanTerdaftar!.map(
                    (imageone) {
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
                    },
                  ).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => getTerdaftar(),
              label: const Text("UNGGAH DOKUMEN"),
              icon: const Icon(Icons.upload),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: false,
            maintainState: true,
            child: TextFormField(
              controller: _dokTerdaftar,
              validator: (value) {
                if (value == "") {
                  return "Error";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          if (_dokTerdaftar.text == '') const Text("Dokumen wajib diunggah"),
        ],
      );
}
