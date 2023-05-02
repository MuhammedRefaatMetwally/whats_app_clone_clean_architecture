import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/create_group.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/get_group_usecase.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/get_single_user_usecase.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/get_status.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/make_call.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/send_image_message_use_case.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/set_chat_message_seen_use_case.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/set_user_status.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/upload_status.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/auth/auth_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/communication/communication_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/group/group_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/home/home_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/status/status_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/user/get_single_user/get_single_user_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/user/user_cubit.dart';
import 'data/datasource/firebase_remote_datasource.dart';
import 'data/datasource/firebase_remote_datasource_impl.dart';
import 'data/local_datasource/local_datasource.dart';
import 'data/repositories/firebase_repository_impl.dart';
import 'data/repositories/get_device_number_repository_impl.dart';
import 'domain/repositories/firebase_repository.dart';
import 'domain/repositories/get_device_number_repository.dart';
import 'domain/usecases/add_to_my_chat_usecase.dart';
import 'domain/usecases/create_one_to_one_chat_channel_usecase.dart';
import 'domain/usecases/get_all_user_usecase.dart';
import 'domain/usecases/get_create_current_user_usecase.dart';
import 'domain/usecases/get_current_uid_usecase.dart';
import 'domain/usecases/get_device_numbers_usecase.dart';
import 'domain/usecases/get_my_chat_usecase.dart';
import 'domain/usecases/get_one_to_one_single_user_chat_channel_usecase.dart';
import 'domain/usecases/get_text_messages_usecase.dart';
import 'domain/usecases/is_sign_in_usecase.dart';
import 'domain/usecases/send_text_message_usecase.dart';
import 'domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/upload_image_to_storage_use_case.dart';
import 'domain/usecases/verify_phone_number_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //Futures bloc
  sl.registerFactory<AuthCubit>(() =>
      AuthCubit(
        signOutUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        getCurrentUidUseCase: sl.call(),
      ));
  sl.registerFactory<PhoneAuthCubit>(() =>
      PhoneAuthCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInWithPhoneNumberUseCase: sl.call(),
        verifyPhoneNumberUseCase: sl.call(),
      ));

  sl.registerFactory<CommunicationCubit>(() =>
      CommunicationCubit(
        addToMyChatUseCase: sl.call(),
        getOneToOneSingleUserChatChannelUseCase: sl.call(),
        getTextMessagesUseCase: sl.call(),
        sendTextMessageUseCase: sl.call(), sendImageMessageUseCase: sl.call(), makeCallUseCase: sl.call(),
      ));
  sl.registerFactory<MyChatCubit>(() =>
      MyChatCubit(
        getMyChatUseCase: sl.call(), uploadImageToStorageUseCase: sl.call(), setChatMessageSeen: sl.call(),
      ));
  sl.registerFactory<HomeCubit>(() => HomeCubit());

  sl.registerFactory<GetDeviceNumbersCubit>(
          () => GetDeviceNumbersCubit(getDeviceNumberUseCase: sl.call(),));

  sl.registerFactory<UserCubit>(() =>
      UserCubit(
        createOneToOneChatChannelUseCase: sl.call(),
        getAllUserUseCase: sl.call(), setUserStatusUseCase: sl.call(),
      ));
  sl.registerFactory<GetSingleUserCubit>(() =>
      GetSingleUserCubit(getSingleUserUseCase: sl.call()));

  sl.registerFactory<StatusCubit>(() =>
      StatusCubit( uploadStatusUseCase: sl.call(), getStatusUseCase: sl.call()));

  sl.registerFactory<GroupCubit>(() =>
      GroupCubit(createGroupUseCase: sl.call(), getChatGroupUseCase: sl.call()));

  //useCase
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
          () => GetCreateCurrentUserUseCase(repository: sl.call()));


  sl.registerLazySingleton<GetCurrentUidUseCase>(
          () => GetCurrentUidUseCase(repository: sl.call()));

  sl.registerLazySingleton<IsSignInUseCase>(
          () => IsSignInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
          () => SignInWithPhoneNumberUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignOutUseCase>(
          () => SignOutUseCase(repository: sl.call()));

  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
          () => VerifyPhoneNumberUseCase(repository: sl.call()));

  sl.registerLazySingleton<SetUserStatusUseCase>(
          () => SetUserStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton<SendImageMessageUseCase>(
          () => SendImageMessageUseCase(repository: sl.call()));

  sl.registerLazySingleton(
          () => UploadImageToStorageUseCase(repository: sl.call()));

  sl.registerLazySingleton(
          () => SetChatMessageSeen(repository: sl.call()));

  sl.registerLazySingleton(
          () => GetStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton(
          () => CreateGroupUseCase(repository: sl.call()));

  sl.registerLazySingleton(
          () => GetChatGroupUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetAllUserUseCase>(
          () => GetAllUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetSingleUserUseCase>(
          () => GetSingleUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<UploadStatusUseCase>(
          () => UploadStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton<MakeCallUseCase>(
          () => MakeCallUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetMyChatUseCase>(
          () => GetMyChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetTextMessagesUseCase>(
          () => GetTextMessagesUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
          () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<AddToMyChatUseCase>(
          () => AddToMyChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<CreateOneToOneChatChannelUseCase>(
          () => CreateOneToOneChatChannelUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetOneToOneSingleUserChatChannelUseCase>(
          () => GetOneToOneSingleUserChatChannelUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetDeviceNumberUseCase>(
          () => GetDeviceNumberUseCase(deviceNumberRepository: sl.call()));
  //repository
  sl.registerLazySingleton<FirebaseRepository>(
          () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<GetDeviceNumberRepository>(
          () =>
          GetDeviceNumberRepositoryImpl(
            localDataSource: sl.call(),
          ));

  //remote data
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
          () =>
          FirebaseRemoteDataSourceImpl(
            auth: sl.call(),
            fireStore: sl.call(),
            realtime: sl.call(),
            firebaseStorage: sl.call(),
          ));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  //External

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final realtime = FirebaseDatabase.instance;
  final fireStorage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => realtime);
  sl.registerLazySingleton(() => fireStorage);
}
