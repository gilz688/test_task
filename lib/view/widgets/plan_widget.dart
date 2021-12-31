import 'package:flutter/material.dart';
import 'package:test_task/model/subscription_plan.dart';
import 'package:test_task/view/config/theme.dart';

class PlanWidget extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool selected;
  final VoidCallback onTap;

  const PlanWidget(
      {Key? key,
      required this.plan,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: AppThemes.primarySwatch, width: (selected ? 2 : 0)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      color: Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => {onTap()},
        child: Column(
          children: [
            (plan.oldRate != null)
                ? Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppThemes.primarySwatch,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          "SAVE ${plan.percentSavings().toStringAsFixed(2)}%",
                          style: TextStyle(
                              color: Theme.of(context).bottomAppBarColor)),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Text(plan.name,
                          style: Theme.of(context).textTheme.bodyText1),
                      (plan.oldRate != null)
                          ? const SizedBox(height: 10)
                          : const SizedBox.shrink(),
                      (plan.oldRate != null)
                          ? Text("${plan.oldRate}€",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough))
                          : const SizedBox.shrink(),
                    ]),
                    Column(children: [
                      Text("${plan.rate.toStringAsFixed(2)}€",
                          style: Theme.of(context).textTheme.bodyText1),
                      const SizedBox(height: 10),
                      Text('${(plan.monthlyRate()).toStringAsFixed(2)}€ / mo'),
                    ]),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
