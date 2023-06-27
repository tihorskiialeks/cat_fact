import 'package:flutter_bloc/flutter_bloc.dart';
import '../data_sporage/cat_data_storage.dart';
import '../entities/cat.dart';
import '../repositories/cat_repository.dart';

sealed class CatEvent {}

class GetCatPressed extends CatEvent {}

class CatBloc extends Bloc<CatEvent, Cat> {
  CatBloc()
      : super(
          Cat(
            factText: 'Cats want you to press get cats',
            createdAt: DateTime.now(),
          ),
        ) {
    on<GetCatPressed>((final _, final Emitter<Cat> emit) async {
      final CatRepository repository = CatRepository();
      final CatDataStorage catDataStorage = CatDataStorage();
      final Cat cat = await repository.getCatInfo();
      emit(cat);
      await catDataStorage.saveCatToStorage(cat);
    });
  }
}
