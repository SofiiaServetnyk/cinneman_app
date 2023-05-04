import 'package:cinneman/navigation/app_routes.dart';

class NavigationState {
  final List<RoutePath> _stack;

  List<RoutePath> get stack => _stack;

  NavigationState({required List<RoutePath> routePaths}) : _stack = routePaths;

  void clear() {
    _stack.removeRange(0, _stack.length - 2);
  }

  bool canPop() {
    return _stack.length > 1;
  }

  NavigationState pop() {
    if (canPop()) _stack.remove(_stack.last);
    return NavigationState(routePaths: _stack);
  }

  NavigationState pushBeneathCurrent(RoutePath routePath) {
    _stack.insert(_stack.length - 1, routePath);
    return NavigationState(routePaths: _stack);
  }

  NavigationState push(RoutePath routePath) {
    if (_stack.last != routePath) _stack.add(routePath);

    return NavigationState(routePaths: _stack);
  }

  NavigationState replace(RoutePath routePath) {
    if (canPop()) {
      _stack.removeLast();
      push(routePath);
    } else {
      _stack.insert(0, routePath);
      _stack.removeLast();
    }

    return NavigationState(routePaths: _stack);
  }

  NavigationState clearAndPush(RoutePath routePath) {
    _stack.clear();
    _stack.add(routePath);

    return NavigationState(routePaths: _stack);
  }

  NavigationState clearAndPushAll(List<RoutePath> routePaths) {
    _stack.clear();
    _stack.addAll(routePaths);

    return NavigationState(routePaths: _stack);
  }
}
