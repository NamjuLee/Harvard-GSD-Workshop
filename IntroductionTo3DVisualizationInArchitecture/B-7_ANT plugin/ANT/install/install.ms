(
	global NJSLAB

	try ( DestroyDialog NJSLAB ) catch()

	local minMaxVersion = 14000

	local messageBoxTitle = "ANT for animation, Alpha 0.5.1 Install"

	local sourceScript =(GetDir #temp)+ "/PowerPreview/Scripts/SF_PowerPreview.mse"
	--local sourceMacro =(GetDir #temp)+ "/PowerPreview/Macros/Spacefrog Tools-PowerPreview.mcr"

	local targetScript = (GetDir #userscripts)  + "\\SF_PowerPreview.mse"
	local targetMacro = (GetDir #usermacros)  + "\\Spacefrog Tools-PowerPreview.mcr"
	local targetText = " Files getting installed width PowerPreview Beta:\n " + targetScript + "\n " + targetMacro

	
	
	
	
	
	rollout NJSLAB "ANT for Animation" width:299 height:168
	(
		GroupBox grp1 "ANT for animation, Alpah 0.5.1" pos:[3,7] width:290 height:156
		button btInstall "Install" pos:[14,25] width:270 height:73

		button Website "Website" pos:[14,104] width:270 height:28
		label lbl1 "NJSLAB Since 2004" pos:[17,141] width:215 height:15



		on btInstall pressed do
		(
			reallyInstall=true
		
			if( reallyInstall ) then
			(
				
				
				
				if( DoesFileExist targetScript OR DoesFileExist targetMacro) then
				(
					if( (queryBox "PowerPreview installation detected.\nDelete the existing version and continue installing?" title:"PowerPreview Files detected" ) == true ) then
					(
						try( DeleteFile targetScript ) catch()
					    try( DeleteFile targetMacro ) catch()
					)
					else return -1
				)
				
				
				
				if( copyFile sourceScript targetScript AND copyFile sourceMacro targetMacro ) then
				(
					MessageBox "PowerPreview Beta installed successfully...\nPlease restart 3ds Max" title:messageBoxTitle
					return 0
				)
				else
				(
					MessageBox "Error installing PowerPreview Beta..." title:messageBoxTitle
				)
			)
		)
		on Website pressed do
		(
			process=dotnetclass "System.Diagnostics.Process"
			process.start "http://www.njstudio.co.kr/NJSLAB/ANT/index.html"
		)
	)

	if( (Maxversion())[1] < minMaxVersion ) then
	(
		messageBox "PowerPreview is optimized for 3ds Max/3ds Max Design 2012 or newer using Nitrous viewport.\nOlder version has been detected, PowerPreview setup will continue though..." title:"Non-Nitrous enabled 3ds Max Version" beep:true
	)
	CreateDialog dsRollout --modal:true

)