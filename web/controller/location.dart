part of treasure_hunt;

/**
 * Watches the location and device orientation of the user.
 */
class LocationManager {
  
  /// Defines how close the user must get to the destination (in meters).
  final int SUCCESS_RADIUS = 30;
    
  /// The current location.
  LatLng location;
  
  /// The accuracy of [location].
  double accuracy;
  
  /// The current heading.
  double heading;
  
  /// Specifies whether the device is providing orientation data that's relative 
  /// to the Earth's coordinate system, in which case its value is true, or to 
  /// an arbitrary coordinate system.
  bool absolute;
  
  /// The current destination.
  Destination destination;
  
  /// The current direction of the destination. 
  double destinationHeading;
  
  /// The distance to the destination.
  double destinationDistance;
  
  /// True if user is currently at the destination and a success message is shown.
  bool showingSuccessMessage = false;
  
  /**
   * Constructor. Starts watching the location and device orientation.
   */
  LocationManager() {
    // Start watching the location of the user and his device orientation.
    watchLocation();
    watchDeviceOrientation();
  }
  
  /**
   * Uses HTML5 geolocation to watch the current location of the device. When
   * the location changes, the view is updated.
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
        alerts.showError('The geolocation service failed.');
      });
    } else {
      // Browser doesn't support Geolocation.
      alerts.showError('Your browser doesn\'t support geolocation.');
    }
  }
  
  /**
   * Watches the device orientation and updates the compass.
   */
  void watchDeviceOrientation() {
    window.onDeviceOrientation.listen((DeviceOrientationEvent e) {
      heading = e.alpha;
      absolute = e.absolute;
      
      updateCompass();
    });
  }
  
  /**
   * Changes the destination to [newDestination].
   */
  void changeDestination(Destination newDestination) {
    destination = newDestination;
    updateLocation();
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
            destinationString, accuracy, heading, absolute);
        
        showingSuccessMessage = false;
        
        updateCompass();
      }
    }
  }
  
  /**
   * Updates the compass heading.
   */
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
