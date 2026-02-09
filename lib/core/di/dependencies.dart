import 'package:get_it/get_it.dart';
import 'package:smart_courier_assistant/data/datasource/local/settings_shared_preference.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/recommendation_gpt_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/route_direction_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/route_optimize_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/user_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/storage/supabase_storage.dart';
import 'package:smart_courier_assistant/data/repository/auth_repository_impl.dart';
import 'package:smart_courier_assistant/data/repository/delivery_repository_impl.dart';
import 'package:smart_courier_assistant/data/repository/geolocation_repository_impl.dart';
import 'package:smart_courier_assistant/data/repository/order_repository_impl.dart';
import 'package:smart_courier_assistant/data/repository/route_repository_impl.dart';
import 'package:smart_courier_assistant/data/repository/settings_repository_impl.dart';
import 'package:smart_courier_assistant/data/repository/user_repository_impl.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/route/route_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/settings/settings_cubit.dart';

class Dependencies {
  static final _getIt = GetIt.instance;

  static void setupDependencies() {
    _setupDataSources();
    _setupRepositories();
    _setupBloc();
  }

  static void _setupDataSources() {
    _setupFirestore();
    _setupAPI();
    _getIt.registerSingleton<UserAuth>(UserAuth());
    _getIt.registerSingleton<SupabaseStorage>(SupabaseStorage());
    _getIt.registerSingleton<SettingsSharedPreference>(
      SettingsSharedPreference(),
    );
  }

  static void _setupAPI() {
    _getIt.registerSingleton<RecommendationGptClient>(
      RecommendationGptClient(),
    );
    _getIt.registerSingleton<RouteDirectionClient>(RouteDirectionClient());
    _getIt.registerSingleton<RouteOptimizeClient>(RouteOptimizeClient());
  }

  static void _setupFirestore() {
    _getIt.registerSingleton<UserFirestore>(UserFirestore());
    _getIt.registerSingleton<OrderFirestore>(OrderFirestore());
    _getIt.registerSingleton<RouteFirestore>(RouteFirestore());
  }

  static void _setupRepositories() {
    final userAuth = _getIt<UserAuth>();
    final userFirestore = _getIt<UserFirestore>();
    final routeFirestore = _getIt<RouteFirestore>();
    final orderFirestore = _getIt<OrderFirestore>();
    final supabaseStorage = _getIt<SupabaseStorage>();
    _getIt.registerFactory<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(userAuth, userFirestore),
    );
    _getIt.registerFactory<DeliveryRepositoryImpl>(
      () => DeliveryRepositoryImpl(userAuth, routeFirestore, orderFirestore),
    );
    _getIt.registerFactory<UserRepositoryImpl>(
      () => UserRepositoryImpl(userAuth, userFirestore, supabaseStorage),
    );
    _getIt.registerFactory<OrderRepositoryImpl>(
      () => OrderRepositoryImpl(
        userAuth: userAuth,
        orderFirestore: orderFirestore,
        routeFirestore: routeFirestore,
        optimizeClient: _getIt<RouteOptimizeClient>(),
        supabaseStorage: supabaseStorage,
      ),
    );
    _getIt.registerFactory<RouteRepositoryImpl>(
      () => RouteRepositoryImpl(
        userAuth: userAuth,
        orderFirestore: orderFirestore,
        routeFirestore: routeFirestore,
        gptClient: _getIt<RecommendationGptClient>(),
        directionClient: _getIt<RouteDirectionClient>(),
      ),
    );
    _getIt.registerFactory<GeolocationRepositoryImpl>(
      () => GeolocationRepositoryImpl(),
    );
    _getIt.registerFactory<SettingsRepositoryImpl>(
      () => SettingsRepositoryImpl(_getIt<SettingsSharedPreference>()),
    );
  }

  static void _setupBloc() {
    final authRepository = _getIt<AuthRepositoryImpl>();
    final userRepository = _getIt<UserRepositoryImpl>();
    final routeRepository = _getIt<RouteRepositoryImpl>();
    final orderRepository = _getIt<OrderRepositoryImpl>();
    _getIt.registerFactory<AppBloc>(() => AppBloc(userRepository));
    _getIt.registerFactory<LoginCubit>(() => LoginCubit(authRepository));
    _getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(userRepository, authRepository),
    );
    _getIt.registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(authRepository, userRepository),
    );
    _getIt.registerFactory<EditProfileCubit>(
      () => EditProfileCubit(userRepository, authRepository),
    );
    _getIt.registerFactory<OrderCubit>(
      () => OrderCubit(
        orderRepository,
        _getIt<GeolocationRepositoryImpl>(),
        userRepository,
        routeRepository,
      ),
    );
    _getIt.registerFactory<ProofDeliveryCubit>(
      () => ProofDeliveryCubit(
        orderRepository,
        _getIt<DeliveryRepositoryImpl>(),
      ),
    );
    _getIt.registerFactory<RouteCubit>(() => RouteCubit(routeRepository));
    _getIt.registerFactory<SaveOrderCubit>(
      () => SaveOrderCubit(orderRepository, routeRepository),
    );
    _getIt.registerFactory<SettingsCubit>(
      () => SettingsCubit(_getIt<SettingsRepositoryImpl>()),
    );
  }
}
