import 'dart:convert';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifestream/componentes/hospitalcard.dart';

class Hospitais extends StatefulWidget {
  const Hospitais({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HospitaisState();
  }
}

const int tamanhoPagina = 6;

class _HospitaisState extends State<Hospitais> {
  
  late dynamic _feedEstatico;
  List<dynamic> _hospitais = [];

  int _proximaPagina = 1;
  bool _carregando = false;

  @override
  void initState() {
    super.initState();

    _lerFeedEstatico();
  }

  Future<void> _lerFeedEstatico() async {
    final String conteudoJson =
            await rootBundle.loadString("lib/recursos/json/hospitais.json");
        _feedEstatico = await json.decode(conteudoJson);

        _carregarHospitais();
  }

  void _carregarHospitais() {
    setState(() {
      _carregando = true;
    });

    final totalHospitaisParaCarregar = _proximaPagina * tamanhoPagina;

    var maisHospitais = _hospitais;
    if (_feedEstatico["hospitais"].length >= totalHospitaisParaCarregar) {
      maisHospitais =
          _feedEstatico["hospitais"].sublist(0, totalHospitaisParaCarregar);
    }

    setState(() {
      _hospitais = maisHospitais;
      _proximaPagina = _proximaPagina + 1;

      _carregando = false;
    });
  }

  Future<void> _atualizarHospitais() async {
    _hospitais = [];
    _proximaPagina = 1;

    _carregarHospitais();
  }

  @override
  Widget build(BuildContext context) {
    return FlatList(
        data: _hospitais,
        numColumns: 1,
        loading: _carregando,
        onRefresh: () => _atualizarHospitais(),
        onEndReached: () => _carregarHospitais(),
        buildItem: (item, int indice) {
          return SizedBox(height: 280, child: HospitalCard(hospital: item));
        });
  }
}
