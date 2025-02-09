import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslatorFeature extends StatefulWidget {
  const LanguageTranslatorFeature({Key? key}) : super(key: key);

  @override
  _LanguageTranslatorFeatureState createState() => _LanguageTranslatorFeatureState();
}

class _LanguageTranslatorFeatureState extends State<LanguageTranslatorFeature> {
  var languages = ['Hindi', 'English', 'Arabic'];
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var output = '';
  final TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    if (src == '--' || dest == '--' || input.isEmpty) {
      setState(() {
        output = 'Fail to translate. Check your input or language selection.';
      });
      return;
    }

    try {
      GoogleTranslator translator = GoogleTranslator();
      var translation = await translator.translate(input, from: src, to: dest);
      setState(() {
        output = translation.text.toString();
      });
    } catch (e) {
      setState(() {
        output = 'Translation failed. Please try again later.';
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Hindi') {
      return 'hi';
    } else if (language == 'Arabic') {
      return 'ar';
    }
    return '--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: const Text('Language Translator'),
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Dropdown for Origin Language
                  DropdownButton(
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(color: Colors.black),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  // Dropdown for Destination Language
                  DropdownButton(
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.black),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Please enter your text...",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    translate(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      languageController.text.trim(),
                    );
                  },
                  child: const Text('Translate', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '\n$output',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}