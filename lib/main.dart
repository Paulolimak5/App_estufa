import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request1 = "https://api.hgbrasil.com/finance?format=json&key=7c432ef2";
const request = "http://192.168.15.16:80/estufa/estufa.json";

void main() async {
  print(await getData());
  print(await getData1());

  runApp(MaterialApp(home: Monitora()));

}

Future<Map> getData1() async {
  http.Response response = await http.get(request1);
  return json.decode(response.body);
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Monitora extends StatefulWidget {
  @override
  _MonitoraState createState() => _MonitoraState();
}


class _MonitoraState extends State<Monitora> {
  String nome;
  int id;
  double ppm;
  double ph;
  double temp;
  double umidade;
  bool iluminacao;
  bool bomba;
  bool cooler;
  bool nivel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Monitoramento Estufa"),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao Carregar Dados!",
                      style: TextStyle(color: Colors.green, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    id = snapshot.data["results"]["estufas"]["id"];
                    nome = snapshot.data["results"]["estufas"]["nome"];
                    ppm = snapshot.data["results"]["estufas"]["ppm"];
                    ph = snapshot.data["results"]["estufas"]["ph"];
                    temp = snapshot.data["results"]["estufas"]["temp"];
                    umidade = snapshot.data["results"]["estufas"]["umidade"];
                    iluminacao =
                        snapshot.data["results"]["estufas"]["iluminacao"];
                    bomba = snapshot.data["results"]["estufas"]["bomba"];
                    cooler = snapshot.data["results"]["estufas"]["cooler"];
                    nivel = snapshot.data["results"]["estufas"]["nivel"];

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 30.0)),
                          Text('$nome',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 30.0),
                              textAlign: TextAlign.center),
                          Padding(padding: EdgeInsets.only(top: 40)),
                          //Valor Id
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Id: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$id', style: TextStyle(fontSize: 25.0)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Nome: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$nome', style: TextStyle(fontSize: 25.0)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("PPM: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$ppm', style: TextStyle(fontSize: 25.0)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Ph: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$ph', style: TextStyle(fontSize: 25.0)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Temperatura: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$temp' "ºC",
                                  style: TextStyle(fontSize: 25.0))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Umidade: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$umidade', style: TextStyle(fontSize: 25.0))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Iluminação: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$iluminacao',
                                  style: TextStyle(fontSize: 25.0))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Bomba: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$bomba', style: TextStyle(fontSize: 25.0))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Ventilação: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$cooler', style: TextStyle(fontSize: 25.0))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Nível de água: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$nivel', style: TextStyle(fontSize: 25.0))
                            ],
                          ), //Valor Nome//Valor Nome
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
