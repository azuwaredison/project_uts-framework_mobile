import 'package:flutter/material.dart';

// Pada project uts Framework Mobile, Saya (Mahasiswa) akan membuat aplikasi validasi dengan TextFormField.
// Adapun langkah-langkahnya sebagai berikut :
// Pertama membuat Container widget menjadi Form widget dan memberikan Padding widget sebagai dari Form widget
// Kedua memberikan GlobalKey untuk key properties pada Form widget
// Ketiga membuat TextFormField, kemudian menambahkan validator dan memberikan sebuah fungsi untuk melakukan validasi
// Yang terakhir memberikan properti ketika tombol disubmit
// Untuk lebih memperjelas, saya (Mahasiswa) akan memberikan komentar pada beberapa fungsi kode program dibawah ini.


void main() {
  runApp(MaterialApp(
    title: 'Kalkulator Bunga',
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

//Pada void main, halaman utama yang dijalakan bernama class MyApp dengan title Kalulator Bunga
// Main adalah fungsi khusus dari dart.
// Ketika aplikasi dijalankan, maka fungsi yang pertama kali dijalankan.
// Pada project ini, nama class yang dibuat adalah MyApp yang di extends dari class StatefulWidget dari material.dart package

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<MyApp> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupiah', 'Dollar', 'Pound'];
  final _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {

    // ignore: deprecated_member_use
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Kalkulator Bunga"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Harap Masukkan Jumlah Pokok';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Kepala Sekolah',
                      hintText: 'Kepala Sekolah, misalnya 1000000',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Harap Masukkan Nilai';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Suku Bunga',
                      hintText: 'In Percent',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: termController,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Harap Masukkan Nilai';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Waktu Dalam Tahun',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Menghitung",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                this.displayResult = _calculateTotalReturns();
                              }
                            });
                          }),
                    ),
                    Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Text(
                  this.displayResult,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/images/test1 (copy).jpg');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'Setelah $term Tahun, Investasi Anda Akan Bernilai $totalAmountPayable $_currentItemSelected';

    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}