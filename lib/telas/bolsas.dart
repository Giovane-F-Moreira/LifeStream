import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Bolsas extends StatefulWidget {
  const Bolsas({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BolsasState();
  }
}

const int tamanhoPagina = 8;

class _BolsasState extends State<Bolsas> {
  
  late dynamic _feedEstatico;
  List<dynamic> _bolsas = [];

  int _proximaPagina = 1;
  
  @override
  void initState() {
    super.initState();

    _lerFeedEstatico();
  }


  Future<void> _lerFeedEstatico() async {
    final String conteudoJson =
            await rootBundle.loadString("lib/recursos/json/feed.json");
        _feedEstatico = await json.decode(conteudoJson);

        _carregarBolsas();
  }

  void _carregarBolsas(){

    final totalBolsasParaCarregar = _proximaPagina * tamanhoPagina;

    var maisBolsas = _bolsas;

    if( _feedEstatico["bolsas"].length >=totalBolsasParaCarregar){
      maisBolsas = _feedEstatico["bolsas"].sublist(0, totalBolsasParaCarregar);
    }

    setState(() {
      _bolsas = maisBolsas;
      _proximaPagina = _proximaPagina + 1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Text("${_bolsas.length}");
  }
}
