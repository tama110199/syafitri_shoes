import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syafitri_shoes/stok_barang/detail_barang.dart';

class ListBarang extends StatefulWidget {
  final String jenisBarang;

  const ListBarang({Key key, this.jenisBarang}) : super(key: key);

  @override
  _ListBarangState createState() => _ListBarangState();
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

class _ListBarangState extends State<ListBarang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            widget.jenisBarang.toUpperCase(),
            style: fontAppBar,
          ),
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('stok_barang')
                  .where('jenis', isEqualTo: widget.jenisBarang)
                  .orderBy('jumlah')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('Error : ${snapshot.error}');
                }
                if (!snapshot.hasData) {
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
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
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
                                              'Stok : ${result['jumlah']}',
                                              style: fontSubContent,
                                            )),
                                            Expanded(
                                                child: InkWell(
                                              onTap: () {
                                                _detailBarangDialog(
                                                    context,
                                                    result['kode'],
                                                    result['nama'],
                                                    result['warna'],
                                                    result['jenis'],
                                                    result['ukuran'],
                                                    result['jumlah'],
                                                    result['harga_modal'],
                                                    result['harga_nego'],
                                                    result['tanggal'],
                                                    result['waktu']);
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
