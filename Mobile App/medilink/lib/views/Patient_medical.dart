import 'package:flutter/material.dart';

class PatientMedical extends StatefulWidget {
  const PatientMedical({super.key});

  @override
  State<PatientMedical> createState() => _PatientMedical();  
}

class _PatientMedical extends State<PatientMedical> {
  @override
  Widget build(BuildContext context) {
    var selectedBloodType;
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
                  child: Column(
                    children: [
                      Text('Medical information',textAlign:TextAlign.start,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                      SizedBox(height: 10,),
                      TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Hight",
                          hintText: "Enter Your Hight",
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
                          labelText: "Weight",
                          hintText: "Enter Your Weight",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
               DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                    labelText: "Blood Type",
                      border: OutlineInputBorder(),
     ),
                    value: selectedBloodType,
                   items: [
                                "A+",
                                "A-",
                                "B+",
                                "B-",
                                "AB+",
                                "AB-",
                                 "O+",
                                 "O-",
                            ].map((blood) {
                  return DropdownMenuItem(
                    value: blood,
                         child: Text(blood),
                         );
                     }).toList(),
            onChanged: (value) {
                  selectedBloodType = value;
                               },
                        ),

                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Chronic Condition ",
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
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 53, 183, 235),
                          fontWeight: FontWeight.bold
                          ),
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 131, 131)),
                          labelText: "Allergies",
                          hintText: "At Least 6 Character",
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
                          labelText: "Medical History Summary",
                          hintText: "Confirm Your Password",
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