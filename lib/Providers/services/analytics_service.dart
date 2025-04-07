import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalytics getAnalytics() => _analytics;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future logEvent(String name, Map<String, Object>? parameters) async =>
      await _analytics.logEvent(name: name, parameters: parameters);

  Future setUserId(String? userId, AnalyticsCallOptions? callOptions) async =>
      await _analytics.setUserId(id: userId, callOptions: callOptions);

  Future logScreenView(
    String? screenClass,
    String? screenName,
    Map<String, Object>? parameters, {
    AnalyticsCallOptions? callOptions,
  }) async =>
      await _analytics.logScreenView(
          screenClass: screenClass,
          screenName: screenName,
          parameters: parameters,
          callOptions: callOptions);

  Future setUserProperty(String name, String? value) async =>
      await _analytics.setUserProperty(name: name, value: value);

  Future logSelectItem({
    String? itemListId,
    String? itemListName,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async =>
      await _analytics.logSelectItem(
        itemListId: itemListId,
        itemListName: itemListName,
        items: items,
        parameters: parameters,
        callOptions: callOptions,
      );
}
