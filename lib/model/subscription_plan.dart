class SubscriptionPlan {
  String name;
  double rate;
  double? oldRate;
  int periodInMonths;

  SubscriptionPlan(this.name, this.rate, this.periodInMonths, [this.oldRate]);

  double percentSavings() {
    oldRate ??= rate;
    return (oldRate! - rate) * 100 / oldRate!;
  }

  double monthlyRate() {
    return rate / periodInMonths;
  }
}
