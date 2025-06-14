import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/model/lecture_session_material_asset_model.dart';
// import 'lecture_session_material_asset_model.dart';

abstract class LectureSessionMaterialAssetState extends Equatable {
  const LectureSessionMaterialAssetState();

  @override
  List<Object> get props => [];
}

class LectureSessionMaterialAssetInitial
    extends LectureSessionMaterialAssetState {}

class LectureSessionMaterialAssetLoading
    extends LectureSessionMaterialAssetState {}

class LectureSessionMaterialAssetLoaded
    extends LectureSessionMaterialAssetState {
  final List<LectureSessionMaterialAssetModel> data;

  const LectureSessionMaterialAssetLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class LectureSessionMaterialAssetError
    extends LectureSessionMaterialAssetState {
  final String message;

  const LectureSessionMaterialAssetError(this.message);

  @override
  List<Object> get props => [message];
}
