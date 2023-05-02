import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/auth/auth_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/communication/communication_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/group/group_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/home/home_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/status/status_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/user/get_single_user/get_single_user_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/home_screen/home_screen.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/welcome_screen/welcome_screen.dart';
import 'common/theme/dark_theme.dart';
import 'common/theme/light_theme.dart';
import 'data/model/user_model.dart';
import 'injection_container.dart' as di;
import 'on_generate_route.dart';
import 'presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'presentation/bloc/user/user_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  List<CameraDescription> cameras = await availableCameras();
  runApp(ProviderScope(
      child: MyApp(
    cameras: cameras,
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider(
          create: (_) => di.sl<PhoneAuthCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>()..getAllUsers(),
        ),
        BlocProvider<GetDeviceNumbersCubit>(
          create: (_) => di.sl<GetDeviceNumbersCubit>()..getDeviceNumbers(),
        ),
        BlocProvider<CommunicationCubit>(
          create: (_) => di.sl<CommunicationCubit>(),
        ),
        BlocProvider<MyChatCubit>(
          create: (_) => di.sl<MyChatCubit>(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => di.sl<HomeCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (_) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider<StatusCubit>(
          create: (_) => di.sl<StatusCubit>()..getStatus(),
        ),
        BlocProvider<GroupCubit>(
          create: (_) => di.sl<GroupCubit>()..getChatGroup(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter WhatsApp Clone',
                darkTheme: darkTheme(),
                theme: lightTheme(),
                onGenerateRoute: OnGenerateRoute.route,
                initialRoute: "/",
                routes: {
                  "/": (context) {
                    return BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, authState) {
                        if (authState is Authenticated) {
                          return BlocBuilder<UserCubit, UserState>(
                            builder: (context, userState) {
                              if (userState is UserLoaded) {
                                final currentUserInfo = userState.users
                                    .firstWhere(
                                        (user) => user.uid == authState.uid,
                                        orElse: () => UserModel());
                                return HomeScreen(
                                  userInfo: currentUserInfo,
                                  cameras: cameras,
                                );
                              }
                              return Container();
                            },
                          );
                        }
                        if (authState is UnAuthenticated) {
                          return const WelcomeScreen();
                        }
                        return Container();
                      },
                    );
                  }
                },
              )),
    );
  }
}
