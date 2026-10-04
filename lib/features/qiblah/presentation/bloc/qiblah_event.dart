import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim/features/qiblah/domain/entities/qiblah_direction_entity.dart';

part 'qiblah_event.freezed.dart';

@freezed
sealed class QiblahEvent with _$QiblahEvent {
  const factory QiblahEvent.init() = QiblahInit;
  const factory QiblahEvent.locationStatusChanged(ServiceStatus status) = QiblahLocationStatusChanged;
  const factory QiblahEvent.startCompass() = QiblahStartCompass;
  const factory QiblahEvent.qiblahDataReceived(QiblahDirectionEntity data) = QiblahDataReceived;
  const factory QiblahEvent.locationDisabled() = QiblahLocationDisabled;
  const factory QiblahEvent.errorOccurred(String message) = QiblahErrorOccurred;
}
