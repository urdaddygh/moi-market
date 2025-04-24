import 'package:moi_market/features/home/data/api/home_api.dart';
import 'package:moi_market/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApi api;

  HomeRepositoryImpl({required this.api});

  @override
  Future<String?> getInfo() {
    return api.getInfo();
  }
}