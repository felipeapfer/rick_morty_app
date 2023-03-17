import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/pages/forgot_password.dart';
import 'package:rick_morty_app/repositories/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Bem vindo';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login.';
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<UserRepository>().singIn(email.text, senha.text);
    } on RadarAuthExecption catch (e) {
      setState(() => loading = false);
      switch (e.type) {
        case 'INVALID_EMAIL':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'INVALID_PASSWORD':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'UNKNOWN_ERROR':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'NEEDS_USER_CONFIRMATION':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'RESET_PASSWORD':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
      }
    } on Exception catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Erro inesperado.')));
    }
    setState(() => loading = false);
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<UserRepository>().signUp(email.text, senha.text);
      // ignore: use_build_context_synchronously
      /*  Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Scaffold(),
        ), 
      );*/
    } on RadarAuthExecption catch (e) {
      setState(() => loading = false);
      switch (e.type) {
        case 'INVALID_EMAIL':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'INVALID_PASSWORD':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'UNKNOWN_ERROR':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'NEEDS_USER_CONFIRMATION':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
        case 'RESET_PASSWORD':
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
          break;
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => loading = false);
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
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
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
                      } else if (!RegExp(r'^[\w-\.\+]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  child: TextFormField(
                    controller: senha,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          }),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informa sua senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
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
                        if (isLogin) {
                          login();
                        } else {
                          registrar();
                        }
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
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  actionButton,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(toggleButton),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPassowrdPage())),
                  child: const Text('Esqueci a senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
