import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/ikm.dart';
import '../services/api_container.dart';

class IkmForm extends StatefulWidget {
  final int id;
  const IkmForm(this.id, {super.key});

  @override
  State<IkmForm> createState() => _IkmFormState();
}

class _IkmFormState extends State<IkmForm> {
  final baseUrl = ApiContainer.baseUrl;
  List<IkmModels> ikmList = [];

  final _formKey = GlobalKey<FormState>();

  Future getIkm() async {
    loadingData();

    var result = await http.get(Uri.parse(
        "$baseUrl/api/permohonan-ikm?id=${widget.id}&key=${ApiContainer.baseKey}"));

    if (result.statusCode == 200) {
      hapusLoader();
      List ikm = (json.decode(result.body) as Map<String, dynamic>)["data"];

      for (var element in ikm) {
        setState(() {
          ikmList.add(IkmModels.fromJson(element));
        });
      }
    } else {
      hapusLoader();
      errorPesan("Terjadi kegagalan koneksi, silahkan ulangi kembali.");
    }
  }

  @override
  void initState() {
    super.initState();
    getIkm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            "SURVEY IKM",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Survey Indeks Kepuasan Masyarakat",
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
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ikmList.length,
                  itemBuilder: (context, itemIndex) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ikmList[itemIndex].pertanyaan.toString(),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 30,
                              child: Row(
                                children: [
                                  Radio(
                                    value: "4",
                                    groupValue:
                                        ikmList[itemIndex].score.toString(),
                                    onChanged: (value) => setState(() {
                                      ikmList[itemIndex].score = "4";
                                    }),
                                  ),
                                  Text(ikmList[itemIndex].d.toString())
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Row(
                                children: [
                                  Radio(
                                    value: "3",
                                    groupValue:
                                        ikmList[itemIndex].score.toString(),
                                    onChanged: (value) => setState(() {
                                      ikmList[itemIndex].score = "3";
                                    }),
                                  ),
                                  Text(ikmList[itemIndex].c.toString())
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Row(
                                children: [
                                  Radio(
                                    value: "2",
                                    groupValue:
                                        ikmList[itemIndex].score.toString(),
                                    onChanged: (value) => setState(() {
                                      ikmList[itemIndex].score = "2";
                                    }),
                                  ),
                                  Text(ikmList[itemIndex].b.toString())
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Row(
                                children: [
                                  Radio(
                                    value: "1",
                                    groupValue:
                                        ikmList[itemIndex].score.toString(),
                                    onChanged: (value) => setState(() {
                                      ikmList[itemIndex].score = "1";
                                    }),
                                  ),
                                  Text(ikmList[itemIndex].a.toString())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      loadingData();

                      List<Map<String, String>> listItem =
                          <Map<String, String>>[];

                      for (int i = 0; i < ikmList.length; i++) {
                        Map<String, String> val = {
                          'id': ikmList[i].id.toString(),
                          'score': ikmList[i].score.toString(),
                        };
                        listItem.add(val);
                      }

                      Map data = {
                        'key': ApiContainer.baseKey,
                        'id_permohonan': widget.id.toString(),
                        'score': listItem,
                      };

                      final http.Response response = await http.post(
                        Uri.parse("$baseUrl/api/permohonan-ikm"),
                        headers: {'content-type': 'application/json'},
                        body: jsonEncode(data),
                      );

                      if (response.statusCode == 200) {
                        hapusLoader();
                        Get.offAllNamed("/home");
                      } else {
                        hapusLoader();
                        errorPesan("Gagal mendapatkan data pemohon");
                      }
                    },
                    child: const Text("KIRIM IKM"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
