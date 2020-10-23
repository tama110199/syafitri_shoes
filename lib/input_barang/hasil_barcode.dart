import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syafitri_shoes/home_page.dart';
import 'package:syafitri_shoes/input_barang/input_barang.dart';

class HasilBarcode extends StatefulWidget {
  final String kodeBarang;
  final String namaBarang;
  final String warnaBarang;
  final String jenisBarang;
  final String ukuran;
  final int jumlah;
  final double hargaModal;
  final double hargaNego;

  const HasilBarcode(
      {Key key,
      this.kodeBarang,
      this.namaBarang,
      this.warnaBarang,
      this.jenisBarang,
      this.jumlah,
      this.ukuran,
      this.hargaModal,
      this.hargaNego})
      : super(key: key);

  @override
  _HasilBarcodeState createState() => _HasilBarcodeState();
}

final TextStyle fontAppBar = TextStyle(
    color: Colors.blue,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 20);

final TextStyle fontMainContent = TextStyle(
    color: Colors.black,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 20);

final TextStyle fontContent = TextStyle(
    color: Colors.black,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 18);

final TextStyle fontBarcode = TextStyle(
    color: Colors.black,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16);

final TextStyle fontAlert =
    TextStyle(color: Colors.black, fontFamily: 'Montserrat', fontSize: 14);

class _HasilBarcodeState extends State<HasilBarcode> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, left: 16.0, right: 16.0, top: 38),
                child: Card(
                  elevation: 5,
                  color: Colors.blue[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Data Barang",
                            style: fontMainContent,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          '[${widget.jenisBarang}]'.toUpperCase(),
                          style: fontContent,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          '${widget.namaBarang}',
                          textAlign: TextAlign.justify,
                          style: fontContent,
                        ),
                        Divider(
                          color: Colors.blue,
                        ),
                        Text(
                          'Warna : ${widget.warnaBarang}',
                          style: fontContent,
                        ),
                        Divider(
                          color: Colors.blue,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              'Ukuran : ${widget.ukuran}',
                              style: fontContent,
                            )),
                            Expanded(
                                child: Text(
                              'Jumlah : ${widget.jumlah}',
                              style: fontContent,
                            ))
                          ],
                        ),
                        Divider(
                          color: Colors.blue,
                        ),
                        Text(
                          'Harga Modal : Rp${_rupiah(widget.hargaModal)},-',
                          style: fontContent,
                        ),
                        Text(
                          'Harga Nego : Rp${_rupiah(widget.hargaNego)},-',
                          style: fontContent,
                        ),
                        Divider(
                          color: Colors.blue,
                        ),
                        Text(
                          'Kode : ${widget.kodeBarang}',
                          style: fontContent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              Text('Barcode :'),
              SizedBox(
                height: 8,
              ),
              Center(
                child: BarcodeWidget(
                  margin: EdgeInsets.all(8),
                  height: 90,
                  width: 180,
                  data: widget.kodeBarang,
                  barcode: Barcode.code128(),
                  style: fontBarcode,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.exclamation,
                      color: Colors.red,
                      size: 40,
                    ),
                    Text(
                        '1. Screenshoot halaman ini.\n2. Print barcode barang.\n3. Tempelkan pada barang')
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[100],
            child: Icon(FontAwesomeIcons.fileImport),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InputBarang()));
            }),
      ),
    );
  }

  String _rupiah(double nominal) {
    String convert;
    MoneyFormatterOutput fmf = FlutterMoneyFormatter(
            amount: nominal,
            settings: MoneyFormatterSettings(
                thousandSeparator: '.',
                decimalSeparator: ',',
                fractionDigits: 0))
        .output;
    convert = fmf.nonSymbol;
    return convert;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            title: Text('Kamu Yakin?',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
            content: Text('Kamu akan kembali ke menu utama.',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
            actions: <Widget>[
              FlatButton(
                child: Text('TIDAK',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YA',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ],
          );
        });
  }
}
