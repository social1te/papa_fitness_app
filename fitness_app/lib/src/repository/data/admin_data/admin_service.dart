import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/admin_data/admin_model.dart';
import 'package:retrofit/retrofit.dart';

part 'admin_service.g.dart';

@RestApi(baseUrl: 'https://fohowomsk.ru/')
abstract class AdminService{
  factory AdminService(Dio dio, {String baseUrl}) = _AdminService;

  @GET('api/chat-admin/room')
  Future<List<AdminModel>> getAdmin(
      {@Query('admin') required String query});
}