part of treasure_hunt;

/**
 * A destination representing a point on the map.
 */
class Destination {
  String name;
  LatLng latLng;
  
  String successTitle;
  String successImage;
  String successMessage;
}

/**
 * Function to create a list of all available destinations.
 */
List<Destination> createDestinations() {
  List<Destination> dests = [];
  
  dests.add(new Destination()
      ..name = 'Bundeshaus (Federal Palace)'
      ..latLng = new LatLng(46.946240, 7.444588)
      ..successTitle = 'Awesome, you are at the Bundeshaus!'
      ..successImage = 'resources/images/bundeshaus.jpg'
      ..successMessage = 'Make a selfie of you and the view behind the Bundeshaus.');

  dests.add(new Destination()
      ..name = 'Zytglogge (Clock Tower)'
      ..latLng = new LatLng(46.947953, 7.447801)
      ..successTitle = 'Great, you\'ve reached the Zytglogge!'
      ..successImage = 'resources/images/zytglogge.jpg'
      ..successMessage = 'Please take a picture of the clock.');

  dests.add(new Destination()
      ..name = 'Bärengraben (Bear Pit)'
      ..latLng = new LatLng(46.947992, 7.459366)
      ..successTitle = 'Nice! You are at the Bear Pit!'
      ..successImage = 'resources/images/bear.jpg'
      ..successMessage = 'Try to take a picture of a bear.');

  dests.add(new Destination()
      ..name = 'Vor der WG'
      ..latLng = new LatLng(46.892780, 7.500639)
      ..successTitle = 'Nice! You\'ve found it!'
      ..successImage = 'resources/images/brunnen.gif'
      ..successMessage = 'Enjoy.');
  
  return dests;
}