import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syafitri_shoes/stok_barang/list_barang.dart';

class DaftarJenis extends StatefulWidget {
  @override
  _DaftarJenisState createState() => _DaftarJenisState();
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
    fontSize: 20);

class _DaftarJenisState extends State<DaftarJenis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Pilih Jenis Barang',
            style: fontAppBar,
          ),
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('jenis_barang')
                  .orderBy('jumlah')
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
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                gradient: LinearGradient(colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade600
                                ])),
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: MaterialButton(
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ListBarang(
                                  jenisBarang: result['jenis'].toString(),
                                )));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 16, right: 8, left: 8),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${result['jenis']}'.toUpperCase(),
                                          style: fontContent,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${result['jumlah']}',
                                            style: fontContent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ));
                      }).toList(),
                    );
                }
              },
            )));
  }
}
