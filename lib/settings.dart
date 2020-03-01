import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextEditingController _numberBitcoin = TextEditingController();

  _save() async {
    
    double btAmount = double.parse(_numberBitcoin.text);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('bitcoin', btAmount);

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blueGrey[800]
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Informe a quantidade de Bitcoins:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(35),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ex.: 0.02053388'
                ),
                controller: _numberBitcoin,
              )
            ),
            RaisedButton(
              color: Colors.orange,
              textColor: Colors.white,
              child: Text(
                'Salvar',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}