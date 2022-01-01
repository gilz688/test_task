import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_task/view/widgets/base_container.dart';
import 'package:test_task/view/widgets/hyperlink.dart';
import 'package:test_task/view/widgets/plan_widget.dart';
import 'package:provider/provider.dart';
import 'package:test_task/view_model/subscription_view_model.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SubscriptionScreen> createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<SubscriptionScreen> {
  static const String contactUrl = 'https://www.gilz688.tech/';
  static const String faqUrl =
      'https://help.twitter.com/en/resources/new-user-faq';
  static const String disclaimerUrl = 'https://twitter.com/en/tos';

  late Timer _timer;
  bool german = false;

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

    return BaseContainer(
      title: tr('subscription_screen_title'),
      child: Column(
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
          ElevatedButton(
              onPressed: (selectedItem != null)
                  ? () {
                      german = !german;
                      if (german) {
                        context.setLocale(const Locale('de'));
                      } else {
                        context.setLocale(const Locale('en'));
                      }
                    }
                  : null,
              child: Text((selectedItem != null)
                  ? tr('subscribe_btn_label',
                      args: [tr(selectedItem.name + '_plan')]).toUpperCase()
                  : tr('subscribe_btn_label', args: ["Plan"]).toUpperCase())),
          // Links Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hyperlink(url: contactUrl, label: tr('contact_btn_label')),
              Hyperlink(url: faqUrl, label: tr('faq_btn_label')),
              Hyperlink(url: disclaimerUrl, label: tr('disclaimer_btn_label')),
            ],
          )
        ],
      ),
    );
  }
}
