import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginScreen> {
  TextEditingController _idCont = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    _idCont = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idCont.dispose();
    _pass.dispose();
    super.dispose();
  }

  String _id = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log in now!")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: TextField(
                onChanged: (v) => setState(() {
                  _id = v;
                }),
                controller: _idCont,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Student ID',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: TextField(
                onChanged: (v) => setState(() {
                  _password = v;
                }),
                controller: _pass,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              child: const Text("Log in"),
              onPressed: () {
                setState(() {
                  _id = _idCont.text;
                  _password = _pass.text;
                  _idCont.text = "";
                  _idCont.text = "";
                  Navigator.of(context).pushNamed(
                      '/home',
                      arguments: {_id, _password}
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}