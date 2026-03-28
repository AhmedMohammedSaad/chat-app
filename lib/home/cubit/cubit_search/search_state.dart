part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<UserModel> users;

  SearchSuccess({required this.users});
}

final class SearchFailure extends SearchState {
  final String errorMessage;

  SearchFailure({required this.errorMessage});
}

final class ChatStared extends SearchState {
  final String chatId;
  final UserModel otherUser;

  ChatStared({required this.chatId, required this.otherUser});
}
