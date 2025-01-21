import 'package:flutter/material.dart';

class ScrollTimePickerWheel extends StatefulWidget {
  const ScrollTimePickerWheel({super.key, this.initialTime, this.onChange});
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay>? onChange;
  @override
  State<ScrollTimePickerWheel> createState() => _ScrollTimePickerWheelState();
}

class _ScrollTimePickerWheelState extends State<ScrollTimePickerWheel> {
  final FixedExtentScrollController _hourController =
      FixedExtentScrollController();
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController();
  final FixedExtentScrollController _ampmController =
      FixedExtentScrollController();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 7, minute: 00);
  @override
  void initState() {
    super.initState();
    _initializePickers();
  }

  void _initializePickers() {
    if (widget.initialTime != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _selectedTime = TimeOfDay(
            hour: widget.initialTime!.hour, minute: widget.initialTime!.minute);
        if (widget.initialTime!.hour >= 12) {
          _ampmController.jumpToItem(1);
          if (widget.initialTime!.hour > 12) {
            _hourController.jumpToItem(widget.initialTime!.hour - 12 - 1);
          } else {
            _hourController.jumpToItem(11);
          }
        } else {
          if (widget.initialTime!.hour == 0) {
            _hourController.jumpToItem(11);
          } else {
            _hourController.jumpToItem(widget.initialTime!.hour - 1);
          }
        }
        _minuteController.jumpToItem(widget.initialTime!.minute ~/ 15);
      });
    }
  }

  void _onHourChanged(int index) {
    bool isAm = _ampmController.selectedItem == 0;
    int hour = (index + 1);
    if (isAm && hour == 12) {
      hour = 0;
    }
    if (!isAm && hour != 12) {
      hour += 12;
    }
    _selectedTime = _selectedTime.replacing(hour: hour);
  }

  void _onMinuteChanged(int index) {
    _selectedTime = _selectedTime.replacing(minute: index * 15);
  }

  void _onAmpmChanged(int index) {
    setState(() {
      if (index == 0 && _selectedTime.hour > 12) {
        _selectedTime = _selectedTime.replacing(hour: _selectedTime.hour - 12);
      } else if (index == 1 && _selectedTime.hour < 12) {
        _selectedTime = _selectedTime.replacing(hour: _selectedTime.hour + 12);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPicker(
                _hourController,
                12,
                _onHourChanged,
                (index) => (index + 1).toString().padLeft(2, '0'),
                'HH',
                const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8))),
            _buildPicker(
                _minuteController,
                4,
                _onMinuteChanged,
                (index) => (index * 15).toString().padLeft(2, '0'),
                'MM',
                BorderRadius.zero),
            _buildPicker(
                _ampmController,
                2,
                _onAmpmChanged,
                (index) => index == 0 ? 'AM' : 'PM',
                'AM/PM',
                const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12),
          child: Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Thoát',
                ),
              )),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onChange?.call(_selectedTime);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPicker(
    FixedExtentScrollController controller,
    int itemCount,
    ValueChanged<int> onSelectedItemChanged,
    String Function(int) formatLabel,
    String semanticLabel,
    BorderRadius borderRadius,
  ) {
    return SizedBox(
      width: 75,
      height: 150,
      child: Stack(
        children: [
          ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 40,
            diameterRatio: 1.2,
            offAxisFraction: 0,
            onSelectedItemChanged: onSelectedItemChanged,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: TimeTileWidget(
                      time: formatLabel(index), isSelected: false),
                );
              },
              childCount: itemCount,
            ),
          ),
          IgnorePointer(
            child: Center(
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: borderRadius,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeTileWidget extends StatelessWidget {
  final String time;
  final bool isSelected;

  const TimeTileWidget(
      {super.key, required this.time, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          time,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.grey.shade900),
        ),
      ),
    );
  }
}
