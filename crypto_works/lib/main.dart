import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:crypto_works/my_encryp.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _input = TextEditingController();
  var encryptedText, plainText, bytes, sha;
  var sha_256;
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text('Digital Fortress'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter any text",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        controller: _input,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        plainText = _input.text;
                         bytes = utf8.encode(plainText);
                         sha = sha1.convert(bytes);
                        sha_256 = sha256.convert(bytes);
                        setState(() {
                          encryptedText = DigitalFortress.encryptAES(plainText);
                        });
                      },
                      child: const Text('Encrypt'),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        plainText = _input.text;
                        setState(() {
                          encryptedText = DigitalFortress.decryptAES(encryptedText);
                        });
                      },
                      child: const Text('Decrypt'),
                    ),
                    Text(
                      'Your Result',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreen[400],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(encryptedText == null
                          ? ""
                          : encryptedText is encrypt.Encrypted
                              ? encryptedText.base64
                              : encryptedText),
                    ),
                    const Text(
                      'SHA-1 encoded Text',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(sha.toString(),),),
                    const Text(
                      'SHA-256 encoded Text',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(sha_256.toString(),),),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
