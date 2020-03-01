import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextEditingController _numberBitcoin = TextEditingController();
  String _currency;

  _save() async {

    String saveCurr = _currency;

    final prefs = await SharedPreferences.getInstance();

    if (_numberBitcoin.text != '') {
      double btAmount = double.parse(_numberBitcoin.text);
      await prefs.setDouble('bitcoin', btAmount);
    }

    print('RETORNO: ' + _numberBitcoin.text);
    await prefs.setString('currency', saveCurr);

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
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Selecione a moeda desejada:',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            RadioListTile(
              title: Text('R\$ - Real Brasileiro'),
              value: 'real',
              groupValue: _currency,
              onChanged: (String currency){
              setState(() {
                _currency = currency;
              });
              },
            ),
            RadioListTile(
              title: Text('US\$ - Dólar Americano'),
              value: 'dolar',
              groupValue: _currency,
              onChanged: (String currency){
              setState(() {
                _currency = currency;
              });
              },
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