script AppDelegate
	property parent : class "NSObject"
    
    property statusMenu : missing value
    
    property _statusItem : missing value
    property twService : missing value
    
    on tweet_(sender)
        set shareItems to current application's NSMutableArray's alloc's initWithObjects_(missing value)
        tell twService to performWithItems_(shareItems)
        --delay 0.5
        --tell application "System Events" to tell process me to keystroke (ASCII character 28)
    end
	
    on setupStatusItem()
        set systemStatusBar to systemStatusBar() of current application's NSStatusBar
        tell systemStatusBar to set _statusItem to statusItemWithLength_(current application's NSVariableStatusItemLength)
        tell _statusItem to setHighlightMode_(1)
        --tell _statusItem to setTitle_("Tweeter")
        tell current application's NSImage to imageNamed_("TweeterIconTemplate")
        tell _statusItem to setImage_(result)
        tell _statusItem to setMenu_(statusMenu)
    end
    
    on hotkeyWithEvent_(hkEvent)
        tell me to tweet_(me)
    end
    
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
        tell me to setupStatusItem()
        set twService to current application's NSSharingService's sharingServiceNamed_(current application's NSSharingServiceNamePostOnTwitter)
        set twService's delegate to me
        set c to current application's DDHotKeyCenter's alloc's init()
        tell c to registerHotKeyWithKeyCode_modifierFlags_target_action_object_(45,1572864,me,"hotkeyWithEvent:",null)
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
    on applicationShouldTerminateAfterLastWindowClosed_(sender)
		return current application's NSTerminateNow
	end applicationShouldTerminateAfterLastWindowClosed_
    
end script