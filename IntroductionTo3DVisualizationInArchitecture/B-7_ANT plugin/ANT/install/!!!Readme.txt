/* PowerPreview Comment Header
-------------------------------------------------------------------------------------------------------------------------------------------
---- PowerPreview V0.60- Beta 6
-------------------------------------------------------------------------------------------------------------------------------------------
---- Power Preview :  High Quality Nitrous Preview  - !!! BETA RELEASE !!!
---- Created:  June  6, 2011
---- Modified: April 12, 2012
-------------------------------------------------------------------------------------------------------------------------------------------

LIMITS EXISTING UP TO THIS VERSION:
----	3ds Max Bug:  bitmaps/AVIS saved via maxscript ALWAYS are written using an output gamma of 1.0, they do not respect the settings in the gamma setup dialog
----	3ds Max Bug:  AVI files bigger than 1GB get corrupted ( they do not grow beyond 1GB), please file a bug report at Autodesk (fixed in Max 2013 )
----	3ds Max Limitation: 3ds Max has to be the foreground application, otherwise Nitrous will stop refining the viewport progressively
----	Because of the previous issue IT'S IMPORTANT TO DISALBE THE SCREENSAVER, energy mode which turns off the display is okay though
----	pressing "Cancel" on 32 bit Max might crash 3ds Max, this is currently under investigation
----	if the target file is locked (eg. playing in an AVI Player, PowerPreview reports an "Internal Error"
----	having the output set to an image sequence while having "Autoplay" enabled might produce an error after the preview was generated
----
----	Advanced Nitrous options ( eg. dynamic reflections) tend to fail from time to time on lower end GPUs
----	Workarround: set timebudget high enough, press create preview/snapshot, look at output: if something's wrong, toggle the Nitrous option on&off
----	This will eventually bring the nitrous output back to advanced again, if everything is okay, turn down the timebudget again and let the preview be created
-------------------------------------------------------------------------------------------------------------------------------------------

HISTORY:
---- Version:  V0.60 - Beta 6
----	Increased resolution limit again ti 6.4Kx6.4K -> going beyond that risks severe graphics driver crashes (bluescreen, reboot etcc )
---		fixed unintended bitmap scaling during screen grab, this caused subtle graphics artefacts, especially visible on wireframe previews
---		implemented basic preview creation mode switching feature, now you can choose between various methods, currently default 3ds Max's "Make Preview" only
---		Filename postfixing based on token expansion added ( known tokens "%scene", "%view", "%date", "%time","%begin","%end"), added checkboxes for some convenience
---		DOF/Boken shape/image handling added:  per viewport bokeh shape mechanism implemented
---		UI rearranged,introduced "Minimal UI" button, Progressive refinement OFF checkbox added for quick previews
---		various additional fixes...

---- Version:  V0.51a - Beta 5, DC20120216, HOTFIX
----	Fixed "visibility in undefined" error for people having the viewcube-plugin completly removed
----	Please note regarding the gamma fixes: due to a Max bug/Limitation, maxscript always uses an output gamma value of 1.0 when it saves a bitmap
----	Thus when doing a "Preview", the current display gamma settings are applied to the written files, this means it' provides complete WYSIWYG ("What you see is what you get")
----	Contrary to that, when doing a "Viewport Snapshot" and using the framebuffer save button to save the bitmap, the current "output gamma" setting is applied to the written image

---- Version:  V0.51 - Beta 5, DC20120215
----	Fixed filename-frame numbering when writing to  image sequence
----	Fixed double gamma issues with snapshot mode when display gamma is enabled
----	Implemented ViewCube hiding ;-)
---- 	Implemented basic UI and options for upcoming nitrous features (DOF,Bokeh)

---- Version:  V0.50c - Beta 4, DC20120104, HOTFIX
----	Fixed time jumping bug during simple snapshot creation
----	Implemented simple Nitrous glitch recovery mechanism (still experimental)
----
---- Version:  V0.50b - Beta 4, DC20111221, HOTFIX
----	Fixed stupid installer bug: install only executed when existing PowerPreview install was detected - D'oh!!!!!
----	Removed Dummy D3D button in Direct 3D mode - D3D options still wait to be implemented....

---- Version:  V0.50a - Beta 4, DC20111220
----	Complete GUI rework, now features flexible rollout support, minimizing etc...
----	Introduced Nitrous config rollout ( look for dynamic reflection option , a buggy Nitrous feature, but works most of the time)
----	Introduced Viewport SnapShot feature, supporting the same resolutions and viewport features like the preview creation tool
----	Implemented update check feature, simply press a button to know if you have the latest Version installed (see About rollout )
----	Implemented timerange configurability, fixed bugs in previous versions related to timeline changes in the scene
----	Implemented Object Category Filtering and rudimentary overlay options (WIP)
----	cranked up limits ( timelimit to 90 secs, max. resolution to 5000 x 5000 )
    	
---- Version:  V0.46a - Beta 3, DC20111212
----	implemented compatbility wiht German and French Max Versions
----	further improved UI logic and behavior
----	Improved future and internal 3d Max version stability
    	
---- Version:  V0.45c - Beta 2, DC20111210, HOTFIX
----	fixed crash-to-desktop bug after preview creation on 32bit 3ds Max Versions
----	Fixed bug which could cause 3ds Max dialogs and menus to close immediatly after preview generation
----	Improved parts of the UI and the viewport change dedection code ( still work in progress )
----
---- Version:  V0.45b - Beta 1, DC20111205
----	Fixed various UI related issues, which messed with the parameters on viewport selection
----	Reimplemented iteration-based limiting ( enabled by default, set to 2048 preogressive refinement iterations)
----	Note: all parameters in timebudget group can be adjusted on the fly while a preview is in preogress..
----	Statustext reflects wether the last frame had hit the time based limit, or the iteration limit
----	Fixed framerange detection ( WIP ), parameters are updated when "Create Preview" is pressed
----	Script works now in Direct3D mode too, without any delay ( no progressive options in D3D mode)
----
---- Version:  V0.40c - Initial Alpha Release, DC20110728
----
---- Author:   
----	Josef Wienerroither aka "spacefrog"  www.frogsinspace.at  | spacefrog@chello.at
-------------------------------------------------------------------------------------------------------------------------------------------

FUTURE PLANS:
----
----	Too many to list
-------------------------------------------------------------------------------------------------------------------------------------------

INSTALL:
----
---- 	3ds Max Version 2012 and up with Nitrous viewport enabled recommended
---- 	Use automatic installer or copy the zip contents to your 3ds Max folders manually....
----    "Spacefrog Tools-PowerPreview.mcr" should go to your "usermacros/macroscripts" folder
----    "SF_PowerPreview.mse"  should go to your userscripts folder ( usually "[MaxRoot]\Scripts\" )
----
----	Assign keyboard-shortcut/button or menu to "PowerPreview: Enhanced Preview" in the "Spacefrog Tools" category
----
-------------------------------------------------------------------------------------------------------------------------------------------

USAGE:
----
----	Start the script via your prefered method and select the viewport you want a preview generated from...
----	The script detects when you select a viewport and adjusts its output resolution automatically,
----	To create "bigger than screen" previews use "Preview Scale Factor" - slider and/or resolution spinners
----	Set the output file and format, codecs available on 64 bit are limited ( 3ds Max bug )
----	Adjust the timebudget( ms) and iterations ( count) you want Nitrous to give per frame,
----	You can re-adjust both budgets during preview creation, if you see that Nitrous is not able to reach your required quality
----	Nitrous options are currently "live" too
----
-------------------------------------------------------------------------------------------------------------------------------------------

NOTES:
----
----	The script is encrypted as long as i consider it as a draft and unstable proof of concept.
----	Please do not share the script or the download link to the script,
----	There are bugs, quirks and shortcomings in the script of course, i'm not quite sure when and if i should develop it further
----
----	Feedback welcome,  please post here on the board or on scriptspot,
----	Of course i do not take responsibility if the script burns your GPU, toasts your hamster or turns you into a bunny, you have been warned!
----	Happy Previewing! 
----	
-------------------------------------------------------------------------------------------------------------------------------------------