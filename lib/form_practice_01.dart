import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const GlassUI(),
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

  // Input Variables
  String name = "", roll = "", reg = "", phone = "", about = "";
  String? blood;
  String gender = "Male";

  // Results Map
  Map<String, String> data = {};

  // Form Reset Logic
  void _handleSubmission() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // 1. Capture data for display
        data = {
          "Name": name,
          "Roll": roll,
          "Reg Number": reg,
          "Blood Group": blood ?? "N/A",
          "Gender": gender,
          "Phone": phone,
          "About": about,
        };

        // 2. Clear logic variables
        name = ""; roll = ""; reg = ""; phone = ""; about = "";
        blood = null;
        gender = "Male";
      });

      // 3. Reset the UI Fields
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                /// --- FORM CARD ---
                Container(
                  constraints: const BoxConstraints(maxWidth: 450),
                  margin: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "Student Enrollment",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyanAccent),
                                ),
                              ),
                              const SizedBox(height: 25),
                              
                              customInput("Name", (v) => name = v),
                              
                              Row(
                                children: [
                                  Expanded(child: customInput("Roll", (v) => roll = v, type: TextInputType.number)),
                                  const SizedBox(width: 15),
                                  Expanded(child: customInput("Reg Number", (v) => reg = v, type: TextInputType.number)),
                                ],
                              ),

                              customDropdown("Blood Group", blood, 
                                ["A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"], 
                                (v) => setState(() => blood = v)),

                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 5),
                                child: Text("Gender", style: TextStyle(color: Colors.white70)),
                              ),
                              Row(
                                children: [
                                  genderRadio("Male"),
                                  genderRadio("Female"),
                                   
                                ],
                              ),

                              customInput("Phone Number", (v) => phone = v, type: TextInputType.phone),
                              customInput("About Me", (v) => about = v, maxLines: 3),

                              const SizedBox(height: 30),

                              /// --- SUBMIT BUTTON WITH CURSOR FIX ---
                              Center(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click, // Fixes the cursor shift
                                  child: GestureDetector(
                                    onTap: _handleSubmission,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: const LinearGradient(colors: [Colors.cyanAccent, Colors.blueAccent]),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.cyanAccent.withOpacity(0.3),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          )
                                        ],
                                      ),
                                      child: const Text(
                                        "SUBMIT",
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// --- STYLISH DATA DISPLAY ---
                if (data.isNotEmpty)
                  Container(
                    width: 400,
                    margin: const EdgeInsets.only(top: 20, bottom: 40),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.cyanAccent.withOpacity(0.4)),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, color: Colors.cyanAccent, size: 20),
                            SizedBox(width: 10),
                            Text("SUBMISSION SUCCESSFUL", style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(color: Colors.white24, height: 30),
                        ...data.entries.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${e.key}: ", style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                              Expanded(child: Text(e.value, style: const TextStyle(color: Colors.white))),
                            ],
                          ),
                        )).toList(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- COMPONENT WIDGETS ---

  Widget genderRadio(String value) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: gender,
            activeColor: Colors.cyanAccent,
            onChanged: (v) => setState(() => gender = v!),
          ),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget customInput(String label, Function(String) onChanged, {int maxLines = 1, TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: type,
        maxLines: maxLines,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white60),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.cyanAccent)),
        ),
        validator: (v) => v!.isEmpty ? "Enter $label" : null,
      ),
    );
  }

  Widget customDropdown(String hint, String? value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(hint, style: const TextStyle(color: Colors.white60)),
        dropdownColor: const Color(0xFF203A43),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? "Select $hint" : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
