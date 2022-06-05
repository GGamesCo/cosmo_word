import 'package:flutter/material.dart';

class BalanceIndication extends StatelessWidget{
  
  final int coinsAmount;

  final TextStyle _coinsAmountTextStyle = TextStyle(
    color: Color.fromRGBO(35, 97, 114, 1),
    fontSize: 16,
    fontFamily: 'Roboto',
  );

  BalanceIndication({required this.coinsAmount});
  
  @override
  Widget build(BuildContext context){
    return Container(
      child: Stack(
        children: [
          Image.asset('assets/images/common_controls/balanceIndication.png'),
          Positioned(
            left: 40,
            top: 12,
            child: Text(
              coinsAmount.toString(),
              style: _coinsAmountTextStyle,
            )
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
}