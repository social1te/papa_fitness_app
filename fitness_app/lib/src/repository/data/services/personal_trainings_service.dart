// import 'package:dio/dio.dart';
// import 'package:fitness_app/src/repository/data/models/personal_trainings_model.dart';
// import 'package:retrofit/retrofit.dart';
//
// @RestApi(baseUrl: 'https://onlydev.fun/')
// abstract class PersonalTrainingsService {
//   factory PersonalTrainingsService(Dio dio, {String baseUrl}) = _PersonalTrainingsService;
//
//   @GET('api/individual_events')
//   Future<List<PersonalTrainingsModel>> getPersonalTraining(
//       {@Query('individual_event') required String query});
// }