import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/repositories/user_repository.dart';

class ForgotPassowrdPage extends StatefulWidget {
  const ForgotPassowrdPage({super.key});

  @override
  State<ForgotPassowrdPage> createState() => _ForgotPassowrdPageState();
}

class _ForgotPassowrdPageState extends State<ForgotPassowrdPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  String _warningMessage = "";
  bool loading = false;

  forgotPassword() async {
    try {
      await context.read<UserRepository>().forgotPassword(email.text);
      _warningMessage = "Email de recuperação enviado";
    } on RadarAuthExecption catch (e) {
      _warningMessage = e.message;
      switch (e.type) {
        case 'INVALID_EMAIL':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'UNKNOWN_ERROR':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
      }
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Redefinir Senha',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o email corretamente!';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Por favor insira um e-mail válido';
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        forgotPassword();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loading)
                          ? [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ]
                          : [
                              const Icon(Icons.check),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Redefinir Senha',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _warningMessage,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Lembrei a Senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
