import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/src/core/utils/error/failures.dart';

import '../debouncer.dart';

part 'generic_bloc_event.dart';

part 'generic_bloc_state.dart';

///Simple class aimed to provide mutual logic for simple blocs that ///only do async resource fetching
abstract class SimpleLoaderBloc<T>
    extends Bloc<SimpleBlocEvent, SimpleBlocState> {
  late final ScrollController scrollController;
  SimpleLoaderBloc({required this.eventParams}) : super(InitialState()) {
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }
  final eventParams;

  final _debouncer = Debouncer(milliseconds: 350);

  void _onScroll() {
    _debouncer.run(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= 50) {
        add(LoadMoreEvent(eventParams));
      }
    });
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  @override
  Stream<SimpleBlocState> mapEventToState(
    SimpleBlocEvent event,
  ) async* {
    if (event is LoadEvent) {
      yield LoadingState();

      final result = await load(event);
      yield result.fold((l) {
        return ErrorState(l.errorMessage);
      }, (r) {
        return SuccessState<T>(r, isListReachedMax<T>(r));
      });
    } else if (event is LoadMoreEvent &&
        (state is SuccessState && !(state as SuccessState).hasReachedMax)) {
      final result = await load(event);
      yield result.fold((l) {
        return SuccessState<T>((state as SuccessState).items,
            false); // if error happen don't block the screen with the error
      }, (r) {
        return SuccessState<T>(
            (state as SuccessState).items + r, isListReachedMax<T>(r));
      });
    }
  }

  Future<Either<Failure, T>> load(SimpleBlocEvent event);
}

bool isListReachedMax<T>(T list) {
  return (list is List) && (list.isEmpty || list.length < 10);
}
