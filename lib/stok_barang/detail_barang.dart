import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

final TextStyle fontDialog = TextStyle(
    color: Colors.grey.shade800, fontFamily: 'Montserrat', fontSize: 14);

class DetailBarang extends StatelessWidget {
  final String kodeBarang;
  final String namaBarang;
  final String warnaBarang;
  final String jenisBarang;
  final String ukuran;
  final int jumlah;
  final double hargaModal;
  final double hargaNego;
  final String tanggal;
  final String waktu;

  const DetailBarang(
      {Key key,
      this.kodeBarang,
      this.namaBarang,
      this.warnaBarang,
      this.jenisBarang,
      this.ukuran,
      this.jumlah,
      this.hargaModal,
      this.hargaNego,
      this.tanggal,
      this.waktu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 360,
        child: Dialog(
          backgroundColor: Colors.blue[100],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '[$jenisBarang]'.toUpperCase(),
                      style: fontDialog,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '$namaBarang',
                      textAlign: TextAlign.justify,
                      style: fontDialog,
                    ),
                    Divider(
                      color: Colors.blue,
                    ),
                    Text(
                      'Warna : $warnaBarang',
                      style: fontDialog,
                    ),
                    Divider(
                      color: Colors.blue,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          'Ukuran : $ukuran',
                          style: fontDialog,
                        )),
                        Expanded(
                            child: Text(
                          'Jumlah : $jumlah',
                          style: fontDialog,
                        ))
                      ],
                    ),
                    Divider(
                      color: Colors.blue,
                    ),
                    Text(
                      'Harga Modal : Rp${_rupiah(hargaModal)},-',
                      style: fontDialog,
                    ),
                    Text(
                      'Harga Nego : Rp${_rupiah(hargaNego)},-',
                      style: fontDialog,
                    ),
                    Divider(
                      color: Colors.blue,
                    ),
                    Text(
                      'Kode : $kodeBarang',
                      style: fontDialog,
                    ),
                    Divider(
                      color: Colors.blue,
                    ),
                    Text(
                      'Waktu input barang : \n$tanggal | $waktu',
                      style: fontDialog,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
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
}
