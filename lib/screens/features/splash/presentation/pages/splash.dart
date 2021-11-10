import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/injection_container.dart';
import 'package:bufi_remake/screens/features/splash/presentation/bloc/splas_bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SplashBloc>(
        create: (_) => sl<SplashBloc>(),
        child: Stack(
          children: [
            _buildContainer(),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue,
            ),
            Center(
              child: FlutterLogo(),
            )
          ],
        ),
      ),
    );
  }

  BlocBuilder _buildContainer() {
    return BlocBuilder<SplashBloc, SplashState>(
      buildWhen: (prevState, currState) {
        if (currState is LoggedState) {
          Navigator.pushNamedAndRemoveUntil(context, HOME_ROUTE, (r) => false);
        }
        return !(currState is LoggedState);
      },
      builder: (context, state) {
        if (state is NotLoggedState) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
