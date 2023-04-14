import 'package:chat/global/enviroment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  online,
  offline,
  connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket!;
  Function get emit => _socket!.emit;

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    _socket = IO.io(Enviroment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token},
    });
    _socket!.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });
    _socket!.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
    /* socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje: $payload');
    }); */
  }

  void disconnect() {
    _socket!.disconnect();
  }
}
