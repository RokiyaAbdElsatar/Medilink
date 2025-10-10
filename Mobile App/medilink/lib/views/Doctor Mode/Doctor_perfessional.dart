// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../widget/textfield.dart' show Textfield;

class DoctorPerfessional extends StatefulWidget {
  const DoctorPerfessional({super.key});

  @override
  State<DoctorPerfessional> createState() => _DoctorPerfessionalState();
}

class _DoctorPerfessionalState extends State<DoctorPerfessional> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 196, 238, 232),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("images/1.png"), 
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
                    "Doctor",
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
                  child: Column(
                    children: [
                      Text('Perfessional Information',textAlign:TextAlign.start,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                      SizedBox(height: 10,),
                      Textfield(
                       labletitle: "Medical Speciaty",
                          hinttitle: "EG.Cardiologist Dermatologist",
                      ),
                       SizedBox(height: 20),
                      Textfield(
                        labletitle: "Medical License",
                          hinttitle: "Enter Your Medical License Number ",
                      ),
                      SizedBox(height: 20),
                      Textfield(
                        labletitle:"issuing Authority",
                          hinttitle: "EG. Medical Syndicate",
                      ),
                      SizedBox(height: 20),
                      Textfield(
                       labletitle: "License Issue Date",
                          hinttitle: "Enter The License isuue date", 
                      ),
                      SizedBox(height: 20),
                      Textfield(
                       labletitle: "License Expir Date",
                          hinttitle: "Enter The License Expir date", 
                      ),
                      SizedBox(height: 20),
                      Textfield(
                        labletitle:"Licensing Authority",
                          hinttitle: "Enter the Licensing Authority",
                      ),
                      SizedBox(height: 20),
                      Textfield(
                       labletitle: "Years of Experiance",
                          hinttitle: "Enter Your Experiance",
                      ), SizedBox(height: 20),
                      Textfield(
                        labletitle: "Current Workplace",
                          hinttitle: "Enter Your Work Hospital Name",
                      ),
                      SizedBox(height: 20),
                      Textfield(
                        labletitle: "Upload Medical ID",
                          hinttitle: "Accepted Formats : jpg , png , pdf - Max size: 5 MB",
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
          child: Text('Continue' ,style: TextStyle(color:Colors.white,
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
                  )
               ) )
          ],
        ),
      ),
    );
  }
}