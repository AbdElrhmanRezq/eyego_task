part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class CommentsLoaded extends CommentsState {
  final Set<CommentModel> comments;
  CommentsLoaded({this.comments = const {}});
}

final class CommentsFailure extends CommentsState {
  final String errorMessage;
  CommentsFailure({required this.errorMessage});
}
