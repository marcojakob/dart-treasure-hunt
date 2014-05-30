part of treasure_hunt;

class LocationController {
  
  /// The current location.
  LatLng location = new LatLng(46.949150, 7.438484); // Bahnhof Bern
  
  /// The accuracy of [location].
  double accuracy;
  
  /// The current heading.
  double heading;
  
  /// The current destination.
  Destination destination;
  
  /// The current direction of the destination. 
  double destinationHeading;
  
  /// The distance to the destination.
  double destinationDistance;
  
  /// True if user is currently at the destination and a success message is shown.
  bool showingSuccessMessage = false;
  
  /**
   * Constructor.
   */
  LocationController() {
    // Start watching the location of the user.
    watchLocation();
    
    watchDeviceOrientation();
  }
  
  /**
   * Uses HTML5 geolocation to watch the current location of the device.
   */
  void watchLocation() {
    if (window.navigator.geolocation != null) {
      window.navigator.geolocation.watchPosition(enableHighAccuracy: true).listen((position) {
        
        // Set the new location and accuracy.
        location = new LatLng(position.coords.latitude,
            position.coords.longitude);
        accuracy = position.coords.accuracy;
        
        updateLocation();
        
        // Received valid location. Clear error alerts.
        alerts.clearError();
      }, onError: (error) {
        alerts.showError('The Geolocation service failed. Will try again.');
      });
    } else {
      // Browser doesn't support Geolocation.
      alerts.showError('Your browser doesn\'t support geolocation.');
    }
  }
  
  void watchDeviceOrientation() {
    window.onDeviceOrientation.listen((DeviceOrientationEvent e) {
      heading = e.alpha;
      
      updateCompass();
    });
  }

  /**
   * Recalculates the distance and heading, updates the view.
   */
  void updateLocation() {
    // Check if we have a destination and a current position before calculating.
    if (destination != null && location != null) {
      
      destinationDistance = computeDistanceBetween(location, destination.latLng);
      
      // Test if destination is reached.
      if (destinationDistance <= SUCCESS_RADIUS) {

        // Test if not already showing success message.
        if (!showingSuccessMessage) {
          infoPanel.showMessage(destination.successTitle, destination.successImage, 
              destination.successMessage);
          showingSuccessMessage = true;
        }
      } else {
        
        destinationHeading = computeHeading(location, destination.latLng);
        
        String locationString = convertToDegreeMinute(location);
        String destinationString = convertToDegreeMinute(destination.latLng);
        
        infoPanel.showLocationInfo(destinationDistance, locationString, 
            destinationString, accuracy);
        
        showingSuccessMessage = false;
        
        updateCompass();
      }
    }
  }
  
  void updateCompass() {
    // Update the compass.
    compass.updateHeading(heading, destinationHeading);
  }
}

/**
 * Helper method to convert the [pos] to a Degree/Minute representation. 
 * Example: N48°51.497' E2°17.668'
 */
String convertToDegreeMinute(LatLng pos) {
  bool latSouth = pos.lat.isNegative;
  int latDeg = pos.lat.abs().toInt();
  String latMin =  ((pos.lat.abs() - latDeg) * 60).toStringAsFixed(3);
  
  bool lngWest = pos.lng.isNegative;
  int lngDeg = pos.lng.abs().toInt();
  String lngMin =  ((pos.lng.abs() - lngDeg) * 60).toStringAsFixed(3);

  String result = '';
  if (latSouth) {
    result += 'S';
  } else {
    result += 'N';
  }
  
  result += '${latDeg}°${latMin}\'';
  
  if (lngWest) {
    result += ' W';
  } else {
    result += ' E';
  }
  
  result += '${lngDeg}°${lngMin}\'';
  return result;
}
