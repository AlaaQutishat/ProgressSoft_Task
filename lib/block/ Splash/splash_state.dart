
import 'package:equatable/equatable.dart';


abstract class SplashState extends Equatable {
  const SplashState();
}
class ConfigurationLoading extends SplashState {
  final String page;

  const ConfigurationLoading(this.page);
   @override
  List<Object> get props => [page];
}

class ConfigurationLoaded extends SplashState {
  final Map<String, dynamic> config;
  const ConfigurationLoaded({this.config = const {}});


  @override
  List<Object> get props => [config];
}


class ConfigurationLoadedError extends SplashState {
  final String message;
  const ConfigurationLoadedError(this.message);
  @override
  List<Object> get props => [message];
}