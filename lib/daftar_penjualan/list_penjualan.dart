import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syafitri_shoes/penjualan/detail_transaksi.dart';

class ListPenjualan extends StatefulWidget {
  final String tanggal;

  const ListPenjualan({Key key, this.tanggal}) : super(key: key);

  @override
  _ListPenjualanState createState() => _ListPenjualanState();
}

final TextStyle fontAppBar = TextStyle(
    color: Colors.blue,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 20);

final TextStyle fontContent = TextStyle(
    color: Colors.grey.shade800,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 20);

final TextStyle fontSubContent = TextStyle(
    color: Colors.grey.shade800,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16);
final TextStyle fontFlatButton = TextStyle(
    color: Colors.blue,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16);

class _ListPenjualanState extends State<ListPenjualan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            widget.tanggal,
            style: fontAppBar,
          ),
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('daftar_penjualan')
                  .document(widget.tanggal)
                  .collection('penjualan_harian')
                  .orderBy('tanggal', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('Error : ${snapshot.error}');
                }
                if (snapshot.data == null) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ));
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: snapshot.data.documents
                          .map((DocumentSnapshot result) {
                        return Container(
                            color: Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueAccent, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ));
                      }).toList(),
                    );
                  default:
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: snapshot.data.documents
                          .map((DocumentSnapshot result) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 135,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                border:
                                    Border.all(color: Colors.blue, width: 2)),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, right: 16, left: 16),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${result['nama']}',
                                          style: fontContent,
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
                                              'Ukuran : ${result['ukuran']}',
                                              style: fontSubContent,
                                            )),
                                            Expanded(
                                                child: Text(
                                              '${result['warna']}',
                                              style: fontSubContent,
                                            ))
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Text(
                                              'Sisa stok : ${result['sisa_stok']}',
                                              style: fontSubContent,
                                            )),
                                            Expanded(
                                                child: InkWell(
                                              onTap: () {
                                                _detailTransaksiDialog(
                                                    context,
                                                    result['kode'],
                                                    result['nama'],
                                                    result['warna'],
                                                    result['jenis'],
                                                    result['ukuran'],
                                                    result['sisa_stok'],
                                                    result['harga_modal'],
                                                    result['harga_jual'],
                                                    result['tanggal'],
                                                    result['waktu']);
                                              },
                                              child: Text(
                                                'Detail Transaksi',
                                                style: fontFlatButton,
                                              ),
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            )));
  }

  _detailTransaksiDialog(
      BuildContext context,
      String kode,
      String nama,
      String warna,
      String jenis,
      String ukuran,
      int sisaStok,
      double hargaModal,
      double hargaJual,
      String tanggal,
      String waktu) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailTransaksi(
            kodeBarang: kode,
            namaBarang: nama,
            warnaBarang: warna,
            jenisBarang: jenis,
            ukuran: ukuran,
            sisaStok: sisaStok,
            hargaModal: hargaModal,
            hargaJual: hargaJual,
            tanggal: tanggal,
            waktu: waktu,
          );
        });
  }
}
