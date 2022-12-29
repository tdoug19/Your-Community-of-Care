import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:http/http.dart' as http;

class ViewAgreements extends StatefulWidget {
  const ViewAgreements({super.key});

  @override
  State<ViewAgreements> createState() => _ViewAgreements();
}

class _ViewAgreements extends State<ViewAgreements> {
  final _client_first_name = TextEditingController();
  final _client_last_name = TextEditingController();
  String? pdfFlePath;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String> downloadAndSavePdf({
    required String firstName,
    required String lastName,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final file =
        File('${directory.path}' + '/' + firstName + lastName + '.pdf');
    if (await file.exists()) {
      return file.path;
    }

    final downloadURL = await FirebaseStorage.instance
        .ref('agreements/' + firstName + lastName + '.pdf')
        .getDownloadURL();
    print(downloadURL);

    final response = await http.get(Uri.parse(downloadURL));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  void loadPdf({
    required String firstName,
    required String lastName,
  }) async {
    pdfFlePath =
        await downloadAndSavePdf(firstName: firstName, lastName: lastName);
    setState(() {});
  }

  // Future<void> _viewAgreement({
  //   required String firstName,
  //   required String lastName,
  // }) async {
  //   //final storageRef = FirebaseStorage.instance.ref();
  //   //final islandRef = storageRef.child("agreements/JoeBlow.pdf");
  //   final storageRef = FirebaseStorage.instance.ref("agreements");
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final filePath = "${appDocDir.path}/JoeBlow.jpg";
  //   final file = File(filePath);

  //   final downloadTask =
  //       storageRef.child(firstName + lastName + ".pdf").writeToFile(file);

  //   //final downloadTask = islandRef.writeToFile(file);
  //   downloadTask.snapshotEvents.listen((taskSnapshot) {
  //     switch (taskSnapshot.state) {
  //       case TaskState.running:
  //         print('running');
  //         break;
  //       case TaskState.paused:
  //         print('pause');
  //         break;
  //       case TaskState.success:
  //         print('success');
  //         break;
  //       case TaskState.canceled:
  //         print('cancelled');
  //         break;
  //       case TaskState.error:
  //         print('error');
  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(150, 40),
      maximumSize: const Size(150, 40),
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final viewAgreement = ElevatedButton(
        child: Text("View Agreement"),
        style: style,
        onPressed: () {
          loadPdf(
            firstName: _client_first_name.text,
            lastName: _client_last_name.text,
          );
        });

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                firstNameField,
                const SizedBox(height: 25.0),
                lastNameField,
                const SizedBox(height: 25.0),
                viewAgreement,
                if (pdfFlePath != null)
                  Expanded(
                    child: Container(
                      child: PdfView(path: pdfFlePath!),
                    ),
                  )
                else
                  Text("Pdf is not Loaded"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
