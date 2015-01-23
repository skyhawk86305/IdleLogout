#tag BuildAutomation			Begin BuildStepList Linux				Begin BuildProjectStep Build				End			End			Begin BuildStepList Mac OS X				Begin IDEScriptBuildStep SaveProject , AppliesTo = 0					DoCommand "SaveFile"				End				Begin BuildProjectStep Build				End				Begin IDEScriptBuildStep UnDock , AppliesTo = 0					Dim AppLocation as String = CurrentBuildAppName + ".app"					AppLocation = AppLocation.ReplaceAll( " ", "\ " )					AppLocation = CurrentBuildLocation + "/" + AppLocation										//@ More cocoa info.plist keys here:					//  https://developer.apple.com/library/ios/documentation/general/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html										Call DoShellCommand("/usr/bin/defaults write " + AppLocation + "/Contents/Info ""LSBackgroundOnly"" -bool ""true""")									End				Begin IDEScriptBuildStep tarProject , AppliesTo = 0					// Set Variables					dim packageLoc, res, tarname as string					tarname = "Idle-Logout.tar.bz2"					packageLoc = "/Users/rzm102/Documents/_Programing/CLC\ Git/Software\ Packages/idle-logout/"										if CurrentBuildLocation="/Users/rzm102/Documents/_Programing/Git/IdleLogout/Builds\ \-\ psuIdleLogout.rbvcp/Mac\ OS\ X\ \(Intel\)" OR CurrentBuildLocation="/Users/rzm102/Documents/_Programing/Git/IdleLogout/Builds\ \-\ psuIdleLogout.rbvcp/Mac\ OS\ X\ \(Cocoa\ Intel\)" then					//print "Build Location: "+CurrentBuildLocation										// Tar up folder					res = DoShellCommand _					("cd "+CurrentBuildLocation+"; /usr/bin/tar -c --exclude='.svn' -vjf "+tarname+" *")					if res = "" then					print "Results: "+res					end					// Delete old tar					// print "rm "+packageLoc+tarname					res = DoShellCommand _					("rm "+packageLoc+tarname)										// Move tar to luggage folder					// print "mv "+CurrentBuildLocation+"/"+tarname+" "+packageLoc					res = DoShellCommand _					("mv "+CurrentBuildLocation+"/"+tarname+" "+packageLoc)										// Make package					res = DoShellCommand _					("cd "+packageLoc+"; make pkg; open "+packageLoc)					print res					else					print "Not on rusty's mac. Skipping pkg creation"					//print CurrentBuildLocation//print "Build Location: "+CurrentBuildLocation					end									End			End			Begin BuildStepList Windows				Begin BuildProjectStep Build				End			End#tag EndBuildAutomation