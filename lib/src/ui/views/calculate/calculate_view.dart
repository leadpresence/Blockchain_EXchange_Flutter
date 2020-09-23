import 'package:flutter/material.dart';
import '../../../app/generated/locator/locator.dart';
import 'calculate_view_model.dart';

import 'package:stacked/stacked.dart';

class CalculateCurrencyScreen extends StatefulWidget {
  @override
  _CalculateCurrencyScreenState createState() =>
      _CalculateCurrencyScreenState();
}

class _CalculateCurrencyScreenState extends State<CalculateCurrencyScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalculateScreenViewModel>.reactive(
      viewModelBuilder: () => CalculateScreenViewModel(),
      onModelReady: (CalculateScreenViewModel model) async {
        model.initialize();
      },
      builder: (BuildContext context, CalculateScreenViewModel model, child) =>
          Scaffold(
        appBar: AppBar(
          title: Text('kanyimaX'),
          actions: <Widget>[
            IconButton(
              icon: Text("💹", style: TextStyle(fontSize: 22)),
              onPressed: () async {
                await model.navigateToHomeView();
                model.refreshFavorites();
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            baseCurrencyTitle(model),
            baseCurrencyTextField(model),
            quoteCurrencyList(model),
          ],
        ),
      ),
    );
  }

  Padding baseCurrencyTitle(CalculateScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 32, right: 32, bottom: 5),
      child: Text(
        '${model.baseCurrency.longName}',
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Padding baseCurrencyTextField(CalculateScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextField(
          style: TextStyle(fontSize: 20),
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                width: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${model.baseCurrency.flag}',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            labelStyle: TextStyle(fontSize: 20),
            hintStyle: TextStyle(fontSize: 20),
            hintText: 'Amount to exchange',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(20),
          ),
          keyboardType: TextInputType.number,
          onChanged: (text) {
            model.calculateExchange(text);
          },
        ),
      ),
    );
  }

  Expanded quoteCurrencyList(CalculateScreenViewModel model) {
    return Expanded(
      child: ListView.builder(
        itemCount: model.quoteCurrencies.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: SizedBox(
                width: 60,
                child: Text(
                  '${model.quoteCurrencies[index].flag}',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              title: Text(model.quoteCurrencies[index].longName),
              subtitle: Text(model.quoteCurrencies[index].amount),
              onTap: () {
                model.setNewBaseCurrency(index);
                _controller.clear();
              },
            ),
          );
        },
      ),
    );
  }
}
