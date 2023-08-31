

import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Espere por favor',
      'Cargando películas',
      'Buscando películas populares y mejor puntuadas',
      'Cargando ...'
    ];

    return Stream.periodic(const Duration(milliseconds: 2000), (step) {
      return messages[step];
    }).take(messages.length);
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if(!snapshot.hasData)  return const Text('Cargando...');
              return Text(snapshot.data!);
            }
          )
        ],
      ),
    );
  }
}