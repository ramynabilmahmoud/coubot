// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.email,
    this.name = 'No Name',
    this.photoUrl = 'https://via.placeholder.com/150',
    this.isVerified = true,
    this.hasMessages = true,
  });
  final String? id;
  final String? email;
  final String name;
  final String? photoUrl;
  final bool isVerified;
  final bool hasMessages;

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photoUrl,
        isVerified,
        hasMessages,
      ];
}
