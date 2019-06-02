# User Interface

## RunApp
The `runApp()` function that can be found on `main()` takes the given Widget and amkes it the root of the widget tree.

## Basic Widgets
A widget's main job is to implement a `build` function that describes the widget in terms of other, lower-level widgets. The framework builds those widgets in turn until the process bottoms out in widgets that represent the underlying `RenderObject` which computes and describes the geometry of the widget.

## StatelessWidgets
`StatelessWidget`s receive arguments from their parent widget, which they store in final member variables. When a widget is asked to `build`, it used these stored values to dervice new arguments for the widgets it creates.

## StatefulWidgets
`StatefulWidget`s and `State` objects are separete because Widgets are temporary objects that are used to construct a presentation of the application in its current state. The `State` objects are persistent between calls to `build()`, allowing them to remember information.