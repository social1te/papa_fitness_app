import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/models/account_model.dart';
import 'package:retrofit/http.dart';

part 'account_service.g.dart';

@RestApi(baseUrl: 'https://fohowomsk.ru/')
abstract class AccountService {
  factory AccountService(Dio dio, {String baseUrl}) = _AccountService;

  @GET('auth/users/me')
  Future<AccountModel> getAccount({
    @Query('account') required String query
  });

  @GET('api/my_history_events')
  Future<List<EventHistoryModel>> getHistory({
    @Query('history') required String query
  });

  @GET('api/my_events/')
  Future<List<MyEventsModel>> getMyEvents({
    @Query('my_events') required String query
  });
}