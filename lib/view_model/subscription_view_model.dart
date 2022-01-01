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
  List<String>? _textList;

  SubscriptionViewModel() {
    loadSubscriptionPlans();
  }

  String currentText() {
    if (_textList == null) {
      return "";
    } else {
      return _textList![_current];
    }
  }

  List<SubscriptionPlan>? get plans => _plans;

  void setAnimatedTexts(List<String> textList) {
    _textList = textList;
  }

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
    if (_textList == null) {
      _current = 0;
    } else if (_current < _textList!.length - 1) {
      _current++;
    } else {
      _current = 0;
    }
    notifyListeners();
  }
}
