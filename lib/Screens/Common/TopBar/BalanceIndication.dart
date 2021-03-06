import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/material.dart';
import 'package:event/event.dart';

class BalanceIndication extends StatefulWidget{

  late int coinsAmount = 0;

  BalanceIndication();

  @override
  State<BalanceIndication> createState() => _BalanceIndicationState();
}

class _BalanceIndicationState extends State<BalanceIndication> {
  void initState(){
    super.initState();
    getIt.get<IBalanceController>().balanceUpdatedEvent.subscribe(updateBalance);
  }


  final TextStyle _coinsAmountTextStyle = TextStyle(
    color: Color.fromRGBO(35, 97, 114, 1),
    fontSize: 16,
    fontFamily: 'Roboto',
  );

  @override
  Widget build(BuildContext context){
    return Container(
      child: Stack(
        children: [
          Image.asset('assets/images/common_controls/balanceIndication.png'),
          Positioned(
            left: 40,
            top: 12,
            child:
            FutureBuilder(
                future: getBalanceAsync(),
                builder: (context, AsyncSnapshot<int> snapshot) {

              return Text(widget.coinsAmount.toString(),
              style: _coinsAmountTextStyle);
            })

          ),
          Positioned(
              right: 5,
              top: 5,
              child: SizedBox(
                height: 40,
                child: GestureDetector(
                  onTap: () => {},
                  child: Image.asset('assets/images/common_controls/balance-open-store.png')
                )
              )
          )
        ],
      ),
    );
  }

  Future<int> getBalanceAsync() async{
    var balance = await getIt.get<IBalanceController>().getBalanceAsync();
    setState(() {widget.coinsAmount = balance;});
    return balance;
  }

  void updateBalance(Value<int>? args){
    if (!mounted){
      print("BalanceIndication umounted!");
      return;
    }


    setState(() {
      widget.coinsAmount = args!.value;
      });
  }

  void dispose(){
    super.dispose();
    getIt.get<IBalanceController>().balanceUpdatedEvent.unsubscribe(updateBalance);
    print("BalanceIndication disposed.");
  }
}