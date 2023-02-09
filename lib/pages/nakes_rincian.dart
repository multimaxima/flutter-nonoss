import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/waktu.dart';
import '../services/api_container.dart';

class NakesRincian extends StatefulWidget {
  final int id;

  const NakesRincian(this.id, {super.key});

  @override
  State<NakesRincian> createState() => _NakesRincianState();
}

class _NakesRincianState extends State<NakesRincian> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> permohonan = {};
  Map<String, dynamic> nakes = {};
  Map<String, dynamic> fasyankes = {};
  Map<String, dynamic> status = {};

  String _namaPemohon = "";
  String _gelarDepan = "";
  String _gelarBelakang = "";
  String _alamatPemohon = "";
  String _dusunPemohon = "";
  String _rtPemohon = "";
  String _rwPemohon = "";
  String _propinsiPemohon = "";
  String _kotaPemohon = "";
  String _kecamatanPemohon = "";
  String _desaPemohon = "";
  String _kodeposPemohon = "";
  String _tempLahir = "";
  String _tglLahir = "";
  String _jenisKelamin = "";
  String _pekerjaan = "";
  String _warganegara = "";
  String _negara = "";
  String _hp = "";
  String _email = "";
  String _nik = "";
  String _perpanjangan = "";
  String _jenisIzin = "";
  String _kodeIzin = "";
  String _tempatPraktik = "";
  String _kategoriFasyankes = "";
  String _namaFasyankes = "";
  String _alamatPraktik = "";
  String _dusunPraktik = "";
  String _rtPraktik = "";
  String _rwPraktik = "";
  String _desaPraktik = "";
  String _kecamatanPraktik = "";
  String _latPraktik = "";
  String _lngPraktik = "";
  String _pendidikanTerakhir = "";
  String _lembagaPendidikan = "";
  String _nomorIjasah = "";
  String _tanggalIjasah = "";
  String _sertKompetensi = "";
  String _tglSertKompetensi = "";
  String _strNo = "";
  String _strBerlaku = "";
  String _strAsal = "";
  String _strTanggal = "";
  String _rekomOp = "";
  String _tglRekomOp = "";
  String _lamaNomor = "";
  String _lamaTanggal = "";
  String _lamaBerlaku = "";
  String _lamaAn = "";
  String _imbNo = "";
  String _rekomDinkesNo = "";
  String _waktuPermohonan = "";
  String _statusPermohonan = "";
  String _skpdPermohonan = "";
  String _registerPermohonan = "";
  int _diTolak = 0;
  String _adaRekom = "";
  String rekomDinkes = "";
  List<WaktuModels> waktuList = [];

  final baseUrl = ApiContainer.baseUrl;

  Future getRincian() async {
    loadingData();

    var result = await http.get(Uri.parse(
        "$baseUrl/api/nakes-rincian?id=${widget.id}&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();

      setState(() {
        user = json.decode(result.body)["user"];
        permohonan = json.decode(result.body)["permohonan"];
        nakes = json.decode(result.body)["nakes"];
        status = json.decode(result.body)["status"];

        List waktu =
            (json.decode(result.body) as Map<String, dynamic>)["waktu"];

        for (var element in waktu) {
          waktuList.add(WaktuModels.fromJson(element));
        }

        if (json.decode(result.body)["fasyankes"] != null) {
          fasyankes = json.decode(result.body)["fasyankes"];

          _kategoriFasyankes = fasyankes["kategori"].toString() != "null"
              ? fasyankes["kategori"].toString().toUpperCase()
              : "";
          _namaFasyankes = fasyankes["nama"].toString() != "null"
              ? fasyankes["nama"].toString().toUpperCase()
              : "";
        } else {
          fasyankes = {};
        }

        _namaPemohon = user["nama"].toString();
        _gelarDepan = user["gelar_depan"].toString() != "null"
            ? "${user["gelar_depan"].toString()} "
            : "";
        _gelarBelakang = user["gelar_belakang"].toString() != "null"
            ? "${user["gelar_belakang"].toString()} "
            : "";
        _alamatPemohon = user["alamat"].toString() != "null"
            ? "${user["alamat"].toString()} "
            : "";
        _dusunPemohon = user["dusun"].toString() != "null"
            ? "${user["dusun"].toString().toUpperCase()}, "
            : "";
        _rtPemohon = user["rt"].toString() != "null"
            ? "RT. ${user["rt"].toString()} "
            : "";
        _rwPemohon = user["rw"].toString() != "null"
            ? "RW. ${user["rw"].toString()} "
            : "";
        _propinsiPemohon = user["propinsi"].toString() != "null"
            ? "${user["propinsi"].toString()} "
            : "";
        _kotaPemohon = user["kota"].toString() != "null"
            ? "${user["kota"].toString()}, "
            : "";
        _kecamatanPemohon = user["kecamatan"].toString() != "null"
            ? "KECAMATAN ${user["kecamatan"].toString()}, "
            : "";
        _desaPemohon = user["kelurahan"].toString() != "null"
            ? "${user["kelurahan"].toString()}, "
            : "";
        _kodeposPemohon = user["kodepos"].toString() != "null"
            ? user["kodepos"].toString()
            : "";
        _tempLahir = user["temp_lahir"].toString() != "null"
            ? "${user["temp_lahir"].toString()}, "
            : "";
        _tglLahir = user["tgl_lahir"].toString() != "null"
            ? user["tgl_lahir"].toString()
            : "";
        _jenisKelamin =
            user["kelamin"].toString() == "1" ? "LAKI-LAKI" : "PEREMPUAN";
        _pekerjaan = user["pekerjaan"].toString() != "null"
            ? user["pekerjaan"].toString().toUpperCase()
            : "";
        _warganegara =
            user["warganegara"].toString() == "1" ? "INDONESIA" : "ASING";
        _negara = user["negara"].toString() != "null"
            ? user["negara"].toString()
            : "";
        _hp = user["hp"].toString() != "null" ? user["hp"].toString() : "";
        _email =
            user["email"].toString() != "null" ? user["email"].toString() : "";
        _nik = user["nik"].toString() != "null" ? user["nik"].toString() : "";
        _perpanjangan = nakes["perpanjangan"].toString() == "0"
            ? "PERMOHONAN IZIN BARU"
            : "PERPANJANGAN IZIN LAMA";
        _jenisIzin = nakes["izin"].toString() != "null"
            ? nakes["izin"].toString().toUpperCase()
            : "";
        _kodeIzin =
            nakes["kode"].toString() != "null" ? nakes["kode"].toString() : "";
        _tempatPraktik = nakes["temp_praktik"].toString() == "1"
            ? "MANDIRI"
            : nakes["temp_praktik"].toString() == "2"
                ? "FASYANKES"
                : nakes["temp_praktik"].toString() == "3"
                    ? "DISTRIBUSI"
                    : "PRODUKSI";

        _alamatPraktik = nakes["alamat"].toString() != "null"
            ? "${nakes["alamat"].toString()}, "
            : "";
        _dusunPraktik = nakes["dusun"].toString() != "null"
            ? "${nakes["dusun"].toString()}, "
            : "";
        _rtPraktik = nakes["rt"].toString() != "null"
            ? "RT. ${nakes["rt"].toString()} "
            : "";
        _rwPraktik = nakes["rw"].toString() != "null"
            ? "RW. ${nakes["rw"].toString()} "
            : "";
        _desaPraktik = nakes["desa"].toString() != "null"
            ? "${nakes["desa"].toString()}, "
            : "";
        _kecamatanPraktik = nakes["kecamatan"].toString() != "null"
            ? "KECAMATAN ${nakes["kecamatan"].toString()}, "
            : "";
        _latPraktik =
            nakes["lat"].toString() != "null" ? nakes["lat"].toString() : "";
        _lngPraktik =
            nakes["lng"].toString() != "null" ? nakes["lng"].toString() : "";
        _pendidikanTerakhir = user["pendidikan_terakhir"].toString() != "null"
            ? user["pendidikan_terakhir"].toString()
            : "";
        _lembagaPendidikan = user["lembaga_pendidikan"].toString() != "null"
            ? user["lembaga_pendidikan"].toString()
            : "";
        _nomorIjasah = user["no_ijasah"].toString() != "null"
            ? user["no_ijasah"].toString()
            : "";
        _tanggalIjasah = user["tgl_ijasah"].toString() != "null"
            ? user["tgl_ijasah"].toString()
            : "";
        _sertKompetensi = user["sert_kompetensi"].toString() != "null"
            ? user["sert_kompetensi"].toString()
            : "";
        _tglSertKompetensi = user["tgl_sert_kompetensi"].toString() != "null"
            ? user["tgl_sert_kompetensi"].toString()
            : "";
        _strNo = user["str_no"].toString() != "null"
            ? user["str_no"].toString()
            : "";
        _strBerlaku = user["str_berlaku"].toString() != "null"
            ? user["str_berlaku"].toString()
            : "";
        _strAsal = user["str_asal"].toString() != "null"
            ? user["str_asal"].toString()
            : "";
        _strTanggal = user["str_tanggal"].toString() != "null"
            ? user["str_tanggal"].toString()
            : "";
        _rekomOp = user["rekom_op"].toString() != "null"
            ? user["rekom_op"].toString()
            : "";
        _tglRekomOp = user["tgl_rekom_op"].toString() != "null"
            ? user["tgl_rekom_op"].toString()
            : "";
        _lamaNomor = nakes["lama_nomor"].toString() != "null"
            ? nakes["lama_nomor"].toString()
            : "";
        _lamaTanggal = nakes["lama_tanggal"].toString() != "null"
            ? nakes["lama_tanggal"].toString()
            : "";
        _lamaBerlaku = nakes["lama_berlaku"].toString() != "null"
            ? nakes["lama_berlaku"].toString()
            : "";
        _lamaAn = nakes["lama_an"].toString() != "null"
            ? nakes["lama_an"].toString()
            : "";
        _imbNo = nakes["imb_no"].toString() != "null"
            ? nakes["imb_no"].toString()
            : "";
        _rekomDinkesNo = nakes["rekom_dinkes_no"].toString() != "null"
            ? nakes["rekom_dinkes_no"].toString()
            : "";
        _waktuPermohonan = permohonan["waktu_permohonan"].toString() != "null"
            ? permohonan["waktu_permohonan"].toString()
            : "";
        _registerPermohonan = permohonan["register"].toString() != "null"
            ? permohonan["register"].toString()
            : "";
        _statusPermohonan = status["keterangan"].toString() != "null"
            ? status["keterangan"].toString()
            : "";
        _skpdPermohonan = status["kode"].toString() != "null"
            ? status["kode"].toString()
            : "";

        _diTolak = permohonan["ditolak"] != 0 ? permohonan["ditolak"] : 0;

        _adaRekom = nakes["ada_rekom"].toString() != "null"
            ? nakes["ada_rekom"].toString()
            : "";

        rekomDinkes = nakes["rekom_dinkes"].toString();
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
          Text("$_gelarDepan$_namaPemohon$_gelarBelakang"),
          const Divider(
            height: 15,
            thickness: 1,
            color: Colors.black,
          ),
          const Text("Alamat :"),
          Text(
              "$_alamatPemohon$_rtPemohon$_rwPemohon$_dusunPemohon$_desaPemohon$_kecamatanPemohon$_kotaPemohon$_propinsiPemohon$_kodeposPemohon"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Temp.Tgl. Lahir :"),
          Text("$_tempLahir$_tglLahir"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Jenis Kelamin :"),
          Text(_jenisKelamin),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Pekerjaan :"),
          Text(_pekerjaan),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Warganegara :"),
          Text(_warganegara),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (user["warganegara"].toString() != "1") ...[
            const Text("Negara :"),
            Text(_negara),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          const Text("Email :"),
          Text(_email),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("HP :"),
          Text(_hp),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("NIK :"),
          Text(_nik),
          user['dok_ktp'].toString() != ""
              ? DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.network(
                    user['dok_ktp'].toString(),
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
        ],
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
            _waktuPermohonan,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Nomor Register :"),
          Text(
            _registerPermohonan,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("SKPD :"),
          Text(
            _skpdPermohonan,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Status Permohonan :"),
          Text(
            _statusPermohonan,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          if (_diTolak == 1) ...[
            const Text("Catatan :"),
            Html(data: status["catatan"].toString()),
            const Divider(height: 15, thickness: 1, color: Colors.black),
          ],
          const Text("Jenis Permohonan :"),
          Text(_perpanjangan),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Jenis Izin :"),
          Text("$_jenisIzin ($_kodeIzin)"),
          const Divider(height: 15, thickness: 1, color: Colors.black),
          const Text("Tempat Praktik :"),
          Text(_tempatPraktik),
          if (nakes["temp_praktik"].toString() != "1") ...[
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Text("Kategori Fasyankes :"),
            Text(_kategoriFasyankes),
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Text("Nama Fasyankes :"),
            Text(_namaFasyankes),
          ] else ...[
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Text("Alamat Praktik :"),
            Text(
                "$_alamatPraktik$_rtPraktik$_rwPraktik$_dusunPraktik$_desaPraktik$_kecamatanPraktik"),
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Text("Kordinat Praktik :"),
            Text("Lat : $_latPraktik"),
            Text("Lon : $_lngPraktik"),
          ],
          if (nakes["file_izin"] != null &&
              permohonan["ikm"] == 0 &&
              permohonan["id_kadis"] != null) ...[
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Text("Draft SK :"),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: SfPdfViewer.network(nakes['file_izin_user'].toString()),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(nakes["file_izin_user"].toString()),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file ${nakes["file_izin_user"].toString()}';
                }
              },
              child: const Text("DOWNLOAD"),
            ),
          ],
          if (nakes["file_izin"] != null && permohonan["ikm"] == 1) ...[
            const Divider(height: 15, thickness: 1, color: Colors.black),
            const Text("SK Izin :"),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: SfPdfViewer.network(nakes['file_izin'].toString()),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(nakes["file_izin"].toString()),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Tidak dapat membuka file ${nakes["file_izin"].toString()}';
                }
              },
              child: const Text("DOWNLOAD"),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildDokumen() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(children: [
        const Text(
          "DOKUMEN PERMOHONAN",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (_pendidikanTerakhir != "") ...[
          const SizedBox(height: 10),
          const Text(
            "PENDIDIKAN TERAKHIR",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text("Pendidikan Terakhir :"),
          Text(_pendidikanTerakhir),
          const SizedBox(height: 10),
          const Text("Lembaga Pendidikan :"),
          Text(_lembagaPendidikan),
          const SizedBox(height: 10),
          const Text("Nomor Ijasah :"),
          Text(_nomorIjasah),
          const SizedBox(height: 10),
          const Text("Tanggal Ijasah :"),
          Text(_tanggalIjasah),
          const SizedBox(height: 10),
          const Text("Dokumen Ijasah :"),
          const SizedBox(height: 10),
          user["dok_ijasah"].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(user["dok_ijasah"].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (_sertKompetensi != "") ...[
          const SizedBox(height: 10),
          const Text(
            "SERTIFIKAT KOMPETENSI",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text("Sertifikat Kompetensi :"),
          Text(_sertKompetensi),
          const SizedBox(height: 10),
          const Text("Tanggal Sertifikat Kompetensi :"),
          Text(_tglSertKompetensi),
          const SizedBox(height: 10),
          const Text("Tanggal Sertifikat Kompetensi :"),
          Text(_tglSertKompetensi),
          const Text("Dokumen Sertifikat Kompetensi :"),
          const SizedBox(height: 10),
          user["dok_sert_kompetensi"].toString() != "null"
              ? Wrap(children: [
                  for (String im in jsonDecode(
                      user["dok_sert_kompetensi"].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['str_no'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SURAT TANDA REGISTER (STR)",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text("Nomor STR :"),
          Text(_strNo),
          const SizedBox(height: 10),
          const Text("Tanggal STR :"),
          Text(_strTanggal),
          const SizedBox(height: 10),
          const Text("STR Berlaku Sampai :"),
          Text(_strBerlaku),
          const SizedBox(height: 10),
          const Text("STR Dikeluarkan Oleh :"),
          Text(_strAsal),
          const SizedBox(height: 10),
          const Text("Dokumen STR :"),
          const SizedBox(height: 10),
          user["dok_str"].toString() != "null"
              ? Wrap(children: [
                  for (String im in jsonDecode(user["dok_str"].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['rekom_op'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "REKOM ORGANISASI PROFESI",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text("Nomor Rekom Organisasi Profesi :"),
          Text(_rekomOp),
          const SizedBox(height: 10),
          const Text("Tanggal Rekom :"),
          Text(_tglRekomOp),
          const SizedBox(height: 10),
          const Text("Dokumen Rekom Organisasi Profesi :"),
          const SizedBox(height: 10),
          user["dok_rekom_op"].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(user["dok_rekom_op"].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['ket_sehat'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SURAT KETERANGAN SEHAT DARI DOKTER YANG MEMILIKI SURAT IZIN PRAKTIK",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          user['ket_sehat'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(user['ket_sehat'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['sp_mematuhi'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SURAT PERNYATAAN AKAN MEMATUHI DAN MELAKSANAKAN KETENTUAN ETIKA KEFARMASIAN",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          user['sp_mematuhi'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(user['sp_mematuhi'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['sp_temp_praktek'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SURAT PERNYATAAN MEMPUNYAI TEMPAT PRAKTIK/KERJA DI FASILITAS PELAYANAN KESEHATAN ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          user['sp_temp_praktek'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(user['sp_temp_praktek'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['sk_fasyankes'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SURAT KETERANGAN DARI PIMPINAN FASILITAS PELAYANAN KESEHATAN SEBAGAI TEMPAT PRAKTIK/BEKERJA",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          user['sk_fasyankes'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(user['sk_fasyankes'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['sp_atasan'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SURAT PERSETUJUAN DARI ATASAN LANGSUNG BAGI YANG BEKERJA PADA INSTANSI/FASILITAS PELAYANAN KESEHATAN PEMERINTAH ATAU PADA INSTANSI/FASILITAS PELAYANAN KESEHATAN LAIN SECARA PURNA WAKTU",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          user['sp_atasan'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(user['sp_atasan'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['sk_komite_interensif'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SURAT KETERANGAN DARI KOMITE INTERNSIP DOKTER INDONESIA",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          user['sk_komite_interensif'].toString() != "null"
              ? Wrap(children: [
                  for (String im in jsonDecode(
                      user['sk_komite_interensif'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (user['surat_izin_sebelum'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SURAT IZIN DARI FASYANKES SEBELUMNYA",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          user['surat_izin_sebelum'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(user['surat_izin_sebelum'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (_lamaNomor != "") ...[
          const SizedBox(height: 10),
          const Text(
            "SIP LAMA",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text("Nomor SIP Lama :"),
          Text(_lamaNomor),
          const SizedBox(height: 10),
          const Text("Atas Nama :"),
          Text(_lamaAn),
          const SizedBox(height: 10),
          const Text("Tanggal SIP :"),
          Text(_lamaTanggal),
          const SizedBox(height: 10),
          const Text("Berlaku Sampai :"),
          Text(_lamaBerlaku),
          const SizedBox(height: 10),
          const Text("Dokumen SIP Lama :"),
          nakes['lama_dok'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(nakes['lama_dok'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (_imbNo != "") ...[
          const SizedBox(height: 10),
          const Text(
            "IMB / PBG",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text("Nomor IMB :"),
          Text(_imbNo),
          const SizedBox(height: 10),
          const Text("Dokumen IMB :"),
          nakes['dok_imb'].toString() != "null"
              ? Wrap(children: [
                  for (String im
                      in jsonDecode(nakes['dok_imb'].toString())) ...[
                    Image.network(
                      im,
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
                    const SizedBox(height: 5),
                  ]
                ])
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (_rekomDinkesNo != "" &&
            nakes['rekom_dinkes'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "REKOMENDASI DINAS KESEHATAN",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text("Nomor Rekomendasi Dinkes :"),
          Text(_rekomDinkesNo),
          const SizedBox(height: 10),
          const Text("Dokumen Rekomendasi Dinkes :"),
          const SizedBox(height: 10),
          nakes['rekom_dinkes'].toString() != "null"
              ? _adaRekom == "1"
                  ? Wrap(children: [
                      for (String im
                          in jsonDecode(nakes['rekom_dinkes'].toString())) ...[
                        Image.network(
                          im,
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
                        const SizedBox(height: 5),
                      ]
                    ])
                  : IntrinsicHeight(
                      child: SfPdfViewer.network(rekomDinkes),
                    )
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
        if (nakes['dok_sppl'].toString() != "null") ...[
          const SizedBox(height: 10),
          const Text(
            "SPPL",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          nakes['dok_sppl'].toString() != "null"
              ? IntrinsicHeight(
                  child: SfPdfViewer.network(nakes['dok_sppl'].toString()),
                )
              : const SizedBox(),
          const Divider(height: 15, thickness: 1, color: Colors.black),
        ],
      ]),
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
