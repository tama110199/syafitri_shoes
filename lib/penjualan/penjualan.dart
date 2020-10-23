import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syafitri_shoes/convert_waktu.dart';
import 'package:syafitri_shoes/penjualan/hasil_transaksi.dart';
import 'package:syafitri_shoes/stok_barang/detail_barang.dart';
import 'package:syafitri_shoes/stok_barang/list_barang.dart';
import 'package:toast/toast.dart';

class Penjualan extends StatefulWidget {
  @override
  _PenjualanState createState() => _PenjualanState();
}

final TextStyle fontAppBar = TextStyle(
    color: Colors.blue,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 20);

final TextStyle fontContent = TextStyle(
    color: Colors.white,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16);

final TextStyle fontContentInput = TextStyle(
    color: Colors.grey.shade800,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16);

final TextStyle fontInput = TextStyle(
    color: Colors.black,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 18);

final TextEditingController _kodeController = TextEditingController();
final TextEditingController _hargaController = TextEditingController();

ConvertWaktu convertWaktu = ConvertWaktu();
DateTime now = DateTime.now();
String hariNow = convertWaktu.convertHari(now.weekday);
String bulanNow = convertWaktu.convertBulan(now.month);
String tanggalNow = '$hariNow, ${now.day} $bulanNow ${now.year}';
String jamNow = '${now.hour}.${now.minute}';

class _PenjualanState extends State<Penjualan> {
  bool isGetKode = false;
  bool isInputKodeBarang = false;
  bool isDataExist = false;
  String kode, nama, jenis, warna, ukuran, tanggal, waktu;
  double hargaModal, hargaNego;
  int jumlah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Penjualan',
          style: fontAppBar,
        ),
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        color: Colors.blue,
                        child: Text(
                          'Scan Barcode',
                          style: fontContent,
                        ),
                        onPressed: () {
                          Toast.show(
                              'Fitur masih dalam tahap pengembangan', context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        })),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        color: Colors.blue,
                        child: Text(
                          'Input Kode',
                          style: fontContent,
                        ),
                        onPressed: () {
                          setState(() {
                            isInputKodeBarang = true;
                            isGetKode = false;
                          });
                          _kodeController.clear();
                        }))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            (isInputKodeBarang)
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Text(
                          'Input kode barang',
                          style: fontContent,
                        )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: TextField(
                            controller: _kodeController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                            keyboardType: TextInputType.text,
                            style: fontInput,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            color: Colors.greenAccent,
                            child: Text(
                              'Konfirmasi',
                              style: fontContentInput,
                            ),
                            onPressed: () {
                              if (_kodeController.text.isEmpty) {
                                Toast.show('Isi kode barang', context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } else {
                                setState(() {
                                  isInputKodeBarang = false;
                                  isGetKode = true;
                                });
                                Firestore.instance
                                    .collection('stok_barang')
                                    .document(_kodeController.text)
                                    .get()
                                    .then((DocumentSnapshot result) {
                                  if (result.exists) {
                                    setState(() {
                                      kode = result['kode'];
                                      nama = result['nama'];
                                      warna = result['warna'];
                                      jenis = result['jenis'];
                                      ukuran = result['ukuran'];
                                      jumlah = result['jumlah'];
                                      hargaModal = result['harga_modal'];
                                      hargaNego = result['harga_nego'];
                                      tanggal = result['tanggal'];
                                      waktu = result['waktu'];

                                      isDataExist = true;
                                    });
                                  } else {
                                    Toast.show('kode tidak terdaftar', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  }

                                  _kodeController.clear();
                                });
                              }
                            })
                      ],
                    ),
                  )
                : Container(),
            (isGetKode && isDataExist)
                ? Container(
                    height: 285,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: Colors.blue, width: 2)),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, right: 16, left: 16),
                        child: Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '$nama',
                                  style: fontInput,
                                ),
                                Divider(
                                  color: Colors.blue,
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      'Ukuran : $ukuran',
                                      style: fontSubContent,
                                    )),
                                    Expanded(
                                        child: Text(
                                      '$warna',
                                      style: fontSubContent,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      'Kode : $kode',
                                      style: fontSubContent,
                                    )),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        _detailBarangDialog(
                                            context,
                                            kode,
                                            nama,
                                            warna,
                                            jenis,
                                            ukuran,
                                            jumlah,
                                            hargaModal,
                                            hargaNego,
                                            tanggal,
                                            waktu);
                                      },
                                      child: Text(
                                        'Detail Barang',
                                        style: fontFlatButton,
                                      ),
                                    ))
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.blue,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Input harga jual',
                                style: fontSubContent,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              child: TextField(
                                controller: _hargaController,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    )),
                                keyboardType: TextInputType.number,
                                style: fontInput,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              color: Colors.greenAccent,
                              child: Text(
                                'Setujui Transaksi',
                                style: fontContentInput,
                              ),
                              onPressed: () async {
                                double hargaJual =
                                    double.parse(_hargaController.text);
                                if (_hargaController.text.isEmpty) {
                                  Toast.show('Isi harga jual', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                } else if (jumlah == 0) {
                                  Toast.show('Stok barang habis', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                } else {
                                  QuerySnapshot result = await Firestore
                                      .instance
                                      .collection('daftar_penjualan')
                                      .document(tanggalNow)
                                      .collection('penjualan_harian')
                                      .getDocuments();
                                  List<DocumentSnapshot> documents =
                                      result.documents;
                                  int jumlahJualHarian = documents.length;
                                  print(jumlahJualHarian);

                                  Firestore.instance
                                      .collection('daftar_penjualan')
                                      .document(tanggalNow)
                                      .setData({'tanggal': tanggalNow});

                                  int sisaStok = jumlah - 1;
                                  Firestore.instance
                                      .collection('daftar_penjualan')
                                      .document(tanggalNow)
                                      .collection('penjualan_harian')
                                      .document(
                                          (jumlahJualHarian + 1).toString())
                                      .setData({
                                    'kode': kode,
                                    'nama': nama,
                                    'warna': warna,
                                    'jenis': jenis,
                                    'ukuran': ukuran,
                                    'sisa_stok': sisaStok,
                                    'harga_modal': hargaModal,
                                    'harga_jual': hargaJual,
                                    'tanggal': tanggalNow,
                                    'waktu': jamNow
                                  });

                                  Firestore.instance
                                      .collection('stok_barang')
                                      .document(kode)
                                      .updateData({'jumlah': sisaStok});

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HasilTransaksi(
                                                kodeBarang: kode,
                                                namaBarang: nama,
                                                warnaBarang: warna,
                                                jenisBarang: jenis,
                                                ukuran: ukuran,
                                                sisaStok: sisaStok,
                                                hargaModal: hargaModal,
                                                hargaJual: hargaJual,
                                                tanggal: tanggalNow,
                                                waktu: jamNow,
                                              )));

                                  _hargaController.clear();
                                  setState(() {
                                    isDataExist = false;
                                  });
                                }
                              },
                            )
                          ],
                        )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _detailBarangDialog(
      BuildContext context,
      String kode,
      String nama,
      String warna,
      String jenis,
      String ukuran,
      int jumlah,
      double hargaModal,
      double hargaNego,
      String tanggal,
      String waktu) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailBarang(
            kodeBarang: kode,
            namaBarang: nama,
            warnaBarang: warna,
            jenisBarang: jenis,
            ukuran: ukuran,
            jumlah: jumlah,
            hargaModal: hargaModal,
            hargaNego: hargaNego,
            tanggal: tanggal,
            waktu: waktu,
          );
        });
  }
}
