# Dart Treasure Hunt

[![Build Status](https://drone.io/github.com/marcojakob/dart-treasure-hunt/status.png)](https://drone.io/github.com/marcojakob/dart-treasure-hunt/latest)

This is an example implementation of a treasure hunt game in Dart. It is meant
for educational purposes to learn programming in Dart.


## Demo

You can try the following example application in your browser:

[Treasure Hunt Demo](http://marcojakob.github.io/dart-treasure-hunt/)


## Features

* Predefined treasure destinations (in latitude and longitude). User can 
choose a destination.
* Uses HTML5 Geolocation API (GPS, etc.) to get the position of the user.
* Calculates distance between user and destination.
* Displays a compass to indicate the direction of the destination.
* If supported by the device, the compass is turned to always face the magnetic
north.
* When close enough (e.g. 30m) to the destination, a message and an imaage is 
displayed.


## Alternative Scenarios

The treasure hunt app could easily be changed into various other scenarios:

* A [Geocaching](http://en.wikipedia.org/wiki/Geocaching) client.
* A [Scavenger Hunt](http://en.wikipedia.org/wiki/Scavenger_hunt).


## Known Limitations

* In iOS Safari the compass points in an arbitrary direction. North will point
in the direction the device is facing when the app was loaded. This will be 
resolved when [Dart Issue 19119](is fixed).


## Further Infos

* [An Introduction to the Geolocation API](http://code.tutsplus.com/tutorials/an-introduction-to-the-geolocation-api--cms-20071)
* [An Introduction to the Device Orientation API](http://code.tutsplus.com/tutorials/an-introduction-to-the-device-orientation-api--cms-21067)