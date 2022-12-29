import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class UploadAgreements extends StatefulWidget {
  const UploadAgreements({super.key});

  static String id = 'upload_agreements_screen';

  @override
  State<UploadAgreements> createState() => _UploadAgreementsState();
}

class _UploadAgreementsState extends State<UploadAgreements> {
  final _client_first_name = TextEditingController();
  final _client_last_name = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _addAgreement({
    required String firstName,
    required String lastName,
  }) async {
    final storageRef = FirebaseStorage.instance;
    final Map<String, String> customMeta = {
      "firstName": firstName,
      "lastName": lastName,
    };

    var fileName = firstName + lastName + ".pdf";
    //Check if
    if (kIsWeb) {
      var picked = await FilePicker.platform.pickFiles();

      final metadata = SettableMetadata(
        contentType: "pdf",
        customMetadata: customMeta,
      );

      if (picked != null) {
        var fileBytes = picked.files.first.bytes;

        print(fileName);
        // upload file
        await FirebaseStorage.instance
            .ref('agreements/$fileName')
            .putData(fileBytes!, metadata);
      }
    } //else {
    //**** This needs to be done to pick files from mobile */
    //final Directory systemTempDir = Directory.systemTemp;
    //final byteData = await rootBundle.load('assets/images/some-image.jpg');
    //final file = File('${systemTempDir.path}/${fileName}');
    //await file.writeAsBytes(byteData.buffer
    //  .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    //storageRef
    //  .ref('/images/some-image.jpg')
    //  .putData(await file.readAsBytes());
    //storageRef.ref('agreements/$fileName').putData(await file.readAsBytes());
    //}
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(170, 40),
      maximumSize: const Size(170, 40),
    );

    final firstNameField = TextFormField(
      controller: _client_first_name,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Client First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final lastNameField = TextFormField(
      controller: _client_last_name,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Client Last Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final saveButton = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          var response = await _addAgreement(
            firstName: _client_first_name.text,
            lastName: _client_last_name.text,
          );
        }
      },
      style: style,
      child: Text('Select Agreement'),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your Community of Care'),
          backgroundColor: Colors.blue[400],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              color: Colors.white,
              Icons.arrow_back_ios,
            ),
          ),
        ),
        backgroundColor: Colors.blue[100],
        body: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        firstNameField,
                        const SizedBox(height: 25.0),
                        lastNameField,
                        const SizedBox(height: 25.0),
                        saveButton,
                        const SizedBox(height: 15.0),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
