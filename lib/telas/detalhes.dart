import 'dart:convert';

import 'package:lifestream/estado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetalhesState();
  }
}

class _DetalhesState extends State<Detalhes> {
  late dynamic _feedEstatico;

  bool _temHospital = false;

  late dynamic _hospital;

  @override
  void initState() {
    super.initState();

    _lerFeedEstatico();
  }

  Future<void> _lerFeedEstatico() async {
    final String conteudoJson =
        await rootBundle.loadString("lib/recursos/json/hospitais.json");
    _feedEstatico = await json.decode(conteudoJson);

    _carregarHospital();
  }

  void _carregarHospital() {
    setState(() {
      _hospital = _feedEstatico['hospitais']
          .firstWhere((hospitais) => hospitais["_id"] == estadoApp.idHospitais);

      _temHospital = _hospital != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Text texto = const Text("O hospital não existe");

    if (_temHospital) {
      texto = Text("Hospital escolhido: ${_hospital['nome']}");
    }

    return Scaffold(
      appBar: AppBar(
        actions: [   
          GestureDetector(
          onTap: () => {
            estadoApp.mostrarHospitais()
        },
        child: const Text("voltar"),
        )],
        title: Text("${_hospital['nome']}"),
      ),
      body: Center(
      child: texto));
  }
}
