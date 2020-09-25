import 'dart:async';

import 'package:kanyimax/src/app/models/currency_ticker.model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:kanyimax/src/ui/widgets/dumb/skeleton.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.initialize();
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget child,
      ) {
        Timer.periodic(
          Duration(
            seconds: 1,
          ),
          (Timer timer) async {
            await model.getTickerData();
          },
        );

        _buildBlockchainTile(String flag, CurrencyTicker currencyTicker) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  shadowColor: Colors.grey[400],
                  child: ListTile(
                    leading: Text(
                      flag,
                      style: TextStyle(fontSize: 15),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Buy Price: " + currencyTicker.buyPrice.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Sell Price: " + currencyTicker.buyPrice.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Delay: " + currencyTicker.delay.toString(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Recent: " +
                                currencyTicker.recentMarketPprice.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return Skeleton(
          isBusy: model.isBusy,
          appBarTitle: 'Kanyimax',
          appBarActions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.syncAlt,
              ),
              onPressed: model.isBusy
                  ? null
                  : () async {
                      model.setBusy(true);
                      //make request to refresh rates on Api
                      await model.getTickerData();
                      model.setBusy(false);
                    },
            ),
            IconButton(
              icon: Text(
                "💱",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: model.isBusy
                  ? null
                  : () async {
                      await model.navigateToCalculateView();
                    },
            ),
          ],
          body: model.blockchainTicker == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: <Widget>[
                    _buildBlockchainTile(
                      "🇺🇸",
                      model.blockchainTicker.usd,
                    ),
                    _buildBlockchainTile(
                      "🇦🇺",
                      model.blockchainTicker.aud,
                    ),
                    _buildBlockchainTile(
                      "🇧🇷",
                      model.blockchainTicker.brl,
                    ),
                    _buildBlockchainTile(
                      "🇨🇦",
                      model.blockchainTicker.cad,
                    ),
                    _buildBlockchainTile(
                      "🇨🇭",
                      model.blockchainTicker.chf,
                    ),
                    _buildBlockchainTile(
                      "🇨🇱",
                      model.blockchainTicker.clp,
                    ),
                    _buildBlockchainTile(
                      "🇨🇳",
                      model.blockchainTicker.cny,
                    ),
                    _buildBlockchainTile(
                      "🇩🇰",
                      model.blockchainTicker.dkk,
                    ),
                    _buildBlockchainTile(
                      "🇪🇺",
                      model.blockchainTicker.eur,
                    ),
                    _buildBlockchainTile(
                      "🇬🇧",
                      model.blockchainTicker.gbp,
                    ),
                    _buildBlockchainTile(
                      "🇭🇰",
                      model.blockchainTicker.hkd,
                    ),
                    _buildBlockchainTile(
                      "🇮🇳",
                      model.blockchainTicker.inr,
                    ),
                    _buildBlockchainTile(
                      "🇮🇸",
                      model.blockchainTicker.isk,
                    ),
                    _buildBlockchainTile(
                      "🇯🇵",
                      model.blockchainTicker.jpy,
                    ),
                    _buildBlockchainTile(
                      "🇰🇷",
                      model.blockchainTicker.krw,
                    ),
                    _buildBlockchainTile(
                      "🇳🇿",
                      model.blockchainTicker.nzd,
                    ),
                    _buildBlockchainTile(
                      "🇵🇱",
                      model.blockchainTicker.pln,
                    ),
                    _buildBlockchainTile(
                      "🇷🇺",
                      model.blockchainTicker.rub,
                    ),
                    _buildBlockchainTile(
                      "🇸🇪",
                      model.blockchainTicker.sek,
                    ),
                    _buildBlockchainTile(
                      "🇸🇬",
                      model.blockchainTicker.sgd,
                    ),
                    _buildBlockchainTile(
                      "🇹🇭",
                      model.blockchainTicker.thb,
                    ),
                    _buildBlockchainTile(
                      "🇹🇷",
                      model.blockchainTicker.kTry,
                    ),
                    _buildBlockchainTile(
                      "🇹🇼",
                      model.blockchainTicker.twd,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
