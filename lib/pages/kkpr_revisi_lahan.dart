import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../models/status_tanah.dart';
import '../services/api_container.dart';

class KkprLahanRevisi extends StatefulWidget {
  final int idPermohonan;
  final String nama;

  const KkprLahanRevisi(this.idPermohonan, this.nama, {super.key});

  @override
  State<KkprLahanRevisi> createState() => _KkprLahanRevisiState();
}

class _KkprLahanRevisiState extends State<KkprLahanRevisi> {
  final baseUrl = ApiContainer.baseUrl;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _idStatusTanah = TextEditingController();
  final TextEditingController _statusTanah = TextEditingController();
  final TextEditingController _kodeStatusTanah = TextEditingController();
  final TextEditingController _nomorLegalitas = TextEditingController();
  final TextEditingController _tahunLegalitas = TextEditingController();
  final TextEditingController _atasNamaLegalitas = TextEditingController();
  final TextEditingController _nomorUkurLegalitas = TextEditingController();
  final TextEditingController _tglUkurLegalitas = TextEditingController();
  final TextEditingController _tglUkurLegalitas1 = TextEditingController();
  final TextEditingController _keadaanLegalitas = TextEditingController();
  final TextEditingController _dokLegalitas = TextEditingController();
  final TextEditingController _luasLegalitas = TextEditingController();
  final TextEditingController _dokKematian = TextEditingController();
  final TextEditingController _dokAhliWaris = TextEditingController();
  final TextEditingController _dokAjb = TextEditingController();
  final TextEditingController _dokHibah = TextEditingController();
  final TextEditingController _dokSewa = TextEditingController();
  final TextEditingController _dokJualBeli = TextEditingController();
  final TextEditingController _dokPinjamPakai = TextEditingController();
  final TextEditingController _dokPernyataanPemilik = TextEditingController();
  final TextEditingController _dokPetaBidang = TextEditingController();
  final TextEditingController _idNamaSendiri = TextEditingController();
  final TextEditingController _namaSendiri = TextEditingController();

  List<XFile>? scanLegal;
  List<XFile>? scanKematian;
  List<XFile>? scanAhliWaris;
  List<XFile>? scanAjb;
  List<XFile>? scanHibah;
  List<XFile>? scanSewa;
  List<XFile>? scanJualBeli;
  List<XFile>? scanPinjamPakai;
  List<XFile>? scanPernyataanPemilik;
  List<XFile>? scanPetaBidang;

  Future getLegalitas() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanLegal = pickedfiles;
        hapusLoader();
        setState(() {
          _dokLegalitas.text = scanLegal.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getKematian() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanKematian = pickedfiles;
        hapusLoader();
        setState(() {
          _dokKematian.text = scanKematian.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getAhliWaris() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanAhliWaris = pickedfiles;
        hapusLoader();
        setState(() {
          _dokAhliWaris.text = scanAhliWaris.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getAjb() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanAjb = pickedfiles;
        hapusLoader();
        setState(() {
          _dokAjb.text = scanAjb.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getHibah() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanHibah = pickedfiles;
        hapusLoader();
        setState(() {
          _dokHibah.text = scanHibah.toString();
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
        scanSewa = pickedfiles;
        hapusLoader();
        setState(() {
          _dokSewa.text = scanSewa.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getJualBeli() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanJualBeli = pickedfiles;
        hapusLoader();
        setState(() {
          _dokJualBeli.text = scanJualBeli.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getPinjamPakai() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanPinjamPakai = pickedfiles;
        hapusLoader();
        setState(() {
          _dokPinjamPakai.text = scanPinjamPakai.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getPernyataanPemilik() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanPernyataanPemilik = pickedfiles;
        hapusLoader();
        setState(() {
          _dokPernyataanPemilik.text = scanPernyataanPemilik.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  Future getPetaBidang() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage();

      if (pickedfiles.isNotEmpty) {
        scanPetaBidang = pickedfiles;
        hapusLoader();
        setState(() {
          _dokPetaBidang.text = scanPetaBidang.toString();
        });
      } else {
        hapusLoader();
      }
    } catch (e) {
      hapusLoader();
      errorPesan("Error waktu mengambil file :$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            "LEGALITAS LAHAN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Rincian Legalitas Lahan Dimohon",
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                const SizedBox(height: 15),
                DropdownSearch<StatusTanahModels>(
                  asyncItems: (String filter) async {
                    loadingData();
                    var response = await http.get(
                      Uri.parse(
                          "$baseUrl/api/status-tanah?key=${ApiContainer.baseKey}"),
                    );

                    if (response.statusCode != 200) {
                      hapusLoader();
                      errorData();
                      return [];
                    } else {
                      hapusLoader();
                      List tanah = (json.decode(response.body)
                          as Map<String, dynamic>)["data"];

                      List<StatusTanahModels> tanahList = [];

                      for (var element in tanah) {
                        tanahList.add(StatusTanahModels.fromJson(element));
                      }

                      return tanahList;
                    }
                  },
                  popupProps: PopupProps.dialog(
                    itemBuilder: (context, item, isSelected) => ListTile(
                      title: Text('${item.statusTanah}',
                          style: const TextStyle(fontSize: 14)),
                    ),
                  ),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Status Tanah",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _idStatusTanah.text = value?.id.toString() as String;
                      _statusTanah.text = value?.statusTanah ?? "";
                      _kodeStatusTanah.text = value?.kode ?? "";
                    });
                  },
                  selectedItem: StatusTanahModels(
                    id: int.tryParse(_idStatusTanah.text),
                    statusTanah: _statusTanah.text,
                    kode: _kodeStatusTanah.text,
                  ),
                  dropdownBuilder: (context, selectedItem) => Text(
                    selectedItem?.statusTanah ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value?.id == null) {
                      return 'Status tanah wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(fontSize: 14),
                          controller: _nomorLegalitas,
                          decoration: const InputDecoration(
                            labelText: "Nomor Legalitas",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return "Wajib diisi";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(fontSize: 14),
                          controller: _tahunLegalitas,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: "Tahun Legalitas",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return "Wajib diisi";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                DropdownSearch<Map<String, dynamic>>(
                  items: const [
                    {"id": 1, "nama_sendiri": "ATAS NAMA SENDIRI"},
                    {"id": 2, "nama_sendiri": "ATAS NAMA ORANG LAIN"},
                  ],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Status Legalitas",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _idNamaSendiri.text = value?["id"].toString() as String;
                      _namaSendiri.text = value?["nama_sendiri"] ?? "";

                      if (value?["id"] == 1) {
                        _atasNamaLegalitas.text = widget.nama;
                      }
                    });
                  },
                  selectedItem: {
                    "id": _idNamaSendiri.text,
                    "nama_sendiri": _namaSendiri.text,
                  },
                  popupProps: PopupProps.dialog(
                    itemBuilder: (context, item, isSelected) => ListTile(
                      title: Text(
                        item["nama_sendiri"],
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  dropdownBuilder: (context, selectedItem) => Text(
                    selectedItem?["nama_sendiri"] ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value?["id"] == "") {
                      return 'Status Legalitas Wajib Diisi';
                    }
                    return null;
                  },
                ),
                if (_idNamaSendiri.text == "2") ...[
                  const SizedBox(height: 15),
                  TextFormField(
                    style: const TextStyle(fontSize: 14),
                    controller: _atasNamaLegalitas,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: "Atas Nama",
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Atas nama wajib diisi';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  controller: _luasLegalitas,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Luas",
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    suffixText: "m\u00B2",
                  ),
                  validator: (value) {
                    if (value == "") {
                      return 'Luas lahan wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(fontSize: 14),
                          controller: _nomorUkurLegalitas,
                          decoration: const InputDecoration(
                            labelText: "Nomor Surat Ukur",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return "Wajib diisi";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(fontSize: 14),
                          decoration: const InputDecoration(
                            labelText: "Tanggal Surat Ukur",
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_month),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return 'Tanggal surat ukur wajib diisi';
                            }
                            return null;
                          },
                          controller: _tglUkurLegalitas1,
                          autocorrect: false,
                          readOnly: true,
                          onTap: () async {
                            DateTime? newDateUkur = await showDatePicker(
                              context: context,
                              initialDate: _tglUkurLegalitas.text != ""
                                  ? DateTime.parse(_tglUkurLegalitas.text)
                                  : DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (newDateUkur != null) {
                              setState(() {
                                _tglUkurLegalitas.text =
                                    DateFormat("yyyy-MM-dd")
                                        .format(newDateUkur);
                                _tglUkurLegalitas1.text =
                                    DateFormat("d MMM yyyy", "id")
                                        .format(newDateUkur);
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  controller: _keadaanLegalitas,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "Keadaan Tanah",
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  ),
                  validator: (value) {
                    if (value == "") {
                      return 'Keadaan tanah wajib diisi';
                    }
                    return null;
                  },
                ),
                const Divider(height: 30, thickness: 1, color: Colors.black),
                const Text(
                  "DOKUMEN LEGALITAS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                scanLegal != null
                    ? Wrap(
                        children: scanLegal!.map(
                          (imageone) {
                            return Card(
                              child: SizedBox(
                                height: 100,
                                width: 80,
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
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () => getLegalitas(),
                    label: const Text("UNGGAH DOKUMEN"),
                    icon: const Icon(Icons.upload),
                  ),
                ),
                Visibility(
                  visible: false,
                  maintainState: true,
                  child: TextFormField(
                    controller: _dokLegalitas,
                    validator: (value) {
                      if (value == "") {
                        return "Error";
                      }
                      return null;
                    },
                  ),
                ),
                if (_idNamaSendiri.text == "2") ...[
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  const Text(
                    "SURAT KETERANGAN KEMATIAN (LURAH/KADES)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  scanKematian != null
                      ? Wrap(
                          children: scanKematian!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 100,
                                  width: 80,
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => getKematian(),
                      label: const Text("UNGGAH DOKUMEN"),
                      icon: const Icon(Icons.upload),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: TextFormField(
                      controller: _dokKematian,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  const Text(
                    "SURAT KETERANGAN AHLI WARIS (LURAH/KADES)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  scanAhliWaris != null
                      ? Wrap(
                          children: scanAhliWaris!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 100,
                                  width: 80,
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => getAhliWaris(),
                      label: const Text("UNGGAH DOKUMEN"),
                      icon: const Icon(Icons.upload),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: TextFormField(
                      controller: _dokAhliWaris,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  const Text(
                    "AKTA JUAL BELI / AJB (NOTARIS)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  scanAjb != null
                      ? Wrap(
                          children: scanAjb!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 100,
                                  width: 80,
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => getAjb(),
                      label: const Text("UNGGAH DOKUMEN"),
                      icon: const Icon(Icons.upload),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: TextFormField(
                      controller: _dokAjb,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  const Text(
                    "AKTA HIBAH (NOTARIS)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  scanHibah != null
                      ? Wrap(
                          children: scanHibah!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 100,
                                  width: 80,
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => getHibah(),
                      label: const Text("UNGGAH DOKUMEN"),
                      icon: const Icon(Icons.upload),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: TextFormField(
                      controller: _dokHibah,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  const Text(
                    "PERJANJIAN SEWA (NOTARIS)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  scanSewa != null
                      ? Wrap(
                          children: scanSewa!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 100,
                                  width: 80,
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => getSewa(),
                      label: const Text("UNGGAH DOKUMEN"),
                      icon: const Icon(Icons.upload),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: TextFormField(
                      controller: _dokSewa,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  const Text(
                    "PERIKATAN JUAL BELI (NOTARIS)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  scanJualBeli != null
                      ? Wrap(
                          children: scanJualBeli!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 100,
                                  width: 80,
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => getJualBeli(),
                      label: const Text("UNGGAH DOKUMEN"),
                      icon: const Icon(Icons.upload),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: TextFormField(
                      controller: _dokJualBeli,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  const Text(
                    "PERJANJIAN PINJAM PAKAI (NOTARIS)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  scanPinjamPakai != null
                      ? Wrap(
                          children: scanPinjamPakai!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 100,
                                  width: 80,
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => getPinjamPakai(),
                      label: const Text("UNGGAH DOKUMEN"),
                      icon: const Icon(Icons.upload),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: TextFormField(
                      controller: _dokPinjamPakai,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  const Text(
                    "SURAT PERNYATAAN PEMILIK TANAH (NOTARIS)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  scanPernyataanPemilik != null
                      ? Wrap(
                          children: scanPernyataanPemilik!.map(
                            (imageone) {
                              return Card(
                                child: SizedBox(
                                  height: 100,
                                  width: 80,
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
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => getPernyataanPemilik(),
                      label: const Text("UNGGAH DOKUMEN"),
                      icon: const Icon(Icons.upload),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: TextFormField(
                      controller: _dokPernyataanPemilik,
                    ),
                  ),
                ],
                const Divider(height: 30, thickness: 1, color: Colors.black),
                const Text(
                  "PETA BIDANG (KUTIPAN LETTER C)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                scanPetaBidang != null
                    ? Wrap(
                        children: scanPetaBidang!.map(
                          (imageone) {
                            return Card(
                              child: SizedBox(
                                height: 100,
                                width: 80,
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
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () => getPetaBidang(),
                    label: const Text("UNGGAH DOKUMEN"),
                    icon: const Icon(Icons.upload),
                  ),
                ),
                Visibility(
                  visible: false,
                  maintainState: true,
                  child: TextFormField(
                    controller: _dokPetaBidang,
                  ),
                ),
                const Divider(height: 50, thickness: 1, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              loadingData();

                              Map<String, String> headers = {
                                'Content-Type': 'multipart/form-data',
                                'Accept': 'application/json',
                              };

                              Map<String, String> body = {
                                "key": ApiContainer.baseKey,
                                "id_permohonan_pkkpr":
                                    widget.idPermohonan.toString(),
                                "status_lahan": _idStatusTanah.text,
                                "nomor_akta": _nomorLegalitas.text,
                                "tahun_akta": _tahunLegalitas.text,
                                "atas_nama_akta": _atasNamaLegalitas.text,
                                "luas_akta": _luasLegalitas.text,
                                "surat_ukur": _nomorUkurLegalitas.text,
                                "surat_ukur_tgl": _tglUkurLegalitas.text,
                                "keadaan_tanah": _keadaanLegalitas.text,
                                "nama_sendiri": _idNamaSendiri.text,
                              };

                              var request = http.MultipartRequest('POST',
                                  Uri.parse("$baseUrl/api/kkpr-lahan-revisi"));

                              request.headers.addAll(headers);
                              request.fields.addAll(body);

                              if (scanLegal != null) {
                                for (int i = 0; i < scanLegal!.length; i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'dok_akta[]',
                                        File(scanLegal![i].path)
                                            .readAsBytesSync(),
                                        filename:
                                            scanLegal![i].path.split("/").last),
                                  );
                                }
                              }

                              if (scanKematian != null) {
                                for (int i = 0; i < scanKematian!.length; i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'suket_kematian[]',
                                        File(scanKematian![i].path)
                                            .readAsBytesSync(),
                                        filename: scanKematian![i]
                                            .path
                                            .split("/")
                                            .last),
                                  );
                                }
                              }

                              if (scanAhliWaris != null) {
                                for (int i = 0;
                                    i < scanAhliWaris!.length;
                                    i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'suket_waris[]',
                                        File(scanAhliWaris![i].path)
                                            .readAsBytesSync(),
                                        filename: scanAhliWaris![i]
                                            .path
                                            .split("/")
                                            .last),
                                  );
                                }
                              }

                              if (scanSewa != null) {
                                for (int i = 0; i < scanSewa!.length; i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'perjanjian_sewa[]',
                                        File(scanSewa![i].path)
                                            .readAsBytesSync(),
                                        filename:
                                            scanSewa![i].path.split("/").last),
                                  );
                                }
                              }

                              if (scanJualBeli != null) {
                                for (int i = 0; i < scanJualBeli!.length; i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'perikatan_jual_beli[]',
                                        File(scanJualBeli![i].path)
                                            .readAsBytesSync(),
                                        filename: scanJualBeli![i]
                                            .path
                                            .split("/")
                                            .last),
                                  );
                                }
                              }

                              if (scanAjb != null) {
                                for (int i = 0; i < scanAjb!.length; i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'ajb[]',
                                        File(scanAjb![i].path)
                                            .readAsBytesSync(),
                                        filename:
                                            scanAjb![i].path.split("/").last),
                                  );
                                }
                              }

                              if (scanPernyataanPemilik != null) {
                                for (int i = 0;
                                    i < scanPernyataanPemilik!.length;
                                    i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'pernyataan_pemilik_tanah[]',
                                        File(scanPernyataanPemilik![i].path)
                                            .readAsBytesSync(),
                                        filename: scanPernyataanPemilik![i]
                                            .path
                                            .split("/")
                                            .last),
                                  );
                                }
                              }

                              if (scanHibah != null) {
                                for (int i = 0; i < scanHibah!.length; i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'akte_hibah[]',
                                        File(scanHibah![i].path)
                                            .readAsBytesSync(),
                                        filename:
                                            scanHibah![i].path.split("/").last),
                                  );
                                }
                              }

                              if (scanPinjamPakai != null) {
                                for (int i = 0;
                                    i < scanPinjamPakai!.length;
                                    i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'pinjam_pakai[]',
                                        File(scanPinjamPakai![i].path)
                                            .readAsBytesSync(),
                                        filename: scanPinjamPakai![i]
                                            .path
                                            .split("/")
                                            .last),
                                  );
                                }
                              }

                              if (scanPetaBidang != null) {
                                for (int i = 0;
                                    i < scanPetaBidang!.length;
                                    i++) {
                                  request.files.add(
                                    http.MultipartFile.fromBytes(
                                        'peta_bidang[]',
                                        File(scanPetaBidang![i].path)
                                            .readAsBytesSync(),
                                        filename: scanPetaBidang![i]
                                            .path
                                            .split("/")
                                            .last),
                                  );
                                }
                              }

                              var response = await request.send();

                              if (response.statusCode == 200) {
                                var responseString =
                                    await response.stream.bytesToString();
                                final decodedMap =
                                    json.decode(responseString)['data'];

                                hapusLoader();
                                pesanData(
                                    "Legalitas lahan berhasil ditambahkan");
                                Get.back(result: decodedMap);
                              } else {
                                hapusLoader();
                                errorData();
                              }
                            } else {
                              hapusLoader();
                              errorPesan("Silahkan melengkapi semua data");
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text("SIMPAN"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.cancel),
                          label: const Text("BATAL"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
