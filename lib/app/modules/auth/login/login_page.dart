import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validatorless/validatorless.dart';
import 'package:work_report/app/core/alerts/auth_alert.dart';
import 'package:work_report/app/core/ui/widgets/work_button.dart';
import 'package:work_report/app/core/ui/widgets/work_textfield.dart';
import 'package:work_report/app/models/user.dart';
import 'package:work_report/app/modules/auth/login/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore> {
  String get _userLogin => store.userLogin;
  String get _errorLogin => store.errorLogin;

  final _formKey = GlobalKey<FormState>();
  bool obscuredTextPassword = true;
  var user = User(
    id: '',
    name: '',
    email: '',
    cpf: '',
    password: '',
    token: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: LayoutBuilder(builder: (_, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Center(
                      child: Image.asset(
                        'assets/images/bar_transp.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Controle as etapas'
                    '\n'
                    'e a duração de'
                    '\n'
                    'suas tarefas',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(fontSize: 30.0),
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 40, right: 40),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        WorkTextfield(
                          icon: Icons.security,
                          hint: 'CPF',
                          keyboardType: TextInputType.number,
                          onSaved: (text) => user = user.copyWith(cpf: text),
                          validator: Validatorless.multiple([
                            Validatorless.required('CPF obrigatório'),
                            Validatorless.cpf('CPF inválido'),
                          ]),
                        ),
                        const SizedBox(height: 15),
                        WorkTextfield(
                          icon: Icons.vpn_key,
                          hint: 'Senha',
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                obscuredTextPassword = !obscuredTextPassword;
                              });
                            },
                            icon: Icon(obscuredTextPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          keyboardType: TextInputType.number,
                          obscuredTextPassword: obscuredTextPassword,
                          onSaved: (text) =>
                              user = user.copyWith(password: text),
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha obrigatória'),
                            Validatorless.min(6,
                                'A senha não pode ter menos de 6 caracteres'),
                          ]),
                        ),
                        const SizedBox(height: 15),
                        WorkButton(
                          onPressed: () async {
                            var formValid =
                                _formKey.currentState?.validate() ?? false;

                            if (formValid) {
                              _formKey.currentState!.save();

                              await store.login(user.cpf, user.password);
                              _formKey.currentState!.reset();

                              if (_userLogin.isEmpty) {
                                return authAlert(_errorLogin);
                              }
                            }
                          },
                          label: 'Entrar',
                          fontSize: 20,
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Esqueci a senha',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Modular.to.pushNamed('/auth/register');
                              },
                              child: Text(
                                'Cadastre-se',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
