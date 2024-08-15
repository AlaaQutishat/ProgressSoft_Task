

import 'package:equatable/equatable.dart';


abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class GetConfiguration extends SplashEvent{
  @override
  List<Object?> get props => [];
}

