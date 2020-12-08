import 'package:calc_app/calculation_history_container.dart';
import 'package:calc_app/calculation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/calculation_bloc.dart';
import 'calculator_button.dart';
import 'custom_button.dart';
import 'result_display.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  double width;

  @override
  void initState() {
    context.read<CalculationBloc>().add(FetchHistory());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculationBloc, CalculationState>(
      builder: (context, CalculationState state) {
        return Column(
          children: [
            ResultDisplay(
              text: _getDisplayText(state.calculationModel),
            ),

            CalculationHistoryContainer(
                calculations: state.history.reversed.toList()
            ),
            Spacer(),
            _getButtonCustomWide(text:"Clear History",onTap:clearHistory,backgroundColor: Colors.yellow[200] ),
            Row(
              children: [
                _getButton(text: '7', onTap: () => numberPressed(7)),
                _getButton(text: '8', onTap: () => numberPressed(8)),
                _getButton(text: '9', onTap: () => numberPressed(9)),
                _getButton(text: 'x', onTap: () => operatorPressed('*'), backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
              ],
            ),
            Row(
              children: [
                _getButton(text: '4', onTap: () => numberPressed(4)),
                _getButton(text: '5', onTap: () => numberPressed(5)),
                _getButton(text: '6', onTap: () => numberPressed(6)),
                _getButton(text: '/', onTap: () => operatorPressed('/'), backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
              ],
            ),
            Row(
              children: [
                _getButton(text: '1', onTap: () => numberPressed(1)),
                _getButton(text: '2', onTap: () => numberPressed(2)),
                _getButton(text: '3', onTap: () => numberPressed(3)),
                _getButton(text: '+', onTap: () => operatorPressed('+'), backgroundColor: Color.fromRGBO(220, 220, 220, 1))
              ],
            ),
            Row(
              children: [
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  _getButton(text: 'C', onTap: clear, backgroundColor: Colors.amber[800]),
                  _getButton(text: '0', onTap: () => numberPressed(0)),
                  _getButton(text: '-', onTap: () => operatorPressed('-')),
                  _getButton(text: '=', onTap: calculateResult,backgroundColor: Colors.amber[800])
                ],
              ),

              ],
            ),
            //Spacer(),
            //_getButtonCustomWide(text:'Get Results', onTap: calculateResult, backgroundColor: Colors.amber[300],height:100)

            //Spacer(),

          ],
        );
      },
    );
  }

  Widget _getButton({String text, Function onTap, Color backgroundColor = Colors.white, Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }
  Widget _getButtonCustom({String text, Function onTap, Color backgroundColor = Colors.white, Color textColor = Colors.black, double height}) {
    return CustomButton(
      label: text,
      onTap: onTap,
      height: height,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }
  Widget _getButtonCustomWide({String text, Function onTap, Color backgroundColor = Colors.white, Color textColor = Colors.black, double height}) {
    return CustomButton(
      label: text,
      onTap: onTap,
      height: height,
      size: width,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  numberPressed(int number) {
    context.read<CalculationBloc>().add(NumberPressed(number: number));
  }

  operatorPressed(String operator) {
    context.read<CalculationBloc>().add(OperatorPressed(operator: operator));
  }

  calculateResult() {
    context.read<CalculationBloc>().add(CalculateResult());
  }

  clear() {
    context.read<CalculationBloc>().add(ClearCalculation());
  }
  clearHistory() {
    context.read<CalculationBloc>().add(ClearHistory());
  }

  String _getDisplayText(CalculationModel model) {
    if (model.result != null) {
      return '${model.result}';
    }

    if (model.secondOperand != null) {
      return '${model.firstOperand}${model.operator}${model.secondOperand}';
    }

    if (model.operator != null) {
      return '${model.firstOperand}${model.operator}';
    }

    if (model.firstOperand != null) {
      return '${model.firstOperand}';
    }

    return "${model.result ?? 0}";
  }

}