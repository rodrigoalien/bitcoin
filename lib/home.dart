import 'package:bitcoin/settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
    double _preco = 0.00;
    double _btAmount = 0.00;

  _getCurrency() async {

    String urlApi = 'https://blockchain.info/ticker';
    http.Response response;
  
    response = await http.get(urlApi);
    Map <String, dynamic> contacao = json.decode(response.body);

    // get bitcoin amount in prefs
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _preco = contacao['BRL']['15m'];

      // get bitcoin amount in prefs
      _btAmount = prefs.getDouble('bitcoin');
    });
    
  }
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Bitcoin'),
        backgroundColor: Colors.blueGrey[800],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.orange,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),  
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/bitcoin.png'),
            ),
            Padding(
              padding: EdgeInsets.all(35),
              child: Text(
                'R\$ ' + _preco.toString(),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Text(
                'Saldo: R\$ ' + (_btAmount * _preco).toStringAsFixed(2),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RaisedButton(
              color: Colors.orange,
              textColor: Colors.white,
              child: Text(
                'Atualizar',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _getCurrency,
            ),
          ],
        ),
      ),
    );
  }
}