try (closeRolloutFloater LEGOBuildingAnimation) catch()



global _about, rollout1, rollout2, rollout3, rollout4


rollout _about "About :: LEGO Building Animation " width:540 height:194
(
	bitmap bmplogo "Bitmap" pos:[6,6] width:525 height:109 enabled:true fileName:"iconTop_01.png" border:false 
 
 
	label lbl1 " Alpha version 0.1.5 
 Email nj.namju@gmail.com 
 www.LEGOBuildingAnimation.com. 
 www.NJSTUDIO.co.kr 
 Copyright (c) 2010-2013, NJ STUDIO" pos:[8,120] width:523 height:70
	label lbl8 "Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription " pos:[233,129] width:291 height:54
	
)

rollout rollout1 "First Step :: Selection Set" width:540 height:118
(
	fn spline_filt obj = classof obj == line 	--filter all objects of class Box:

	button UseUurrentSelection "Use current selection" pos:[17,26] width:115 height:69
	GroupBox Selection_set "Selection set" pos:[11,9] width:516 height:96
	button btn18 "By click with links" pos:[269,68] width:113 height:20
	button btn16 "By a layer" pos:[395,41] width:116 height:20
	button btn167 "By Excel file" pos:[395,68] width:116 height:20

	GroupBox grp12 "Description" pos:[260,21] width:262 height:75
	pickbutton chooseit "By a closed spline" pos:[269,41] width:113 height:20 -- filter:spline_filt()
	label lbl60 "Discription Discription Discription Discription Discription Discription Discription Discription Discription " pos:[140,28] width:98 height:67

	
	
	
	
	on UseUurrentSelection pressed do
	with undo "undo" on
	( 

		
	)
		
	
	
	-- Selection by a closed spline
	on chooseit picked obj do with undo "undo" on
	(
	
		--see if the user did not cancel the picking...
		if obj != undefined do
			(
			
			tempSpline = copy obj
			convertToMesh tempSpline
				
			selObjs = #()	
			
			for i in selection collect
					(
					 r = ray i.pos [0,0,-1]
					 crash = intersectray tempSpline r
					 if crash != undefined do
					  append selObjs i
					)
	
			select selObjs
			delete tempSpline
			completeRedraw()
			)
	) -- end chooseit
	
	
	
	
) -- end rollout1










rollout rollout1 "Second Step :: Animation Ordering  " width:540 height:168
(
	GroupBox grp12 "Re-ordering" pos:[12,9] width:516 height:79
	dropdownList preset "Current preset" pos:[129,26] width:84 height:41 enabled:true items:#("Custom", "Very samll", "Small", "Medium", "Large", "Very large")
	
	button Re_Ordering "Re-ordering" pos:[19,29] width:74 height:43
	dropdownList ddl4 "First" pos:[264,32] width:44 height:41 items:#("+X", "-X", "+Y", "-Y", "+Z", "-Z")
	dropdownList ddl5 "Second" pos:[365,32] width:44 height:41 items:#("+X", "-X", "+Y", "-Y", "+Z", "-Z")
	dropdownList ddl6 "Third" pos:[461,32] width:44 height:41 items:#("+X", "-X", "+Y", "-Y", "+Z", "-Z")
	GroupBox grp65 "Random deselection" pos:[255,103] width:264 height:51 enabled:true
	button Random_ordering "Random" pos:[21,108] width:71 height:44
	button btn_deselection "Deselection" pos:[263,125] width:64 height:21
	spinner randomvalue1 "" pos:[330,128] width:44 height:16 enabled:true range:[0,100,50] type:#float 	
 	
	progressBar pb_re_ordering "ProgressBar" pos:[23,75] width:222 height:8 color:(color 255 255 255)
 	
	GroupBox grp339 "Random ordering" pos:[255,18] width:262 height:59
	GroupBox grp345 "Random ordering" pos:[13,89] width:516 height:72
	button btn83 "More selection" pos:[381,124] width:81 height:21
	spinner spn661 "" pos:[465,126] width:44 height:16 enabled:true range:[0,100,50] type:#float
 	
	label lbl6 "Discription, Ordering" pos:[101,111] width:142 height:40
 	

-- XYZ order in a given selection
	fn sortObjs objArray =
	(
		pb_re_ordering.value = 0 	--print spin_fromx.value
		
		for i in 1 to objArray.count do
		(
			for q in 1 to objArray.count do
			(	
				if keyboard.escPressed do exit
					
				if objArray[i].center.z < objArray[q].center.z do
				swap objArray[i] objArray[q]
				
				if objArray[i].center.y < objArray[q].center.y do
				swap objArray[i] objArray[q]
				
				if objArray[i].center.x < objArray[q].center.x do
				swap objArray[i] objArray[q]
			)
		pb_re_ordering.value = (i as float  / objArray.count) *100
		)
		
	  return objArray
	)



		


fn RandomOrder selection =  -- Random order in a given selection
		(

		 --selectobj = objectsel
		 i = 0
		 randomselection = #()

		  while i < selection.count do (
		   s_ = selection[(random 1 selection.count)]
			if (finditem randomselection s_) == 0 then 
			 (
			  append randomselection s_
			  i +=1  
			 )
			else print 
			
		  )
		
		 return randomselection
		)



fn randomdeselction selection randomvalue1 =  -- random De-Selection
		(
			newselection = #()
			
			for obj in selection do (
				if (random 0.0 100.0) <= randomvalue1 then (
					append newselection obj
					)
			)
			return newselection
		)
 

	
	
	-- Random Orderinge

	-- De-Selection
				

	

		
		
	

		
	on Re_Ordering pressed do
	with undo "undo" on
					(
					objArray = selection as array
					finishedOrder = sortObjs objArray -- Ordering	
					select finishedOrder		
					)
	on Random_ordering pressed do
	with undo "undo" on
				(
					 a = RandomOrder selection
					select a
				)
	on btn_deselection pressed do
	with undo "undo" on
				(
				randomobjsel = randomdeselction selection randomvalue1.value 
				select randomobjsel -- or delete randomobjsel as an example
						
				)
	on btn83 pressed do
	with undo "undo" on
					(
					randomobjsel = randomdeselction selection randomvalue1.value 
					select randomobjsel -- or delete randomobjsel as an example
							
					)
)




--arrPreset = #("Scale : Small Movement : Fast", "Small Fast","Small Fast","Small Fast","Small Fast")







rollout rollout2 "Third Step :: LOGO Building Animation " width:540 height:618
(

	dropdownList objectSize "" pos:[440,127] width:67 height:22 enabled:true items:#("Custom", "Very samll", "Small", "Medium", "Large", "Very large") selection:4
	dropdownList AnimationSpeed "" pos:[440,153] width:67 height:22 enabled:false items:#("Custom", "Very fast", "fast", "Medium", "slow", "Very slow") selection:4
 
	GroupBox grp5 "Basic parameters" pos:[10,65] width:507 height:147
	spinner spin_startAni "Start frame of building animation" pos:[134,87] width:108 height:16 enabled:true range:[3,1000,3] type:#integer
	spinner spin_movementinterval "Duration of building" pos:[371,156] width:61 height:16 enabled:true range:[3,100,7] type:#integer
	spinner spin_buildingstep "Interval of each building" pos:[371,183] width:61 height:16 enabled:true range:[1,100,1] type:#integer
	
	GroupBox grp11 "Movement Animation" pos:[261,230] width:245 height:110
	spinner spin_fromx "Position X" pos:[305,275] width:69 height:16 range:[-1e+006,1e+006,0] type:#worldunits
	spinner spin_fromy "Position Y" pos:[305,296] width:68 height:16 range:[-1e+006,1e+006,0] type:#worldunits
	spinner spin_fromz "Position Z" pos:[305,316] width:68 height:16 range:[-1e+006,1e+006,100] type:#worldunits scale:0.1
	
	
	button btn_GenerateAni "Animation Generate" pos:[10,16] width:233 height:30
	
	GroupBox grp13 "Rotation Animation" pos:[262,341] width:245 height:110


	GroupBox grp20 "Scale Animation" pos:[262,452] width:245 height:110
	
	GroupBox grp21 "Visibility Animation" pos:[262,562] width:245 height:38 enabled:true



 
	spinner spnScaleX "Scale X" pos:[314,498] width:57 height:16 range:[0.1,10,0.9] type:#float
	spinner spnScaleY "Scale Y" pos:[314,519] width:57 height:16 range:[0.1,10,0.9]
	spinner spnScaleZ "Scale Z" pos:[315,540] width:57 height:16 range:[0.1,10,0.9]
	checkbox check_visible1 "Activate" pos:[279,575] width:96 height:23 checked:true




	spinner ScaleRandomValue1 "Max Value" pos:[428,508] width:57 height:16 enabled:false range:[0.001,10,0.8]
	spinner ScaleRandomValue2 "Min Value" pos:[432,533] width:57 height:16 enabled:false range:[0.001,10,1.2] type:#float
	spinner spin_rotation_x "Rotation X" pos:[315,385] width:57 height:16 range:[-360,360,0] type:#float
	spinner spin_rotation_y "Rotation Y" pos:[315,404] width:57 height:16 range:[-360,360,180]
	spinner spin_rotation_z "Rotation Z" pos:[317,428] width:57 height:16 range:[-360,360,0] type:#float
	spinner RotationRandomMaxValue1 "Max Value" pos:[427,400] width:57 height:16 enabled:false range:[1,360,15]
	spinner RotationRandomMaxValue2 "Min Value" pos:[428,420] width:57 height:16 enabled:false range:[-360,0,-15]
	spinner MovementRandomMaxValue1 "Max Value" pos:[423,279] width:57 height:16 enabled:false range:[0,1e+006,100]
	spinner MovementRandomMaxValue2 "Min Value" pos:[423,303] width:57 height:16 enabled:false range:[-1e+006,0,-100]
	


	GroupBox grp415 "Additional options" pos:[260,9] width:257 height:48
	checkbox chk196 "Group" pos:[275,22] width:63 height:14
	checkbox chk197 "Add layer" pos:[275,39] width:65 height:14


	checkbox check_visible2 "Deactivate" pos:[401,575] width:96 height:23 enabled:false checked:false
	checkbox chkUniformActivate1 "Uniform Activate" pos:[277,252] width:100 height:23 checked:true
	checkbox chkUniformActivate2 "Random Activate" pos:[388,251] width:105 height:23 checked:false
	checkbox chkRotationUniformActivate1 "Uniform Activate" pos:[273,361] width:100 height:23 checked:true
	checkbox chkRotationUniformActivate2 "Random Activate" pos:[391,363] width:105 height:23 checked:false
	checkbox chkScaleUniformActivate1 "Uniform Activate" pos:[275,474] width:100 height:23 checked:true
	
	checkbox chkScaleUniformActivate2 "Random Activate" pos:[394,476] width:105 height:23 checked:false
	

	dropdownList BasicCurrentpreset "Current preset" pos:[17,119] width:93 height:41 enabled:true items:#("Custom", "One box in 1mm", "One box in 1cm", "One box in 1inch", "One box in 1m", "One box in 1feet", "One box in 10m", "One box in 100m")
	GroupBox grp125 "Time parameters" pos:[259,106] width:253 height:102 enabled:true
	dropdownList ddl71 "" pos:[440,179] width:67 height:22 enabled:false items:#("Custom", "Stack Brick", "Rotation for floor", "fast", "Medium", "slow", "Very slow") selection:4
	dropdownList BasicPresetLoadSave "Load/Save presets" pos:[18,161] width:93 height:41 enabled:false items:#("Custom", "Very samll", "Small", "Medium", "Large", "Very large")
	GroupBox grp216 "Preset" pos:[14,107] width:228 height:101
	label lbl40 "Discription of current preset Discription of current presetDiscription of current preset Discription of current preset" pos:[131,124] width:105 height:74


	checkbox chkGeneralMotionBlur "Motion Blur" pos:[363,19] width:79 height:14
	progressBar pbar "" pos:[10,50] width:232 height:8 color:[255,255,255]
 

	spinner spin_AniScale "Animation scale" pos:[371,130] width:61 height:16 enabled:true range:[0.1,5,1] type:#float scale:0.1
	GroupBox grp139 "Movement parameters" pos:[11,219] width:507 height:390
	dropdownList MovementCurrentpreset "Current preset" pos:[23,258] width:93 height:41 enabled:true items:#("Custom", "Move for brick from top to down", "Rotation for floor", "Scale for column", "Transparency for window ", "Small", "Medium", "Large", "Very large")
	label lbl13 "Discription of current preset Discription of current presetDiscription of current preset Discription of current preset" pos:[132,262] width:105 height:92
	GroupBox grp147 "Quick preview" pos:[16,372] width:228 height:227
	GroupBox grp156 "Preset" pos:[15,239] width:228 height:122
	colorPicker cp1 "Wire color" pos:[364,39] width:79 height:15 color:(color 255 255 155)
	dropdownList MovementPresetLoadSave "Load/Save presets" pos:[22,306] width:93 height:41 enabled:false items:#("Custom", "Stack for brick", "Rotation for floor", "Scale for column", "Large", "Very large")
	bitmap bmp3 "Bitmap" pos:[28,397] width:205 height:190 fileName:"preset_01.png"
	button btn50 "Axis Center to object" pos:[365,86] width:137 height:14
	button btn61 "Key editor" pos:[456,25] width:56 height:25
	
	
	
	
	
	
	
		

	fn LEGOAni selection_  =  -- Movement Animation
			(
				if chkGeneralMotionBlur.checked == true then (
					selection_.motionBlur = #object
				) 
				else 
				(
					selection_.motionBlur = #none
				)
				

			pbar.value = 0 	--print spin_fromx.value
			
			--	
		
				
			for i in 1 to selection_.count do
				(
					
					
				if (chkUniformActivate1.checked or chkUniformActivate2.checked) == true then(
				deleteTime selection_[i].position.controller (interval 0 1000000000) #noslide
				)
				
				if (chkRotationUniformActivate1.checked or chkRotationUniformActivate2.checked) == true then(
				deleteTime selection_[i].rotation.controller (interval 0 1000000000) #noslide
				)
				
				if (chkScaleUniformActivate1.checked or chkScaleUniformActivate2.checked) == true then(
				deleteTime selection_[i].scale.controller (interval 0 1000000000) #noslide
				)
				
				
				if (check_visible1.checked or check_visible2.checked) == true then(
					
				try(
					deleteTime selection_[i].visibility.controller (interval 0 1000000000) #noslide
					)
					catch()
				
				)
				
				
				
				
					
					
					
					
					
					
					if chkUniformActivate1.checked == true then -- Uniform movement 
						( 
							animate on  -- movement 
								(
									
									
									at time (spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].position += [0,0,0]
									at time (spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].position += [spin_fromx.value,spin_fromy.value,spin_fromz.value]
									--at time (0) selection_[i].position += [spin_fromx.value,spin_fromy.value,spin_fromz.value]


									delete selection_[i].position.controller.keys [1]

								)
						)

					
					if chkUniformActivate2.checked == true then -- Random movement 
						( 
							animate on  -- movement 
								(

									spin_from_random_x = random MovementRandomMaxValue1.value MovementRandomMaxValue2.value 
									spin_from_random_y = random MovementRandomMaxValue1.value MovementRandomMaxValue2.value
									spin_from_random_z = random MovementRandomMaxValue1.value MovementRandomMaxValue2.value
									
									at time (0) selection_[i].position += [spin_from_random_x,spin_from_random_y,spin_from_random_z]
									at time (spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].position += [0,0,0]
									at time (spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].position += [-spin_from_random_x,-spin_from_random_y,-spin_from_random_z]

									delete selection_[i].position.controller.keys [1]
								)
						)
						
						
					if chkRotationUniformActivate1.checked == true then -- rotation 
						( 
						animate on  -- rotation 
							(
								--at time (0) rotate selection_[i] 9 [1,0,0] --spin_rotation_x.value
								at time ((spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value))/spin_AniScale.value) rotate selection_[i] 0 [1,0,0]
								at time ((spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value))*spin_AniScale.value) rotate selection_[i] spin_rotation_x.value [1,0,0] 

								at time ((spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value))/spin_AniScale.value) rotate selection_[i] 0 [0,1,0]
								at time ((spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value))*spin_AniScale.value) rotate selection_[i] spin_rotation_y.value [0,1,0] 
								
								at time ((spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value))/spin_AniScale.value) rotate selection_[i] 0 [0,0,1]
								at time ((spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value))*spin_AniScale.value) rotate selection_[i] spin_rotation_z.value [0,0,1] 

								
								delete selection_[i].rotation.controller.keys [1]
								
							)
						)

						
						if chkRotationUniformActivate2.checked == true then -- Random rotation  
						( 
						animate on  -- Random rotation 
							(

								spin_rotation_random_x = random RotationRandomMaxValue1.value RotationRandomMaxValue2.value 
								spin_rotation_random_y = random RotationRandomMaxValue1.value RotationRandomMaxValue2.value
								spin_rotation_random_z = random RotationRandomMaxValue1.value RotationRandomMaxValue2.value
								
								at time (0) rotate selection_[i] 0 [1,0,0]
								at time ((spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value))/spin_AniScale.value) rotate selection_[i] 0 [1,0,0]
								at time ((spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value))*spin_AniScale.value) rotate selection_[i] spin_rotation_random_x [0,1,0]


								at time (0) rotate selection_[i] 0 [0,1,0]
								at time ((spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value))/spin_AniScale.value) rotate selection_[i] 0 [0,1,0]
								at time ((spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value))*spin_AniScale.value) rotate selection_[i] spin_rotation_random_y [0,1,0]

								
								at time (0) rotate selection_[i] 0 [0,0,1]
								at time ((spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value))/spin_AniScale.value) rotate selection_[i] 0 [0,0,1]
								at time ((spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value))*spin_AniScale.value) rotate selection_[i] spin_rotation_random_z [0,0,1]

								delete selection_[i].rotation.controller.keys [1]
							)
						)	
					
						
						
						
					if chkScaleUniformActivate1.checked == true then ( 		
						animate on  -- scale 
							(
								at time (spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].scale += [0,0,0]
								at time (0) selection_[i].scale = [spnScaleX.value,spnScaleY.value,spnScaleZ.value]
								at time (spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].scale = [spnScaleX.value,spnScaleY.value,spnScaleZ.value]

								delete selection_[i].scale.controller.keys [1]

							)
						)
					if chkScaleUniformActivate2.checked == true then ( 		
						animate on  --  random scale 
							(
								
								spin_scale_random_x = random ScaleRandomValue1.value ScaleRandomValue2.value 
								spin_scale_random_y = random ScaleRandomValue1.value ScaleRandomValue2.value 
								spin_scale_random_z = random ScaleRandomValue1.value ScaleRandomValue2.value 

								
								at time (spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].scale += [0,0,0]
								at time (0) selection_[i].scale = [spnScaleX.value,spnScaleY.value,spnScaleZ.value]
								at time (spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].scale = [spin_scale_random_x,spin_scale_random_y,spin_scale_random_z]

								delete selection_[i].scale.controller.keys [1]

							)
						)
						
						
						
						
						
						
					if check_visible1.checked == true then (
						animate on  -- visiblity 
							(
								at time (spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].visibility = 0   --3st key
								at time (0) selection_[i].visibility = 0  --1st key
								at time (spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].visibility = 1  --2st key
									
								-- key resure
								at time (0) selection_[i].visibility.controller.value = 0  --1st key
								at time (spin_startAni.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].visibility.controller.value = 0
								at time (spin_startAni.value+spin_movementinterval.value+spin_movementinterval.value+(i*spin_buildingstep.value)) selection_[i].visibility.controller.value = 1

								delete selection_[i].visibility.controller.keys [1]
							)
						)
						
					
				pbar.value = (i as float  / selection_.count) *100
				)
					

				
			)



--selection_ = selection as array

/*
finishedOrder = sortObjs selection_  -- Ordering 
rotationAni selection_  -- Rotation Animation
MoveAni selection
ScaleAni selection
VisiAni selection


--selection_ = selection_box as array




--selection_ = #()


*/



				
				
				
				
				
	-- Main Generate Animation

		
		
					
					
					
	
	
		
	
	
	
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	on AnimationSpeed selected sel do
	(
			/*
			spin_AnimationScale.enabled = false
			spin_startAni.enabled = false
			spin_movementinterval.enabled = false
			spin_buildingstep.enabled = false 
			*/
		
			if Basic_preset2.selection ==1 then(
			spin_AnimationScale.enabled = true
			spin_startAni.enabled = true
			spin_movementinterval.enabled = true
			spin_buildingstep.enabled = true
			--Basic_preset2.selection = 2
				
			spin_AnimationScale.value = 1
			spin_startAni.value = 5
			spin_movementinterval.value = 3
			spin_buildingstep.value = 2
	
			)
		
			if Basic_preset2.selection ==2 then(
			spin_AnimationScale.enabled = false
			spin_startAni.enabled = false
			spin_movementinterval.enabled = false
			spin_buildingstep.enabled = false
			--Basic_preset2.selection = 2
				
			spin_AnimationScale.value = 1
			spin_startAni.value = 5
			spin_movementinterval.value = 3
			spin_buildingstep.value = 2
	
			)
		
		
		)
	on btn_GenerateAni pressed do with undo "undo" on	-- position btn
					(
						pbar.value = 0
						LEGOAni selection
					)
	on check_visible1 changed state do
		check_visible2.checked = false
	on check_visible2 changed state do
		check_visible1.checked = false
	on chkUniformActivate1 changed state do		-- movement active 1
	(
			chkUniformActivate2.checked = false
			
			MovementRandomMaxValue1.enabled = false
			MovementRandomMaxValue2.enabled = false
			spin_fromx.enabled = true
			spin_fromy.enabled = true
			spin_fromz.enabled = true
		
			if chkUniformActivate1.state  == false   then(
			spin_fromx.enabled = false
			spin_fromy.enabled = false
			spin_fromz.enabled = false
			)
		)
	on chkUniformActivate2 changed state do   -- movement active2
	(
				chkUniformActivate1.checked = false
			
				MovementRandomMaxValue1.enabled = true
				MovementRandomMaxValue2.enabled = true
		
				spin_fromx.enabled = false
				spin_fromy.enabled = false
				spin_fromz.enabled = false
	
				if chkUniformActivate2.state  == false   then(
					MovementRandomMaxValue1.enabled = false
					MovementRandomMaxValue2.enabled = false
				)
	
		)
	on chkRotationUniformActivate1 changed state do
	(
			chkRotationUniformActivate2.checked = false
			
			RotationRandomMaxValue1.enabled = false
			RotationRandomMaxValue2.enabled = false
	
			spin_rotation_x.enabled = true
			spin_rotation_y.enabled = true
			spin_rotation_z.enabled = true
		
			if chkRotationUniformActivate1.state  == false   then(
			spin_rotation_x.enabled = false
			spin_rotation_y.enabled = false
			spin_rotation_z.enabled = false
			)
		)
	on chkRotationUniformActivate2 changed state do
	(
			chkRotationUniformActivate1.checked = false
			
			RotationRandomMaxValue1.enabled = true
			RotationRandomMaxValue2.enabled = true
	
			spin_rotation_x.enabled = false
			spin_rotation_y.enabled = false
			spin_rotation_z.enabled = false
		
			if chkRotationUniformActivate2.state  == false   then(
			RotationRandomMaxValue1.enabled = false
			RotationRandomMaxValue2.enabled = false
			)
		)
	on chkScaleUniformActivate1 changed state do
	(
			chkScaleUniformActivate2.checked = false
			
			ScaleRandomValue1.enabled = false
			ScaleRandomValue2.enabled = false
			spnScaleX.enabled = true
			spnScaleY.enabled = true
			spnScaleZ.enabled = true
		
			if chkScaleUniformActivate1.state  == false   then(
			spnScaleX.enabled = false   
			spnScaleY.enabled = false   
			spnScaleZ.enabled = false
			)
		)
	on chkScaleUniformActivate2 changed state do
	(
			chkScaleUniformActivate1.checked = false
			
			ScaleRandomValue1.enabled = true
			ScaleRandomValue2.enabled = true
	
			spnScaleX.enabled = false   
			spnScaleY.enabled = false   
			spnScaleZ.enabled = false
	
				if chkScaleUniformActivate2.state  == false   then(
					ScaleRandomValue1.enabled = false
					ScaleRandomValue2.enabled = false
				)
	
		)
	on ddl71 selected sel do
	(
			/*
			spin_AnimationScale.enabled = false
			spin_startAni.enabled = false
			spin_movementinterval.enabled = false
			spin_buildingstep.enabled = false 
			*/
		
			if Basic_preset2.selection ==1 then(
			spin_AnimationScale.enabled = true
			spin_startAni.enabled = true
			spin_movementinterval.enabled = true
			spin_buildingstep.enabled = true
			--Basic_preset2.selection = 2
				
			spin_AnimationScale.value = 1
			spin_startAni.value = 5
			spin_movementinterval.value = 3
			spin_buildingstep.value = 2
	
			)
		
			if Basic_preset2.selection ==2 then(
			spin_AnimationScale.enabled = false
			spin_startAni.enabled = false
			spin_movementinterval.enabled = false
			spin_buildingstep.enabled = false
			--Basic_preset2.selection = 2
				
			spin_AnimationScale.value = 1
			spin_startAni.value = 5
			spin_movementinterval.value = 3
			spin_buildingstep.value = 2
	
			)
		
		
		)
)








------------------------------------------------------------------------------------------------------------------------ rollout 4
rollout rollout3 " LOGO Building Animation Tools" width:540 height:296
(
	GroupBox grp5 "Tools" pos:[6,7] width:515 height:162
	GroupBox grp199 "Re-construction" pos:[13,24] width:231 height:68
	button btnReconstruction "Generate" pos:[22,51] width:94 height:25
	GroupBox grp458 "Motion Blur" pos:[261,24] width:233 height:68
	button btnchkselectionMotionBlur "Generate" pos:[272,52] width:94 height:25	
	
	
	
	
	button btn10 "Object cracking" pos:[21,122] width:94 height:25
	GroupBox grp11 "Object Cracking" pos:[13,98] width:232 height:65


	
	edittext etBaseName "Object" pos:[342,110] width:89 height:17 fieldwidth:70 across:2
	
	GroupBox GropboxDetach "Detach" pos:[262,98] width:232 height:65
	button facedetach "Face detach" pos:[390,136] width:94 height:25
	button Elementdetach "Element detach" pos:[439,109] width:51 height:21
	
	

	--start_objs = objects as array
				
	fn detach_elems obj base_name = (
		if convertToPoly obj != undefined do (
			while polyOp.getNumFaces obj != 0 do (
				local f_list = polyOp.getElementsUsingFace obj #{1}
				local elem = polyOp.detachFaces obj f_list asNode:true name:(uniqueName base_name)
			)
			delete obj
		)
	)
	
	-- Reset Pivot
	fn reset_pivots coll = (
		centerPivot coll
		worldAlignPivot coll
		resetXForm coll
		convertToPoly coll)

	
	fn invert_set coll = (
		return (for obj in objects where findItem coll obj == 0 collect obj)
	)


	-- detach all surface
fn detachallsurface arrobj = 
		(
			for i in 1 to arrobj.faces.count do 
			(  
				polyop.detachFaces $  #{1} delete:true asNode:true 

			)
		)

	
	
		
				
		

		
		
		
	button Preview "Preview" pos:[21,191] width:219 height:53
	
		
		
	on Preview pressed do
	with undo "undo" on	-- position btn
			(
			NitrousGraphicsManager.MakePreviewQuality = 60
			createPreview outputAVI:false percentSize:100 dspGeometry:true dspShapes:false dspLights:false dspCameras:false dspHelpers:false dspParticles:false dspBones:false dspGrid:false dspSafeFrame:false dspFrameNums:false dspBkg:false --rndLevel:<#smoothhighlights | #smooth | #facethighlights | #facet | #flat | #hiddenline | #litwireframe | #wireframe | #box> 
  
				
			)

		
		
	on btnReconstruction pressed do
	with undo "undo" on	-- position btn
			(
				
			)
	on facedetach pressed do
	with undo "Elements to Objects" on 
			(
			sel = convertTopoly $
			detachallsurface sel
			delete selection
			--reset_pivots (invert_set start_objs)
			)
	on Elementdetach pressed do
	with undo "Elements to Objects" on 
			(
			local the_name = etBaseName.text
			local the_objs = for obj in selection where superClassOf obj == geometryClass collect obj
			for obj in the_objs do detach_elems obj the_name
			reset_pivots (invert_set start_objs)
			)
			
			
			
			
			
			
			
)









LEGOBuildingAnimation = newRolloutFloater "LEGO Building Animation, Alpha version 0.1.5 " 540 900

addRollout _About LEGOBuildingAnimation rolledUp:false
addRollout rollout1 LEGOBuildingAnimation rolledUp:true
addRollout rollout2 LEGOBuildingAnimation rolledUp:true
addRollout rollout3 LEGOBuildingAnimation rolledUp:false
addRollout rollout4 LEGOBuildingAnimation rolledUp:true

_About.controls[1].caption = "Test me"


--cui.RegisterDialogBar LEGOBuildingAnimation -minSize: 100 maxSize: 300 style:#(#cui_dock_lef)
--cui.DockDialogBar LEGOBuildingAnimation #cui_dock_left
-- cui.UnRegisterDialogBar LEGOBuildingAnimation

--cui.getDockState #cui_dock_lef



#cui_dock_left


