import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VibeGaugeWidget extends StatefulWidget {
  final double meterHeight;
  final double topMargin;
  final double? customValue;
  final String? customText;
  final double initialValue;
  final bool isSlider;
  final bool isDiscount;
  final bool fromReview;

  const VibeGaugeWidget({
    super.key,
    required this.meterHeight,
    required this.topMargin,
    this.customValue,
    this.customText,
    this.initialValue = 10,
    this.isSlider = true,
    this.isDiscount = false,
    this.fromReview = false,
  });
  @override
  _VibeGaugeWidgetState createState() => _VibeGaugeWidgetState();
}

class _VibeGaugeWidgetState extends State<VibeGaugeWidget> {
  late double initialValue; // Initial value
  double difference = 20; // Difference between values
  List<Color> colorList = List.filled(20, Color(0xffEEEDE9));

  List<double> values = [];
  double sliderValue = 0.0 + 1;

  @override
  void initState() {
    initialValue = widget.initialValue;
    sliderValue = initialValue;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.meterHeight,
      width: widget.meterHeight,
      // color: Colors.white,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                showLabels: true,
                centerX: 0.5,
                centerY: 0.6,
                labelFormat: "",
                startAngle: 190,
                endAngle: 360,
                axisLineStyle: AxisLineStyle(
                    cornerStyle: CornerStyle.bothCurve,
                    thickness: 2,
                    color: Colors.transparent
                    // dashArray: [14, 2],
                    ),
                showTicks: false,
                pointers: <GaugePointer>[
                  NeedlePointer(
                      value: widget.customValue == null
                          ? sliderValue
                          : widget.customValue!,
                      enableAnimation: true,
                      animationDuration: 3000,
                      needleStartWidth: 0,
                      needleEndWidth: widget.meterHeight <= 50 ? 1 : 4,
                      needleLength: 0.75,
                      needleColor: Colors.red,
                      knobStyle: KnobStyle(
                          color: Colors.red,
                          borderColor: Colors.red,
                          knobRadius: 0.10,
                          borderWidth: 0.03),
                      tailStyle:
                          TailStyle(color: Colors.red, width: 00, length: 0.0)),
                ]),
          ]),
          Positioned(
            bottom: 30,
            child: Text(
              widget.customValue != null
                  ? widget.customText!
                  : widget.isDiscount == true
                      ? sliderValue.toStringAsFixed(0) + "%"
                      : sliderValue >= -9 && sliderValue < 10
                          ? "Fine"
                          : sliderValue >= 10 && sliderValue < 30
                              ? "Good"
                              : sliderValue >= 30 && sliderValue < 50
                                  ? "Average"
                                  : sliderValue >= 50 && sliderValue < 67
                                      ? "Best"
                                      : sliderValue >= 67 && sliderValue < 90
                                          ? "Great"
                                          : sliderValue >= 85
                                              ? "Amazing"
                                              : "",
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: 'PoppinsBold',
                  fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            child: Column(
              children: [
                SizedBox(
                  height: widget.topMargin,
                ),
                widget.meterHeight >= 50
                    ? Container(
                        child: sliderValue >= -9 && sliderValue < 10
                            ? Image.asset(
                                "assets/images/meter.png",
                              )
                            : sliderValue >= 10 && sliderValue < 30
                                ? Image.asset(
                                    "assets/images/meter.png",
                                  )
                                : sliderValue >= 30 && sliderValue < 50
                                    ? Image.asset(
                                        "assets/images/meter.png",
                                      )
                                    : sliderValue >= 50 && sliderValue < 67
                                        ? Image.asset(
                                            "assets/images/meter.png",
                                          )
                                        : sliderValue >= 67 && sliderValue < 90
                                            ? Image.asset(
                                                "assets/images/meter.png",
                                              )
                                            : sliderValue >= 85
                                                ? Image.asset(
                                                    "assets/images/meter.png",
                                                  )
                                                : Image.asset(
                                                    "assets/images/meter.png",
                                                  ),
                      )
                    : Container(
                        child: widget.customValue! >= -9 &&
                                widget.customValue! < 10
                            ? Image.asset(
                                "assets/images/meter.png",
                              )
                            : widget.customValue! >= 10 &&
                                    widget.customValue! < 30
                                ? Image.asset(
                                    "assets/images/meter.png",
                                  )
                                : widget.customValue! >= 30 &&
                                        widget.customValue! < 50
                                    ? Image.asset(
                                        "assets/images/meter.png",
                                      )
                                    : widget.customValue! >= 50 &&
                                            widget.customValue! < 67
                                        ? Image.asset(
                                            "assets/images/meter.png",
                                          )
                                        : widget.customValue! >= 67 &&
                                                widget.customValue! < 90
                                            ? Image.asset(
                                                "assets/images/meter.png",
                                              )
                                            : widget.customValue! >= 85
                                                ? Image.asset(
                                                    "assets/images/meter.png",
                                                  )
                                                : Image.asset(
                                                    "assets/images/meter.png",
                                                  ),
                      )
              ],
            ),
          ),
          if (widget.isSlider)
            GestureDetector(
              onPanUpdate: (details) {
                // Calculate the position of the touch relative to the container's width
                double position = details.localPosition.dx /
                    MediaQuery.of(context).size.width;

                // Check if position is within the valid range (0 to 1)
                if (position >= 0.0 && position <= 1.0) {
                  setState(() {
                    sliderValue = position * 114; // Update the sliderValue
                  });

                  print(sliderValue);
                }
              },
            ),
        ],
      ),
    );
  }
}
