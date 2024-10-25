import 'package:flutter/material.dart';
import '../data/datasources/document_local_datasource.dart';
import '../data/models/document_model.dart';

import 'lates_document.dart';

class DocumentCategories extends StatefulWidget {
  final String categoryTitle;
  const DocumentCategories({
    super.key,
    required this.categoryTitle,
  });

  @override
  State<DocumentCategories> createState() => _DocumentCategoriesState();
}

class _DocumentCategoriesState extends State<DocumentCategories> {
  List<DocumentModel> documents = [];

  loadData() async {
    documents = await DocumentLocalDatasource.instance
        .getDocumentByCategory(widget.categoryTitle);
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document ${widget.categoryTitle}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: LatesDocument(
              documents: documents,
            ),
          ),
        ],
      ),
    );
  }
}
