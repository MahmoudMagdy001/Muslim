import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:muslim/core/error/exceptions.dart';
import 'package:muslim/features/zakat/data/models/gold_price_model.dart';

abstract class ZakatRemoteDataSource {
  Future<GoldPriceModel> getGoldPriceInUsd();
  Future<double> getUsdToEgpRate();
}

class ZakatRemoteDataSourceImpl implements ZakatRemoteDataSource {
  ZakatRemoteDataSourceImpl({required this.client});

  final http.Client client;

  static const String _goldApiUrl = 'https://api.gold-api.com/price/XAU';
  static const String _exchangeApiUrl =
      'https://v6.exchangerate-api.com/v6/1ee47c1bb5322848794692ee/latest/USD';

  @override
  Future<GoldPriceModel> getGoldPriceInUsd() async {
    try {
      return await _fetchFromPrimaryApi();
    } on Object catch (e) {
      debugPrint('Primary Gold API failed: $e');
      debugPrint('Trying fallback API...');
      return _fetchFromFallbackApi();
    }
  }

  Future<GoldPriceModel> _fetchFromPrimaryApi() async {
    final response = await client
        .get(Uri.parse(_goldApiUrl))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return GoldPriceModel.fromJson(data);
    } else {
      throw const ServerException();
    }
  }

  Future<GoldPriceModel> _fetchFromFallbackApi() async {
    const fallbackUrl = 'https://data-asg.goldprice.org/dbXRates/USD';

    final response = await client
        .get(Uri.parse(fallbackUrl))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>?;
      if (items != null && items.isNotEmpty) {
        final item = items[0] as Map<String, dynamic>;
        final price = (item['xauPrice'] as num?)?.toDouble() ?? 0.0;
        return GoldPriceModel(priceInUsd: price, currency: 'USD');
      }
    }
    throw const ServerException();
  }

  @override
  Future<double> getUsdToEgpRate() async {
    try {
      final response = await client
          .get(Uri.parse(_exchangeApiUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final rates = data['conversion_rates'] as Map<String, dynamic>?;
        return (rates?['EGP'] as num?)?.toDouble() ?? 0.0;
      } else {
        throw const ServerException();
      }
    } on Object catch (e) {
      debugPrint('Error fetching exchange rate: $e');
      throw const ServerException();
    }
  }
}
