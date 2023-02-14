import 'package:com.propacy.b2c/screen/property_details/widgets/widget.dart';
import 'package:com.propacy.b2c/screen/schedule_home/schedule_view_model.dart';
import 'package:com.propacy.b2c/screen/schedule_home/widgets/widgets.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class ScheduleHomeScreen extends StatefulWidget {
  @override
  _ScheduleHomeScreenState createState() => _ScheduleHomeScreenState();
}

class _ScheduleHomeScreenState extends State<ScheduleHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScheduleViewModel>.reactive(
        onModelReady: (model) {
          model.init();
        },
        viewModelBuilder: () => ScheduleViewModel(),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorRes.black,
              bottomNavigationBar: bottembarSchedule(model),
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    appBarSchedule(),
                    Divider(
                      color: ColorRes.raioContainer,
                      thickness: 2,
                    ),
                    middlePartSchedule(),
                    Divider(
                      color: ColorRes.raioContainer,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // listViewTabbarSchedule(model),
                    // SizedBox(height: 10,),
                    // listViewBuilder(model),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
