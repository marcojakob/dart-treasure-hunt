library treasure_hunt;

import 'dart:html';
import 'package:geo/geo.dart';
import 'dart:js';

part 'model/destination.dart';
part 'view/view.dart';
part 'controller/location.dart';

// Model objects.
List<Destination> allDestinations;

// Controller objects.
LocationManager locationManager;

// View objects.
DestinationDropdown destinationDropdown;
InfoPanel infoPanel;
Compass compass;
Alerts alerts;

DebugInfo debugInfo;

/**
 * Wire up the application.
 */
void main() {
  // Init model data.
  allDestinations = createDestinations();
  
  // Init views.
  destinationDropdown = new DestinationDropdown(allDestinations);
  infoPanel = new InfoPanel();
  compass = new Compass();
  alerts = new Alerts();
  
  debugInfo = new DebugInfo();
  
  // Init controllers.
  locationManager = new LocationManager();
}