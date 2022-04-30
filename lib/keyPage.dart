import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController userInput = TextEditingController();
// The node used to request the keyboard focus.
  final FocusNode _focusNode = FocusNode();
// The message to display.
  String? _message;

// Focus nodes need to be disposed.
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

// Handles the key events from the RawKeyboardListener and update the
// _message.
  void _handleKeyEvent(RawKeyEvent event) {
    setState(() {
      if (event.logicalKey == LogicalKeyboardKey.keyQ) {
        _message = 'Pressed the "Q" key!';
      } else {
        if (kReleaseMode) {
          _message =
              'Not a Q: Pressed 0x${event.logicalKey.keyId.toRadixString(16)}';
        } else {
          // The debugName will only print useful information in debug mode.
          _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: textTheme.headline4!,
          child: RawKeyboardListener(
            focusNode: _focusNode,
            onKey: _handleKeyEvent,
            child: AnimatedBuilder(
              animation: _focusNode,
              builder: (BuildContext context, Widget? child) {
                if (!_focusNode.hasFocus) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_focusNode);
                    },
                    child: const Text('Tap to focus'),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: userInput,
                      onChanged: (userInput) {

                      },
                    ),
                    Text(_message ?? 'Press a key'),
                    Container(width: 128, height: 64, color: Colors.black
                        // child: TextFormField(
                        //     // key: Key(totalCalculated()),
                        //     // textInputAction: TextInputAction.next,
                        //     // controller: desc,
                        //     // onChanged: (desc) {},
                        //     // onTap: () {},
                        //     // decoration: InputDecoration(),
                        //     // keyboardType: TextInputType.number,
                        //   ),
                        ),
                  ],
                );
                // Text(_message ?? 'Press a key');
              },
            ),
          ),
        ),
      ),
    );
  }
}
