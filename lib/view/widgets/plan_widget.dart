import 'package:flutter/material.dart';
import 'package:test_task/view/config/theme.dart';

class PlanWidget extends StatelessWidget {
  final String name;
  final double rate;
  final double? oldRate;
  final double percentSavings;
  final double monthlyRate;
  final bool selected;
  final VoidCallback onTap;

  const PlanWidget(
      {Key? key,
      required this.selected,
      required this.onTap,
      required this.name,
      required this.rate,
      this.oldRate,
      required this.percentSavings,
      required this.monthlyRate})
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
            (oldRate != null)
                ? Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppThemes.primarySwatch,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("SAVE ${percentSavings.toStringAsFixed(2)}%",
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
                      Text(name, style: Theme.of(context).textTheme.bodyText1),
                      (oldRate != null)
                          ? const SizedBox(height: 10)
                          : const SizedBox.shrink(),
                      (oldRate != null)
                          ? Text("$oldRate€",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough))
                          : const SizedBox.shrink(),
                    ]),
                    Column(children: [
                      Text("${rate.toStringAsFixed(2)}€",
                          style: Theme.of(context).textTheme.bodyText1),
                      const SizedBox(height: 10),
                      Text('${(monthlyRate).toStringAsFixed(2)}€ / mo'),
                    ]),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
