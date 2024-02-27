import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/models/gym_model.dart';
import 'package:retrofit/retrofit.dart';

part 'gym_service.g.dart';

@RestApi(baseUrl:'https://fohowomsk.ru/')
abstract class GymService{
  factory GymService(Dio dio, {String baseUrl}) = _GymService;

  @GET('api/main_events')
  Future <List<EventModel>> getEvent({
    @Query('event') required String query
});
  @GET('api/coaches')
  Future <List<CoachModel>> getCoach({
    @Query('coach') required String query
});
  @GET('api/individual_event_schedules')
  Future <List<TimeModel>> getTime({
    @Query('time') required String query
  });
}