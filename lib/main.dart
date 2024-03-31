import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifestream/estado.dart';
import 'package:lifestream/telas/detalhes.dart';
import 'package:lifestream/telas/hospitais.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => EstadoApp(),
        child: MaterialApp(
          title: "Life Stream",
          theme: ThemeData(
              colorScheme: const ColorScheme.light(), useMaterial3: true),
          home: const Tela(),
        ));
  }
}

class Tela extends StatefulWidget {
  const Tela({super.key});

  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  void _exibirComoRetrato() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

  @override
  Widget build(BuildContext context) {
    _exibirComoRetrato();

    estadoApp = context.watch<EstadoApp>();

    Widget tela = const SizedBox.shrink();
    if (estadoApp.situacao == Situacao.mostrandoHospitais) {
      tela = const Hospitais();
    } else if (estadoApp.situacao == Situacao.mostrandoDetalhes) {
      tela = const Detalhes();
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            title: Center(
              child: Image.asset("lib/recursos/imagens/logo.png", width: 220)
            ),
            backgroundColor: const Color.fromRGBO(78,192,219,100)
          )
        ),
      body: Center(
      child: tela));

  }
}