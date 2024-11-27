import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time.Gregorian;

class sixthfaceMenu extends WatchUi.Menu2 {

    var item1 = new MenuItem("Dawn", null, 1, null);
    var item2 = new MenuItem("Spring", null, 2, null);
    var item3 = new MenuItem("Summer", null, 3, null);
    var item4 = new MenuItem("Rainbow", null, 4, null);
    var item5 = new MenuItem("Night", null, 5, null);
    var item6 = new MenuItem("Crystal", null, 6, null);
    var item7 = new MenuItem("Winter", null, 7, null);
    var item8 = new MenuItem("Lava", null, 8, null);
    var item9 = new MenuItem("Jetblack", null, 9, null);
    var item10 = new MenuItem("Pumpkin", null, 10, null);

    function initialize() {
        Menu2.initialize(null);
        setTitle("Theme");
        addItem(item1);
        addItem(item2);
        addItem(item3);
        addItem(item4);
        addItem(item5);
        addItem(item6);
        addItem(item7);
        addItem(item8);
        addItem(item9);
        addItem(item10);
    }
}

class sixthfaceMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize(menu) {
        Menu2InputDelegate.initialize();
    }

    function onSelect(menuItem as WatchUi.MenuItem) {
        if (menuItem.getId() == 1) {
            getApp().setProperty("WatchFaceTheme", 1);
        } else if(menuItem.getId() == 2) {
            getApp().setProperty("WatchFaceTheme", 2);
        } else if(menuItem.getId() == 3) {
            getApp().setProperty("WatchFaceTheme", 3);
        } else if(menuItem.getId() == 4) {
            getApp().setProperty("WatchFaceTheme", 4);
        } else if(menuItem.getId() == 5) {
            getApp().setProperty("WatchFaceTheme", 5);
        } else if(menuItem.getId() == 6) {
            getApp().setProperty("WatchFaceTheme", 6);
        } else if(menuItem.getId() == 7) {
            getApp().setProperty("WatchFaceTheme", 7);
        } else if(menuItem.getId() == 8) {
            getApp().setProperty("WatchFaceTheme", 8);
        } else if(menuItem.getId() == 9) {
            getApp().setProperty("WatchFaceTheme", 9);
        } else if(menuItem.getId() == 10) {
            getApp().setProperty("WatchFaceTheme", 10);
        }

        WatchUi.popView(SLIDE_DOWN);
        getApp().onSettingsChanged();
        // WatchUi.requestUpdate();
    }
}