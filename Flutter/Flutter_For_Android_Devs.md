# Flutter For Android Developers

## The equivalent of a View in Flutter
The rough equivalent of a `View` object is a `Widget`.

### Lifespans
Widgets
- Widgets have a different lifespan. They are immutable and only exist until they need to be changed. Whenever widgets or their state change, Flutter's framework creates a new tree of widget instances. 
- Widgets are lightweight because they aren't views themselves and therefore don't draw anything.
  
Views
- Android `View` objects are drawn once and do not redraw until `invalidate` is called.

### Updating UI
Widgets
- Widgets are immutable and are not updated directly, instead you have to work with the widget's state
- `StatelessWidget` is a widget that contains no state information. These are useful when the part of the user interface described does not depend on anything other than the configuration information in the object. The equivalent of this would be an `ImageView` with a logo. The logo does not change during runtime so use a `StatelessWidget` in flutter.
- `StatefulWidget` is a widget that allows itself to be updated dynamically.

Example of using `StatelessWidget` to display a static text
```
// A Text is a stateless widget since it usually does not need any dymanic updating
Text(
    'I like Flutter!',
    style: TextStyle(fontWeight: FontWeight.bold),
);
```

Example of using `StatefulWidget` to display dynamically updating text
```
import `package:flutter/material.dart`;

void main() {
    runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
    // This widget is the root of the application
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Sample App',
            theme: ThemeData(pimrarySwatch: Colors.blue),
            home: SampleAppPage()
        );
    }
}

class SampleAppPage extends StatefulWidget {
    SampleAppPage({Key key}): super(key: key);

    @override
    _SampleAppPageState createState() => _SampleAppPageState();
}
```

Example of adding padding to a simple Text widget
```
@override
Widget build(BuildContext context)  => Scaffold(
    appBar: AppBar(
        title: Text("Sample App"),
    ),
    body: Center (
        child: MaterialButton(
            onPressed: () {},
            child: Text('Hello'),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
        ),
    ),
);
```
Add and removing Components
```
import 'package:flutter/material.dart';

/// The entry point of the application
void main() => runApp(FlutterLearn());

class FlutterLearn extends StatelessWidget {
    @override
    Widget build(BuildContext context) { 
        final toggler = Toggler();

        return MaterialApp(
            title: "Learning Flutter",
            theme: ThemeData(primarySwatch: Colors.red),
            home: Scaffold(
                appBar: AppBar(
                    title: Text("Learn Flutter"),
                ),
                body: Center(child: toggler),
                floatingActionButton: FloatingActionButton(
                    onPressed: () { toggler.toggerState.doToggle(); },
                    tooltip: 'Update Text',
                    child: Icon(Icons.update),
                )
            )
        );
    }
}

class Toggler extends StatefulWidget {
    final togglerState = _TogglerState();

    @override
    State createState() => toggerState;
}

class _TogglerState extends State<Toggler> {
    bool toggle = true;

    void doToggle() {
        setState( () {
            toggle = !toggle;
        });
    }

    Widget _getToggleChild() {
        if(toggle) {
            return Text('Toggle One');
        } else {
            return MaterialButton(onPressed: () {}, child: Text('Toggle Two'));
        }
    }

    @override
    Widget build(BuildContext context) => _getToggleChild();
}
```
View
- Views are directly updated by mutating their state
- 