import 'package:bloc/bloc.dart';
import 'package:hacker_news/src/bloc/counter_event.dart';
import 'package:hacker_news/src/bloc/counter__state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {

  //we do all business logic in CounterBLoc

  CounterBloc() : super(CounterState(count: 0));  //initial value

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {  //incoming value event outgoing value stream
    if (event is IncrementEvent) {
      if(state.count > 9) return;
      yield (CounterState(count: state.count + 1));  //controller.sink.add
    } else if (event is DecrementEvent) {
      yield (CounterState(count: state.count - 1));
    }
  }
}
