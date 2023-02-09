import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();

  String _resultado = "Resultado";

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;

    // Tenho que transformar a url em uri pra ele aceitar
    var url = Uri.parse('https://viacep.com.br/ws/$cepDigitado/json/');

    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro} ${complemento} ${bairro} ${localidade}";
    });

    print(
        "Resposta logradouro: ${logradouro}, complemento: ${complemento}, bairro: ${bairro}, localidade: ${localidade}");

    // print("resposta: " + response.statusCode.toString());
    // print("resposta: " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço"),
      ),
      body: Container(
        child: Column(children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Digite um cep: 05254632"),
            style: TextStyle(fontSize: 20),
            controller: _controllerCep,
          ),
          ElevatedButton(
            onPressed: () {
              _recuperarCep();
            },
            child: Text("Clique aqui"),
          ),
          Text(_resultado),
        ]),
      ),
    );
  }
}
