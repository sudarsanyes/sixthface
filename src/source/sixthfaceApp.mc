import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Background;

class sixthfaceApp extends Application.AppBase {

    var ui;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
    	if(Toybox.System has :ServiceDelegate) {
            System.println("Temporal Event Created for every 1 hour");
    		Background.registerForTemporalEvent(new Time.Duration(12 * 5 * 60));
    	} else {
    		System.println("( ˘︹˘ )   ---BACKGROUND SERVICES ARE NOT AVAILABLE FOR THIS DEVICE---   ( ˘︹˘ )");
    	}
        Background.registerForTemporalEvent(new Time.Duration(5 * 60));
        System.println("***New View Created!***");
        ui = new sixthfaceView();
        ui.forceMoonAgeCalcuation();
        return [ ui ] as Array<Views or InputDelegates>;
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        ui.updateTheme();
    }

    function getSettingsView() as Array<Views or InputDelegates>? {
        var menu = new sixthfaceMenu();
        return [ menu, new sixthfaceMenuDelegate(menu) ];
    }

    function getServiceDelegate() as Array<Toybox.System.ServiceDelegate> {
        return [new sixthfaceBg()];
    }

    function onBackgroundData (data as Application.PersistableType) {
        // if (ui == null) {
        //     System.println("UI is not created yet!");
        // }
        if (ui != null) {
            ui.forceMoonAgeCalcuation();
        }
        // Reference: System.println("BackgroundData Received: " + data.toString());
    }
}

function getApp() as sixthfaceApp {
    return Application.getApp() as sixthfaceApp;
}