
import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GlassUI(),
    );
  }
}

class GlassUI extends StatefulWidget {
  const GlassUI({super.key});

  @override
  State<GlassUI> createState() => _GlassUIState();
}

class _GlassUIState extends State<GlassUI> {
  final _formKey = GlobalKey<FormState>();

  String name = "", roll = "", reg = "", phone = "", about = "";
  String? blood;
  String gender = "Male"; // Default value for radio

  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// GLASS CARD
                Container(
                  constraints: const BoxConstraints(maxWidth: 420),
                  margin: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "Student Registration",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),

                              input("Name", (v) => name = v),
                              
                              Row(
                                children: [
                                  Expanded(child: input("Roll", (v) => roll = v, type: TextInputType.number)),
                                  const SizedBox(width: 10),
                                  Expanded(child: input("Reg Number", (v) => reg = v, type: TextInputType.number)),
                                ],
                              ),

                              dropdown("Blood Group", blood,
                                  ["A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"],
                                  (v) => setState(() => blood = v)),

                              const Padding(
                                padding: EdgeInsets.only(top: 15, left: 4),
                                child: Text("Gender", style: TextStyle(color: Colors.white70, fontSize: 14)),
                              ),
                              Row(
                                children: [
                                  genderRadio("Male"),
                                  genderRadio("Female"),
                                 
                                ],
                              ),

                              input("Phone Number", (v) => phone = v, type: TextInputType.phone),
                              input("About Me", (v) => about = v, maxLines: 3),

                              const SizedBox(height: 30),

                              /// SUBMIT BUTTON
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        data = {
                                          "Name": name,
                                          "Roll": roll,
                                          "Registration": reg,
                                          "Blood": blood ?? "N/A",
                                          "Gender": gender,
                                          "Phone": phone,
                                          "About": about,
                                        };
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF00c6ff), Color(0xFF0072ff)],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        )
                                      ],
                                    ),
                                    child: const Text(
                                      "SUBMIT",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// OUTPUT CARD
                if (data.isNotEmpty)
                  Container(
                    width: 380,
                    margin: const EdgeInsets.only(bottom: 40),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: data.entries.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Text("${e.key}: ", style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                            Expanded(child: Text("${e.value}", style: const TextStyle(color: Colors.white))),
                          ],
                        ),
                      )).toList(),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget genderRadio(String value) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: gender,
            activeColor: Colors.blueAccent,
            onChanged: (v) => setState(() => gender = v!),
          ),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }

  Widget input(String label, Function(String) onChanged,
      {int maxLines = 1, TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: type,
        maxLines: maxLines,
        onChanged: onChanged,
        validator: (v) => v!.isEmpty ? "Required" : null,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white60),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  Widget dropdown(String hint, String? value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField(
        value: value,
        hint: Text(hint, style: const TextStyle(color: Colors.white60)),
        dropdownColor: const Color(0xFF16222A),
        style: const TextStyle(color: Colors.white),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? "Required" : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
