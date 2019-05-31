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


## Animating a Widget
In Flutter, use an `AnimationController` which is an `Animation<double>` that can ****pause, seek, stop, and reverse the animation**. This requires the following 
- A `Ticker` that signals when vsync happens, and produces a linear interpolation between 0 and 1 on each frame while it's running. 
- `Animation`s that are attached to the controller
- Assign the `Animation` to an animated property of a widget, such as the opacity of a `FadeTransition`, and tell the controller to start the animation

Example: 
- Use a `CurvedAnimation` to implement an animation along an interpolated curve. In this sense, the controller is the "master" source of the animation progress and the `CurvedAnimation` computes the curve that replaces the controller's default linear motion. Like widgets, animations in Flutter work with composition.

## Building Custom Widgets
In Flutter, a custom widget is build by composing other smaller widgets.
```
class CustomButton extends StatelessWidget {
    final String label;
    CustomButton(this.label);

    @override
    Widget build(BuildContext context) {
        return RaisedButton(onPressed: () {}, child: Text(label))
    }
}
```

## What is the Equivalent of an Intent in Flutter
Navigation between screens is done via a `Navigator` and `Route`s all within the same "Activity".
- A `Route` is an abstraction for a "screen" or "page" of an application. A `Route` roughly maps to an Activity, but it does not carry the same meaning. 
- A `Navigator` is a widget that manages routes. A `Navigator` can push and pop routes to move from screen to screen. Navigators work like a stack on which you can `push()` new routes you want to navigate to and `pop()` routes when you want to go back.

In Android, you declare activities inside the applicatin's AndroidManifest.xml. <br>
In Flutter, you have a couple options to navigate between pages:
- Specify a `Map` of route names (MaterialApp)
```
void main() {
    runApp(MaterialApp(
        home: MyAppHome(),
        routes: <String, WidgetBuilder> {
            '/a': (BuildContext context) => MyPage(title: 'page A'),
            '/b': (BuildContext context) => MyPage(title: 'page B'),
            '/c': (BuildContext context) => MyPage(title: 'page C'),
        },
    ));
}

// Navigate to a route by pushing its name to the Navigator
Navigator.of(context).pushNamed('/b');

// The equivalent of startActivityForResult()
// From Page A
Map coordinates = await Navigator.of(context).pushNamed('/b')
// From Page B once we have received the location route
Navigator.of(context).pop({'lat': 43.821757, 'long': -79.226392})
```
- Directly navigate to a route (WidgetApp)

## Asynchronous UI
The following code loads data asyncrhonously and displays it in a ListView
```
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
    runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
    @override
    Widget build(BUildContext context) {
        return MaterialApp(
            title: 'Sample App',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: SampleAppPage(),
        );
    }
}

class SampleAppPage extends StatefulWidget {
    SampleAppPage({Key key}): super(key: key);

    @override
    _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
    List widgets = [];

    @override
    void initState {
        super.initState();
        loadData();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Sample App'),
            ),
            body: ListView.builder (
                itemCount: widgets.length,
                itemBuilder: (BuildContext context, int position) {
                    return get Row(position);
                }
            ),
        );
    }

    Widget getRow(int i) {
        return Padding (
            padding: EdgeInsets.all(10.0),
            child: Text("Row ${widgets[i]["title"]}),
        );
    }

    loadData() async {
        String dataUrl = "https://jsonplaceholder.typicode.com/posts";
        http.Response response = await http.get(dataUrl);
        setState(() {
            widgets = json.decode(response.body);
        });
    }
}

```

## How/When do you move work to a Background Thread
- **Async/Await**: Since Flutter is single thread and runs an event loop, you don't have to worry about thread management or spawning background threads. If you're dong I/O bound work, such as disk access or a network call, then an async/await cal be used. 
```
loadData() async {
    String dataUrl = ".."
    http.Response response = await http.get(dataUrl);
    setState(() {
        widgets = json.decode(response.body);
    });
}
```
- **Isolate**: To avoid blocking the event loop, do any instensive work that keeps the CPU busy on an **Isolate** just like you would keep any sort of work out of the main thread in Android. `Isolate`s are separate execution threads that do not share any memory with the main execution memory heap. This means you can't access variables from the main thread, or update your UI by calling setState(). Unlike Android threads, Isolates are true to their name and cannot share memory.
```
loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The echo isolate sends its SendPort as the first message
    SendPort sendPort = await receivePort.first;

    List msg = await sendReceive(sendPort, "...");

    setState(() {
        widgets = msg;
    });
}

// The entry point for the isolate
static dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages
    ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to
    sendPort.send(port.sendPort);

    await for(var msg in port) {
        String data = msg[0];
        SendPort replyTo = msg[1];

        String dataUrl = data;
        http.Response response = await http.get(dataUrl);
        // Lots of JSON to parse
        replyTo.send(json.decode(response.body));
    }
}

Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
}
```
For one shot communication use `compute`. This function does the following:
- Spawns an Isolate
- Runs a callback function on that isolate, padding it some data
- Returns the value, outcome of the callback
- Kills the Isolate at the end of the execution of the callback
- **The callback MUST be a top-level function**
- https://api.flutter.dev/flutter/foundation/compute.html

**When to use Futures or Isolates**:
- If pieces of code MAY NOT be interrupted, use a normal synchronous process
- If pieces of codes could run independently WITHOUT impacting the fluidity of the application, condier using the Event Loop via the user of Futures
- If heavy processing might take some time to complete and could potentially impact the fluidity of the application, consider using Isolates.
- If a method takes a couple of millieseconds, use Future
- If a processing might take several hundres of milliseconds, use Isolate

**Some candidates to using Isolates:**
- JSON Decoding: Decoding a JSON might take some time, use **compute**
- Encryption: Might be very time consuming, use Isolate
- Image processing: Processing an image such as cropping takes some time to complete, use Isolate
- Load an image from the Web: Why not delegate this to an Isolate which will return the complete image, once fully loaded


## What is the equivalent of OkHttp in Flutter
```
dependencies:
    http:^0.11.3+16
```
To make a network call, call await on the async function http.get()
```
loadData() async {
    String dataUrl = "..";
    http.Response response = await http.get(dataUrl);
    setState(() {
        widgets = json.decode(response.body);
    });
}
```

## How do I show the Progress for a Long-running task?
In Flutter, use a `ProgressIndicator` widget. Show the progress programmatically by controlling when it's rendered through a boolean flag. Tell Flutter to update its state before the long-running task starts, and hide it after it ends. 
```
void main() {
    runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Sample App',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: SampleAppPage(),
        );
    }
}

class SampleAppPage extends StatefulWidget {
    SampleAppPage({Key key}): super(key: key);

    @override
    _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
    List widgets = [];

    @override
    void initState() {
        super.initState();
        loadData();
    }

    showLoadingDialog() {
        return widgets.length == 0;
    }

    getBody() {
        if(showLoadingDialog()) {
            return getProgressDialog();
        } else {
            return getListView();
        }
    }

    getProgressDialog() {
        return Center(child: CircularProgressIndicator());
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Sample App"),
            ),
            body: getBody();
        );
    }

    ListView getListView() => ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) => getRow(position);
    );

    Widget getRow(int i) => Padding(padding: EdgeInsets.all(10.0), child: Text("Row ${widgets[i]["title"]}));
    

    loadData() async {
        String dataUrl = "...";
        http.Response response = await http.get(dataUrl);
        setState(() {
            widgets = json.decode(response.body);
        });
    }
}
```

# Project Structure and Resources

## Where do I store my resolution-dependent image files
Assets are located in any arbitrary folder, Flutter has no predefined folder structure. You declare the assets with a location in the pubspec.yaml file and Flutter picks them up. <br>
1) To add a new image asset called **my_icon.png** to the Flutter project, for example, and deciding that it shoud live in a folder we arbitrarily called **images**, you would put the base image (1.0x) in the **images** folder and all other variants in sub-folders called with the appropriate ratio multiplier:
```
images/my_icon.png          // Base: 1.0x image
images/2.0x/my_icon.png     // 2.0x image
images/3.0x/my_icon.png     // 3.0x image
```
2) Next, declare these images in the pubspec.yaml file
```
assets:
- images/my_icon.jpeg
```
3) You can then access your images using `AssetImage`:
```
return AssetImage("images/my_icon.png");
// or Directly in an Image widget
@override
Widget build(BuildContext context) {
    return Image.asset("images/my_image.png");
}
```

## How do I Listen to lifecycle Events?
You can listen to lifecycle events by hooking into the `WidgetsBinding` observer and listening to the `didChangeAppLifecycleState()` change event. The following observable lifecyle events include:
- **inactive**: The application is in an inactive state and is not receiving user input. This event only works on iOS, as there is no equivalent event to map to on Android.
- **paused**: The application is not currently visible to the user, not responding to user input, and running in the background. This is equivalent to **onPause()** in Android.
- **resumed**: The application is visible and responding to user input. This is equivalent to **onPostResume()** in Android.
- **suspending**: The application is suspended momentarily. This is equivalent to **onStop()** in Android. It is not triggered on iOS as there is no equivalent event to map to on iOS.
```
class LifecycleWatcher extends StatefulWidget {
    @override
    _LifecycleWatcherState createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver {
    AppLifecycleState _lastLifecycleState;

    @override
    void initState() {
        super.initState();
        WidgetsBinding.instance.addObserver(this);
    }

    @override
    void dispose() {
        WidgetsBinding.instance.removeObserver(this);
        super.dispose();
    }

    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
        setState(() {
            _lastLifecycleState = state;
        });
    }

    @override
    Widget build(BuildContext context) {
        if(_lastLifecycleState == null) {
            return Text('This widget has not observed any lifecycle changes.', textDirection: TextDirection.ltr);
        }

        return Text('The most recent lifecycle state this widget observed was: $_lastLifecycleState.', 
            textDirection: TextDirection.ltr);
    }
}

void main() {
    runApp(Center(child: LifecycleWatcher()));
}
```

## What is the equivalent of a LinearLayout
```
@override
Widget build(BuildContext context) {
    // Row < - > Column
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Text('Row One'),
            Text('Row Two'),
            Text('Row Three'),
            Text('Row Four'),
        ],
    );
}
```

## What is the equivalent of a ScrollView
```
@override
Widget build(BuildContext context) {
  return ListView(
    children: <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}
```

## How do I add an onClick listener to a Widget in Flutter
1) If the Widget supports event detection, pass a function to it and handle it in the function
```
@override
Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () {
            print("Click");
        },
        child: Text("Button"),
    );
}
```

2) If the Widget doesn't support event detection, wrap the widget in a GestureDetector and pass a function to the onTap parameter
```
class SampleApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: GestureDetector(
                    child: FlutterLogo(
                        size:200.0,
                    ),
                    onTap: () {
                        print("tap");
                    },
                ),
            ),
        );
    }
}
```

## ListView
```
import 'package:flutter/material.dart';

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: ListView.builder(
            itemCount: widgets.length,
            itemBuilder: (BuildContext context, int position) {
              return getRow(position);
            }));
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Row $i")),
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length + 1));
          print('row $i');
        });
      },
    );
  }
}
```
