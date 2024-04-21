import 'dart:convert';

import 'package:api/Post%20API/api_link/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();


  Future signup(String email, String password) async {
    try {
      var response = await post(
          Uri.parse("https://reqres.in/api/register"),
          body: {
            "email": email,
            "password": password,
          } //body
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print(data["id"]);
        print(data["token"]);
        print("Register Successfully");

      }else{
        print("Some Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return "Enter Name";
                  },
                  decoration: InputDecoration(
                      hintText: "Your Name",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.blue
                          )

                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.blue
                          )
                      )

                  )

              ),
              SizedBox(height: 10,),
              TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return "Enter email";
                  },
                  decoration: InputDecoration(
                      hintText: "example@gmail.com",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.blue
                          )

                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.blue
                          )
                      )

                  )

              ),
              SizedBox(height: 10,),
              TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return "Enter password";
                  },
                  obscureText: true,

                  decoration: InputDecoration(
                      hintText: "******",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.blue
                          )

                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.blue
                          )
                      )

                  )

              ),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .06,
                child: ElevatedButton.icon(
                  onPressed: () {
                      signup(emailController.text.toString(), passwordController.text.toString());

                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text("Register"),
                ),
              )

            ],
          ),
        ),
      ),

    );
  }
}
