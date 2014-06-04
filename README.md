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

* A [Geocaching](http://wikipedia.org/wiki/Geocaching) client.
* A [Scavenger Hunt](http://wikipedia.org/wiki/Scavenger_hunt).