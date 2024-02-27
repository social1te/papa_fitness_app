import 'package:dio/dio.dart';
import 'package:fitness_app/src/repository/data/coach_models/coach_trainings_model.dart';
import 'package:fitness_app/src/repository/data/services/api_service.dart';
import 'package:retrofit/retrofit.dart';

part 'coach_trainings_service.g.dart';

@RestApi(baseUrl: 'https://fohowomsk.ru/')
abstract class CoachService{
  factory CoachService(Dio dio, {String baseUrl}) = _CoachService;

  @GET('api/trainer_events')
  Future<List<CoachTrainingsModel>> getEvents(
      {@Query('events') required String query});

  @GET('api/trainer_list_individual_event')
  Future<List<CoachPersonalTrainingsModel>> getPersonalEvents(
      {@Query('events') required String query});

  @GET('api/tags')
  Future<List<Tag>> getTags(
      {@Query('tags') required String query});

  @GET('api/schedules')
  Future<List<CoachSchedule>> getSchedule(
      {@Query('schedule') required String query});
}

