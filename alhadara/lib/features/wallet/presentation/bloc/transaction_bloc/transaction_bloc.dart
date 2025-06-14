import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alhadara/features/wallet/domain/entities/transaction_entity.dart';
import 'package:alhadara/features/wallet/domain/usecases/get_transactions.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;

  TransactionBloc({required this.getTransactions}) : super(TransactionInitial()) {
    on<LoadTransactionsEvent>(_onLoadTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = await getTransactions();
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}