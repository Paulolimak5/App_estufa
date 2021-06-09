import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request1 = "https://wcsgreenhouse.azurewebsites.net/Receita/consultar/1";
//const request2 = "http://192.168.15.16:80/estufa/estufa.json";
const request = "https://wcsgreenhouse.azurewebsites.net/Estufa/status/1";

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

  bool iluminacao;
  String hora;
  int ph;
  int ppm;
  int temperatura;
  String umidade;
  String luz;

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

                    iluminacao = snapshot.data["iluminacao"];
                    hora = snapshot.data["hora"];
                    ph = snapshot.data["ph"];
                    ppm = snapshot.data["ppm"];
                    temperatura = snapshot.data["temperatura"];
                    umidade = snapshot.data["humidade"];

                    if(iluminacao == true){
                      luz = "Ligada";
                    }else{
                      luz = "Desligada";
                    }


                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 30.0)),
                          Text("Estufa",
                              style: TextStyle(
                                  color: Colors.green, fontSize: 30.0),
                              textAlign: TextAlign.center),
                          Padding(padding: EdgeInsets.only(top: 40)),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Hora: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$hora',
                                  style: TextStyle(fontSize: 25.0))
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
                              Text('$temperatura' "ºC",
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
                              Text('$luz',
                                  style: TextStyle(fontSize: 25.0))
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
                              Text('$ph',
                                  style: TextStyle(fontSize: 25.0))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, bottom: 35.0)),
                              Text("Ppm: ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25.0),
                                  textAlign: TextAlign.center),
                              Text('$ppm',
                                  style: TextStyle(fontSize: 25.0))
                            ],
                          ),


                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
