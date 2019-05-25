# The Dart Programming Language

## The Main Function
Every application has a main() function.

## Importing
```
// Importing core libraries
import 'dart:math';

// Importing libraries from external packages
import package:test/test.dart';

// Importing files
import 'path/to/my_other_file.dart';
```

## Throwing
```
if(astronauts == 0) { 
    throw StateError('No astronauts.');
}

try {
  for (var object in flybyObjects) {
    var description = await File('$object.txt').readAsString();
    print(description);
  }
} on IOException catch (e) {
  print('Could not describe object: $e');
} finally {
  flybyObjects.clear();
}
```

## Variables
Type Inference
```
var name = 'Voyager I';
var year = 1977;
var antennaDiameter = 3.7
var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
var image = {
    'tags' : ['saturn'],
    'url' : '//path/to/saturn.jpg'
};
```

Dynamic objects that can be turned into anything
```
dynamic name = 'Bob';
name = Object()
name = ...
```

Final variables can only be set once and a const variable is a compile-time constant.
```
final name = 'Bob';
final String nickname = 'Bobby';

const bar = 100000;
const double atm = 1.01325 * bar;

class TestClass {
    static const value = 1000;
}
```

## Control Flow
Conditional statements
```
if(year >= 2001) {
    print(...); 
} else if (year >= 1901) {
    print(...);
}
```

Loops
```
// For Loops
var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
for(var object in flybyObjects) {
    print(...)
}

for (int month = 1; month <= 12; month++) {
    print(month);
}

// While Loops
while(year < 2016) {
    year += 1;
}
```

## Functions
Functions
```
int fibonacci(int n) {
    if (n == 0 || n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

var result = fibonacci(20);
```

Optional paremeters
```
class Rectangle {
    int width;
    int height;
    Point origin;

    // Optionnal named parameters are enclosed in curly braces
    Rectangle({this.origin = const Point(0,0), this.width = 0, this.height = 0});
}
```

## Classes
```
class Spacecraft {
    String name;
    DateTime launchDate;

    // Constructor, with syntactic sugar for assignment to members.
    Spacecraft(this.name, this.launchDate) {
        // Initialization code goes here
    }

    // Named constructor that forwards to the default one
    Spacecraft.unlaunched(String name) : this(name, null);

    // Read only non-final property
    int get launchYear => launchDate?.year;

    // Method 
    void describe() {
        print('Spacecraft: $name')
        if(launchDate != null) {
            int years = DateTime.now().difference(launchDate).inDays . 365;
            print('Launched: $launchYear ($years years ago)');
        } else {
            print('Unlaunched');
        }
    }
}

// Using the Spacecraft class
var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
voyager.describe();

var voyager3 = Spacecraft.unlaunched('Voyager III');
voyager3.describe();
```

## Inheritance
```
class Orbider extends Spacecraft {
    num altitude;
    Orbiter(String name, DateTime launchDate, this.altitude) : super(name, launchDate)
}
```


## Mixins
Mixins are a way of reusing code in multiple class hierarchies. The following class can act as a mixin:
```
class Piloted {
    int astronauts = 1;
    void describeCrew() {
        print('Number of astronauts: $astronauts`);
    }
}

// To add a mixin's capabilities to a class, just extend the class with the mixin
class PilotedCraft extends Spacecraft with Piloted {

}
```

## Interfaces
Dart has no `interface` keyword. Instead, all classes implicitly define an interface.
```
// Implementing an interface
class MockSpaceship implements Spacecraft {
    // ...
}
```


## Abstract classes
Abstract classes can be created to be extended or implemented by a concrete class
```
abstract class Describable {
    void describe();

    void describeWithEmphasis() {
        // implementation
    }
}
```

## Async and Await
```
const oneSecond = Duratoin(seconds: 1);

Future<void> printWithDelay(String message) async {
    await Future.delayed(oneSecond);
    print(message);
}
```

## Asynchronous Programming
**Handling Futures**: When you need the result of a completed Future, you have two options:
* Use `async` and `await`
* Use the Future API

To use await, code must be in an `async` function, a function marked as `async`. The async function executes only until it encounters its first `await` expression. Then it returns a `Future` object, resuming executoin only after the `await` expression completes.
```
Future checkVersion() async {
    var versoin = await lookUpVersion();
}
```

**Handling Streams**: When you need to get values from a Strea, you have two options: 
* Use `async` and an asynchronous for loop (await for)
* Use the Stream API
```
await for (varOrType identifier in expression) {
    // Executes each time the stream emits a value
}
```

## Generators
When you need to lazily produce a sequence of values, consider using a generator function. Dart has built-in support for two kinds of generator functions:
* Synchronous generator: Returns an `Iterable` object
```
// Use the yield statement to deliver values
Iterable<int> naturalsTo(int n) sync* {
    int k = 0;
    while (k < n) yield k++;
}
```
* Asynchronous generator: Returns a `Stream` object
```
Stream<int> asynchronousNaturalsTo(int n) async* {
    int k = 0;
    while( k < n ) yield k++;
}
```