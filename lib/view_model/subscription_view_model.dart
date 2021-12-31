import 'package:flutter/widgets.dart';
import 'package:test_task/model/subscription_plan.dart';
import 'package:test_task/model/repository/static_subscription_plan_repo.dart';
import 'package:test_task/model/repository/subscription_plan_repo.dart';

class SubscriptionViewModel with ChangeNotifier {
  final SubscriptionPlanRepository _planRepository =
      StaticSubscriptionPlanRepository();

  SubscriptionPlan? plan;
  List<SubscriptionPlan>? _plans;

  int _current = 0;
  final _textList = [
    "Unlock Your Full Potential",
    "Let Go Of Negativity",
    "Access Your Subconsious Mind"
  ];

  String currentText() {
    return _textList[_current];
  }

  SubscriptionViewModel() {
    loadSubscriptionPlans();
  }

  List<SubscriptionPlan>? get plans => _plans;

  void loadSubscriptionPlans() async {
    _plans = await _planRepository.fetchSubscriptionPlans();
    plan = _plans?.first;
    notifyListeners();
  }

  void select(SubscriptionPlan plan) async {
    this.plan = plan;
    notifyListeners();
  }

  void nextText() async {
    if (_current < _textList.length - 1) {
      _current++;
    } else {
      _current = 0;
    }
    notifyListeners();
  }
}
