import 'package:fitness/models/user_model.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Utils {
  static UserModel? getMyProfile(BuildContext context) {
    AuthenticationBloc bloc = context.read<AuthenticationBloc>();
    if (bloc.state is AuthenticationSuccess) {
      return (bloc.state as AuthenticationSuccess).user;
    }
    return null;
  }

  static String? getMyId(BuildContext context) {
    UserModel? user = getMyProfile(context);
    return user?.id;
  }
}
