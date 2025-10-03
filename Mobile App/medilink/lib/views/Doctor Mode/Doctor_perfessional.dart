import 'package:flutter/material.dart';

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
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Medical Speciaty",
                          hintText: "EG.Cardiologist Dermatologist",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                       SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Medical License",
                          hintText: "Enter Your Medical License Number ",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "issuing Authority",
                          hintText: "EG. Medical Syndicate",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "License Expiry Date",
                          hintText: "Enter The License Expiration date",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Licensing Authority",
                          hintText: "Enter the Licensing Authority",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Years of Experiance",
                          hintText: "Enter Your Experiance",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ), SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Current Workplace",
                          hintText: "Enter Your Work Hospital Name",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Upload Medical ID",
                          hintText: "Accepted Formats : jpg , png , pdf - Max size: 5 MB",
                          suffixIcon: Icon(Icons.upload),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
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