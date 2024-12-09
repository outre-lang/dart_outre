import 'dart:async';
import '../../values/exports.dart';
import '../exports.dart';

abstract class BeizeFiberNatives {
  static void bind(final BeizeNamespace namespace) {
    final BeizeMapValue value = BeizeMapValue();
    value.set(
      BeizeStringValue('wait'),
      BeizeNativeFunctionValue.async(
        (final BeizeCallableCall call) async {
          final BeizeNumberValue value = call.argumentAt(0);
          await Future<void>.delayed(
            Duration(milliseconds: value.unsafeIntValue),
          );
          return BeizeNullValue.value;
        },
      ),
    );
    value.set(
      BeizeStringValue('runConcurrently'),
      BeizeNativeFunctionValue.async(
        (final BeizeCallableCall call) async {
          final BeizeListValue fns = call.argumentAt(0);
          final List<BeizeValue> result = await Future.wait(
            fns.elements.map(
              (final BeizeValue x) async {
                BeizeValue value =
                    call.frame.callValue(x, <BeizeValue>[]).unwrapUnsafe();
                while (value is BeizeUnawaitedValue) {
                  value = await value.kExecute(call.frame).unwrapUnsafe();
                }
                return value;
              },
            ),
          );
          return BeizeListValue(result);
        },
      ),
    );
    namespace.declare('Fiber', value);
  }
}
