import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verify = " ";
  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController _controller = TextEditingController();
  var phone = "";
  @override
  void initState() {
    _controller.text="+88";
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25,right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/img1.png",height: 150,width: 150,),
SizedBox(height: 25,),

              Text(
                "Phone Verification",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone befor getting started !",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
             SizedBox(height: 20,),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:   Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                      ),
                    ),


                    SizedBox(width: 10,),
                    Text("|",style: TextStyle(
                        fontSize: 45,
                        color: Colors.green
                    ),),

                    SizedBox(width: 10,),
                    Expanded(child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value){
                        phone=value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,hintText: "Phone"
                      ),
                    )),

                  ],
                ),
              ),
              SizedBox(height: 20,),
             SizedBox(
               height: 45,
                 width: double.infinity,
               child:  ElevatedButton(
                   onPressed: () async {
                     await FirebaseAuth.instance.verifyPhoneNumber(
                       phoneNumber: '${_controller.text+phone}',
                       verificationCompleted: (PhoneAuthCredential credential) {},
                       verificationFailed: (FirebaseAuthException e) {},
                       codeSent: (String verificationId, int? resendToken) {
                         MyPhone.verify = verificationId;
                         Navigator.pushNamed(context, "otp");
                       },
                       codeAutoRetrievalTimeout: (String verificationId) {

                       },

                     );

                   },
                   child: Text("Send the code"),
                   style:
                   ElevatedButton.styleFrom(backgroundColor: Colors.green,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)
                       ))),
             )
            ],
          ),
        ),
      ),
    );
  }
}
