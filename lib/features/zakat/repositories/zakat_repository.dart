import '../services/zakat_service.dart';

class ZakatRepository {
  ZakatRepository({ZakatService? service})
    : _service = service ?? ZakatService();
  final ZakatService _service;

  Future<double> getGoldPricePerGramInEgp() async {
    try {
      // Fetch both prices concurrently for better performance
      final results = await Future.wait([
        _service.getGoldPriceInUsd(),
        _service.getUsdToEgpRate(),
      ]);

      final pricePerOunceUsd = results[0];
      final usdToEgp = results[1];

      // Convert Ounce to Gram (1 Ounce ≈ 31.1035 Grams)
      const ounceToGram = 31.1035;
      final pricePerGramUsd = pricePerOunceUsd / ounceToGram;

      final pricePerGramEgp = pricePerGramUsd * usdToEgp;

      return pricePerGramEgp;
    } catch (e) {
      // In a real app, we might map exceptions to failure objects here
      rethrow;
    }
  }
}
