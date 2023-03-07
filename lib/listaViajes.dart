import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ViajesIniciados extends StatefulWidget {
  const ViajesIniciados({super.key});

  @override
  State<ViajesIniciados> createState() => _ViajesIniciadosState();
}

/*final String url = 'https://byetraffic.com:8080/execute/Sql/get_database_info';
final String db = 'mysql_db';
final Map<String, String> headers = {
  'Authorization': 'cpanel $username:$key',
};
final Map<String, String> body = {
  'db': db,
};
final http.Response response = await http.post(
  url,
  headers: headers,
  body: body,
);
*/

class _ViajesIniciadosState extends State<ViajesIniciados> {
  final soc = IO.io('http://162.241.217.96:3000', <String, dynamic>{
    'transports': ['websocket'],
  });
  late final List<String> items = ['Viaje 0'];

  @override
  void initState() {
    super.initState();
    // manejar el evento connect
    soc.on('connection', (_) => print('Conectado al servidor'));

    // manejar el evento mensaje
    soc.on('mensaje', (data) => print('Mensaje del servidor: $data'));

    // enviar un mensaje al servidor
    soc.emit('act1', 'actualizacion de la interfaz');

    soc.on('act_1', (_) => print('') /*actualizar bd*/);

    //2da opt de conectar
    soc.onConnect((data) => print('Conectado'));

    soc.connect();
    print("cliente encendido");

    /*items.add("Viaje 1");
    items.add("Viaje 2");
    items.add("Viaje 3");
    items.add("Viaje 4");
    items.add("Viaje 5");
    items.add("Viaje 6");*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de viajes'),
        backgroundColor: Colors.red,
      ),
      body: items == null
          ? Column()
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index]),
                );
              },
            ),
    );
  }



}
