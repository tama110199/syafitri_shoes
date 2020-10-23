import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:syafitri_shoes/convert_waktu.dart';
import 'package:syafitri_shoes/input_barang/hasil_barcode.dart';

final TextStyle fontDialogAlert = TextStyle(
    color: Colors.black,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16);

final TextStyle fontDialog = TextStyle(
    color: Colors.grey.shade800, fontFamily: 'Montserrat', fontSize: 14);

final TextStyle fontButtonDialog = TextStyle(
    color: Colors.grey.shade800,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16);

class BarangKonfirmDialog extends StatelessWidget {
  final String kodeBarang;
  final String namaBarang;
  final String warnaBarang;
  final String jenisBarang;
  final String ukuran;
  final int jumlah;
  final double hargaModal;
  final double hargaNego;

  const BarangKonfirmDialog(
      {Key key,
      this.kodeBarang,
      this.namaBarang,
      this.warnaBarang,
      this.jenisBarang,
      this.ukuran,
      this.jumlah,
      this.hargaModal,
      this.hargaNego})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConvertWaktu convertnow = ConvertWaktu();
    DateTime now = DateTime.now();
    String hariNow = convertnow.convertHari(now.weekday);
    String bulanNow = convertnow.convertBulan(now.month);
    String tanggalNow = '$hariNow, ${now.day} $bulanNow ${now.year}';
    String jamNow = '${now.hour}.${now.minute}';

    return Center(
      child: SizedBox(
        height: 390,
        child: Dialog(
          backgroundColor: Colors.blue[100],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    "Pastikan Data Sudah Benar !",
                    style: fontDialogAlert,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
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
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton(
                    color: Colors.blue[300],
                    child: Text(
                      'Buat Barcode',
                      style: fontButtonDialog,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () async {
                      Firestore.instance
                          .collection('stok_barang')
                          .document(kodeBarang)
                          .setData({
                        'kode': kodeBarang,
                        'nama': namaBarang,
                        'warna': warnaBarang,
                        'jenis': jenisBarang.toLowerCase(),
                        'ukuran': ukuran,
                        'jumlah': jumlah,
                        'harga_modal': hargaModal,
                        'harga_nego': hargaNego,
                        'tanggal': tanggalNow,
                        'waktu': jamNow
                      });

                      QuerySnapshot result = await Firestore.instance
                          .collection("stok_barang")
                          .where("jenis", isEqualTo: jenisBarang)
                          .getDocuments();
                      List<DocumentSnapshot> documents = result.documents;
                      int jumlahJenis = documents.length;
                      print(jumlahJenis);

                      Firestore.instance
                          .collection('jenis_barang')
                          .document(jenisBarang.toLowerCase())
                          .setData({
                        'jenis': jenisBarang.toLowerCase(),
                        'jumlah': jumlahJenis,
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HasilBarcode(
                                    kodeBarang: kodeBarang,
                                    namaBarang: namaBarang,
                                    warnaBarang: warnaBarang,
                                    jenisBarang: jenisBarang,
                                    ukuran: ukuran,
                                    jumlah: jumlah,
                                    hargaModal: hargaModal,
                                    hargaNego: hargaNego,
                                  )));
                    })
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
