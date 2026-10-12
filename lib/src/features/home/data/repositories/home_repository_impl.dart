import 'package:alurei/src/features/home/data/models/home_profile_model.dart';
import 'package:alurei/src/features/home/domain/entities/home_profile.dart';
import 'package:alurei/src/features/home/domain/repositories/home_repository.dart';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    AuthService? authService,
  }) : _authService = authService ?? AuthService.instance;

  final AuthService _authService;

  @override
  FutureEither<HomeProfile> getCurrentProfile() async {
    final result = await _authService.getCurrentUser();
    return result.fold(
      (failure) {
        final error = failure.error;
        if (error is DioException && error.response?.statusCode == 401) {
          return left(
            UnauthorizedFailure(
              'Your session has expired. Please sign in again.',
              error: error,
            ),
          );
        }
        return left(failure);
      },
      (payload) {
        if (payload == null) {
          return left(const ServerFailure('Profile response was empty.'));
        }

        try {
          return right(HomeProfileModel.fromJson(payload).toEntity());
        } catch (error) {
          return left(ServerFailure('Invalid profile response.', error: error));
        }
      },
    );
  }
}
