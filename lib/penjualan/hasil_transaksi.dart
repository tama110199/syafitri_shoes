import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syafitri_shoes/penjualan/detail_transaksi.dart';
import 'package:syafitri_shoes/penjualan/penjualan.dart';

class HasilTransaksi extends StatefulWidget {
  final String kodeBarang;
  final String namaBarang;
  final String warnaBarang;
  final String jenisBarang;
  final String ukuran;
  final String tanggal;
  final String waktu;
  final int sisaStok;
  final double hargaModal;
  final double hargaJual;

  const HasilTransaksi(
      {Key key,
      this.kodeBarang,
      this.namaBarang,
      this.warnaBarang,
      this.jenisBarang,
      this.ukuran,
      this.tanggal,
      this.waktu,
      this.hargaModal,
      this.hargaJual,
      this.sisaStok})
      : super(key: key);

  @override
  _HasilTransaksiState createState() => _HasilTransaksiState();
}

class _HasilTransaksiState extends State<HasilTransaksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.solidHandshake,
                color: Colors.blue,
                size: 100,
              ),
              Text(
                'Transaksi Selesai',
                style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: Colors.greenAccent,
                child: Text(
                  'Detail Transaksi',
                  style: fontContentInput,
                ),
                onPressed: () {
                  _detailTransaksiDialog(
                      context,
                      widget.kodeBarang,
                      widget.namaBarang,
                      widget.warnaBarang,
                      widget.jenisBarang,
                      widget.ukuran,
                      widget.sisaStok,
                      widget.hargaModal,
                      widget.hargaJual,
                      widget.tanggal,
                      widget.waktu);
                },
              )
            ],
          ),
        ),
      ),
    );
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
      double hargaNego,
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
            hargaJual: hargaNego,
            tanggal: tanggal,
            waktu: waktu,
          );
        });
  }
}
