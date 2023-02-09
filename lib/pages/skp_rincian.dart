import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nonoss/models/lokasi_skp.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/anggota_skp.dart';
import '../services/api_container.dart';
import '../models/waktu.dart';

class SkpRincian extends StatefulWidget {
  final int id;

  const SkpRincian(this.id, {super.key});

  @override
  State<SkpRincian> createState() => _SkpRincianState();
}

class _SkpRincianState extends State<SkpRincian> {
  final baseUrl = ApiContainer.baseUrl;

  Map<String, dynamic> user = {};
  Map<String, dynamic> permohonan = {};
  Map<String, dynamic> skp = {};
  Map<String, dynamic> status = {};
  List<WaktuModels> waktuList = [];
  List<LokasiSkpModels> lokasiList = [];
  List<AnggotaSkpModels> anggotaList = [];

  String gelarDepan = "";
  String gelarBelakang = "";
  String namaPemohon = "";
  String alamatPemohon = "";
  String rtPemohon = "";
  String rwPemohon = "";
  String dusunPemohon = "";
  String desaPemohon = "";
  String kecamatanPemohon = "";
  String kotaPemohon = "";
  String propinsiPemohon = "";
  String kodeposPemohon = "";
  String tempLahir = "";
  String tglLahir = "";
  String namaBadan = "";
  String kodeBadan = "";
  String alamatBadan = "";
  String rtBadan = "";
  String rwBadan = "";
  String dusunBadan = "";
  String desaBadan = "";
  String kecamatanBadan = "";
  String kotaBadan = "";
  String propinsiBadan = "";

  Future getRincian() async {
    loadingData();

    var result = await http.get(Uri.parse(
        "$baseUrl/api/skp-rincian?id=${widget.id}&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();

      setState(() {
        user = json.decode(result.body)["user"];
        permohonan = json.decode(result.body)["permohonan"];
        skp = json.decode(result.body)["skp"];
        status = json.decode(result.body)["status"];

        List waktu =
            (json.decode(result.body) as Map<String, dynamic>)["waktu"];

        for (var element in waktu) {
          waktuList.add(WaktuModels.fromJson(element));
        }

        gelarDepan = user['gelar_depan'] != null
            ? "${user['gelar_depan'].toString()} "
            : "";
        namaPemohon = user['nama'] != null ? user['nama'].toString() : "";
        gelarBelakang = user['gelar_belakang'] != null
            ? " ${user['gelar_belakang'].toString()}"
            : "";
        alamatPemohon =
            user['alamat'] != null ? "${user['alamat'].toString()} " : "";
        rtPemohon = user['rt'] != null ? "RT. ${user['rt'].toString()} " : "";
        rwPemohon = user['rw'] != null ? "RW. ${user['rw'].toString()} " : "";
        dusunPemohon =
            user['dusun'] != null ? "${user['dusun'].toString()}, " : "";
        desaPemohon = user['kelurahan'] != null
            ? "${user['kelurahan'].toString()}, "
            : "";
        kecamatanPemohon = user['kecamatan'] != null
            ? "KECAMATAN ${user['kecamatan'].toString()}, "
            : "";
        kotaPemohon =
            user['kota'] != null ? "${user['kota'].toString()}, " : "";
        propinsiPemohon =
            user['propinsi'] != null ? user['propinsi'].toString() : "";
        tempLahir =
            user['temp_lahir'] != null ? user['temp_lahir'].toString() : "";
        tglLahir = user['tgl_lahir'] != null
            ? ", ${user['tgl_lahir'].toString()}"
            : "";
        namaBadan =
            user['nama_badan'] != null ? user['nama_badan'].toString() : "";
        kodeBadan = user['KODE'] != null ? "${user['KODE'].toString()} " : "";
        alamatBadan = user['alamat_badan'] != null
            ? "${user['alamat_badan'].toString()} "
            : "";
        rtBadan = user['rt_badan'] != null
            ? "RT. ${user['rt_badan'].toString()} "
            : "";
        rwBadan = user['rw_badan'] != null
            ? "RW. ${user['rw_badan'].toString()} "
            : "";
        dusunBadan = user['dusun_badan'] != null
            ? "${user['dusun_badan'].toString()}, "
            : "";
        desaBadan = user['kelurahan_badan'] != null
            ? "${user['kelurahan_badan'].toString()}, "
            : "";
        kecamatanBadan = user['kecamatan_badan'] != null
            ? "KECAMATAN ${user['kecamatan_badan'].toString()}, "
            : "";
        kotaBadan = user['kota_badan'] != null
            ? "${user['kota_badan'].toString()}, "
            : "";
        propinsiBadan = user['propinsi_badan'] != null
            ? "${user['propinsi_badan'].toString()}, "
            : "";

        if (skp['lokasi'] != null) {
          for (var e in jsonDecode(skp['lokasi'].toString())) {
            lokasiList.add(LokasiSkpModels.fromJson(e));
          }
        }

        if (skp['anggota'] != null) {
          for (var e in jsonDecode(skp['anggota'].toString())) {
            anggotaList.add(AnggotaSkpModels.fromJson(e));
          }
        }
      });
    } else {
      hapusLoader();
      errorPesan("Gagal mendapatkan data pemohon");
      Get.offAllNamed("/home");
    }
  }

  int _selectedIndex = 0;

  Widget _getWidget() {
    if (_selectedIndex == 0) {
      return buildPermohonan();
    } else if (_selectedIndex == 1) {
      return buildPemohon();
    } else if (_selectedIndex == 2) {
      return buildDokumen();
    } else if (_selectedIndex == 3) {
      return buildRiwayat();
    } else {
      return buildPermohonan();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    getRincian();
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
      body: _getWidget(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Permohonan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Pemohon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'Dokumen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildPermohonan() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          const Text(
            "DATA PERMOHONAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text("Waktu Permohonan :"),
          Text(
            permohonan['waktu_permohonan'] != null
                ? permohonan['waktu_permohonan'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Nomor Register :"),
          Text(
            permohonan['register'] != null
                ? permohonan['register'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("SKPD :"),
          Text(
            status['kode'] != null ? status['kode'].toString() : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Status :"),
          Text(
            status['keterangan'] != null ? status['keterangan'].toString() : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Jenis Pemohon :"),
          Text(skp['jenis'].toString() == "1" ? "PERORANGAN" : "KELOMPOK WNI"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Asal Peneliti :"),
          Text(skp['asal'].toString() == "1"
              ? "LEMBAGA PENDIDIKAN/PERGURUAN TINGGI"
              : skp['asal'].toString() == "2"
                  ? "BADAN USAHA"
                  : "ORGANISASI KEMASYARAKATAN"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (skp["jenis"].toString() == "2") ...[
            const Text("Anggota Penelitian :"),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: anggotaList.length,
              itemBuilder: (context, itemIndex) {
                return Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(25),
                    1: IntrinsicColumnWidth(flex: 100),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.top,
                          child: Text("${(itemIndex + 1).toString()}."),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.top,
                          child: Text(
                            anggotaList[itemIndex].nama ?? "",
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        const TableCell(
                          verticalAlignment: TableCellVerticalAlignment.top,
                          child: Text(""),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.top,
                          child: Text(
                            anggotaList[itemIndex].alamat ?? "",
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          Text(skp["asal"].toString() == "1"
              ? "Nama Lembaga :"
              : skp["asal"].toString() == "2"
                  ? "Nama Badan Usaha :"
                  : "Nama Organisasi :"),
          Text(skp['lembaga'] != null
              ? skp['lembaga'].toString().toUpperCase()
              : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Judul Penelitian :"),
          Text(skp['judul'] != null
              ? skp['judul'].toString().toUpperCase()
              : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Tujuan Penelitian :"),
          Text(skp['tujuan'] != null
              ? skp['tujuan'].toString().toUpperCase()
              : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Lokasi Penelitian :"),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lokasiList.length,
            itemBuilder: (context, itemIndex) {
              return Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(25),
                  1: IntrinsicColumnWidth(flex: 100),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Text(
                          "${(itemIndex + 1).toString()}.",
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Text(
                          lokasiList[itemIndex].lokasi ?? "",
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Penelitian Mulai Tanggal :"),
          Text(skp['dari'] != null ? skp['dari'].toString().toUpperCase() : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Penelitian Sampai Tanggal :"),
          Text(skp['sampai'] != null
              ? skp['sampai'].toString().toUpperCase()
              : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (skp["file_izin"] != null &&
              permohonan["ikm"] == 0 &&
              permohonan["id_kadis"] != null) ...[
            const Text("Draft SK :"),
            IntrinsicHeight(
              child: SfPdfViewer.network(
                skp["file_izin_user"].toString(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(skp["file_izin_user"].toString()),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file ${skp["file_izin_user"].toString()}';
                }
              },
              child: const Text("DOWNLOAD"),
            ),
          ],
          if (skp["file_izin"] != null && permohonan["ikm"] == 1) ...[
            const Text("SK Izin :"),
            IntrinsicHeight(
              child: SfPdfViewer.network(
                skp["file_izin"].toString(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(skp["file_izin"].toString()),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file ${skp["file_izin"].toString()}';
                }
              },
              child: const Text("DOWNLOAD"),
            ),
          ]
        ],
      ),
    );
  }

  Widget buildPemohon() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          const Text(
            "DATA PEMOHON",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          user['foto'].toString() != ""
              ? DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.network(
                    user['foto'].toString(),
                    height: 200,
                    width: 150,
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Text('Loading foto...');
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
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
          const SizedBox(height: 20),
          const Text("Nama Lengkap Pemohon :"),
          Text("$gelarDepan$namaPemohon$gelarBelakang"),
          const Divider(
            height: 15,
            thickness: 1,
            color: Colors.black,
          ),
          const Text("Alamat :"),
          Text(
              "$alamatPemohon$rtPemohon$rwPemohon$dusunPemohon$desaPemohon$kecamatanPemohon$kotaPemohon$propinsiPemohon"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Temp.Tgl. Lahir :"),
          Text("$tempLahir$tglLahir"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Jenis Kelamin :"),
          Text(user['kelamin'].toString() == "1"
              ? "LAKI-LAKI"
              : user['tgl_lahir'].toString() == "2"
                  ? "PEREMPUAN"
                  : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Pekerjaan :"),
          Text(user['pekerjaan'] != null ? user['pekerjaan'].toString() : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Warganegara :"),
          Text(user['warganegara'].toString() == "1"
              ? "INDONESIA"
              : user['warganegara'].toString() == "2"
                  ? "ASING"
                  : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (user["warganegara"].toString() != "1") ...[
            const Text("Negara :"),
            Text(user['negara'].toString() == "1"
                ? user['negara'].toString()
                : ""),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          const Text("HP :"),
          Text(user['hp'] != null ? user['hp'].toString() : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Email :"),
          Text(user['email'] != null ? user['email'].toString() : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("NIK :"),
          Text(user['nik'] != null ? user['nik'].toString() : ""),
          user['dok_ktp'] != null
              ? DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.network(
                    user['dok_ktp'].toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Text('Loading foto...');
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
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
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
      ),
    );
  }

  Widget buildDokumen() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          const Text(
            "DOKUMEN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text("Nomor Proposal :"),
          Text(skp['proposal_nomor'] != null
              ? skp['proposal_nomor'].toString()
              : ""),
          const SizedBox(height: 10),
          const Text("Tanggal Proposal :"),
          Text(skp['proposal_tanggal'] != null
              ? skp['proposal_tanggal'].toString()
              : ""),
          const SizedBox(height: 10),
          const Text("Proposal Penelitian :"),
          const SizedBox(height: 10),
          skp['proposal'] != null
              ? Wrap(children: [
                  for (String im in jsonDecode(skp['proposal'].toString())) ...[
                    Card(
                      child: SizedBox(
                        height: 170,
                        width: 110,
                        child: Image.network(
                          im,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
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
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (skp['asal'].toString() == "1") ...[
            const SizedBox(height: 10),
            const Text("Surat Pengantar :"),
            const SizedBox(height: 10),
            skp['surat_pengantar'] != null
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(skp['surat_pengantar'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 170,
                          child: Image.network(
                            im,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
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
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (skp['asal'].toString() == "2") ...[
            const SizedBox(height: 10),
            const Text("Pengesahan Badan Hukum :"),
            const SizedBox(height: 10),
            skp['surat_pengesahan'] != null
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(skp['surat_pengesahan'].toString())) ...[
                      Card(
                        child: SizedBox(
                          width: 110,
                          child: Image.network(
                            im,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
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
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (skp['asal'].toString() == "3") ...[
            const SizedBox(height: 10),
            const Text("Keterangan Terdaftar :"),
            const SizedBox(height: 10),
            skp['keterangan_terdaftar'] != null
                ? Wrap(children: [
                    for (String im in jsonDecode(
                        skp['keterangan_terdaftar'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
                          width: 100,
                          child: Image.network(
                            im,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
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
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
        ],
      ),
    );
  }

  Widget buildRiwayat() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          const Text(
            "RIWAYAT PERMOHONAN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: waktuList.length,
            itemBuilder: (context, itemIndex) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(80),
                      1: FixedColumnWidth(15),
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
                              waktuList[itemIndex].waktu != null
                                  ? waktuList[itemIndex]
                                      .waktu
                                      .toString()
                                      .toUpperCase()
                                  : "",
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
                              waktuList[itemIndex].kode ?? "",
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
                              waktuList[itemIndex].keterangan != null
                                  ? waktuList[itemIndex]
                                      .keterangan
                                      .toString()
                                      .toUpperCase()
                                  : "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(221, 73, 73, 73),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
