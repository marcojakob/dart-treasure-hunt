library treasure_hunt;

import 'dart:html';
import 'package:geo/geo.dart';

part 'model/destination.dart';
part 'view/view.dart';
part 'controller/location.dart';

/// Defines how close the user must get to the destination (in meters).
final int SUCCESS_RADIUS = 30;

// A list of all destinations.
List<Destination> allDestinations = [];

// Controller classes.
LocationController locationManager;

// View classes.
DestinationDropdown destinationDropdown;
InfoPanel infoPanel;
Compass compass;
Alerts alerts;

void main() {
  // Init model data.
  createDestinations();
  
  // Init controller classes.
  locationManager = new LocationController();
  
  // Init view classes.
  destinationDropdown = new DestinationDropdown(allDestinations);
  infoPanel = new InfoPanel();
  compass = new Compass();
  alerts = new Alerts();
}

/**
 * Create a list of all destinations.
 */
void createDestinations() {
  allDestinations.add(new Destination()
      ..name = 'Central Zürich'
      ..latLng = new LatLng(47.376895, 8.544137)
      ..successTitle = 'Nice! You are at Central!'
      ..successImage = 'resources/images/central.jpg'
      ..successMessage = 'Take a picture of a tram at central.');
  
  allDestinations.add(new Destination()
      ..name = 'Grünau Zürich'
      ..latLng = new LatLng(47.397292, 8.489801)
      ..successTitle = 'Nice! You are at Grünau!'
      ..successImage = 'resources/images/gruenau.jpg'
      ..successMessage = 'Bla blabla.');
  
  allDestinations.add(new Destination()
      ..name = 'Meilen'
      ..latLng = new LatLng(47.266659, 8.668566)
      ..successTitle = 'Nice! You are in Meilen!'
      ..successImage = 'resources/images/food.jpg'
      ..successMessage = 'Enjoy a good meal!');
  
  allDestinations.add(new Destination()
      ..name = 'Home'
      ..latLng = new LatLng(46.899201, 7.496635)
      ..successTitle = 'Nice! You are at home!'
      ..successImage = 'resources/images/home.jpg'
      ..successMessage = 'Bla blabla.');
  
  allDestinations.add(new Destination()
      ..name = 'Bundeshaus (Federal Palace)'
      ..latLng = new LatLng(46.946240, 7.444588)
      ..successTitle = 'Awesome, you are at the Bundeshaus!'
      ..successImage = 'resources/images/bundeshaus.jpg'
      ..successMessage = 'Make a selfie of you and the view behind the Bundeshaus.');

  allDestinations.add(new Destination()
      ..name = 'Zytglogge (Clock Tower)'
      ..latLng = new LatLng(46.947953, 7.447801)
      ..successTitle = 'Great, you\'ve reached the Zytglogge!'
      ..successImage = 'resources/images/zytglogge.jpg'
      ..successMessage = 'Please take a picture of the clock.');

  allDestinations.add(new Destination()
      ..name = 'Bärengraben (Bear Pit)'
      ..latLng = new LatLng(46.947992, 7.459366)
      ..successTitle = 'Nice! You are at the Bear Pit!'
      ..successImage = 'resources/images/bear.jpg'
      ..successMessage = 'Try to take a picture of a bear.');

}

/**
 * Update to the chosen destination.
 */
void updateDestination(Destination newDestination) {
  locationManager.destination = newDestination;
  destinationDropdown.setDestinationTitle(newDestination.name);
  locationManager.updateLocation();
}