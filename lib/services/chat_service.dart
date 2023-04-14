import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/enviroment.dart';

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioID');
    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '',
      },
    );

    final mensajesResponse = MensajesResponse.fromRawJson(resp.body);
    return mensajesResponse.mensajes;
  }
}
