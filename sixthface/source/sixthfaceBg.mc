using Toybox.Background;
using Toybox.System;

// The Service Delegate is the main entry point for background processes
// our onTemporalEvent() method will get run each time our periodic event
// is triggered by the system.

(:background)
class sixthfaceBg extends Toybox.System.ServiceDelegate {
	
	function initialize() {
		System.ServiceDelegate.initialize();
	}
	
    function onTemporalEvent() {
        System.println("Temporal Event Occured!");
		Background.exit("Data from sixthfaceBg!");
    }
}