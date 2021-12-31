import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/view/widgets/plan_widget.dart';
import 'package:provider/provider.dart';
import 'package:test_task/view_model/subscription_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SubscriptionScreen> createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<SubscriptionScreen> {
  static const String contactUrl = 'https://www.gilz688.tech/';
  static const String faqUrl = 'https://help.twitter.com/en';
  static const String disclaimerUrl =
      'https://help.twitter.com/en/resources/new-user-faq';

  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    const oneSec = Duration(seconds: 2);
    _timer = Timer.periodic(oneSec, (Timer t) {
      Provider.of<SubscriptionViewModel>(context, listen: false).nextText();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SubscriptionViewModel>(context);
    var currentText = provider.currentText();
    var selectedItem = provider.plan;
    var list = provider.plans;
    list ??= [];
    var subscribeLabel = (selectedItem != null)
        ? "GET ${selectedItem.name.toUpperCase()} PLAN"
        : "GET PLAN";
    VoidCallback? subscribeAction = (selectedItem != null) ? () {} : null;

    return Material(
        color: Theme.of(context).backgroundColor,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            leading: const IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: null),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
            )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Stack(children: [
                SvgPicture.asset(
                  'assets/background/subscription_bg.svg',
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        currentText,
                        key: ValueKey<String>(currentText),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'And Free Your Life',
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                        child: ListView.builder(
                      // Let the ListView know how many items it needs to build.
                      itemCount: list.length,
                      // Provide a builder function. This is where the magic happens.
                      // Convert each item into a widget based on the type of item it is.
                      itemBuilder: (context, index) {
                        final item = list![index];
                        return PlanWidget(
                            plan: item,
                            selected: selectedItem == item,
                            onTap: () {
                              Provider.of<SubscriptionViewModel>(context,
                                      listen: false)
                                  .select(item);
                            });
                      },
                    )),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: subscribeAction,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(subscribeLabel),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              _launchURL(contactUrl);
                            },
                            child: const Text('CONTACT US',
                                style: TextStyle(
                                    decoration: TextDecoration.underline))),
                        TextButton(
                            onPressed: () {
                              _launchURL(faqUrl);
                            },
                            child: const Text('FAQ',
                                style: TextStyle(
                                    decoration: TextDecoration.underline))),
                        TextButton(
                            onPressed: () {
                              _launchURL(disclaimerUrl);
                            },
                            child: const Text('DISCLAIMER',
                                style: TextStyle(
                                    decoration: TextDecoration.underline))),
                      ],
                    ),
                  ],
                )
              ]),
            ),
          ),
        ));
  }

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
