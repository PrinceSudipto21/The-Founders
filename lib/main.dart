import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_google_2fa/flutter_google_2fa.dart';

//import 'package:flutter/cupertino.dart';

import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Founders',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const LoginPage(title: 'The Founders'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _MyLoginPage();
}

class _MyLoginPage extends State<LoginPage> {
  var mobile_number = '';
  String otp = "";
  var code = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.yellowAccent.shade100,
              child: const Center(
                  child: Text(
                'Welcome to the application build by the team -\nThe Founders',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Arial'),
              )),
            ),
            Row(
              children: [
                Container(
                  height: 20,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Mobile No.: ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(
                    width: 210,
                    child: TextField(
                        onChanged: (value) {
                          mobile_number = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        )))
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91' + mobile_number,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        otp = verificationId;
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: const Text("Send OTP"),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'OTP: ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(
                    width: 210,
                    child: TextField(
                        onChanged: (value) {
                          code = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ))),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: otp, smsCode: code);
                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: AlertDialog(
                                title: Text("Wrong OTP!!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"))
                                ],
                              ),
                            );
                          });
                    }
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('OR')],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () async {
                      await signInWithGoogle();
                      if (mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    },
                    child: Image.asset(
                      'assets/images/google.jpg',
                      height: 35,
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.yellowAccent[100],
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'This application is developed to educate people about the available schemes through which the population below poverty lin will also uplift and avail the capital providing by the government.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Arial'),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
