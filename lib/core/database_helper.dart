import 'package:flock_flutter/models/feed_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/flock.db";
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE FeedItems (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        imageUrl TEXT,
        pledgeCount INTEGER,
        pledgeGoal INTEGER,
        likeCount INTEGER,
        commentCount INTEGER
      )
    ''');
  }

  Future<void> cacheFeedItems(List<FeedItem> items) async {
    final db = await database;
    await db.delete('FeedItems'); // Clear old cache
    Batch batch = db.batch();
    for (var item in items) {
      batch.insert('FeedItems', item.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<FeedItem>> getCachedFeedItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('FeedItems');
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (i) {
      return FeedItem.fromMap(maps[i]);
    });
  }
}
