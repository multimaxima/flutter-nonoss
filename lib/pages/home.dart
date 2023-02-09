import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
            const SizedBox(width: 5),
            const Text(
              "PERIZINAN BANYUWANGI",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
          ],
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
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ElevatedButton(
            onPressed: () => Get.toNamed("/nakes"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(30),
                      1: IntrinsicColumnWidth(flex: 100),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: <TableRow>[
                      const TableRow(
                        children: <Widget>[
                          Text(
                            "1.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "NAKES",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(),
                          const TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "Izin Tenaga Kesehatan",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 231, 231, 231),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Get.toNamed("/kkpr"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(30),
                      1: IntrinsicColumnWidth(flex: 100),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: <TableRow>[
                      const TableRow(
                        children: <Widget>[
                          Text(
                            "2.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "KKPR",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(),
                          const TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "Kesesuaian Kegiatan Pemanfaatan Ruang",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 231, 231, 231),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Get.toNamed("/sipr"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(30),
                      1: IntrinsicColumnWidth(flex: 100),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: <TableRow>[
                      const TableRow(
                        children: <Widget>[
                          Text(
                            "3.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "SIPR",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(),
                          const TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "Surat Izin Penyelenggaraan Reklame",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 231, 231, 231),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Get.toNamed("/skp"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(30),
                      1: IntrinsicColumnWidth(flex: 100),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: <TableRow>[
                      const TableRow(
                        children: <Widget>[
                          Text(
                            "4.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "SKP",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(),
                          const TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "Surat Keterangan Penelitian",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 231, 231, 231),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          // ElevatedButton(
          //   onPressed: () => Get.toNamed("/perling"),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
          //         child: Table(
          //           columnWidths: const <int, TableColumnWidth>{
          //             0: FixedColumnWidth(30),
          //             1: IntrinsicColumnWidth(flex: 100),
          //           },
          //           defaultVerticalAlignment: TableCellVerticalAlignment.top,
          //           children: <TableRow>[
          //             const TableRow(
          //               children: <Widget>[
          //                 Text(
          //                   "5.",
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //                 TableCell(
          //                   verticalAlignment: TableCellVerticalAlignment.top,
          //                   child: Text(
          //                     "PERLING",
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 16,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             TableRow(
          //               children: <Widget>[
          //                 Container(),
          //                 const TableCell(
          //                   verticalAlignment: TableCellVerticalAlignment.top,
          //                   child: Text(
          //                     "Persetujuan Lingkungan",
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.normal,
          //                       color: Color.fromARGB(255, 231, 231, 231),
          //                       fontSize: 14,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 10),
          // ElevatedButton(
          //   onPressed: () => Get.toNamed("/mbr"),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
          //         child: Table(
          //           columnWidths: const <int, TableColumnWidth>{
          //             0: FixedColumnWidth(30),
          //             1: IntrinsicColumnWidth(flex: 100),
          //           },
          //           defaultVerticalAlignment: TableCellVerticalAlignment.top,
          //           children: <TableRow>[
          //             const TableRow(
          //               children: <Widget>[
          //                 Text(
          //                   "6.",
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //                 TableCell(
          //                   verticalAlignment: TableCellVerticalAlignment.top,
          //                   child: Text(
          //                     "MBR",
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 16,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             TableRow(
          //               children: <Widget>[
          //                 Container(),
          //                 const TableCell(
          //                   verticalAlignment: TableCellVerticalAlignment.top,
          //                   child: Text(
          //                     "Perumahan Masyarakat Berpenghasilan Rendah",
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.normal,
          //                       color: Color.fromARGB(255, 231, 231, 231),
          //                       fontSize: 14,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () => Get.toNamed("/riwayat"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(30),
                      1: IntrinsicColumnWidth(flex: 100),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: <TableRow>[
                      const TableRow(
                        children: <Widget>[
                          Text(
                            "5.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "RIWAYAT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(),
                          const TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text(
                              "Riwayat Permohonan Izin",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 231, 231, 231),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
