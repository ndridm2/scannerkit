import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/colors.dart';
import '../data/datasources/document_local_datasource.dart';
import '../data/models/document_model.dart';

class SaveDocument extends StatefulWidget {
  final String pathImage;
  const SaveDocument({
    super.key,
    required this.pathImage,
  });

  @override
  State<SaveDocument> createState() => _SaveDocumentState();
}

class _SaveDocumentState extends State<SaveDocument> {
  TextEditingController? nameController;
  String? selectCategory;

  final List<String> categories = [
    'Kartu',
    'Nota',
    'Surat',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Document'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // document path
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(widget.pathImage),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectCategory,
            onChanged: (String? value) {
              setState(() {
                selectCategory = value;
              });
            },
            items: categories
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            decoration: const InputDecoration(
              labelText: 'Category',
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          DocumentModel model = DocumentModel(
            name: nameController!.text,
            category: selectCategory!,
            path: widget.pathImage,
            createdAt:
                DateFormat('dd-MM-yyyy THH:mm:ss').format(DateTime.now()),
          );
          DocumentLocalDatasource.instance.saveDocument(model);
          Navigator.pop(context);
          const snackBar = SnackBar(
            content: Text('Document saved'),
            backgroundColor: AppColors.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 52,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text(
              'Save Document',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
