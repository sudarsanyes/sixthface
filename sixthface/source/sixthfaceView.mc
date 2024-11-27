import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time.Gregorian;

class sixthfaceView extends WatchUi.WatchFace {

    var testBg; 
    var theme;
    var activeBg, dawnBg, springBg, summerBg, rainbowBg, nightBg, crystalBg, winterBg, lavaBg, jetblackBg, pumpkinBg;
    var timeFace, fieldFace;
    var faceRadius,viewWidth, viewHeight, viewXCenter, viewYCenter; 
    var hrIterator, stressIterator; 
    var currentWeatherCondition, weatherClear, weatherCloud, weatherRain, weatherSnow, weatherWind, weatherChill, weatherHaze, weatherHail, weatherFog, weatherUnknown;
    var currentFriendlyWeatherCondition;
    var battery;
    var forceMoonAgeCalculation = false;
    var moonAge = 0;
    var secondClockOffset = 0;
    var secondClockName = "";
    var isSecondClockEnabled = true;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc)); 
        
        // Background Images
        testBg = Toybox.WatchUi.loadResource(Rez.Drawables.testBg);
        dawnBg = Toybox.WatchUi.loadResource(Rez.Drawables.dawnBg);
        springBg = Toybox.WatchUi.loadResource(Rez.Drawables.springBg);
        summerBg = Toybox.WatchUi.loadResource(Rez.Drawables.summerBg);
        rainbowBg = Toybox.WatchUi.loadResource(Rez.Drawables.rainbowBg);
        nightBg = Toybox.WatchUi.loadResource(Rez.Drawables.nightBg);
        crystalBg = Toybox.WatchUi.loadResource(Rez.Drawables.crystalBg);
        winterBg = Toybox.WatchUi.loadResource(Rez.Drawables.winterBg);
        lavaBg = Toybox.WatchUi.loadResource(Rez.Drawables.lavaBg);
        jetblackBg = Toybox.WatchUi.loadResource(Rez.Drawables.jetblackBg);
        pumpkinBg = Toybox.WatchUi.loadResource(Rez.Drawables.pumpkinBg);

        // Fonts
        timeFace = Toybox.WatchUi.loadResource(Rez.Fonts.timeFace);
        fieldFace = Toybox.WatchUi.loadResource(Rez.Fonts.fieldFace);

        faceRadius = dc.getWidth() / 2;
        viewWidth = dc.getWidth();
        viewHeight = dc.getHeight();
        viewXCenter = viewWidth / 2;
        viewYCenter = viewHeight / 2;

        weatherClear = Toybox.WatchUi.loadResource(Rez.Drawables.weatherClear);
        weatherCloud = Toybox.WatchUi.loadResource(Rez.Drawables.weatherCloud);
        weatherRain = Toybox.WatchUi.loadResource(Rez.Drawables.weatherRain);
        weatherSnow = Toybox.WatchUi.loadResource(Rez.Drawables.weatherSnow);
        weatherWind = Toybox.WatchUi.loadResource(Rez.Drawables.weatherWind);
        weatherChill = Toybox.WatchUi.loadResource(Rez.Drawables.weatherChill);
        weatherHaze = Toybox.WatchUi.loadResource(Rez.Drawables.weatherHaze);
        weatherHail = Toybox.WatchUi.loadResource(Rez.Drawables.weatherHail);
        weatherFog = Toybox.WatchUi.loadResource(Rez.Drawables.weatherFog);
        weatherUnknown = Toybox.WatchUi.loadResource(Rez.Drawables.weatherUnknown);

        updateTheme();
    }

    function forceMoonAgeCalcuation() {
        var calInfo = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        moonAge = getMoonAge(calInfo.day, calInfo.month, calInfo.year);
    }

    // Updates the theme based on whatever is currently set. 
    function updateTheme() {
        // Read the settings
        var theme = getApp().getProperty("WatchFaceTheme");
        if (theme == 1) {
            activeBg = dawnBg;
        } else if (theme == 2) {
            activeBg = springBg;
        } else if (theme == 3) {
            activeBg = summerBg;
        } else if (theme == 4) {
            activeBg = rainbowBg;
        } else if (theme == 5) {
            activeBg = nightBg;
        } else if (theme == 6) {
            activeBg = crystalBg;
        } else if (theme == 7) {
            activeBg = winterBg;
        } else if (theme == 8) {
            activeBg = lavaBg;
        } else if (theme == 9) {
            activeBg = jetblackBg;
        } else if (theme == 10) {
            activeBg = pumpkinBg;
        }

        var secondClockOffsetFromSettings = getApp().getProperty("WorldClockOffset");
        if (secondClockOffsetFromSettings == 0) {
            secondClockOffset = 0;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 1) {
            secondClockOffset = 60 * 5 * 12;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 2) {
            secondClockOffset = 60 * 5 * 12 * 2;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 3) {
            secondClockOffset = 60 * 5 * 12 * 3;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 4) {
            secondClockOffset = 60 * 5 * 12 * 3.5;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 5) {
            secondClockOffset = 60 * 5 * 12 * 4;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 6) {
            secondClockOffset = 60 * 5 * 12 * 4.5;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 7) {
            secondClockOffset = 60 * 5 * 12 * 5;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 8) {
            secondClockOffset = 60 * 5 * 12 * 5.5;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 9) {
            secondClockOffset = 60 * 5 * 12 * 5.75;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 10) {
            secondClockOffset = 60 * 5 * 12 * 6;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 11) {
            secondClockOffset = 60 * 5 * 12 * 6.5;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 12) {
            secondClockOffset = 60 * 5 * 12 * 7;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 13) {
            secondClockOffset = 60 * 5 * 12 * 8;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 14) {
            secondClockOffset = 60 * 5 * 12 * 9;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 15) {
            secondClockOffset = 60 * 5 * 12 * 10;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 16) {
            secondClockOffset = 60 * 5 * 12 * 11;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 17) {
            secondClockOffset = 60 * 5 * 12 * 12;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 18) {
            secondClockOffset = 60 * 5 * 12 * 12.75;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 19) {
            secondClockOffset = 13;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 20) {
            secondClockOffset = 14;
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 21) {
            secondClockOffset = -(60 * 5 * 12 * 11);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 22) {
            secondClockOffset = -(60 * 5 * 12 * 10);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 23) {
            secondClockOffset = -(60 * 5 * 12 * 9.5);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 24) {
            secondClockOffset = -(60 * 5 * 12 * 9);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 25) {
            secondClockOffset = -(60 * 5 * 12 * 8);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 26) {
            secondClockOffset = -(60 * 5 * 12 * 7);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 27) {
            secondClockOffset = -(60 * 5 * 12 * 6);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 28) {
            secondClockOffset = -(60 * 5 * 12 * 5);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 29) {
            secondClockOffset = -(60 * 5 * 12 * 4);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 30) {
            secondClockOffset = -(60 * 5 * 12 * 3.5);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 31) {
            secondClockOffset = -(60 * 5 * 12 * 3);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 32) {
            secondClockOffset = -(60 * 5 * 12 * 2);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 33) {
            secondClockOffset = -(60 * 5 * 12 * 1);
            isSecondClockEnabled = true;
        } else if (secondClockOffsetFromSettings == 34) {
            secondClockOffset = 0;
            isSecondClockEnabled = false;
        }

        secondClockName = getApp().getProperty("WorldClockOffsetName");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view. 
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        // // Draw the test image
        // dc.drawBitmap(0, 0, testBg);

        // Draw the background
        dc.drawBitmap(-1, 0, activeBg);
        
        // Draw the Time
        dc.setColor(0xffffff, Graphics.COLOR_TRANSPARENT);
 
        var clockTime = System.getClockTime();
        var hourString = Lang.format("$1$", [clockTime.hour.format("%02d")]);
        var minuteString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        dc.drawText(viewXCenter - 60, viewYCenter - 90, timeFace, hourString, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(viewXCenter + 60, viewYCenter - 60, timeFace, minuteString, Graphics.TEXT_JUSTIFY_CENTER);
        
        // Date
        var dayString = Lang.format("$1$", [Gregorian.info(Time.now(), Time.FORMAT_MEDIUM).day_of_week.toString()]);
        dc.drawText(viewXCenter + 45, viewYCenter - 87, fieldFace, dayString, Graphics.TEXT_JUSTIFY_LEFT);
        var dateString = Lang.format("$1$ $2$", [Gregorian.info(Time.now(), Time.FORMAT_MEDIUM).day.toString(), Gregorian.info(Time.now(), Time.FORMAT_MEDIUM).month.toString()]);
        dc.drawText(viewXCenter + 45, viewYCenter - 63, fieldFace, dateString, Graphics.TEXT_JUSTIFY_LEFT);

        // Weather
        if (Weather.getCurrentConditions() != null && Weather.getCurrentConditions().feelsLikeTemperature != null) {
            // Weather Condition Icon
            var currentConditionEnum = Weather.getCurrentConditions().condition;
            var currentCondition = getFriendlyCondition(currentConditionEnum);
            dc.drawBitmap(viewXCenter - 114, viewYCenter + 36, currentCondition);

            // Temperature 
            var feelLikeTemperature = Lang.format("$1$ C", [Weather.getCurrentConditions().feelsLikeTemperature.toNumber().toString()]);
            dc.drawText(viewXCenter - 60, viewYCenter + 24, fieldFace, feelLikeTemperature, Graphics.TEXT_JUSTIFY_LEFT);

            // Friendly Weather Condition
            dc.drawText(viewXCenter - 60, viewYCenter + 48, fieldFace, currentFriendlyWeatherCondition, Graphics.TEXT_JUSTIFY_LEFT);
        }

        // Left Widget --------------------------------------
        // Heart Rate
        hrIterator = ActivityMonitor.getHeartRateHistory(null, true);
        var hr = Activity.getActivityInfo().currentHeartRate;
        if (null != hr) {
            dc.drawText(viewXCenter - 153, viewYCenter - 9, fieldFace, hr.toString(), Graphics.TEXT_JUSTIFY_CENTER);
        }

        // Right Widget --------------------------------------
        // Stress
        var stressLevel;
        if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getStressHistory)) {
            stressLevel = Toybox.SensorHistory.getStressHistory({});
            if(stressLevel != null) {
                stressLevel = stressLevel.next();
            }
            if (stressLevel != null) {
                stressLevel = stressLevel.data;
                dc.drawText(viewXCenter + 156, viewYCenter - 9, fieldFace, getFriendlyStressLevel(stressLevel), Graphics.TEXT_JUSTIFY_CENTER);
            }
        }

        // Draw a progress
        drawProgressFields(dc);

        // Draw the Seconds
        var angle = (getAngleFromTime(clockTime.sec));
        var x = getXFromAngle(angle, (viewWidth / 2) - 18);
        var y = getYFromAngle(angle, (viewHeight / 2) - 18);
        dc.setColor(0x00ff00, 0x00ff00);
        dc.fillCircle(x, y, 6);

        drawMoonAsVector(dc, 228, 162);

        if (isSecondClockEnabled) {
            showSecondaryClocks(dc);
        }
    }

    // Displays the secondary clocks. 
    // Dc is the drawing context. 
    function showSecondaryClocks(dc as Dc) {
        // Second Clock
        var currentClock = Gregorian.utcInfo(Time.now(), Time.FORMAT_SHORT);
        System.println("UTC: " + currentClock.hour.toString() + ":" + currentClock.min.toString() + ":" + currentClock.sec.toString());
        var secondClock;
        if(secondClockOffset < 0) {
            secondClock = Time.now().subtract(new Time.Duration(secondClockOffset * -1));
        } else {
            secondClock = Time.now().add(new Time.Duration(secondClockOffset));
        }
        dc.drawText(105, 70, fieldFace, secondClockName, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(105, 100, fieldFace, Gregorian.utcInfo(secondClock, Time.FORMAT_SHORT).hour.format("%02d").toString(), Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(141, 100, fieldFace, ":", Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(147, 100, fieldFace, Gregorian.utcInfo(secondClock, Time.FORMAT_SHORT).min.format("%02d").toString(), Graphics.TEXT_JUSTIFY_LEFT);
    }

    // Draws the progress fields. 
    // dc is the DrawingContext. 
    function drawProgressFields(dc as Dc) {
        // Start Angle: 120 / 30 for the top progress
        // Start Angle: 30 / 30 for the top progress
        // Start Angle: -60 / 30 for the top progress
        // Start Angle: -150 / 30 for the top progress

        // Draw the background. 
        dc.setColor(0xafafaf, 0xafafaf);
        drawProgressCW(dc, 100, (viewWidth / 2) - 18, 3, viewXCenter, viewYCenter, 120);
        drawProgressCW(dc, 100, (viewWidth / 2) - 18, 3, viewXCenter, viewYCenter, 30);
        drawProgressCW(dc, 100, (viewWidth / 2) - 18, 3, viewXCenter, viewYCenter, -60);
        drawProgressCW(dc, 100, (viewWidth / 2) - 18, 3, viewXCenter, viewYCenter, -150);

        // Draw the progress. 
        dc.setColor(0xffffff, Graphics.COLOR_TRANSPARENT);
        // drawProgressCW(dc, 25, (viewWidth / 2) - 18, 9, viewXCenter, viewYCenter, 120);
        // drawProgressCW(dc, 50, (viewWidth / 2) - 18, 9, viewXCenter, viewYCenter, 30);
        // drawProgressCW(dc, 75, (viewWidth / 2) - 18, 9, viewXCenter, viewYCenter, -60);
        // drawProgressCW(dc, 100, (viewWidth / 2) - 18, 9, viewXCenter, viewYCenter, -150);

        // Battery: 120
        var batteryPercentage = System.getSystemStats().battery.toNumber();
        drawProgressCW(dc, batteryPercentage, (viewWidth / 2) - 18, 9, viewXCenter, viewYCenter, 120);
        if (batteryPercentage == 100) {
            setAccentColor(dc);
            drawProgressCW(dc, 100, (viewWidth / 2) - 30, 3, viewXCenter, viewYCenter, 120);
            setDefaultColor(dc);
        }
        dc.drawText(321, 33, fieldFace, batteryPercentage.toString(), Graphics.TEXT_JUSTIFY_CENTER);

        // Steps: 30
        var info = ActivityMonitor.getInfo();
        var steps = info.steps;
        var stepsGoal = info.stepGoal;
        var stepsPercentage = getPercentage(steps.toFloat(), stepsGoal.toFloat());
        drawProgressCW(dc, stepsPercentage, (viewWidth / 2) - 18, 9, viewXCenter, viewYCenter, 30);
        if (stepsPercentage == 100) {
            setAccentColor(dc);
            drawProgressCW(dc, 100, (viewWidth / 2) - 30, 3, viewXCenter, viewYCenter, 30);
            setDefaultColor(dc);
        }
        dc.drawText(357, 294, fieldFace, getFriendlySteps(steps), Graphics.TEXT_JUSTIFY_CENTER);

        // Steps: -60
        var floorsClimbed = info.floorsClimbed;
        var floorsClimbedGoal = info.floorsClimbedGoal;
        var floorsClimbedPercentage = getPercentage(floorsClimbed.toFloat(), floorsClimbedGoal.toFloat());
        drawProgressCW(dc, floorsClimbedPercentage, (viewWidth / 2) - 18, 9, viewXCenter, viewYCenter, -60);
        if (floorsClimbedPercentage == 100) {
            setAccentColor(dc);
            drawProgressCW(dc, 100, (viewWidth / 2) - 30, 3, viewXCenter, viewYCenter, -60);
            setDefaultColor(dc);
        }
        dc.drawText(96, 339, fieldFace, floorsClimbed.toString(), Graphics.TEXT_JUSTIFY_CENTER);

        // Body Battery: -150
        var bb = null;
        if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getBodyBatteryHistory)) {
            bb = Toybox.SensorHistory.getBodyBatteryHistory({});
            if (bb != null) {
                bb = bb.next();
            }
            if (bb != null) {
                bb = bb.data;
            }
        }
        if(bb != null) {
            drawProgressCW(dc, bb, (viewWidth / 2) - 18, 9, viewXCenter, viewYCenter, -150);
            if (bb == 100) {
                setAccentColor(dc);
                drawProgressCW(dc, 100, (viewWidth / 2) - 30, 3, viewXCenter, viewYCenter, -150);
                setDefaultColor(dc);
            }
            dc.drawText(51, 75, fieldFace, bb.toNumber().toString(), Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    // Get the steps as 1k, 2k, 3k instead of 1000, 2000, 3000, ...:__version
    // Steps is the excact steps. 
    function getFriendlySteps(steps as Number) {
        if (steps <= 999) {
            return steps.toString();
        } else {
            return (steps / 1000) + "k";
        }
    }

    // Sets the accent color (green). 
    // dc is the DrawingContext. 
    function setAccentColor(dc as Dc) {
        dc.setColor(0x00ff00, Graphics.COLOR_TRANSPARENT);
    }

    // Sets the default color (white). 
    // dc is the DrawingContext. 
    function setDefaultColor(dc as Dc) {
        dc.setColor(0xffffff, Graphics.COLOR_TRANSPARENT);
    }

    // Finds the percentae from a given value and goal. 
    // Value is the current value. 
    // Goal is the target to achieve. 
    function getPercentage(value as Float, goal as Float) {
        var percentage = (value / goal) * 100;
        if(percentage >= 100) 
        {
            percentage = 100;
        }
        return percentage;
    }
    
    // Get the angle from time. 
    // val is the sec, min, or hour. 
    function getAngleFromTime(val as Number) {
        return (((val * 360) / 60));
    }

    // Gets the X from the angle in degrees. 
    // Angle to which the X needs to be calculated. 
    // Radius is the radius of the circle to use to find the angle. 
    function getXFromAngle(angle as Number, raidus as Number) {
        var x = ((raidus) * Math.cos(angle * (Math.PI / 180))) + 209;
        return x;
    }

    // Gets the Y from the angle in degrees. 
    // Angle to which the Y needs to be calculated. 
    // Radius is the radius of the circle to use to find the angle. 
    function getYFromAngle(angle as Number, raidus as Number) {
        var y = ((raidus) * Math.sin(angle * (Math.PI / 180))) + 209;
        return y;
    }
    
    // Draw the progress as an arc oin clockwise direction. 
    // dc is Drawing Context. 
    // percentage is the progress in %. 
    // Radius of the arc. 
    // pen as Pen Width. 
    // X for x-asis. Y for y-axis. 
    // Start is the place to start the arc. 
    function drawProgressCW(dc as Dc, percentage as Number, rad as Number, pen as Number, x as Number, y as Number, start as Number) {
        if(percentage != 0) {
            var endAngle = (percentage * 60) / 100;
            var actualEndAngle = 360 - (endAngle - start);
            dc.setPenWidth(pen);
            dc.drawArc(x, y, rad, Graphics.ARC_CLOCKWISE, start, actualEndAngle);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    // Get the stress level as Resting, Low, Medium, and High. 
    // StressLevel is a level between 0 and 100. 
    function getFriendlyStressLevel(stressLevel as Number) {
        if (stressLevel >= 0 && stressLevel <= 25) {
            return "R";
        } else if (stressLevel >= 26 && stressLevel <= 50) {
            return "L";
        } else if (stressLevel >= 51 && stressLevel <= 75) {
            return "M";
        } else if (stressLevel >= 76 && stressLevel <= 100) {
            return "H";
        } else {
            return "?";
        }
    }

    // Get friendly weather condition like Clear, Cloudy, Rain, ...:__version
    // Condition is the forecast enumeration number. 
    function getFriendlyCondition(condition as Number) {
        if (condition == 0 || condition == 22 || condition == 23 || condition == 40 || condition == 52) {
            currentWeatherCondition = weatherClear;
            currentFriendlyWeatherCondition = "Clear";
        } else if (condition == 1 || condition == 2 || condition == 14 || condition == 20) {
            currentWeatherCondition = weatherCloud;
            currentFriendlyWeatherCondition = "Cloudy";
        } else if (condition == 3 || condition == 6 || condition == 11 || condition == 12 || 
                condition == 15 || condition == 19 || condition == 24 || condition == 25 || 
                condition == 26 || condition == 27 || condition == 28 || condition == 31 ||
                condition == 41 || condition == 42 || condition == 44 || condition == 45 || 
                condition == 50) {
            currentWeatherCondition = weatherRain;
            currentFriendlyWeatherCondition = "Rain";
        } else if (condition == 4 || condition == 16 || condition == 17 || condition == 18 || 
                condition == 21 || condition == 43 || condition == 46 || condition == 47 || 
                condition == 48 || condition == 49 || condition == 51) {
            currentWeatherCondition = weatherSnow;
            currentFriendlyWeatherCondition = "Snow";
        } else if (condition == 5 || condition == 32 || condition == 36) {
            currentWeatherCondition = weatherWind;
            currentFriendlyWeatherCondition = "Wind";
        } else if (condition == 7) {
            currentWeatherCondition = weatherChill;
            currentFriendlyWeatherCondition = "Chill";
        } else if (condition == 8) {
            currentWeatherCondition = weatherFog;
        } else if (condition == 9 || condition == 30 || condition == 33 || 
                condition == 35 || condition == 37 || condition == 38 || 
                condition == 39) {
            currentWeatherCondition = weatherHaze;
            currentFriendlyWeatherCondition = "Haze";
        } else {
            currentWeatherCondition = weatherUnknown; 
            currentFriendlyWeatherCondition = "Crazy";
        }

        return currentWeatherCondition;
    }

    // Draws a moon as vector that matches the age. dc is Dc; dd is today; mm is this month; yy is this year; x is the x pos; y is the y pos; 
    function drawMoonAsVector(dc as Dc, x, y) {
		var A = moonAge;
        if (false) { 
            A = 29.53 - A; 
        }
		var w = 15;
		var F = 14.765, Q = F/2.0, Q2 = F+Q;
		
		var s=A<F ? 0:180;
		dc.setPenWidth(w);
        dc.setColor(0xFFFFFF, -1);
		dc.drawArc(x, y, w/2, Graphics.ARC_CLOCKWISE, 270+s, 90+s);
		var p = w/Q*(A>F ? A-F:A);
        p = w - p;
		var c = A<Q||A>Q2? 0:0xFFFFFF;
		dc.setPenWidth(2);
        dc.setColor(c, -1);
		dc.fillEllipse(x, y, p.abs(), w);
		dc.setColor(0xFFFFFF, -1);
		dc.drawCircle(x, y, w);
    }

    function getJulianDate(d as Number, m as Number, y as Number) { 
        var mm, yy;
        var k1, k2, k3;
        var j;

        yy = y - ((12 - m) / 10);
        mm = m + 9;
        if (mm >= 12) {
            mm = mm - 12;
        }
        k1 = (365.25 * (yy + 4712));
        k2 = (30.6001 * mm + 0.5);
        k3 = (((yy / 100) + 49) * 0.75) - 38;
        // 'j' for dates in Julian calendar:
        j = k1 + k2 + d + 59;
        if (j > 2299160) {
            // For Gregorian calendar:
            j = j - k3; // 'j' is the Julian date at 12h UT (Universal Time)
        }
        return j; 
    }

    function getMoonAge(d as Number, m as Number, y as Number) { 
        var j = getJulianDate(d, m, y);
        var ag;
        //Calculate the approximate phase of the moon
        var ip = (j + 4.867) / 29.53059;
        ip = ip - Math.floor(ip); 
        if(ip < 0.5) {
            ag = ip * 29.53059 + 29.53059 / 2;
        } else {
            ag = ip * 29.53059 - 29.53059 / 2;
        } 
        // Moon's age in days
        ag = Math.floor(ag) + 1;
        return ag;
    }
}