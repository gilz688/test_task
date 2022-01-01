import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/view/widgets/base_container.dart';
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

    // Set the 3 Animated
    provider.setAnimatedTexts([
      tr('text1'),
      tr('text2'),
      tr('text3'),
    ]);

    var currentText = provider.currentText();
    var selectedItem = provider.plan;
    var list = provider.plans;
    list ??= [];
    var subscribeLabel = (selectedItem != null)
        ? "GET ${selectedItem.name.toUpperCase()} PLAN"
        : "GET PLAN";
    VoidCallback? subscribeAction = (selectedItem != null) ? () {} : null;

    return BaseContainer(
      title: tr('subscription_screen_title'),
      child: Stack(children: [
        // Background Image
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
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              tr('text4'),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 20),
            // List of Available Subscription Plans
            Expanded(
                child: ListView.builder(
              // Let the ListView know how many items it needs to build.
              itemCount: list.length,
              // Provide a builder function. This is where the magic happens.
              // Convert each item into a widget based on the type of item it is.
              itemBuilder: (context, index) {
                final item = list![index];
                return PlanWidget(
                  selected: selectedItem == item,
                  onTap: () {
                    Provider.of<SubscriptionViewModel>(context, listen: false)
                        .select(item);
                  },
                  name: item.name,
                  rate: item.rate,
                  oldRate: item.oldRate,
                  percentSavings: item.percentSavings(),
                  monthlyRate: item.monthlyRate(),
                );
              },
            )),
            // Subscribe Button
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
            // Links Section
            const _Footer(),
          ],
        )
      ]),
    );
  }
}

class _Footer extends StatelessWidget {
  static const String contactUrl = 'https://www.gilz688.tech/';
  static const String faqUrl =
      'https://help.twitter.com/en/resources/new-user-faq';
  static const String disclaimerUrl = 'https://twitter.com/en/tos';

  static const TextStyle linkTextStyle =
      TextStyle(decoration: TextDecoration.underline);

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              _launchURL(contactUrl);
            },
            child: Text(tr('contact_btn_label'), style: linkTextStyle)),
        TextButton(
            onPressed: () {
              _launchURL(faqUrl);
            },
            child: Text(tr('faq_btn_label'), style: linkTextStyle)),
        TextButton(
            onPressed: () {
              _launchURL(disclaimerUrl);
            },
            child: Text(tr('disclaimer_btn_label'), style: linkTextStyle)),
      ],
    );
  }
}
