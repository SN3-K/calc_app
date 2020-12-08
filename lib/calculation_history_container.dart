
import 'package:calc_app/calculation_model.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class CalculationHistoryContainer extends StatelessWidget{
  CalculationHistoryContainer({
    @required this.calculations
  });

  final List<CalculationModel> calculations;

  @override
  Widget build(BuildContext context) {
    return Container(

        height: 100,
        //width: 300,
        //margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
        decoration: BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  color: Colors.black12
              )
            ]
        ),
        child: ListView(
          padding: EdgeInsets.all(12),

          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                    'Recent History',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.orangeAccent[200],fontWeight: FontWeight.bold),


            )),

            for (var model in calculations)
              Text(
                  '${model.firstOperand} ${model.operator} ${model.secondOperand} = ${model.result}',
                  textAlign: TextAlign.center
              )
          ],
        )
    );
  }
}
