// features/configuration/presentation/bloc/configuration_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/repositories/app_settings_repository.dart';
import '../../domain/entities/app_configuration.dart'; // Add this import

part './configuration_event.dart';
part './configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final AppSettingsRepository appSettingsRepo;

  ConfigurationBloc({required this.appSettingsRepo})
    : super(ConfigurationInitial()) {
    on<LoadConfiguration>(_onLoad);
    on<SaveSiteUrl>(_onSave);

    add(LoadConfiguration()); // auto load on start
  }

  Future<void> _onLoad(
    LoadConfiguration event,
    Emitter<ConfigurationState> emit,
  ) async {
    emit(ConfigurationLoading());
    final result = await appSettingsRepo.getBaseUrl();
    emit(
      result.fold(
        (failure) => ConfigurationError(message: 'Failed to load site URL'),
        (url) => url == null
            ? ConfigurationEmpty()
            : ConfigurationLoaded(config: AppConfiguration(baseUrl: url)),
      ),
    );
  }

  Future<void> _onSave(
    SaveSiteUrl event,
    Emitter<ConfigurationState> emit,
  ) async {
    emit(ConfigurationSaving());
    final cleanedUrl = event.url.trim();
    final config = AppConfiguration(baseUrl: cleanedUrl);

    final result = await appSettingsRepo.saveBaseUrl(cleanedUrl);
    emit(
      result.fold(
        (failure) => ConfigurationError(message: 'Failed to save site URL'),
        (_) => ConfigurationSaved(config: config),
      ),
    );
  }
}
