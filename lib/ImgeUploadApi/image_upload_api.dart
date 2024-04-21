
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploadRestAPI extends StatefulWidget {
  const ImageUploadRestAPI({super.key});

  @override
  State<ImageUploadRestAPI> createState() => _ImageUploadRestAPIState();
}

class _ImageUploadRestAPIState extends State<ImageUploadRestAPI> {

  var nameController = TextEditingController();


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
    var uri = Uri.parse("https://image.learnwithmotaleb.com/api/products");
    var request = http.MultipartRequest("POST", uri);
    var multiport = http.MultipartFile(
        "image",
        stream,
        length
    );
    request.files.add(multiport);
    request.fields['name'] = nameController.text.toString();

    var response = await request.send();

    if(response.statusCode == 200){
      setState(() {
        showSpinner = false;
      });
      print("Upload Completed");
    }else{
      print("Upload Faild");
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
          title: const Text("Image Upload Api"),
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
                      return "Enter Image Name";
                    },
                    decoration: InputDecoration(
                        hintText: "Image Name",
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
