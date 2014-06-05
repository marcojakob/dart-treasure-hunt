part of treasure_hunt;

/**
 * Class managing the destination dropdown.
 */
class DestinationDropdown {
  
  Element titleElement = querySelector('#dest-title');
  UListElement menuElement = querySelector('#dest-menu');
  
  /**
   * Constructor for the [DestinationDropdown]. Initializes the dropdown with
   * the specified [destinations].
   */
  DestinationDropdown(List<Destination> destinations) {
    menuElement.children.clear();
    
    for (Destination dest in destinations) {
      LIElement item = createMenuItem(dest);
      menuElement.children.add(item);
    }
  }
  
  /**
   * Creates a new destination menu item for [dest].
   */
  LIElement createMenuItem(Destination dest) {
    AnchorElement a = new AnchorElement()
        ..href = '#'
        ..text = dest.name
        ..onClick.listen((e) {
          e.preventDefault(); // Prevent browser from following the link.
          destinationChanged(dest);
        });

    LIElement li = new LIElement()..children.add(a);

    return li;
  }
  
  /**
   * Updates the dropdown to show the destination [title].
   */
  void setDestinationTitle(String title) {
    titleElement.text = title;
  }
  
  /**
   * Handle change of destination to [newDestination].
   */
  void destinationChanged(Destination newDestination) {
    locationManager.changeDestination(newDestination);
    destinationDropdown.setDestinationTitle(newDestination.name);
  }
}


/**
 * Class managing the display of infos (distance, current
 * location and other relevant information). 
 */
class InfoPanel {
  
  Element infoElement = querySelector('#info-panel');
  
  /**
   * Displays information about the [distance] and the locations in an info 
   * panel. The [currentLocation] and [destination] are String representations
   * of the latitude/longitude.
   */
  void showLocationInfo(double distance, String currentLocation, 
                        String destination, double accuracy, double heading,
                        bool absolute) {
    
    var distanceInfo = new HeadingElement.h3()
        ..text = 'Distance: ${distance.round()}m';
    var positionInfo = new Element.html(
        '''
        <p>
          Your Location: ${currentLocation}<br>
          Destination: ${destination}<br>
          Accuracy: ${accuracy}m<br>
          Heading: ${heading}m<br>
          Absolute North: ${absolute}
        </p>
        ''');
    
    // Clear info panel and add location info.
    infoElement.children
        ..clear()
        ..add(distanceInfo)
        ..add(positionInfo);
  }
  
  /**
   * Shows a messageinside the info element.
   */
  void showMessage(String title, String image, String message) {
    var titleElement = new HeadingElement.h2()
        ..text = title;
    var imageElement = new ImageElement()
        ..src = image;
    var messageElement = new ParagraphElement()
        ..text = message;
    
    // Clear info panel and add title and message.
    infoElement.children
        ..clear()
        ..add(titleElement)
        ..add(imageElement)
        ..add(messageElement);
  }
}

/**
 * Class managing the compass heading and its needle.
 */
class Compass {
  
  ImageElement compassElement = querySelector('#compass');
  ImageElement needleElement = querySelector('#needle');
  
  /**
   * Update the heading of the compass and needle.
   */
  void updateHeading(double compassHeading, double needleHeading) {
    if (compassHeading == null) {
      compassHeading = 0.0;
    }
    if (needleHeading == null) {
      needleHeading = 0.0;
    }
    compassElement.style.transform = 'rotate(${compassHeading}deg)';
    needleElement.style.transform = 'rotate(${compassHeading + needleHeading}deg)';
  }
}

/**
 * Class managing alerts shown on the screen.
 */
class Alerts {
  
  Element errorAlert = querySelector('#error-alert');
  
  /**
   * Shows an error alert message. Previous error alerts are cleared.
   */
  void showError(String message) {
    clearError();
    
    var alert = new Element.html(
        '''
        <div class="alert alert-danger">
          <strong>Error! </strong>${message}
        </div>
        ''');

    errorAlert.children.add(alert);
  }

  /**
   * Clears the error alert.
   */
  void clearError() {
    errorAlert.children.clear();
  }
}