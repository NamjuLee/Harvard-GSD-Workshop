(

rollout rollout_ABOUT " ABOUT" width:40 height:194
(
	button NJSLAB "NJS LAB" pos:[5,5] width:47 height:24 -- images:#("..\..\BT_About_0A.bmp", "BT_About_0B.bmp", 1, 1, 1, 1, 1) toolTip:"About NJSTUDIO"
	button LEGO "LEGO" pos:[5,35] width:47 height:24
	
	on LEGO pressed do
	(
			try (closeRolloutFloater aboutNJS) catch()
			filein "AboutLEGO.ms"
		)
		
	on NJSLAB pressed do
	(
			try (closeRolloutFloater aboutNJS) catch()
			filein "AboutNJSLAB.ms"
		)
)




rollout rollout2 "LEGO" width:40 height:199
(
	
	button Keybase "KEY  BASE" pos:[5,5] width:47 height:47 --images:#("BT_Key_Base_0A.bmp", "BT_Key_Base_0B.bmp", 1, 1, 1, 1, 1) toolTip:"Key base generator"
	button Nodbase "NODE  BASE" pos:[5,59] width:47 height:47-- images:#("BT_Node_Base_0A.bmp", "BT_Node_Base_0B.bmp", 1, 1, 1,1, 1) toolTip:"Node base generator "
	button Option "NODE  BASE" pos:[5,112] width:47 height:47 --images:#("BT_Lego_option_0A.bmp", "BT_Lego_option_0B.bmp", 1, 1, 1, 1, 1) toolTip:"Options "
	
		
	on Keybase pressed do
	(
		filein  "Lego.ms" 

	)
	
	
	on Option pressed do
	(
			filein "Lego.ms"
			--internet.CheckConnection url:http://www.njstudio.co.kr force:true
		)
)








rollout rollout3 "T BOX" width:40 height:199
(
	
	button BT_Tool_Box_1 "KEY  BASE" pos:[5,5] width:47 height:47-- images:#("BT_Tool_Box_1_0A.bmp", "BT_Tool_Box_1_0B.bmp", 1, 1, 1, 1, 1) toolTip:"Tool box for transfrom"

	
	on Option pressed do
	(
			filein "Lego.ms" quiet=true
			--internet.CheckConnection url:http://www.njstudio.co.kr force:true
		)
)



NJSTUDIOLAB = newRolloutFloater "NJSTUDIO LAB " 70 2000-- bgcolor:(color 130 136 192) style:#(#style_toolwindow, #style_sysmenu)



addRollout rollout2 NJSTUDIOLAB rolledUp:false
addRollout rollout3 NJSTUDIOLAB rolledUp:false
addRollout rollout_ABOUT NJSTUDIOLAB rolledUp:true



cui.RegisterDialogBar NJSTUDIOLAB minSize:[70,135] maxSize:[75,2000] --style:#(#cui_dock_lef)
cui.DockDialogBar NJSTUDIOLAB #cui_dock_left 
--cui.getDockState #cui_dock_left --  #cui_dock_left   #cui_dock_top   #cui_dock_right   #cui_dock_bottom

/*
cui.UnRegisterDialogBar NJSTUDIOLAB
*/

)
