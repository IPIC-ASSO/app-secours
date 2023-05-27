import 'package:app_secours/Officiant.dart';
import 'package:app_secours/circonstanciel.dart';
import 'package:app_secours/declenchement.dart';
import 'package:app_secours/identite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Vital.dart';
import 'main.dart';

class Menu extends StatefulWidget {


  final String chemin;
  final bool enr;

  @override
  _MenuState createState() => _MenuState();

  Menu(this.chemin, this.enr);
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    'Déclenchement',
    'Circonstanciel',
    'Identité',
    'Vital',
    'Complémentaire',
    'Surveillance'
  ];
  static const _iconMenu = [
    Icons.crisis_alert_outlined,
    Icons.question_mark,
    Icons.perm_identity,
    Icons.medical_information,
    Icons.perm_device_info,
    Icons.safety_check,
  ];
  static const _colorMenu = [
    Colors.blue,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.red,
    Colors.grey,
    Colors.orange
  ];

  static var _classes = [
    Declenchement(chemin: ""),
    Circonstanciel(chemin: ""),
    Identite(chemin: ""),
    Vital(chemin: ""),
    Circonstanciel(chemin: ""),
    Circonstanciel(chemin: ""),
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 300);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 550);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  late Interval _buttonInterval;

  @override
  void initState() {
    super.initState();
    print(widget.enr);
    _createAnimationIntervals();
    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )
      ..forward();
    _classes = [
      Declenchement(chemin: widget.chemin),
      Circonstanciel(chemin: widget.chemin),
      Identite(chemin: widget.chemin),
      Vital(chemin: widget.chemin),
      Circonstanciel(chemin: widget.chemin),
      Circonstanciel(chemin: widget.chemin),
    ];
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuTitles.length+1; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }

    final buttonStartTime =
        Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
    final buttonEndTime = buttonStartTime + _buttonTime;
    _buttonInterval = Interval(
      buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
      buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildFlutterLogo(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildFlutterLogo() {
    return const Positioned(
      right: -100,
      bottom: -30,
      child: Opacity(
        opacity: 0.2,
        child: FlutterLogo(
          size: 400,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: 16),
        _buildGetStartedButton(),
        ..._buildListItems(),
      ],
    );
  }

  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (var i = 0; i < _menuTitles.length; ++i) {
      listItems.add(
        AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.easeOut.transform(
              _itemSlideIntervals[i].transform(_staggeredController.value),
            );
            final opacity = animationPercent;
            final slideDistance = (1.0 - animationPercent) * 150;

            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(slideDistance, 0),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
            child: ListTile(
              leading: Icon(
                _iconMenu[i],
                color: _colorMenu[i],
              ),
              title: Text(
                _menuTitles[i],
                style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
              onTap: () async {
                bool continu = true;
                if(!widget.enr){
                  continu = await Officiant().Confirme(context);
                }
                if(continu){
                  Navigator.pop(context);
                  _staggeredController.animateBack(1);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => _classes[i],
                      transitionDuration: Duration(milliseconds: 500),
                      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      );
    }
    listItems.add(
      AnimatedBuilder(
      animation: _staggeredController,
      builder: (context, child) {
        final animationPercent = Curves.easeOut.transform(
          _itemSlideIntervals.last.transform(_staggeredController.value),
        );
        final opacity = animationPercent;
        final slideDistance = (1.0 - animationPercent) * 150;

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(slideDistance, 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
        child: AboutListTile(
          icon: Icon(
            Icons.info,
          ),
          child: Text('A propos'),
          applicationIcon: Icon(
            Icons.local_play,
          ),
          applicationName: 'Appli protection civile',
          applicationVersion: '1.0',
          applicationLegalese: '© 2023 IPIC-ASSO',
          aboutBoxChildren: [

          ],
        ),
        ),
      ),
    );
    return listItems;
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.elasticOut.transform(
                _buttonInterval.transform(_staggeredController.value));
            final opacity = animationPercent.clamp(0.0, 1.0);
            final scale = (animationPercent * 0.5) + 0.5;
            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            );
          },
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.primaries.first,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
            ),
            onPressed: () async {
              bool continu = true;
              if(!widget.enr){
                continu = await Officiant().Confirme(context);
              }
              if(continu) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
              }
              },
            child: Row(
              children: [
                Icon(Icons.home,color: Colors.white,),
                const Text(
                  'liste des doc',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
            ])
          ),
        ),
      ),
    );
  }
}