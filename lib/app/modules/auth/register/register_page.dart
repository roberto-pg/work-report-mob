import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';
import 'package:work_report/app/core/ui/widgets/work_button.dart';
import 'package:work_report/app/core/ui/widgets/work_textfield.dart';
import 'package:work_report/app/models/user.dart';
import 'package:work_report/app/modules/auth/register/register_store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ModularState<RegisterPage, RegisterStore> {
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
      backgroundColor: const Color(0XFF3a4750),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0XFF3a4750),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Crie sua conta',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (_, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 40),
                  child: Center(
                    child: Image.asset(
                      'assets/images/bar_transp.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        WorkTextfield(
                          icon: Icons.person,
                          hint: 'Nome',
                          keyboardType: TextInputType.name,
                          onSaved: (text) => user = user.copyWith(name: text),
                          validator: Validatorless.required('Nome obrigatório'),
                        ),
                        const SizedBox(height: 15),
                        WorkTextfield(
                          icon: Icons.email,
                          hint: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (text) => user = user.copyWith(email: text),
                          validator: Validatorless.multiple([
                            Validatorless.required('Email obrigatório'),
                            Validatorless.email('Email inválido')
                          ]),
                        ),
                        const SizedBox(height: 15),
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
                        const SizedBox(height: 30),
                        WorkButton(
                          onPressed: () async {
                            var formValid =
                                _formKey.currentState?.validate() ?? false;

                            if (formValid) {
                              _formKey.currentState!.save();
                              await store.addUser(user.name, user.email,
                                  user.cpf, user.password);
                              _formKey.currentState?.reset();
                            }
                          },
                          label: 'Salvar',
                          fontSize: 20,
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
