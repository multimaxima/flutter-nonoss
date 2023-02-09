import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:nonoss/pages/ikm.dart';
import 'package:nonoss/pages/kkpr_revisi.dart';
import 'package:nonoss/pages/kkpr_rincian.dart';
import 'package:nonoss/pages/nakes_revisi.dart';
import 'package:nonoss/pages/nakes_rincian.dart';
import 'package:nonoss/pages/sipr_revisi.dart';
import 'package:nonoss/pages/sipr_rincian.dart';
import 'package:nonoss/pages/skp_revisi.dart';
import 'package:nonoss/pages/skp_rincian.dart';

import '../services/api_container.dart';
import '../models/permohonan_data.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  final baseUrl = ApiContainer.baseUrl;
  int id = 0;

  final _batalKey = GlobalKey<FormState>();
  final TextEditingController _keteranganBatal = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  List<PermohonanModels> permohonanList = [];
  List<XFile>? buktiBayar;

  Future getPermohonan() async {
    loadingData();

    final userId = await getUserId();

    var result = await http.get(Uri.parse(
        "$baseUrl/api/permohonan-izin?uid=$userId&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();
      List permohonan =
          (json.decode(result.body) as Map<String, dynamic>)["data"];

      for (var element in permohonan) {
        setState(() {
          permohonanList.add(PermohonanModels.fromJson(element));
        });
      }

      return permohonanList;
    } else {
      hapusLoader();
      errorPesan("Gagal mendapatkan data pemohon");
      Get.offAllNamed("/home");
    }
  }

  Future getBuktiBayar() async {
    loadingData();
    try {
      var pickedfiles = await _picker.pickMultiImage(
        maxHeight: 800,
        maxWidth: 800,
      );

      if (pickedfiles.isNotEmpty) {
        hapusLoader();
        setState(() {
          buktiBayar = pickedfiles;
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
            "RIWAYAT",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Riwayat Permohonan Izin",
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
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: permohonanList.length,
        itemBuilder: (context, itemIndex) {
          return Card(
            color: permohonanList[itemIndex].revisi == 1
                ? Colors.red[100]
                : Colors.green[100],
            elevation: 3.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    onTap: () {
                      if (permohonanList[itemIndex].revisi == 1) {
                        if (permohonanList[itemIndex].idIzin == 1) {
                          Get.to(
                              () => SiprRevisi(permohonanList[itemIndex].id!));
                        } else if (permohonanList[itemIndex].idIzin == 2) {
                          Get.to(
                              () => NakesRevisi(permohonanList[itemIndex].id!));
                        } else if (permohonanList[itemIndex].idIzin == 3) {
                          Get.to(
                              () => KkprRevisi(permohonanList[itemIndex].id!));
                        } else if (permohonanList[itemIndex].idIzin == 4) {
                          Get.to(
                              () => SkpRevisi(permohonanList[itemIndex].id!));
                        } else if (permohonanList[itemIndex].idIzin == 5) {
                        } else if (permohonanList[itemIndex].idIzin == 6) {}
                      } else {
                        if (permohonanList[itemIndex].idIzin == 1) {
                          Get.to(
                              () => SiprRincian(permohonanList[itemIndex].id!));
                        } else if (permohonanList[itemIndex].idIzin == 2) {
                          Get.to(() =>
                              NakesRincian(permohonanList[itemIndex].id!));
                        } else if (permohonanList[itemIndex].idIzin == 3) {
                          Get.to(
                              () => KkprRincian(permohonanList[itemIndex].id!));
                        } else if (permohonanList[itemIndex].idIzin == 4) {
                          Get.to(
                              () => SkpRincian(permohonanList[itemIndex].id!));
                        } else if (permohonanList[itemIndex].idIzin == 5) {
                        } else if (permohonanList[itemIndex].idIzin == 6) {}
                      }
                    },
                    title: Text(
                      "${permohonanList[itemIndex].register} - ${permohonanList[itemIndex].kodes} ${permohonanList[itemIndex].kode.toString() == "" ? "" : "(${permohonanList[itemIndex].kode})"}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    subtitle: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(70),
                        1: FixedColumnWidth(10),
                        2: IntrinsicColumnWidth(flex: 100),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: <TableRow>[
                        TableRow(
                          children: <Widget>[
                            const TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                "Waktu",
                                style: TextStyle(
                                  color: Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                "${permohonanList[itemIndex].waktuPermohonan}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            const TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                "SKPD",
                                style: TextStyle(
                                  color: Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                permohonanList[itemIndex].dinas != null
                                    ? permohonanList[itemIndex].dinas.toString()
                                    : "-",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            const TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                "Status",
                                style: TextStyle(
                                  color: Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Text(
                                "${permohonanList[itemIndex].keterangan}",
                                style: permohonanList[itemIndex].keterangan ==
                                        "REVISI"
                                    ? const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.red,
                                      )
                                    : permohonanList[itemIndex].keterangan ==
                                            "DITOLAK"
                                        ? const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 12,
                                          )
                                        : const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (permohonanList[itemIndex].ditolak == 1) ...[
                  Html(data: permohonanList[itemIndex].catatan.toString()),
                ],
                if (permohonanList[itemIndex].batal == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (permohonanList[itemIndex].revisi == 0)
                        TextButton(
                          child: const Text('RINCIAN'),
                          onPressed: () {
                            if (permohonanList[itemIndex].idIzin == 1) {
                              Get.to(() =>
                                  SiprRincian(permohonanList[itemIndex].id!));
                            } else if (permohonanList[itemIndex].idIzin == 2) {
                              Get.to(() =>
                                  NakesRincian(permohonanList[itemIndex].id!));
                            } else if (permohonanList[itemIndex].idIzin == 3) {
                              Get.to(() =>
                                  KkprRincian(permohonanList[itemIndex].id!));
                            } else if (permohonanList[itemIndex].idIzin == 4) {
                              Get.to(() =>
                                  SkpRincian(permohonanList[itemIndex].id!));
                            } else if (permohonanList[itemIndex].idIzin == 5) {
                            } else if (permohonanList[itemIndex].idIzin == 6) {}
                          },
                        ),
                      if (permohonanList[itemIndex].revisi == 1)
                        TextButton(
                          child: const Text(
                            'REVISI',
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            if (permohonanList[itemIndex].idIzin == 1) {
                              Get.to(() =>
                                  SiprRevisi(permohonanList[itemIndex].id!));
                            } else if (permohonanList[itemIndex].idIzin == 2) {
                              Get.to(() =>
                                  NakesRevisi(permohonanList[itemIndex].id!));
                            } else if (permohonanList[itemIndex].idIzin == 3) {
                              Get.to(() =>
                                  KkprRevisi(permohonanList[itemIndex].id!));
                            } else if (permohonanList[itemIndex].idIzin == 4) {
                              Get.to(() =>
                                  SkpRevisi(permohonanList[itemIndex].id!));
                            } else if (permohonanList[itemIndex].idIzin == 5) {
                            } else if (permohonanList[itemIndex].idIzin == 6) {}
                          },
                        ),
                      if (permohonanList[itemIndex].sk != null &&
                          permohonanList[itemIndex].ikm == 0) ...[
                        TextButton(
                          child: const Text(
                            'SURVEY IKM',
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            Get.to(
                                () => IkmForm(permohonanList[itemIndex].id!));
                          },
                        ),
                      ],
                      if (permohonanList[itemIndex].sk == null &&
                          permohonanList[itemIndex].ditolak == 0) ...[
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text(
                            'BATAL',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () => Get.defaultDialog(
                              title: "PEMBATALAN",
                              titleStyle: const TextStyle(fontSize: 14),
                              content: Form(
                                key: _batalKey,
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  controller: _keteranganBatal,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    labelText: "Alasan Pembatalan",
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  ),
                                  validator: (value) {
                                    if (value == "") {
                                      return 'Alasan pembatalan wajib diisi';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_batalKey.currentState!.validate()) {
                                      var response = await http.post(
                                        Uri.parse(
                                            "$baseUrl/api/permohonan-batal"),
                                        body: {
                                          "id": permohonanList[itemIndex]
                                              .id
                                              .toString(),
                                          "keterangan": _keteranganBatal.text,
                                        },
                                      );

                                      if (response.statusCode != 200) {
                                        errorPesan(
                                            "Gagal melakukan pembatalan, silahkan ulangi kembali");
                                      } else {
                                        setState(() {
                                          Get.back();
                                          permohonanList.clear();
                                          getPermohonan();
                                        });
                                      }
                                    } else {
                                      errorPesan(
                                          "Silahkan mengisi alasan pembatalan");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text("YA, BATALKAN"),
                                ),
                                ElevatedButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("TIDAK"),
                                )
                              ]),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                if (permohonanList[itemIndex].revisi == 0 &&
                    permohonanList[itemIndex].idIzin == 3 &&
                    permohonanList[itemIndex].sps == 1 &&
                    permohonanList[itemIndex].pnbp == 0)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('UNGGAH BUKTI SETOR BANK'),
                      onPressed: () async {
                        await getBuktiBayar();

                        if (buktiBayar != null) {
                          loadingData();

                          Map<String, String> headers = {
                            'Content-Type': 'multipart/form-data',
                            'Accept': 'application/json',
                          };

                          Map<String, String> body = {
                            "id": permohonanList[itemIndex].id.toString(),
                            "key": ApiContainer.baseKey,
                          };

                          var request = http.MultipartRequest('POST',
                              Uri.parse("$baseUrl/api/kkpr-bukti-setor"));

                          request.headers.addAll(headers);
                          request.fields.addAll(body);

                          for (int i = 0; i < buktiBayar!.length; i++) {
                            request.files.add(http.MultipartFile.fromBytes(
                                'dok_pnbp[]',
                                File(buktiBayar![i].path).readAsBytesSync(),
                                filename: buktiBayar![i].path.split("/").last));
                          }

                          var response = await request.send();

                          if (response.statusCode == 200) {
                            hapusLoader();
                            setState(() {
                              permohonanList.clear();
                              getPermohonan();
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
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
