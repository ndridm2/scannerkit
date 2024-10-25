import 'package:sqflite/sqflite.dart';
import '../models/document_model.dart';

class DocumentLocalDatasource {
  DocumentLocalDatasource._init();

  static final DocumentLocalDatasource instance =
      DocumentLocalDatasource._init();

  final String tableDocuments = 'documents';

  static Database? _database;

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableDocuments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        category TEXT,
        path TEXT,
        createdAt TEXT,
      )
    ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('documentscan.db');
    return _database!;
  }

  Future<void> saveDocument(DocumentModel document) async {
    final db = await instance.database;
    await db.insert(tableDocuments, document.toMap());
  }

  Future<List<DocumentModel>> getAllDocument() async {
    final db = await instance.database;
    final result = await db.query(tableDocuments, orderBy: 'createdAt DESC');
    return result.map((e) => DocumentModel.fromMap(e)).toList();
  }

  Future<List<DocumentModel>> getDocumentByCategory(String category) async {
    final db = await instance.database;
    final result = await db.query(
      tableDocuments,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'createdAt DESC',
    );
    return result.map((e) => DocumentModel.fromMap(e)).toList();
  }

  Future<void> updateDocument(DocumentModel document) async {
    final db = await instance.database;
    await db.update(
      tableDocuments,
      document.toMap(),
      where: 'id = ?',
      whereArgs: [document.id],
    );
  }

  Future<void> deleteDocument(int id) async {
    final db = await instance.database;
    await db.delete(
      tableDocuments,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}