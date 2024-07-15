import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAPEK9uLsaTvAhzY8iw8SW-N0y9y0VGw_Y',
      appId: '1:906179834656:android:6d305aa6a32ed3c178dd45',
      messagingSenderId: '906179834656',
      projectId: 'reproduce-7dbaf',
      storageBucket: 'reproduce-7dbaf.appspot.com',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final _authentication = FirebaseAuth.instance;
  bool isSignup = false;

  final _formKey = GlobalKey<FormState>();

  String userEmail = '';
  String userPassword = '';

  void _tryValidation() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isSignup = false;
                    });
                  },
                  child: const Text('LOGIN')),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isSignup = true;
                    });
                  },
                  child: const Text('SIGNIN'))
            ],
          ),
          if (isSignup)
            Container(
              child: Column(
                children: [
                  TextFormField(
                    key: const ValueKey(1),
                    validator: (value) {
                      if (value!.isEmpty || value.contains('@')) {
                        return 'Please enter valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userEmail = value!;
                    },
                    onChanged: (value) {
                      userEmail = value;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    key: const ValueKey(2),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password length must be more than 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userPassword = value!;
                    },
                    onChanged: (value) {
                      userPassword = value;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ],
              ),
            ),
          if (!isSignup)
            Container(
              child: Column(
                children: [
                  TextFormField(
                    key: const ValueKey(3),
                    validator: (value) {
                      if (value!.isEmpty || value.contains('@')) {
                        return 'Please enter valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userEmail = value!;
                    },
                    onChanged: (value) {
                      userEmail = value;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    key: const ValueKey(4),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password length must be more than 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userPassword = value!;
                    },
                    onChanged: (value) {
                      userPassword = value;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 30),
          GestureDetector(
              onTap: () async {
                try {
                  if (isSignup) {
                    _tryValidation();
                    await _authentication.createUserWithEmailAndPassword(
                      email: userEmail,
                      password: userPassword,
                    );
                  } else {
                    _tryValidation();
                    final newUser =
                        await _authentication.signInWithEmailAndPassword(
                      email: userEmail,
                      password: userPassword,
                    );

                    if (newUser.user != null) {}
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const SizedBox(
                height: 40,
                width: 40,
                child: Text('Submit'),
              )),
        ],
      ),
    );
  }
}
