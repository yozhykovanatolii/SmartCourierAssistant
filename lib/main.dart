import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_event.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/settings/settings_cubit.dart';
import 'package:smart_courier_assistant/presentation/page/splash/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://xwgraskemxbhjtgqrjxn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh3Z3Jhc2tlbXhiaGp0Z3FyanhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgzNjI0MDIsImV4cCI6MjA3MzkzODQwMn0.8N39PRYkuu8vS0j69ucNSNblXDct7NBT7IrVqBpFK8c',
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => ForgotPasswordCubit()),
        BlocProvider(create: (_) => RegisterCubit()),
        BlocProvider(create: (_) => EditProfileCubit()),
        BlocProvider(
          create: (_) => AppBloc()..add(AppUserSubscriptionRequested()),
        ),
        BlocProvider(
          create: (_) => SettingsCubit()..fetchSettings(),
        ),
      ],
      child: const SmartCourierAssistantApp(),
    ),
  );
}

class SmartCourierAssistantApp extends StatelessWidget {
  const SmartCourierAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
