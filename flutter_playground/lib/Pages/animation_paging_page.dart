import 'package:flutter/material.dart';
import 'package:flutter_playground/Components/item_fader.dart';
import 'Containers/count_page.dart';

class AnimationPagingPage extends StatelessWidget {
  const AnimationPagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Paging'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blueGrey])),
        child: SafeArea(
          child: Stack(children: [
            _ArrowIcons(),
            _Plane(),
            _Line(),
            _Page(
              answers: ['answer1', 'answer2', 'answer3'],
              number: 1,
              onOptionSelected: () {},
              question:
                  'question question question question question question question ',
            )
          ]),
        ),
      ),
    );
  }
}

class _ArrowIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 16,
        bottom: 16,
        child: Column(
          children: const [
            Icon(
              Icons.arrow_upward_sharp,
              color: Colors.white,
            ),
            SizedBox(
              height: 16,
            ),
            Icon(
              Icons.arrow_downward,
              color: Colors.white,
            )
          ],
        ));
  }
}

class _Plane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Positioned(
        left: 40,
        top: 32,
        child: RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.airplanemode_active,
            size: 64,
            color: Colors.white,
          ),
        ));
  }
}

class _Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 40.0 + 31.5,
        top: 40,
        bottom: 0,
        width: 1,
        child: Container(
          color: Colors.white.withOpacity(0.5),
        ));
  }
}

class _Page extends StatefulWidget {
  final int number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;

  const _Page(
      {required this.number,
      required this.question,
      required this.answers,
      required this.onOptionSelected});

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  late List<GlobalKey<ItemFaderState>> keys;

  @override
  void initState() {
    super.initState();
    keys = List.generate(5, (_) => GlobalKey<ItemFaderState>());
    onInit();
  }

  void onInit() async {
    for (GlobalKey<ItemFaderState> key in keys) {
      await Future.delayed(const Duration(milliseconds: 40));
      key.currentState?.show();
    }
  }

  void onTap() async {
    for (GlobalKey<ItemFaderState> key in keys) {
      await Future.delayed(const Duration(milliseconds: 40));
      key.currentState?.hide();
    }
    widget.onOptionSelected();

    await Future.delayed(const Duration(milliseconds: 240));
    for (GlobalKey<ItemFaderState> key in keys) {
      await Future.delayed(const Duration(milliseconds: 40));
      key.currentState?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 32,
          ),
          ItemFader(
            key: keys[0],
            child: Padding(
              padding: const EdgeInsets.only(left: 64),
              child: Text(
                '${widget.number}',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 64),
              ),
            ),
          ),
          ItemFader(
            key: keys[1],
            child: Padding(
              padding: const EdgeInsets.only(left: 64),
              child: Text(
                widget.question,
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
            ),
          ),
          const Spacer(),
          ...widget.answers.map((answer) {
            int answerIndex = widget.answers.indexOf(answer);
            int keyIndex = answerIndex + 2;
            return ItemFader(
              key: keys[keyIndex],
              child: _OptionItem(
                onOptionSelected: onTap,
                name: answer,
              ),
            );
          }),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}

class _OptionItem extends StatefulWidget {
  final String name;
  final VoidCallback onOptionSelected;

  const _OptionItem({required this.name, required this.onOptionSelected});

  @override
  State<_OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<_OptionItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onOptionSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            const SizedBox(
              width: 26,
            ),
            SizedBox(
              width: 8,
              height: 8,
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 26,
            ),
            Expanded(
                child: Text(
              widget.name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }
}
