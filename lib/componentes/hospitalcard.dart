import 'package:flutter/material.dart';
import 'package:lifestream/estado.dart';

class HospitalCard extends StatelessWidget {
  final dynamic hospital;

  const HospitalCard({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        estadoApp.mostrarDetalhes(hospital["_id"]);
      },
      child: Card(
        child: Column(children: [
          
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(hospital["nome"],
              style: const TextStyle(fontSize: 24)))
          ]),
          Image.asset("${hospital['foto']}"),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(hospital["nome"],
              style: const TextStyle(fontSize: 19)))
        ]),
      ),
    );
  }
}
