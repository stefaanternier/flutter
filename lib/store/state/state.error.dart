


class ErrorState {
 final Exception? error;

 const ErrorState({
  this.error,
 });

 ErrorState copyWith({
  Exception? e
 }) {

  ErrorState newState=  ErrorState(
   error: e ?? this.error,
  );
  print('nieuw state ${newState.error}   ${e}');
  return newState;
 }
}