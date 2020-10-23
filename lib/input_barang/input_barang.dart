import 'package:flutter/material.dart';
import 'package:syafitri_shoes/input_barang/barang_konfirm_dialog.dart';

class InputBarang extends StatefulWidget {
  @override
  _InputBarangState createState() => _InputBarangState();
}

final TextStyle fontAppBar = TextStyle(
    color: Colors.blue,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 20);

final TextStyle fontButton = TextStyle(
    color: Colors.white,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 20);

class _InputBarangState extends State<InputBarang> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  bool _validate = false;
  String kode, nama, jenis, warna, ukuran;
  double hargaModal, hargaNego;
  int jumlah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Input Barang',
          style: fontAppBar,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          autovalidate: _validate,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Kode Barang",
                      labelStyle: TextStyle(color: Colors.blue),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Isi Kode Barang";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      kode = val;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontFamily: "OpenSans",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nama Barang",
                      labelStyle: TextStyle(color: Colors.blue),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Isi Nama Barang";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      nama = val;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontFamily: "OpenSans",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Warna Barang",
                      labelStyle: TextStyle(color: Colors.blue),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Isi Warna Barang";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      warna = val;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontFamily: "OpenSans",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Jenis Barang",
                      labelStyle: TextStyle(color: Colors.blue),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Isi Jenis Barang";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      jenis = val;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontFamily: "OpenSans",
                    )),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Ukuran",
                            labelStyle: TextStyle(color: Colors.blue),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Isi Ukuran";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            ukuran = val;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Jumlah",
                            labelStyle: TextStyle(color: Colors.blue),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Isi Jumlah";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            jumlah = int.parse(val);
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          )),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Harga Modal",
                            labelStyle: TextStyle(color: Colors.blue),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Isi Harga Modal";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            hargaModal = double.parse(val);
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Harga Nego",
                            labelStyle: TextStyle(color: Colors.blue),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Isi Harga Nego";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            hargaNego = double.parse(val);
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          )),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          'Konfirmasi',
                          style: fontButton,
                        ))),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        if (hargaModal > hargaNego) {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: AlertDialog(
                                    backgroundColor: Colors.blue[100],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    title: Text('Input tidak valid !',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold)),
                                    content: Text(
                                        'Pastikan harga nego lebih tinggi dari harga modal.',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold)),
                                  ),
                                );
                              });
                        }
                        return _barangKonfirmDialog(context, kode, nama, warna,
                            jenis, ukuran, jumlah, hargaModal, hargaNego);
                      } else {
                        setState(() {
                          _validate = true;
                        });
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _barangKonfirmDialog(
      BuildContext context,
      String kode,
      String nama,
      String warna,
      String jenis,
      String ukuran,
      int jumlah,
      double hargaModal,
      double hargaNego) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BarangKonfirmDialog(
            kodeBarang: kode,
            namaBarang: nama,
            warnaBarang: warna,
            jenisBarang: jenis,
            ukuran: ukuran,
            jumlah: jumlah,
            hargaModal: hargaModal,
            hargaNego: hargaNego,
          );
        });
  }
}
