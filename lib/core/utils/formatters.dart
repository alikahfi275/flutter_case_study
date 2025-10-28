import 'package:intl/intl.dart';

String formatRupiah(double number) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(number);
}

String formatRupiahWithDecimal(double number) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 2,
  );
  return formatter.format(number);
}
