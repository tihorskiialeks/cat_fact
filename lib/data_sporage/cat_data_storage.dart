import 'dart:async';
import 'package:hive/hive.dart';

import '../entities/cat.dart';

class CatDataStorage {
  late Box<Cat> _box;
  Future<void> saveCatToStorage(final Cat cat) async {
    _box = await Hive.openBox<Cat>('cats');
    await _box.add(cat);
  }

  Future<List<Cat>> getAllCats() async {
    final Box<Cat> box = await Hive.openBox<Cat>('cats');
    return box.values.toList();
  }
}
