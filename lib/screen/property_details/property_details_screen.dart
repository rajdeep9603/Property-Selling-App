import 'package:com.propacy.b2c/model/get_shortlist_data_model.dart';
import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/screen/property_details/property_details_view_model.dart';
import 'package:com.propacy.b2c/screen/property_details/widgets/widget.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_loader_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class PropertyDetailsScreen extends StatefulWidget {
  String? pId;

  // List<String>images;
  // String? title;
  // String? subCity;
  // String? city;
  // String? sellingPoint;
  // String? area;
  // String? floor;
  // String? description;

  ArrMatch? arr;
  bool? fromVideo;

  PropertyDetailsScreen({this.arr, this.pId, this.fromVideo});

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    print("PROPERTY ID ===>> " + widget.pId.toString());
    FirebaseAnalyticsService.sendAnalyticsEvent3(
        Str.cPropertyDetails, Str.load, Str.lProperty_detail_page, widget.pId);
    super.initState();
    selectedDateTime = widget.arr!.dtmSchedule;
    tabController = TabController(vsync: this, length: 3);

    tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (tabController!.indexIsChanging) {
      switch (tabController!.index) {
        case 0:
          break;
        case 1:
          break;
      }
    }
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyDetailsViewModel>.reactive(
      viewModelBuilder: () => PropertyDetailsViewModel(),
      onModelReady: (model) {
        model.init(pId: widget.pId!, arrMatch: widget.arr!);
      },
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            Get.back(
                result:
                    model.dateIsSelect ? selectedDateTime : model.shortListTap);
            return true;
          },
          child: SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: ColorRes.containerbgColor,
                  title:
                      model.isLoading ? Text("") : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 8),
                          width:Get.width-100,
                          // decoration: BoxDecoration(
                          //   border: Border.all(width: 2)
                          // ),
                          child: Text("${model.arr.title} ")),
                  centerTitle: true,
                  actions: [
                    InkWell(
                      onTap: () {
                        model.chatViewScreen();
                      },
                      child: chatIcon(),
                    ),
                  ],
                  leading: IconButton(
                    onPressed: () {
                      FirebaseAnalyticsService.sendAnalyticsEvent3(
                          Str.cPropertyDetails,
                          Str.click,
                          Str.lProperty_detail_back_button,
                          widget.pId);
                      Get.back(
                          result: model.dateIsSelect
                              ? selectedDateTime
                              : model.shortListTap);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                backgroundColor: ColorRes.containerbgColor,
                bottomNavigationBar: model.isBusy || model.isLoading
                    ? SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : widget.fromVideo == true && model.shortListTap == false
                        ? SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : model.arr.tourType == 'physicaltour'
                            ? visitScheduled(model, context,
                                () => model.onEditBtnTap(context))
                            : bottemBarNew(
                                model,
                                context,
                                model.arr.dtmSchedule,
                                () => model.onDateSelect(context,widget.pId),
                                widget.pId),
                body: model.isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          commonLoader(),
                        ],
                      )
                    : NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverToBoxAdapter(
                              child: model.arr.images!.length != 0
                                  ? imageSlider(
                                      model.arr.images!
                                          .map((e) => e.link)
                                          .toList(),
                                      model.arr.images!
                                          .map((e) => e.link)
                                          .toList())
                                  : Container(
                                      height: 200,
                                      padding: EdgeInsets.only(
                                        top: 15,
                                      ),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        "assets/image/foryouImage.png",
                                        width: double.infinity,
                                        color: ColorRes.raioContainer,
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            SliverToBoxAdapter(
                              child: endPartPropertyDetails(
                                //isShortListed: isShortListed,
                                showShortList: (widget.fromVideo == true &&
                                    model.shortListTap == false),
                                dateTime: model.arr.dtmSchedule,
                                bedroom: model.arr.bedroom,
                                area: model.arr.area.toString(),
                                city: model.arr.city,
                                sellingPoint: model.arr.sellingPoint,
                                subCity: model.arr.subCity,
                                title: model.arr.title,
                                floor: model.arr.floor,
                                description: model.arr.description,
                                model: model,
                                onShortListChange: () {
                                  /*model.setBusy(true);
                                  model.notifyListeners();*/
                                  model.shortListTap = true;
                                  model.notifyListeners();
                                  model.onShortlistCalled(
                                    status: 'A',
                                    command: 'shortlist',
                                    date: DateTime.now().toIso8601String(),
                                  );
                                  //model.shortListTap = true;
                                  /*model.setBusy(false);
                                  model.notifyListeners();*/
                                },
                              ),
                            ),
                            /*SliverToBoxAdapter(
                              child: model.isVisitScheduled
                                  ? visitScheduled(model, context,
                                      () => model.onEditBtnTap(context))
                                  : Container(),
                            ),*/
                            // SliverToBoxAdapter(
                            //   child: model.arr.dtmSchedule != null
                            //       ? visitScheduled(model,context)
                            //       : Container(
                            //     child: Text("date is coming here now"),
                            //   )
                            // ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: 10.0,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: new TabBar(
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: ColorRes.raioContainer,
                                  border: Border.all(
                                    width: 2.0,
                                    color: ColorRes.grey,
                                  ),
                                ),
                                tabs: [
                                  tabBar(model.tabbarList[0].toString()),
                                  tabBar("Amenities(" +
                                      model.arr.amenities!.length.toString() +
                                      ")"),
                                  tabBar("Nearby(" +
                                      model.arr.nearByAmenities!.length
                                          .toString() +
                                      ")"),
                                ], // <-- total of 2 tabs
                              ),
                            ),
                          ];
                        },
                        body: Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Stack(
                            children: [
                              TabBarView(
                                children: <Widget>[
                                  Container(
                                    child: listViewBuilder(
                                        model: model,
                                        nearByAmenities: model.details,
                                        valueList: model.tabbarListSubtitle),
                                  ),
                                  Container(
                                    child: listViewBuilder(
                                      model: model,
                                      nearByAmenities: model.arr.amenities,
                                      type: "Amenities",
                                    ),
                                  ),
                                  Container(
                                    child: listViewBuilder(
                                        model: model,
                                        nearByAmenities:
                                            model.arr.nearByAmenities,
                                        type: "nearby"),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 0,
                                  width: Get.width,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
