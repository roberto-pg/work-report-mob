import 'package:flutter/material.dart';
import 'package:work_report/app/core/ui/widgets/work_button.dart';
import 'package:work_report/app/core/ui/widgets/work_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool obscuredTextPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade100,
        iconTheme: const IconThemeData(color: Color(0XFF3a4750)),
        title: const Text(
          'Crie sua conta',
          style: TextStyle(
            color: Color(0XFF3a4750),
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
                      'assets/images/bar_trans.png',
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
                        const WorkTextfield(
                          icon: Icons.person,
                          hint: 'Nome',
                          keyboardType: TextInputType.name,
                          // onChanged: store.saveName,
                          // onSaved: (text) {
                          //   user = user.copyWith(name: text);
                          // },
                          // validator: (text) => store.validateName,
                        ),
                        const SizedBox(height: 15),
                        const WorkTextfield(
                          icon: Icons.email,
                          hint: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          // onChanged: store.saveEmail,
                          // onSaved: (text) {
                          //   user = user.copyWith(email: text);
                          // },
                          // validator: (text) => store.validateEmail,
                        ),
                        const SizedBox(height: 15),
                        const WorkTextfield(
                          icon: Icons.security,
                          hint: 'CPF',
                          keyboardType: TextInputType.number,
                          // onChanged: store.saveCpf,
                          // onSaved: (text) {
                          //   user = user.copyWith(cpf: text);
                          // },
                          // validator: (text) => store.validateCpf,
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
                          // onChanged: store.savePassword,
                          // onSaved: (text) =>
                          //     user = user.copyWith(password: text),
                          // validator: (text) => store.validatePassword,
                        ),
                        const SizedBox(height: 30),
                        WorkButton(
                          onPressed: () {},
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
