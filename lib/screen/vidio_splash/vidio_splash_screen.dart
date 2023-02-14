import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/screen/vidio_splash/vidio_splash_view_model.dart';
import 'package:com.propacy.b2c/screen/vidio_splash/widgets/bottemBar.dart';
import 'package:com.propacy.b2c/screen/vidio_splash/widgets/explore_tab.dart';
import 'package:com.propacy.b2c/screen/vidio_splash/widgets/for_you_tab.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VidioSplashScreen extends StatefulWidget {
  PostPreferenceModel postPreferenceModelData;

  VidioSplashScreen({required this.postPreferenceModelData});

  @override
  _VidioSplashScreenState createState() => _VidioSplashScreenState();
}

class _VidioSplashScreenState extends State<VidioSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VidioSplashViewModel>.reactive(
        viewModelBuilder: () => VidioSplashViewModel(),
        onModelReady: (model) {
          model.init();
        },
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: bottemBar(),
              body: model.selectedTab == AppRes.explore
                  ? exploreTabScreen(model, widget.postPreferenceModelData)
                  : forYouTab(model, widget.postPreferenceModelData, context),
            ),
          );
        });
  }
}
