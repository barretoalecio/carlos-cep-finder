import 'app_state.dart';

abstract class ErrorState extends AppState {
  ErrorState(String message) : super(message);
}
