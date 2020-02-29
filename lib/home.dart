import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
    String _preco = '0.00';

  _getCurrency() async {

    String urlApi = 'https://blockchain.info/ticker';
    http.Response response;
  
    response = await http.get(urlApi);
    Map <String, dynamic> contacao = json.decode(response.body);

    setState(() {
      _preco = contacao['BRL']['15m'].toString();
    });
    
  }
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin'),
        backgroundColor: Colors.blueGrey[800],
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
                'R\$ ' + _preco,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 32,
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