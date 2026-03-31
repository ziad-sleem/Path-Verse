// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/firebase_auth_repo.dart' as _i110;
import '../../features/auth/domain/repos/auth_repo.dart' as _i877;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/get_user_data_usecase.dart'
    as _i859;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/domain/usecases/reset_password_usecase.dart'
    as _i474;
import '../../features/auth/domain/usecases/send_otp_usecase.dart' as _i663;
import '../../features/auth/domain/usecases/signin_with_google_usecase.dart'
    as _i780;
import '../../features/auth/domain/usecases/verify_otp_usecase.dart' as _i503;
import '../../features/auth/peresnetation/cubits/auth_cubit/auth_cubit.dart'
    as _i102;
import '../../features/auth/peresnetation/cubits/otp_cubit/cubit/otp_cubit.dart'
    as _i515;
import '../../features/create_post/data/firebase_post_repo.dart' as _i624;
import '../../features/create_post/domain/repo/post_repo.dart' as _i114;
import '../../features/create_post/presentation/cubit/post_cubit.dart' as _i845;
import '../../features/create_video/data/firebase_video_repo.dart' as _i994;
import '../../features/create_video/domain/repo/video_repo.dart' as _i177;
import '../../features/create_video/presentation/cubit/create_video_cubit.dart'
    as _i574;
import '../../features/home/data/firebase_home_repo.dart' as _i58;
import '../../features/home/domain/repos/home_repo.dart' as _i130;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i9;
import '../../features/main_page/presentation/cubit/main_cubit.dart' as _i382;
import '../../features/profile/data/firebase_profile_repo.dart' as _i1029;
import '../../features/profile/domain/repos/profile_repo.dart' as _i1007;
import '../../features/profile/presentation/cubits/cubit/profile_cubit.dart'
    as _i469;
import '../../features/search/data/firebase_search_repo.dart' as _i240;
import '../../features/search/domain/repos/search_repo.dart' as _i41;
import '../../features/search/presentation/bloc/search_bloc.dart' as _i552;
import '../../features/vistas/data/repos/video_repo_impl.dart' as _i1019;
import '../../features/vistas/domain/repos/vedio_repo.dart' as _i17;
import '../../features/vistas/presentation/cubit/video_bloc.dart' as _i553;
import '../cloudinary/cloudinary_service.dart' as _i816;
import '../cloudinary/video_picker_service.dart' as _i1022;
import '../dio/dio_module.dart' as _i977;
import '../firebase.dart/firebase_module.dart' as _i1054;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i816.CloudinaryService>(() => _i816.CloudinaryService());
    gh.lazySingleton<_i1022.VideoPickerService>(
      () => _i1022.VideoPickerService(),
    );
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => registerModule.firebaseFirestore,
    );
    gh.lazySingleton<_i382.MainCubit>(() => _i382.MainCubit());
    gh.lazySingleton<_i17.VideoRepository>(
      () => _i1019.VideoRepositoryImpl(
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
        cloudinaryService: gh<_i816.CloudinaryService>(),
      ),
    );
    gh.lazySingleton<_i1007.ProfileRepo>(
      () => _i1029.FirebaseProfileRepo(
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i177.VideoRepo>(
      () => _i994.FirebaseVideoRepo(
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i41.SearchRepo>(
      () => _i240.FirebaseSearchRepo(
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i552.SearchBloc>(
      () => _i552.SearchBloc(searchRepo: gh<_i41.SearchRepo>()),
    );
    gh.factory<_i553.VideoBloc>(
      () => _i553.VideoBloc(
        gh<_i1022.VideoPickerService>(),
        gh<_i17.VideoRepository>(),
      ),
    );
    gh.lazySingleton<_i161.AuthRemoteDatasource>(
      () => _i161.AuthRemoteDataSourceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i574.CreateVideoCubit>(
      () => _i574.CreateVideoCubit(
        videoRepo: gh<_i177.VideoRepo>(),
        cloudinaryService: gh<_i816.CloudinaryService>(),
      ),
    );
    gh.lazySingleton<_i877.AuthRepo>(
      () => _i110.FirebaseAuthRepo(
        authRemoteDataSource: gh<_i161.AuthRemoteDatasource>(),
      ),
    );
    gh.factory<_i130.HomeRepo>(
      () => _i58.FirebaseHomeRepo(
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
        profileRepo: gh<_i1007.ProfileRepo>(),
        authRepo: gh<_i877.AuthRepo>(),
      ),
    );
    gh.lazySingleton<_i114.PostRepo>(
      () => _i624.FirebasePostRepo(
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
        profileRepo: gh<_i1007.ProfileRepo>(),
        authRepo: gh<_i877.AuthRepo>(),
      ),
    );
    gh.lazySingleton<_i17.GetCurrentUserUsecase>(
      () => _i17.GetCurrentUserUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i859.GetUserDataUsecase>(
      () => _i859.GetUserDataUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i188.LoginUsecase>(
      () => _i188.LoginUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i48.LogoutUsecase>(
      () => _i48.LogoutUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i941.RegisterUsecase>(
      () => _i941.RegisterUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i474.ResetPasswordUsecase>(
      () => _i474.ResetPasswordUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i663.SendOtpUsecase>(
      () => _i663.SendOtpUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i780.SigninWithGoogleUsecase>(
      () => _i780.SigninWithGoogleUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i503.VerifyOtpUsecase>(
      () => _i503.VerifyOtpUsecase(authRepo: gh<_i877.AuthRepo>()),
    );
    gh.factory<_i469.ProfileCubit>(
      () => _i469.ProfileCubit(
        authRepo: gh<_i877.AuthRepo>(),
        postRepo: gh<_i114.PostRepo>(),
        profileRepo: gh<_i1007.ProfileRepo>(),
      ),
    );
    gh.factory<_i9.HomeCubit>(
      () => _i9.HomeCubit(homeRepo: gh<_i130.HomeRepo>()),
    );
    gh.factory<_i845.PostCubit>(
      () => _i845.PostCubit(
        postRepo: gh<_i114.PostRepo>(),
        cloudinaryService: gh<_i816.CloudinaryService>(),
        homeRepo: gh<_i130.HomeRepo>(),
      ),
    );
    gh.factory<_i102.AuthCubit>(
      () => _i102.AuthCubit(
        loginUsecase: gh<_i188.LoginUsecase>(),
        registerUsecase: gh<_i941.RegisterUsecase>(),
        logoutUsecase: gh<_i48.LogoutUsecase>(),
        getCurrentUserUsecase: gh<_i17.GetCurrentUserUsecase>(),
        resetPasswordUsecase: gh<_i474.ResetPasswordUsecase>(),
        signinWithGoogleUsecase: gh<_i780.SigninWithGoogleUsecase>(),
      ),
    );
    gh.factory<_i515.OtpCubit>(
      () => _i515.OtpCubit(
        gh<_i663.SendOtpUsecase>(),
        gh<_i503.VerifyOtpUsecase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}

class _$RegisterModule extends _i1054.RegisterModule {}
