import 'package:flutter/material.dart';
import '_parts.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScaffold(
      title: 'Privacy Policy',    // عنوان واحد في المنتصف
      cardChild: SingleChildScrollView(
        child: const Text(
          'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. '
          'Por scientie, musica, sport etc, litot Europa usa li sam vocabular. '
          'Li lingues differe solmen in li grammatica, li pronunciation e li plu commun paroles.\n\n'
          'It is a paradisematic country, in which roasted parts of sentences fly into your mouth. '
          'Even the all-powerful Pointing has no control about the blind texts; it is an almost unorthographic life.',
          style: TextStyle(color: Colors.black87, height: 1.55),
        ),
      ),
    );
  }
}
