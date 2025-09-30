import 'package:akademove/app/_export.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  _setupService();
  _setupDataSource();
  _setupRepository();
  _setupCubit();
}

void _setupService() {}
void _setupDataSource() {}
void _setupRepository() {}
void _setupCubit() {
  sl.registerFactory(AppCubit.new);
}
