import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/models/subscriptions_model.dart';
import 'package:retrofit/retrofit.dart';

part 'subscriptions_service.g.dart';

@RestApi(baseUrl: 'https://fohowomsk.ru/')
abstract class SubscriptionsService {
  factory SubscriptionsService(Dio dio, {String baseUrl}) = _SubscriptionsService;

  @GET('api/my_subscriptions')
  Future<List<SubscriptionsModel>> getSubscriptions(
      {@Query('subscription') required String query});
}
