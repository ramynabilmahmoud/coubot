// ignore_for_file: public_member_api_docs

part of 'app_layout_cubit.dart';

class AppLayoutState extends Equatable {
  const AppLayoutState({
    this.appVersion,
  });

  factory AppLayoutState.initial() {
    return const AppLayoutState();
  }

  final String? appVersion;

  // copyWith method
  AppLayoutState copyWith({
    String? appVersion,
  }) {
    return AppLayoutState(
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object> get props => [
        appVersion ?? '',
      ];

  @override
  bool? get stringify => true;
}
