import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/error/exceptions.dart';

abstract class ZakatRemoteDataSource {
  Future<double> getGoldPriceInUsd();
  Future<double> getUsdToEgpRate();
}

class ZakatRemoteDataSourceImpl implements ZakatRemoteDataSource {
  ZakatRemoteDataSourceImpl({required this.client});

  final http.Client client;

  static const String _goldApiUrl = 'https://api.gold-api.com/price/XAU';
  static const String _exchangeApiUrl =
      'https://v6.exchangerate-api.com/v6/1ee47c1bb5322848794692ee/latest/USD';

  @override
  Future<double> getGoldPriceInUsd() async {
    try {
      return await _fetchFromPrimaryApi();
    } catch (e) {
      debugPrint('Primary Gold API failed: $e');
      debugPrint('Trying fallback API...');
      return await _fetchFromFallbackApi();
    }
  }

  Future<double> _fetchFromPrimaryApi() async {
    final response = await client
        .get(Uri.parse(_goldApiUrl))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return (data['price'] as num?)?.toDouble() ?? 0.0;
    } else {
      throw const ServerException();
    }
  }

  Future<double> _fetchFromFallbackApi() async {
    // Fallback API: https://data-asg.goldprice.org/dbXRates/USD
    const fallbackUrl = 'https://data-asg.goldprice.org/dbXRates/USD';

    final response = await client
        .get(Uri.parse(fallbackUrl))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>?;
      if (items != null && items.isNotEmpty) {
        final item = items[0] as Map<String, dynamic>;
        return (item['xauPrice'] as num?)?.toDouble() ?? 0.0;
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
    } catch (e) {
      debugPrint('Error fetching exchange rate: $e');
      throw const ServerException();
    }
  }
}
