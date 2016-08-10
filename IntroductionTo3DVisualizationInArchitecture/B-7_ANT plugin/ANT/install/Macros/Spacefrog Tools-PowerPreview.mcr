macroScript PowerPreview category:"Spacefrog Tools"	toolTip:"PowerPreview: Enhanced Preview"
(
	local encryptedScript= GetDir #userscripts  + "\SF_PowerPreview.mse" ;
	local vanillaScript=GetDir #userscripts  + "\SF_PowerPreview.ms" ;

	if doesFileExist ( encryptedScript ) then
		filein encryptedScript
	else if doesFileExist ( vanillaScript ) then
		filein vanillaScript
	else
		messageBox "Faulty PowerPreview installation detected. Please reinstall PowerPreview\n or manually copy the file 'SF_PowerPreview.mse' to your user-scripts folder" title:"PowerPreview: mainscript not found!"

)
