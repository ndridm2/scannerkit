import 'dart:io';

import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/spaces.dart';

import '../data/models/document_model.dart';

class DetailDocumen extends StatefulWidget {
  final DocumentModel document;
  const DetailDocumen({
    super.key,
    required this.document,
  });

  @override
  State<DetailDocumen> createState() => _DetailDocumenState();
}

class _DetailDocumenState extends State<DetailDocumen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Dokumen'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.document.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.document.category!,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
              Text(
                widget.document.createdAt!,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SpaceHeight(12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              width: double.infinity,
              File(widget.document.path!),
              fit: BoxFit.contain,
              colorBlendMode: BlendMode.colorBurn,
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
