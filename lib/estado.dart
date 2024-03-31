import 'package:flutter/material.dart';

enum Situacao { mostrandoHospitais, mostrandoDetalhes }

class EstadoApp extends ChangeNotifier {
  Situacao _situacao = Situacao.mostrandoHospitais;
  Situacao get situacao => _situacao;

  late int _idHospital;
  int get idHospitais => _idHospital;

  void mostrarHospitais() {
    _situacao = Situacao.mostrandoHospitais;

    notifyListeners();
  }

  void mostrarDetalhes(int idHospital) {
    _situacao = Situacao.mostrandoDetalhes;
    _idHospital = idHospital;

    notifyListeners();
  }
}

late EstadoApp estadoApp;
