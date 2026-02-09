import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_courier_assistant/core/di/dependencies.dart';
import 'package:smart_courier_assistant/core/navigation/app_router.dart';
import 'package:smart_courier_assistant/core/theme/app_theme.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_event.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/route/route_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/settings/settings_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://xwgraskemxbhjtgqrjxn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh3Z3Jhc2tlbXhiaGp0Z3FyanhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgzNjI0MDIsImV4cCI6MjA3MzkzODQwMn0.8N39PRYkuu8vS0j69ucNSNblXDct7NBT7IrVqBpFK8c',
  );
  Dependencies.setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<LoginCubit>()),
        BlocProvider(create: (_) => GetIt.I<ForgotPasswordCubit>()),
        BlocProvider(create: (_) => GetIt.I<RegisterCubit>()),
        BlocProvider(create: (_) => GetIt.I<EditProfileCubit>()),
        BlocProvider(create: (_) => GetIt.I<SaveOrderCubit>()),
        BlocProvider(
          create: (_) =>
              GetIt.I<AppBloc>()..add(AppUserSubscriptionRequested()),
        ),
        BlocProvider(
          create: (_) => GetIt.I<SettingsCubit>()..fetchSettings(),
        ),
        BlocProvider(create: (_) => GetIt.I<OrderCubit>()),
        BlocProvider(create: (_) => GetIt.I<ProofDeliveryCubit>()),
        BlocProvider(create: (_) => GetIt.I<RouteCubit>()),
      ],
      child: const SmartCourierAssistantApp(),
    ),
  );
}

class SmartCourierAssistantApp extends StatelessWidget {
  const SmartCourierAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (SettingsCubit cubit) => cubit.state.isDarkMode,
    );
    final languageCode = context.select(
      (SettingsCubit cubit) => cubit.state.languageCode,
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? AppTheme.darkMode : AppTheme.lightMode,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(languageCode),
      routerConfig: AppRouter().router,
    );
  }
}
