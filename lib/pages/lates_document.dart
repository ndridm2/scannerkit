import 'dart:io';

import 'package:flutter/material.dart';
import '../core/colors.dart';

import '../data/models/document_model.dart';
import 'detail_documen.dart';

class LatesDocument extends StatefulWidget {
  final List<DocumentModel> documents;
  const LatesDocument({
    super.key,
    required this.documents,
  });

  @override
  State<LatesDocument> createState() => _LatesDocumentState();
}

class _LatesDocumentState extends State<LatesDocument> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: widget.documents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailDocumen(
                    document: widget.documents[index],
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      width: double.infinity,
                      File(widget.documents[index].path!),
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.colorBurn,
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                ),
                Text(
                  widget.documents[index].name!,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
