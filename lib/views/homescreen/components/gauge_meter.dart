import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeMeterWidget extends StatefulWidget {
  final double topPosition;
  final double needleValue;
  final String gageMeterSuggestionText;
  final String percentage;
  const GaugeMeterWidget({super.key, required this.topPosition,required this.needleValue,required this.gageMeterSuggestionText,required this.percentage});

  @override
  _GaugeMeterWidgetState createState() => _GaugeMeterWidgetState();
}

class _GaugeMeterWidgetState extends State<GaugeMeterWidget> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,

      children: [
        SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: 3500,
          axes: <RadialAxis>[
            // RadialAxis(
            //   startAngle: 180,
            //   endAngle: 360,
            //   canScaleToFit: true,
            // ),
            RadialAxis(
                startAngle: 120,
                endAngle: 420,
                // interval: 2,
                showLabels: false,
                showAxisLine: false,
                showTicks: false,
                // minimum: 0,
                // maximum: 99,
                canScaleToFit: true,
                ranges: <GaugeRange>[GaugeRange(
                    startValue: 17,
                    endValue: 28,
                    color: const Color(0xFF99C817),
                    sizeUnit: GaugeSizeUnit.factor,
                  startWidth: 0.35,
                  endWidth: 0.35,
                ), GaugeRange(
                  startValue: 28,
                  endValue: 39,
                  color: const Color(0xFFFDEB48),
                  startWidth: 0.35,
                  endWidth: 0.35,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
                  GaugeRange(
                    startValue: 39,
                    endValue: 50,
                    color: const Color(0xFFFED137),
                    startWidth: 0.35,
                    endWidth: 0.35,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  GaugeRange(
                    startValue: 50,
                    endValue: 61,
                    color: const Color(0xFFF7B11E),
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.35,
                    endWidth: 0.35,
                  ),
                  GaugeRange(
                    startValue: 61,
                    endValue: 71,
                    color: const Color(0xFFF26D24),
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.35,
                    endWidth: 0.35,
                  ),
                  GaugeRange(
                    startValue: 71,
                    endValue: 82,
                    color: const Color(0xFFD72626),
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.35,
                    endWidth: 0.35,
                  ),
                ],
                pointers:  <GaugePointer>[
                  NeedlePointer(
                      value: widget.needleValue,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleLength: 0.3,
                      needleEndWidth:  12,
                      gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF5AA5D0), Color(0xFF5AA5D0),
                            Color(0xFF218DCA), Color(0xFF218DCA)],
                          stops: <double>[0, 0.5, 0.5, 1]),
                      needleColor: Color(0xFF000000),
                      knobStyle: KnobStyle(
                          knobRadius: 0.00,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Colors.blue)),
                ]
            )
          ],
        ),
        Positioned(
          top: widget.topPosition,
          child: Column(
            children: [
              Text(
                widget.percentage,
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.02,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                widget.gageMeterSuggestionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF848484),
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}