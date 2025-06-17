import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/usecases/get_wallet.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWallet getWallet;

  WalletBloc({required this.getWallet}) : super(WalletInitial()) {
    on<LoadWalletEvent>(_onLoadWallet);
  }

  FutureOr<void> _onLoadWallet(
    LoadWalletEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    try {
      final wallet = await getWallet();
      // Mock transactions - replace with actual API call if available
      final transactions = [
        {
          'title': 'Paid for course to Uber',
          'amount': '-7323',
          'date': '21/06/2020',
        },
        {
          'title': 'Paid for course Booking',
          'amount': '-75232',
          'date': '21/06/2020',
        },
      ];
      emit(WalletLoaded(
        balance: wallet.currentBalance,
        transactions: transactions,
      ));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }
}