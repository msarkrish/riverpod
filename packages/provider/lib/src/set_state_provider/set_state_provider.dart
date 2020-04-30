import 'dart:collection';

import '../combiner.dart';
import '../common.dart';
import '../framework/framework.dart';

part 'base.dart';

// This files contains the interfaces for all the variants of Provider.
// This is the public API.

/* Value */

class SetStateProviderValue<T> extends BaseProviderValue {
  SetStateProviderValue._(this._providerState);

  final BaseProviderState<SetStateProviderValue<T>, T,
      BaseProvider<SetStateProviderValue<T>, T>> _providerState;
  final _removeListeners = DoubleLinkedQueue<VoidCallback>();

  void watch(void Function(T) listener) {
    _removeListeners.add(_providerState.$addStateListener(listener));
  }

  @override
  void dispose() {
    for (final listener in _removeListeners) {
      listener();
    }
  }
}

class SetStateProviderState<T> extends ProviderState {
  SetStateProviderState._(this._providerState) : super(_providerState);

  final BaseProviderState<SetStateProviderValue<T>, T,
      BaseProvider<SetStateProviderValue<T>, T>> _providerState;

  T get state => _providerState.$state;
  set state(T state) => _providerState.$state = state;
}

/* Providers */

// abstract class SetStateProvider<T>
//     extends BaseProvider<SetStateProviderValue<T>, T> {
//   factory SetStateProvider(Create<T, SetStateProviderState<T>> create) =
//       _SetStateProvider<T>;
// }

class SetStateProvider<T> extends BaseProvider<SetStateProviderValue<T>, T> {
  SetStateProvider(this._create);

  final Create<T, SetStateProviderState<T>> _create;

  @override
  _SetStateProviderState<T> createState() {
    return _SetStateProviderState<T>();
  }
}

/* Builder */

mixin _Noop {}

class SetStateProviderBuilder<Res> = Combiner<Res, SetStateProvider> with _Noop;

extension SetStateProviderBuilder1X<First extends BaseProviderValue, T>
    on Combiner1<First, T, SetStateProvider> {
  SetStateProvider<T> build(Create1<First, T, SetStateProviderState<T>> cb) {
    return _SetStateProvider1(first, cb);
  }
}
