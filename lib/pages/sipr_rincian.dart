import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_container.dart';
import '../models/waktu.dart';

class SiprRincian extends StatefulWidget {
  final int id;

  const SiprRincian(this.id, {super.key});

  @override
  State<SiprRincian> createState() => _SiprRincianState();
}

class _SiprRincianState extends State<SiprRincian> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> izin = {};
  Map<String, dynamic> permohonan = {};
  Map<String, dynamic> reklame = {};
  Map<String, dynamic> status = {};
  Map<String, dynamic> kategori = {};
  Map<String, dynamic> jenis = {};
  Map<String, dynamic> area = {};
  Map<String, dynamic> lahan = {};
  Map<String, dynamic> pemohon = {};
  List<WaktuModels> waktuList = [];

  final baseUrl = ApiContainer.baseUrl;

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
  String alamatLokasi = "";
  String rtLokasi = "";
  String rwLokasi = "";
  String dusunLokasi = "";
  String desaLokasi = "";
  String kecamatanLokasi = "";
  String panjang = "";
  String lebar = "";
  String luas = "";

  int? varNib;
  int? varNpwp;
  int? varNpwpd;
  int? varSkPenunjukan;
  int? ditolak;

  Future getRincian() async {
    loadingData();

    var result = await http.get(Uri.parse(
        "$baseUrl/api/sipr-rincian?id=${widget.id}&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();

      setState(() {
        user = json.decode(result.body)["user"];
        permohonan = json.decode(result.body)["permohonan"];
        izin = json.decode(result.body)["izin"];
        reklame = json.decode(result.body)["reklame"];
        status = json.decode(result.body)["status"];
        kategori = json.decode(result.body)["kategori"];
        jenis = json.decode(result.body)["jenis"];
        area = json.decode(result.body)["area"];
        lahan = json.decode(result.body)["lahan"];
        pemohon = json.decode(result.body)["pemohon"];

        varNib = pemohon["nib"];
        varNpwp = pemohon["npwp"];
        varNpwpd = pemohon["npwpd"];
        varSkPenunjukan = pemohon["sk_penunjukan"];

        List waktu =
            (json.decode(result.body) as Map<String, dynamic>)["waktu"];

        for (var element in waktu) {
          waktuList.add(WaktuModels.fromJson(element));
        }

        gelarDepan = user['gelar_depan'].toString() != "null"
            ? "${user['gelar_depan'].toString()} "
            : "";
        namaPemohon = user['nama'].toString() != "null"
            ? user['nama'].toString().toUpperCase()
            : "";
        gelarBelakang = user['gelar_belakang'].toString() != "null"
            ? " ${user['gelar_belakang'].toString()}"
            : "";

        alamatPemohon = user['alamat'].toString() != "null"
            ? "${user['alamat'].toString()} "
            : "";
        rtPemohon = user['rt'].toString() != "null"
            ? "RT. ${user['rt'].toString()} "
            : "";
        rwPemohon = user['rw'].toString() != "null"
            ? "RW. ${user['rw'].toString()} "
            : "";
        dusunPemohon = user['dusun'].toString() != "null"
            ? "${user['dusun'].toString()}, "
            : "";
        desaPemohon = user['kelurahan'].toString() != "null"
            ? "${user['kelurahan'].toString()}, "
            : "";
        kecamatanPemohon = user['kecamatan'].toString() != "null"
            ? "KECAMATAN ${user['kecamatan'].toString()}, "
            : "";
        kotaPemohon = user['kota'].toString() != "null"
            ? "${user['kota'].toString()}, "
            : "";
        propinsiPemohon = user['propinsi'].toString() != "null"
            ? user['propinsi'].toString()
            : "";
        tempLahir = user['temp_lahir'].toString() != "null"
            ? user['temp_lahir'].toString()
            : "";
        tglLahir = user['tgl_lahir'].toString() != "null"
            ? ", ${user['tgl_lahir'].toString()}"
            : "";
        namaBadan = user['nama_badan'].toString() != "null"
            ? user['nama_badan'].toString()
            : "";
        kodeBadan = user['KODE'].toString() != "null"
            ? "${user['KODE'].toString()} "
            : "";
        alamatBadan = user['alamat_badan'].toString() != "null"
            ? "${user['alamat_badan'].toString()} "
            : "";
        rtBadan = user['rt_badan'].toString() != "null"
            ? "RT. ${user['rt_badan'].toString()} "
            : "";
        rwBadan = user['rw_badan'].toString() != "null"
            ? "RW. ${user['rw_badan'].toString()} "
            : "";
        dusunBadan = user['dusun_badan'].toString() != "null"
            ? "${user['dusun_badan'].toString()}, "
            : "";
        desaBadan = user['kelurahan_badan'].toString() != "null"
            ? "${user['kelurahan_badan'].toString()}, "
            : "";
        kecamatanBadan = user['kecamatan_badan'].toString() != "null"
            ? "KECAMATAN ${user['kecamatan_badan'].toString()}, "
            : "";
        kotaBadan = user['kota_badan'].toString() != "null"
            ? "${user['kota_badan'].toString()}, "
            : "";
        propinsiBadan = user['propinsi_badan'].toString() != "null"
            ? "${user['propinsi_badan'].toString()}, "
            : "";
        alamatLokasi = reklame['alamat'].toString() != "null"
            ? "${reklame['alamat'].toString()}, "
            : "";
        rtLokasi = reklame['rt'].toString() != "null"
            ? "RT. ${reklame['rt'].toString()} "
            : "";
        rwLokasi = reklame['rw'].toString() != "null"
            ? "RW. ${reklame['rw'].toString()} "
            : "";
        dusunLokasi = reklame['dusun'].toString() != "null"
            ? "${reklame['dusun'].toString()}, "
            : "";
        desaLokasi = reklame['desa'].toString() != "null"
            ? "${reklame['desa'].toString()}, "
            : "";
        kecamatanLokasi = reklame['kecamatan'].toString() != "null"
            ? "KECAMATAN ${reklame['kecamatan'].toString()}"
            : "";
        panjang = reklame['panjang'].toString() != "null"
            ? reklame['panjang'].toString()
            : "";
        lebar = reklame['lebar'].toString() != "null"
            ? reklame['lebar'].toString()
            : "";
        luas = reklame['luas'].toString() != "null"
            ? reklame['luas'].toString()
            : "";

        ditolak = permohonan['ditolak'];
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
            permohonan['waktu_permohonan'].toString() != "null"
                ? permohonan['waktu_permohonan'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Nomor Register :"),
          Text(
            permohonan['register'].toString() != "null"
                ? permohonan['register'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("SKPD :"),
          Text(
            status['kode'].toString() != "null"
                ? status['kode'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Status Permohonan :"),
          Text(
            status['keterangan'].toString() != "null"
                ? status['keterangan'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (ditolak == 1) ...[
            const Text("Catatan :"),
            Html(data: status['catatan'].toString()),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          const Text("Kategori :"),
          Text(
            kategori['kategori'].toString() != "null"
                ? kategori['kategori'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Jenis :"),
          Text(
            jenis['jenis'].toString() != "null"
                ? jenis['jenis'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Materi :"),
          Text(reklame['materi'].toString() != "null"
              ? reklame['materi'].toString()
              : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Iklan Rokok :"),
          Text(reklame['rokok'].toString() == "1" ? "YA" : "TIDAK"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Nama Usaha :"),
          Text(reklame['nama_usaha'].toString() != "null"
              ? reklame['nama_usaha'].toString()
              : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Lokasi :"),
          Text(
              "$alamatLokasi$rtLokasi$rwLokasi$dusunLokasi$desaLokasi$kecamatanLokasi"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Kordinat :"),
          Text("Lat : ${reklame['lat'].toString()}"),
          Text("Lng : ${reklame['lng'].toString()}"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (jenis['area'].toString() == "1") ...[
            const Text("Area :"),
            Text(
              area['area'].toString() != "null" ? area['area'].toString() : "",
            ),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (jenis['ukuran'].toString() == "1") ...[
            const Text("Ukuran :"),
            Text("$panjang m X $lebar m = $luas m\u00B2"),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (jenis['tinggi'].toString() == "1") ...[
            const Text("Tinggi :"),
            Text("${reklame['tinggi'].toString()} m"),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (jenis['diameter_tiang'].toString() == "1") ...[
            const Text("Diameter Tiang :"),
            Text("${reklame['diameter'].toString()} cm"),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (jenis['lembar'].toString() == "1") ...[
            const Text("QTY :"),
            Text("${reklame['lembar'].toString()} lembar"),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (jenis['sisi'].toString() == "1") ...[
            const Text("Sisi/Sudut Pandang :"),
            Text("${reklame['sisi'].toString()} SISI"),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          const Text("Posisi :"),
          Text(reklame['posisi'].toString()),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (jenis['lahan'].toString() == "1") ...[
            const Text("Status Lahan :"),
            Text(lahan['lahan'].toString()),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (reklame["file_izin"] != null &&
              permohonan["ikm"] == 0 &&
              permohonan["id_kadis"] != null) ...[
            const Text("Draft SK :"),
            IntrinsicHeight(
              child: SfPdfViewer.network(
                reklame["file_izin_user"].toString(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(reklame["file_izin_user"].toString()),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file ${reklame["file_izin_user"].toString()}';
                }
              },
              child: const Text("DOWNLOAD"),
            ),
          ],
          if (reklame["file_izin"] != null && permohonan["ikm"] == 1) ...[
            const Text("SK Izin :"),
            IntrinsicHeight(
              child: SfPdfViewer.network(
                reklame["file_izin"].toString(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(reklame["file_izin"].toString()),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file ${reklame["file_izin"].toString()}';
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
          const Text("Jenis Pemohon :"),
          Text(reklame['id_jenis_pemohon'].toString() == "1"
              ? "PERORANGAN"
              : reklame['id_jenis_pemohon'].toString() == "2"
                  ? "BADAN USAHA (BUKAN VENDOR)"
                  : reklame['id_jenis_pemohon'].toString() == "3"
                      ? "BADAN USAHA (VENDOR)"
                      : ""),
          const Divider(
            height: 15,
            thickness: 1,
            color: Colors.black,
          ),
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
          Text(user['pekerjaan'].toString() != "null"
              ? user['pekerjaan'].toString()
              : ""),
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
          Text(user['hp'].toString() != "null" ? user['hp'].toString() : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Email :"),
          Text(user['email'].toString() != "null"
              ? user['email'].toString()
              : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("NIK :"),
          Text(user['nik'].toString() != "null" ? user['nik'].toString() : ""),
          user['dok_ktp'].toString() != ""
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
          if (reklame["id_jenis_pemohon"] != 1) ...[
            const Text("Jabatan Pemohon :"),
            Text(user['jabatan'].toString() != "null"
                ? user['jabatan'].toString()
                : ""),
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const SizedBox(height: 10),
            const Text(
              "DATA BADAN USAHA",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text("Nama Badan Usaha :"),
            Text("$kodeBadan$namaBadan"),
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Text("Alamat :"),
            Text(
                "$alamatBadan$rtBadan$rwBadan$dusunBadan$desaBadan$kecamatanBadan$kotaBadan$propinsiBadan"),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          if (varNpwp == 1) ...[
            const Text("NPWP :"),
            Text(user['npwp'].toString() != "null"
                ? user['npwp'].toString()
                : ""),
            user['dok_npwp'].toString() != ""
                ? DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Image.network(
                      user['dok_npwp'].toString(),
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
          if (varNpwpd == 1) ...[
            const Text("NPWPD :"),
            Text(user['npwpd'].toString() != "null"
                ? user['npwpd'].toString()
                : ""),
            user['dok_npwpd'].toString() != ""
                ? DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Image.network(
                      user['dok_npwpd'].toString(),
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
          if (varNib == 1) ...[
            const Text("NIB :"),
            Text(
                user['nib'].toString() != "null" ? user['nib'].toString() : ""),
            user['dok_nib'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(user['dok_nib'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          ],
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
          const Text(
            "TAMPAK DEPAN",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          reklame['depan'].toString() != ""
              ? DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.network(
                    reklame['depan'].toString(),
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
          const Text(
            "TAMPAK BELAKANG",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          reklame['belakang'].toString() != ""
              ? DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.network(
                    reklame['belakang'].toString(),
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
          const Text(
            "SAMPING KANAN",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          reklame['kanan'].toString() != ""
              ? DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.network(
                    reklame['kanan'].toString(),
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
          const Text(
            "SAMPING KIRI",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          reklame['kiri'].toString() != ""
              ? DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.network(
                    reklame['kiri'].toString(),
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
          if (user['jenis'].toString() != "1") ...[
            const Text("Nomor Akta Pendirian Perusahaan :"),
            Text(user['sk_badan'].toString()),
            const SizedBox(height: 15),
            const Text("Dokumen Akta Pendirian Perusahaan :"),
            const SizedBox(height: 10),
            user['dok_akta'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(user['dok_akta'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
            const Text("Nomor Induk Berusaha (NIB) :"),
            Text(user['nib'].toString()),
            const SizedBox(height: 15),
            const Text("Dokumen NIB :"),
            const SizedBox(height: 10),
            user['dok_nib'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(user['dok_nib'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (reklame['id_lahan'].toString() == "1" ||
              reklame['id_lahan'].toString() == "2") ...[
            const Text("Dokumen Legalitas Lahan :"),
            const SizedBox(height: 10),
            reklame['dok_legal'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['dok_legal'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (reklame['id_lahan'].toString() == "2") ...[
            const Text("Dokumen Perjanjian Sewa Lahan :"),
            const SizedBox(height: 10),
            reklame['dok_sewa'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['dok_sewa'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (reklame['id_lahan'].toString() != "1" &&
              reklame['id_lahan'].toString() != "2") ...[
            const Text("Dokumen Pemangku Jalan :"),
            const SizedBox(height: 10),
            reklame['dok_pemangku'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['dok_pemangku'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (jenis['imb'].toString() == "1") ...[
            const Text("Nomor IMB :"),
            Text(reklame['imb_no'].toString()),
            const SizedBox(height: 15),
            const Text("Dokumen IMB :"),
            const SizedBox(height: 10),
            reklame['dok_imb'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['dok_imb'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (jenis['kkpr'].toString() == "1") ...[
            const Text("Nomor KKPR :"),
            Text(reklame['kkpr'].toString()),
            const SizedBox(height: 15),
            const Text("Dokumen KKPR :"),
            const SizedBox(height: 10),
            reklame['dok_kkpr'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['dok_kkpr'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (jenis['asuransi'].toString() == "1") ...[
            const Text("Dokumen Asuransi :"),
            const SizedBox(height: 10),
            reklame['dok_asuransi'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['dok_asuransi'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (jenis['foto_materi'].toString() == "1") ...[
            const Text("Foto Materi :"),
            const SizedBox(height: 10),
            reklame['foto_materi'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['foto_materi'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (user['jenis'].toString() == "3") ...[
            const Text("Nomor Kontrak :"),
            Text(reklame['no_spk'].toString()),
            const SizedBox(height: 15),
            const Text("Nilai Kontrak :"),
            Text("Rp. ${reklame['kontrak'].toString()}"),
            const SizedBox(height: 15),
            const Text("Dokumen Kontrak :"),
            const SizedBox(height: 10),
            reklame['dok_kontrak'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['dok_kontrak'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
          if (varSkPenunjukan == 1) ...[
            const Text("SK Penunjukan :"),
            const SizedBox(height: 10),
            reklame['dok_lain'].toString() != "null"
                ? Wrap(children: [
                    for (String im
                        in jsonDecode(reklame['dok_lain'].toString())) ...[
                      Card(
                        child: SizedBox(
                          height: 150,
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
                              waktuList[itemIndex].waktu ?? "",
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
                              waktuList[itemIndex].keterangan ?? "",
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
