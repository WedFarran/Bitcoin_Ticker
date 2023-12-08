import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcToCurrency = '';
  CoinData coinData = CoinData();
  List<Widget> currencyExchangeRateWidgets = [];

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownMenuItem = [];
    for (var i in currenciesList) {
      dropdownMenuItem.add(DropdownMenuItem(
        value: i,
        child: Text(i),
      ));
    }
    return dropdownMenuItem;
  }

  List<Widget> getPickerItems() {
    List<Text> z = [];
    for (String currency in currenciesList) {
      z.add(Text(currency));
    }
    return z;
  }

  @override
  void initState() {
    getCurrencyWidgets();
    super.initState();
  }

  Future<List<String>> getCurrency() async {
    List<String> rates = [];
    for (var i = 0; i < 3; i++) {
      var rate = await coinData.getCoinData('USD', "BTC");
      setState(() {
        rates.add(rate);
      });
    }
    return rates;
  }

  Future<List<Widget>> getCurrencyWidgets() async {
    currencyExchangeRateWidgets = [];
    List<Widget> x = [];
    for (String crypto in cryptoList) {
      x.add(Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
            child: Text(
              '1 ${cryptoList[cryptoList.indexOf(crypto)]} = ${await coinData.getCoinData(selectedCurrency, crypto)} $selectedCurrency',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));
    }
    setState(() {
      currencyExchangeRateWidgets = x;
    });
    return currencyExchangeRateWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: currencyExchangeRateWidgets,
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: getDropdownItems(),
              onChanged: (value) async {
                getCurrencyWidgets();
                setState(() {
                  selectedCurrency = value!;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}


/*CupertinoPicker(backgroundColor:Colors.lightBlue,itemExtent:currenciesList.length,onSelectedItemChanged:(selectedIndex){},children:getPickerItems())*/