import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class SignUpPostApi extends StatefulWidget {
  const SignUpPostApi({super.key});

  @override
  State<SignUpPostApi> createState() => _SignUpPostApiState();
}

class _SignUpPostApiState extends State<SignUpPostApi> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn(String email, String password) async{
    try{
      Response response = await post(Uri.parse('https://reqres.in/api/register'), body: { 'email': email, 'password': password});
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('SignUp successfully');
      }else{
        print('Failed');
      }
    }
    catch(e){
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("SignUp"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            GestureDetector(
              onTap: (){
                signIn(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Center(child: Text("SignUp", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
