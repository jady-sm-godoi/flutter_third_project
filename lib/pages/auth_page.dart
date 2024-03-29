import 'dart:math';

import 'package:flutter/material.dart';
import 'package:udemy_shop/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(215, 117, 255, 0.5),
              Color.fromRGBO(255, 188, 117, 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        SizedBox(
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 70,
                    ),
                    transform: Matrix4.rotationZ(-5 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade600,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10,
                              offset: Offset(0, 2))
                        ]),
                    child: Text(
                      'Minha loja !',
                      style: TextStyle(
                          fontSize: 48,
                          fontFamily: 'Anton',
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                  const AuthForm(),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
