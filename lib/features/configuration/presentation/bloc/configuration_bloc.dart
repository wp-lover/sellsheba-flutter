// features/configuration/presentation/bloc/configuration_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/app_configuration.dart';
import '../../domain/repositories/configuration_repository.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final ConfigurationRepository repository;

  ConfigurationBloc({required this.repository})
    : super(ConfigurationInitial()) {
    on<LoadConfiguration>(_onLoad);
    on<SaveSiteUrl>(_onSave);
    on<ClearConfiguration>(_onClear);

    add(LoadConfiguration()); // Auto-load on app start
  }

  Future<void> _onLoad(
    LoadConfiguration event,
    Emitter<ConfigurationState> emit,
  ) async {
    emit(ConfigurationLoading());
    final result = await repository.getSavedConfiguration();
    emit(
      result.fold(
        (failure) => ConfigurationError(message: _mapFailureToMessage(failure)),
        (config) => config == null
            ? ConfigurationEmpty()
            : ConfigurationLoaded(config: config),
      ),
    );
  }

  Future<void> _onSave(
    SaveSiteUrl event,
    Emitter<ConfigurationState> emit,
  ) async {
    emit(ConfigurationSaving());
    final config = AppConfiguration(baseUrl: event.url);
    final result = await repository.saveConfiguration(config);
    emit(
      result.fold(
        (failure) => ConfigurationError(message: _mapFailureToMessage(failure)),
        (_) => ConfigurationSaved(config: config),
      ),
    );
  }

  Future<void> _onClear(
    ClearConfiguration event,
    Emitter<ConfigurationState> emit,
  ) async {
    await repository.clearConfiguration();
    emit(ConfigurationEmpty());
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is CacheFailure) return 'Failed to save site URL';
    return 'Unexpected error';
  }
}
