import 'package:iserve/src/src.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: ListView(
        children: [
          Column(children: [Text('Login Page'), SizedBox(height: 20)]),
        ],
      ),
    );
  }
}
