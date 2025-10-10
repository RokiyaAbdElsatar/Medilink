import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';
import 'widget/textfield.dart' show Textfield;

class PatientPersonal extends StatefulWidget {
  const PatientPersonal({super.key});

  @override
  State<PatientPersonal> createState() => _PatientPersonal();  
}
GlobalKey<FormState> formkey=GlobalKey();
class _PatientPersonal extends State<PatientPersonal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 196, 238, 232),
              ),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("images/2.jpg"), 
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 248, 248, 248),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                            
                            },
                            icon: const Icon(Icons.camera_alt, color: Color.fromARGB(255, 3, 3, 3)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Patient",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 114, 181, 236),
                      ),
                    ),
                    SizedBox(height: 20,),
                     Expanded(
                child: SingleChildScrollView(
                  padding:EdgeInsets.all(5),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          Text('Personal information',textAlign:TextAlign.start,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                          SizedBox(height: 10,),
                          Textfield(
                             labletitle: "Name",
                              hinttitle: "Enter Your Name",
                          ),
                           SizedBox(height: 20),
                           Textfield(
                             labletitle: "Age",
                              hinttitle: "Enter Your Age",
                          ),
                          SizedBox(height: 20),
                          Textfield(
                             labletitle: "Gender",
                              hinttitle: "Select Your Gender",
                          ),
                          SizedBox(height: 20),
                          Textfield(
                             labletitle: "Phone",
                              hinttitle: "Enter Your Phone Number",
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                              fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                              labelText: "Email",
                              hintText: "Enter Your Email",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            validator: (value) {
                           if (value == null || value.isEmpty) {
                               return "Please enter your email";
                               }
                           if (!value.contains('@')) {
                           return "Email must contain @";
                          }
                             return null;
                           },
                      
                          ), SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                              fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                              labelText: "Password",
                              hintText: "Enter Your Password",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                             validator: (value) {
                           if (value == null || value.isEmpty) {
                               return "Please enter your Password";
                               }
                           if (value.length<6) {
                           return "Password not less < 6";
                          }
                             return null;
                           },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                              fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                              labelText: "Confirm Password",
                              hintText: "Enter Your Password agin",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            validator: (value) {
                           if (value == null || value.isEmpty) {
                               return "Please enter your Password";
                               }
                           if (value.length<6) {
                           return "Password not less < 6";
                          }
                             return null;
                           },
                            
                          ),
                          SizedBox(height: 20),
                          Text("Emergency Contact Info",style: TextStyle(color: const Color.fromARGB(255, 49, 121, 255),
                              fontWeight: FontWeight.bold,)),
                               SizedBox(height: 20),
                              Textfield(
                             labletitle: "Name",
                              hinttitle: "Enter Contact Name",
                          ),
                           SizedBox(height: 20),
                              Textfield(
                             labletitle: "Relationship",
                              hinttitle: "Eg:Mum",
                          ),SizedBox(height: 20),
                              Textfield(
                             labletitle: "Phone Number",
                              hinttitle: "Enter Contact Phone",
                          ),
                          SizedBox(height: 20),
                          SizedBox( 
                             width: 350,
                            height: 45,  
                       child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 6, 120, 250),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                ),
                                onPressed: () { },
                                child: Text('Continue' ,style: TextStyle(color: Color(0xFF20A0D8),
                       fontWeight: FontWeight.bold,fontSize: 20
                                      ),),
                                    ),
                                ),
                          SizedBox(height: 20),
                          SizedBox( 
                             width: 350,
                            height: 45,  
                       child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                    backgroundColor:Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text('Back' ,style: TextStyle(color:Colors.blue,
                       fontWeight: FontWeight.bold,fontSize: 20
                                      ),),
                                    ),
                                ),
                        ]
                        ),
                    ),
                    )
                 ) )
                          ],
                        ),
              ),
      ),
    );
  }
}