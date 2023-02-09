import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/kkpr_tanah_rincian.dart';
import '../services/api_container.dart';
import '../models/waktu.dart';

class KkprRincian extends StatefulWidget {
  final int id;

  const KkprRincian(this.id, {super.key});

  @override
  State<KkprRincian> createState() => _KkprRincianState();
}

class _KkprRincianState extends State<KkprRincian> {
  final baseUrl = ApiContainer.baseUrl;

  Map<String, dynamic> user = {};
  Map<String, dynamic> izin = {};
  Map<String, dynamic> permohonan = {};
  Map<String, dynamic> pkkpr = {};
  Map<String, dynamic> status = {};
  List<WaktuModels> waktuList = [];
  List<KkprRincianTanahModels> lahanList = [];

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

  Future getRincian() async {
    loadingData();

    var result = await http.get(Uri.parse(
        "$baseUrl/api/kkpr-rincian?id=${widget.id}&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();

      setState(() {
        user = json.decode(result.body)["user"];
        permohonan = json.decode(result.body)["permohonan"];
        izin = json.decode(result.body)["izin"];
        pkkpr = json.decode(result.body)["pkkpr"];
        status = json.decode(result.body)["status"];

        List waktu =
            (json.decode(result.body) as Map<String, dynamic>)["waktu"];

        for (var element in waktu) {
          waktuList.add(WaktuModels.fromJson(element));
        }

        List lahan =
            (json.decode(result.body) as Map<String, dynamic>)["lahan"];

        for (var element in lahan) {
          lahanList.add(KkprRincianTanahModels.fromJson(element));
        }

        gelarDepan = user['gelar_depan'].toString() != "null"
            ? "${user['gelar_depan'].toString()} "
            : "";
        namaPemohon =
            user['nama'].toString() != "null" ? user['nama'].toString() : "";
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

        alamatLokasi = pkkpr['alamat'].toString() != "null"
            ? "${pkkpr['alamat'].toString().toUpperCase()}, "
            : "";
        rtLokasi = pkkpr['rt'].toString() != "null"
            ? "RT. ${pkkpr['rt'].toString().toUpperCase()} "
            : "";
        rwLokasi = pkkpr['rw'].toString() != "null"
            ? "RW. ${pkkpr['rw'].toString().toUpperCase()} "
            : "";
        dusunLokasi = pkkpr['dusun'].toString() != "null"
            ? "${pkkpr['dusun'].toString().toUpperCase()}, "
            : "";
        desaLokasi = pkkpr['desa'].toString() != "null"
            ? "${pkkpr['desa'].toString().toUpperCase()}, "
            : "";
        kecamatanLokasi = pkkpr['kecamatan'].toString() != "null"
            ? "KECAMATAN ${pkkpr['kecamatan'].toString().toUpperCase()}"
            : "";
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
            "KKPR",
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
          Text(permohonan['waktu_permohonan'].toString()),
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
          const Text("Status :"),
          Text(
            status['keterangan'].toString() != "null"
                ? status['keterangan'].toString()
                : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Catatan Permohonan :"),
          Text(pkkpr['catatan'].toString() != "null"
              ? pkkpr['catatan'].toString()
              : ""),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Kategori :"),
          Text(
            pkkpr['kategori'].toString() != "null"
                ? pkkpr['kategori'].toString()
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Jenis :"),
          Text(
            pkkpr['jenis'].toString() != "null"
                ? pkkpr['jenis'].toString()
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Rencana Peruntukan :"),
          Text(
            pkkpr['rencana_peruntukan'].toString() != "null"
                ? pkkpr['rencana_peruntukan'].toString()
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Rencana Peruntukan :"),
          Text(
            pkkpr['rencana_peruntukan'].toString() != "null"
                ? pkkpr['rencana_peruntukan'].toString().toUpperCase()
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Alamat Lokasi :"),
          Text(
              "$alamatLokasi$rtLokasi$rwLokasi$dusunLokasi$desaLokasi$kecamatanLokasi"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Luas Lahan Dimohon :"),
          Text(
            pkkpr['luas_lahan_dimohon'].toString() != "null"
                ? "${pkkpr['luas_lahan_dimohon'].toString()} m\u00B2"
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Luas Tanah Sesuai Bukti Kepemilikan :"),
          Text(
            pkkpr['luas_lahan_milik'].toString() != "null"
                ? "${pkkpr['luas_lahan_milik'].toString().toUpperCase()} m\u00B2"
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Luas Tanah Untuk Bangunan :"),
          Text(
            pkkpr['luas_lahan_bangunan'].toString() != "null"
                ? "${pkkpr['luas_lahan_bangunan'].toString().toUpperCase()} m\u00B2"
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Rencana Jumlah Lantai :"),
          Text(
            pkkpr['rencana_lantai'].toString() != "null"
                ? "${pkkpr['rencana_lantai'].toString().toUpperCase()} lantai"
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Rencana Tinggi Bangunan :"),
          Text(
            pkkpr['tinggi_bangunan'].toString() != "null"
                ? "${pkkpr['tinggi_bangunan'].toString().toUpperCase()} m"
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Rencana Luas Lantai Bangunan :"),
          Text(
            pkkpr['rencana_luas_lantai'].toString() != "null"
                ? "${pkkpr['rencana_luas_lantai'].toString().toUpperCase()} m\u00B2"
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Penggunaan Sekarang :"),
          Text(
            pkkpr['penggunaan_sekarang'].toString() != "null"
                ? pkkpr['penggunaan_sekarang'].toString().toUpperCase()
                : "",
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Kordinat Lokasi :"),
          Text("Lat : ${pkkpr['lat'].toString()}"),
          Text("Lng : ${pkkpr['lng'].toString()}"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Polygon Lokasi :"),
          Text(pkkpr['polygon_ori'].toString()),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Align(
            child: Text(
              "NERACA BAKU AIR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Jenis Kegiatan :"),
          Text(pkkpr['variabel'].toString().toUpperCase()),
          if (pkkpr['penghuni'].toString() != "null" &&
              pkkpr['penghuni'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Penghuni :"),
            Text("${pkkpr['penghuni'].toString()} Orang"),
          ],
          if (pkkpr['jamaah'].toString() != "null" && pkkpr['jamaah'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Jamaah :"),
            Text("${pkkpr['jamaah'].toString()} Orang"),
          ],
          if (pkkpr['siswa'].toString() != "null" && pkkpr['siswa'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Siswa :"),
            Text("${pkkpr['siswa'].toString()} Orang"),
          ],
          if (pkkpr['karyawan'].toString() != "null" &&
              pkkpr['karyawan'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Karyawan :"),
            Text("${pkkpr['karyawan'].toString()} Orang"),
          ],
          if (pkkpr['l_bangunan'].toString() != "null" &&
              pkkpr['l_bangunan'].toString() != "0.00") ...[
            const SizedBox(height: 10),
            const Text("Luas Bangunan :"),
            Text("${pkkpr['l_bangunan'].toString()} m\u00B2"),
          ],
          if (pkkpr['kursi'].toString() != "null" && pkkpr['kursi'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Kursi :"),
            Text("${pkkpr['kursi'].toString()} Buah"),
          ],
          if (pkkpr['kebutuhan'].toString() != "null" &&
              pkkpr['kebutuhan'].toString() != "0.00") ...[
            const SizedBox(height: 10),
            const Text("Kebutuhan :"),
            Text("${pkkpr['kebutuhan'].toString()} L/Hari"),
          ],
          if (pkkpr['sd'].toString() != "null" && pkkpr['sd'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Siswa SD :"),
            Text("${pkkpr['sd'].toString()} Orang"),
          ],
          if (pkkpr['smp'].toString() != "null" && pkkpr['smp'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Siswa SMP :"),
            Text("${pkkpr['smp'].toString()} Orang"),
          ],
          if (pkkpr['sma'].toString() != "null" && pkkpr['sma'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Siswa SMA :"),
            Text("${pkkpr['sma'].toString()} Orang"),
          ],
          if (pkkpr['pt'].toString() != "null" && pkkpr['pt'] != 0) ...[
            const SizedBox(height: 10),
            const Text("Mahasiswa :"),
            Text("${pkkpr['pt'].toString()} Orang"),
          ],
          if (pkkpr['luas_tambak'].toString() != "null" &&
              pkkpr['luas_tambak'].toString() != "0.00") ...[
            const SizedBox(height: 10),
            const Text("Luas Tambak :"),
            Text("${pkkpr['luas_tambak'].toString()} m\u00B2"),
          ],
          if (pkkpr['insensitas_tambak'].toString() != "null" &&
              pkkpr['insensitas_tambak'].toString() != "0") ...[
            const SizedBox(height: 10),
            const Text("Intensitas Tambak :"),
            Text("${pkkpr['insensitas_tambak'].toString()} Musim/Tahun"),
          ],
          if (pkkpr['luas_toko'].toString() != "null" &&
              pkkpr['luas_toko'].toString() != "0.00") ...[
            const SizedBox(height: 10),
            const Text("Luas Toko :"),
            Text("${pkkpr['luas_toko'].toString()} m\u00B2"),
          ],
          const SizedBox(height: 10),
          const Text("Kebutuhan Air Bersih :"),
          Text("${pkkpr['air_bersih'].toString()} L/Hari"),
          const SizedBox(height: 10),
          const Text("Masak Cuci Kakus :"),
          Text("${pkkpr['masak_cuci'].toString()} L/Hari"),
          const SizedBox(height: 10),
          const Text("Lain-lain (Penyiraman) :"),
          Text("${pkkpr['penyiraman'].toString()} L/Hari"),
          const SizedBox(height: 10),
          const Text("Kapasitas IPAL :"),
          Text("${pkkpr['ipal'].toString()} L/Hari"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lahanList.length,
            itemBuilder: (context, itemIndex) {
              return Card(
                color: Colors.green[100],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Column(
                    children: [
                      Text(
                        "LEGALITAS LAHAN #${itemIndex + 1}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Html(
                          data:
                              "Luas tanah <b>${lahanList[itemIndex].luasAkta} m<sup>2</sup></b> dari total luas tanah ${pkkpr['luas_lahan_dimohon'].toString()} m<sup>2</sup> dengan status kepemilikan tanah ${lahanList[itemIndex].keterangan} atas nama <b>${lahanList[itemIndex].atasNamaAkta}</b> tercantum dalam ${lahanList[itemIndex].statusTanah}  No. ${lahanList[itemIndex].nomorAkta} tahun ${lahanList[itemIndex].tahunAkta} Surat Ukur No. ${lahanList[itemIndex].suratUkur} tanggal ${lahanList[itemIndex].suratUkurTgl} dan status lahan ${lahanList[itemIndex].keadaanTanah}."),
                      if (lahanList[itemIndex].dokAkta.toString() != "[]") ...[
                        const SizedBox(height: 10),
                        const Text(
                          "LEGALITAS LAHAN",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            for (String im in jsonDecode(
                                lahanList[itemIndex].dokAkta.toString())) ...[
                              Card(
                                child: SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Image.network(
                                    im,
                                    fit: BoxFit.cover,
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
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                      if (lahanList[itemIndex].suketKematian.toString() !=
                          "[]") ...[
                        const SizedBox(height: 10),
                        const Text(
                          "SURAT KETERANGAN KEMATIAN",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            for (String im in jsonDecode(lahanList[itemIndex]
                                .suketKematian
                                .toString())) ...[
                              Card(
                                child: SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Image.network(
                                    im,
                                    fit: BoxFit.cover,
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
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                      if (lahanList[itemIndex].suketWaris.toString() !=
                          "[]") ...[
                        const SizedBox(height: 10),
                        const Text(
                          "SURAT KETERANGAN AHLI WARIS",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            for (String im in jsonDecode(lahanList[itemIndex]
                                .suketWaris
                                .toString())) ...[
                              Card(
                                child: SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Image.network(
                                    im,
                                    fit: BoxFit.cover,
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
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                      if (lahanList[itemIndex].perjanjianSewa.toString() !=
                          "[]") ...[
                        const SizedBox(height: 10),
                        const Text(
                          "SURAT PERJANJIAN SEWA",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            for (String im in jsonDecode(lahanList[itemIndex]
                                .perjanjianSewa
                                .toString())) ...[
                              Card(
                                child: SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Image.network(
                                    im,
                                    fit: BoxFit.cover,
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
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                      if (lahanList[itemIndex].perikatanJualBeli.toString() !=
                          "[]") ...[
                        const SizedBox(height: 10),
                        const Text(
                          "PERIKATAN JUAL BELI",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            for (String im in jsonDecode(lahanList[itemIndex]
                                .perikatanJualBeli
                                .toString())) ...[
                              Card(
                                child: SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Image.network(
                                    im,
                                    fit: BoxFit.cover,
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
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                      if (lahanList[itemIndex].ajb.toString() != "[]") ...[
                        const SizedBox(height: 10),
                        const Text(
                          "AKTA JUAL BELI",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            for (String im in jsonDecode(
                                lahanList[itemIndex].ajb.toString())) ...[
                              Card(
                                child: SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Image.network(
                                    im,
                                    fit: BoxFit.cover,
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
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                      if (lahanList[itemIndex]
                              .pernyataanPemilikTanah
                              .toString() !=
                          "[]") ...[
                        const SizedBox(height: 10),
                        const Text(
                          "SURAT PERNYATAAN PEMILIK TANAH",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            for (String im in jsonDecode(lahanList[itemIndex]
                                .pernyataanPemilikTanah
                                .toString())) ...[
                              Card(
                                child: SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Image.network(
                                    im,
                                    fit: BoxFit.cover,
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
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                      if (lahanList[itemIndex].petaBidang.toString() !=
                          "[]") ...[
                        const SizedBox(height: 10),
                        const Text(
                          "PETA BIDANG",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            for (String im in jsonDecode(lahanList[itemIndex]
                                .petaBidang
                                .toString())) ...[
                              Card(
                                child: SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Image.network(
                                    im,
                                    fit: BoxFit.cover,
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
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
          if (pkkpr['file_izin'] != null &&
              permohonan['ikm'] == 0 &&
              permohonan['id_kadis'] != null) ...[
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Align(
              child: Text(
                "DRAFT SK",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: SfPdfViewer.network(
                pkkpr["file_izin_user"].toString(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(pkkpr["file_izin_user"].toString()),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file ${pkkpr["file_izin_user"].toString()}';
                }
              },
              child: const Text("DOWNLOAD"),
            ),
          ],
          if (pkkpr['file_izin'] != null && permohonan['ikm'] == 1) ...[
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Align(
              child: Text(
                "SK IZIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: SfPdfViewer.network(
                pkkpr["file_izin"].toString(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(pkkpr["file_izin"].toString()),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file ${pkkpr["file_izin"].toString()}';
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
          Text(pkkpr['id_jenis_pemohon'].toString() == "1"
              ? "PERORANGAN"
              : pkkpr['id_jenis_pemohon'].toString() == "2"
                  ? "YAYASAN"
                  : pkkpr['id_jenis_pemohon'].toString() == "3"
                      ? "PERUSAHAAN"
                      : "PEMERINTAH"),
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
            "SITEPLAN / MASTERPLAN",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          pkkpr['rencana_teknis'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(pkkpr['rencana_teknis'].toString())) ...[
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
          const SizedBox(height: 10),
          const Text(
            "FOTO LOKASI",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          pkkpr['foto_lokasi'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(pkkpr['foto_lokasi'].toString())) ...[
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
          if (pkkpr['id_jenis_pemohon'].toString() == "2" ||
              pkkpr['id_jenis_pemohon'].toString() == "3") ...[
            const SizedBox(height: 10),
            const Text(
              "LEGALITAS BADAN",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Nomor Akta :"),
            Text(user['sk_badan'].toString() != "null"
                ? user['sk_badan'].toString()
                : ""),
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
          ],
          if (pkkpr['sps'].toString() != "" &&
              pkkpr['sps'].toString() != "null") ...[
            const SizedBox(height: 10),
            const Text(
              "SURAT PERINTAH SETOR",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            pkkpr['sps'].toString() != "null"
                ? Wrap(children: [
                    for (String im in jsonDecode(pkkpr['sps'].toString())) ...[
                      Card(
                        child: SizedBox(
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
          ]
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
