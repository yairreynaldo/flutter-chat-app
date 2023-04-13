import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_label.dart';
import 'package:chat/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLogo(
                    titulo: 'Messenger',
                  ),
                  _Form(),
                  CustomLabels(
                    ruta: 'register',
                    titulo: '¿No tienes cuenta?',
                    subtitulo: 'Crea una ahora',
                  ),
                  Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200)),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOK = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOK) {
                      final navContext = context;
                      Future.delayed(Duration.zero, () {
                        Navigator.pushReplacementNamed(navContext, 'usuarios');
                      });
                    } else {
                      final dialogContext = context;
                      Future.delayed(Duration.zero, () {
                        mostrarAlerta(
                          dialogContext,
                          'Login incorrecto',
                          'Revise sus credenciales nuevamente',
                        );
                      });
                    }
                  },
          ),
        ],
      ),
    );
  }
}
