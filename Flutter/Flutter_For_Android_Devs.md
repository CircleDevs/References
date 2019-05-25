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

View
- Views are directly updated by mutating their state
- 