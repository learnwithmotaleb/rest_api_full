
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var optionalPhoneController = TextEditingController();
  var nidNumberController = TextEditingController();
  var shortAddressController = TextEditingController();
  var cityController = TextEditingController();
  var locationController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();

  File? image;

  final _picker = ImagePicker();
  bool showSpinner = false;


  Future getImage()async{
    final pickFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickFile != null){
      image = File(pickFile.path);
      setState(() {});
    }else{
      print("No Image Selected");
    }


  }

  Future uploadImage()async{
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse("https://priyojon.learnwithmotaleb.com/api/seeker/register");
    var request = http.MultipartRequest("POST", uri);
    var multiport = http.MultipartFile(
        "photo",
        stream,
        length
    );
    request.files.add(multiport);

    request.fields['full_name'] = nameController.text.toString();
    request.fields['email'] = emailController.text.toString();
    request.fields['phone'] =  phoneController.text.toString();
    request.fields['optional_phone'] = optionalPhoneController.text.toString();
    request.fields['nid_number'] = nidNumberController.text.toString();
    request.fields['short_address'] =  shortAddressController.text.toString();
    request.fields['city'] =  cityController.text.toString();
    request.fields['location'] =  locationController.text.toString();
    request.fields['password'] =  passwordController.text.toString();
    request.fields['password_confirmation'] = rePasswordController.text.toString();


    var response = await request.send();

    if(response.statusCode == 200){
      setState(() {
        showSpinner = false;
      });
      print("UserData Upload Completed");
    }else{
      print("UserData Upload Faild");
      setState(() {
        showSpinner = false;
      });
    }


  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Service Seeker Register"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    getImage();
                  },
                  child: CircleAvatar(
                    radius: 80,
                    child: image == null ?  Center(child: Text("Pick Image"),):
                    Center(
                      child: ClipOval(
                        child: Image.file(
                          File(image!.path).absolute,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return "Enter full name";
                    },
                    decoration: InputDecoration(
                        hintText: "Enter FullName",
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      return "Enter phone";
                    },
                    decoration: InputDecoration(
                        hintText: "+88123456789",
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
                    controller: optionalPhoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      return "Enter optional phone";
                    },
                    decoration: InputDecoration(
                        hintText: "+88123456789",
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
                    controller: nidNumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return "Enter nid number";
                    },
                    decoration: InputDecoration(
                        hintText: "1234567890",
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
                    controller: shortAddressController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return "Enter short address";
                    },
                    decoration: InputDecoration(
                        hintText: "short address",
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
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return "Enter city";
                    },
                    decoration: InputDecoration(
                        hintText: "your city",
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
                    controller: locationController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return "Enter Current Location";
                    },
                    decoration: InputDecoration(
                        hintText: "your current location",
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
                        hintText: "password",
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
                    controller: rePasswordController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return "Enter re-password";
                    },
                    obscureText: true,

                    decoration: InputDecoration(
                        hintText: "Confirmation password",
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
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*.06,
                  child: ElevatedButton.icon(onPressed: (){
                    uploadImage().then((value){
                      print(value.toString());
                    }).onError((error, stackTrace){

                      print(error.toString());

                    });
                  }, icon: Icon(Icons.arrow_circle_right_outlined), label: Text("Continue")),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
