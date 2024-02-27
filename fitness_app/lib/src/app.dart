import 'package:fitness_app/main.dart';
import 'package:fitness_app/src/screens/account_screen/balance_confirm_screen.dart';
import 'package:fitness_app/src/screens/account_screen/balance_screen.dart';
import 'package:fitness_app/src/screens/account_screen/edit_personal_info_screen.dart';
import 'package:fitness_app/src/screens/account_screen/my_schedule_screen.dart';
import 'package:fitness_app/src/screens/account_screen/subscriptions_screen.dart';
import 'package:fitness_app/src/screens/admin_screen/admin_screen.dart';
import 'package:fitness_app/src/screens/authreg_screens/auth_phone_check_screen.dart';
import 'package:fitness_app/src/screens/authreg_screens/authorization_screen.dart';
import 'package:fitness_app/src/screens/authreg_screens/password_screen.dart';
import 'package:fitness_app/src/screens/authreg_screens/personal_data_screen.dart';
import 'package:fitness_app/src/screens/authreg_screens/phone_check_screen.dart';
import 'package:fitness_app/src/screens/authreg_screens/registration_screen.dart';
import 'package:fitness_app/src/screens/coach_screens/coach_create_personal_training.dart';
import 'package:fitness_app/src/screens/coach_screens/coach_create_training_screen.dart';
import 'package:fitness_app/src/screens/coach_screens/coach_edit_personal_training.dart';
import 'package:fitness_app/src/screens/coach_screens/coach_edit_training_screen.dart';
import 'package:fitness_app/src/screens/coach_screens/coach_personal_training.dart';
import 'package:fitness_app/src/screens/coach_screens/coach_select_tag.dart';
import 'package:fitness_app/src/screens/coach_screens/coach_tags_screen.dart';
import 'package:fitness_app/src/screens/coach_screens/create_tags_screen.dart';
import 'package:fitness_app/src/screens/coach_screens/edit_tags_screen.dart';
import 'package:fitness_app/src/screens/coach_screens/main_coach_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/club_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/coach_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/coaches_list_personal_training.dart';
import 'package:fitness_app/src/screens/gym_screens/coaches_list_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/feedback_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/group_trainings_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/personal_trainings_calendar_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/personal_trainings_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/subscriptions_list_screen.dart';
import 'package:fitness_app/src/screens/gym_screens/user_agreement_screen.dart';
import 'package:fitness_app/src/screens/home_screens/chat_screen.dart';
import 'package:fitness_app/src/screens/home_screens/event_screen.dart';
import 'package:fitness_app/src/screens/main_screens/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/main') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const Main());
        }
        if (settings.name == '/home_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const HomeScreen());
        }
        if (settings.name == '/coaches_list_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const CoachesListScreen());
        }
        if (settings.name == '/event_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const EventScreen());
        }
        if (settings.name == '/coach_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const CoachScreen());
        }
        if (settings.name == '/authorization_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const AuthorizationScreen());
        }
        if (settings.name == '/registration_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const RegistrationScreen());
        }
        if (settings.name == '/phone_check_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const PhoneCheckScreen());
        }
        if (settings.name == '/password_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const PasswordScreen());
        }
        if (settings.name == '/balance_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const BalanceScreen());
        }
        if (settings.name == '/balance_confirm_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const BalanceConfirmScreen());
        }
        if (settings.name == '/subscriptions_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const SubscriptionsScreen());
        }
        if (settings.name == '/subscriptions_list_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const SubscriptionsListScreen());
        }
        if (settings.name == '/personal_trainings_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => PersonalTrainingsScreen());
        }
        if (settings.name == '/coaches_list_personal_training_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const CoachesListPersonalTrainingScreen());
        }
        if (settings.name == '/club_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const ClubScreen());
        }
        if (settings.name == '/feedback_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const FeedbackScreen());
        }
        if (settings.name == '/main_coach_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => const CoachMain());
        }
        if (settings.name == '/coach_create_training_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => const CoachCreateTraining());
        }
        if (settings.name == '/chat_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => ChatScreen());
        }
        if (settings.name == '/admin_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => AdminScreen());
        }
        if (settings.name == '/group_trainings_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => GroupTrainingsScreen());
        }
        if (settings.name == '/personal_data_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => PersonalDataScreen());
        }
        if (settings.name == '/coach_edit_training_screen') {
          return MaterialPageRoute(
              settings: settings, builder: (context) => CoachEditTraining());
        }
        if (settings.name == '/coach_personal_training') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => CoachPersonalTrainingScreen());
        }
        if (settings.name == '/coach_tags_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => CoachTagsScreen());
        }
        if (settings.name == '/edit_personal_info_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => EditPersonalInfoScreen());
        }
        if (settings.name == '/create_tags_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => CreateTagsScreen());
        }
        if (settings.name == '/edit_tags_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => EditTagsScreen());
        }
        if (settings.name == '/coach_create_personal_training') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => CoachCreatePersonalTrainingScreen());
        }
        if (settings.name == '/coach_edit_personal_training') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => CoachEditPersonalTraining());
        }
        if (settings.name == '/auth_phone_check_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => AuthPhoneCheckScreen());
        }
        if (settings.name == '/personal_training_calendar_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => PersonalTrainingsCalendarScreen());
        }
        if (settings.name == '/user_agreement_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => UserAgreementScreen());
        }
        if (settings.name == '/my_schedule_screen') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => MyScheduleScreen());
        }
        if (settings.name == '/coach_select_tag') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => CoachSelectTag());
        }
      },
      home: AuthorizationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
