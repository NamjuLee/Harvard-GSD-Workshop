(
thresh = 0.55
thresh2 = 0.55
blobby = 4.5
noisyness = 5
noisysize = 9
smoothness = 1
thickness = 1.5

rollout FloaterExample "FloaterExample"
(

--spinner sp_thresh "Coverage " range:[0.05,0.99,0.55] scale:.05
--spinner sp_thresh2 "Coverage2 " range:[0.05,0.99,0.55] scale:.05
spinner sp_thickness "Thickness" range:[0.1,100,1.5] scale:.5
spinner sp_noisyness "Bump size " range:[1,100,5] scale:1
spinner sp_noisysize "Bumpness " range:[1,100,9] scale:1
spinner sp_smoothness "Final detail " range:[0,3,1] scale:1

button but_makeSnow "press"

--

fn makesnow = (
	copy $ isSelected:on name:"Torus02"
	macros.run "Modifier Stack" "Convert_to_Mesh"

	-- select faces
	named = $.name
	subobjectLevel = 0
	actionMan.executeAction 0 "371"
	normal_list = for f = 1 to $.numfaces collect (getfacenormal $ f)
	face_sel = #{}
	for f = 1 to $.numfaces do (face_sel[f] = (dot [0,0,1] normal_list[f] >= random thresh thresh2))
	setfaceselection $ face_sel
	subobjectLevel = 4
	max select invert
	max delete

	-- make snow
	max select all
	modPanel.addModToSelection (Face_Extrude ()) ui:on
	$.modifiers[#Face_Extrude].amount = thickness
	modPanel.addModToSelection (Noisemodifier ()) ui:on
	$.modifiers[#Noise].scale = noisysize
	$.modifiers[#Noise].strength = [noisyness,noisyness,noisyness] 
	modPanel.addModToSelection (meshsmooth ()) ui:on
	$.modifiers[#MeshSmooth].iterations = smoothness
	$.wirecolor = color 255 255 255
	--max select none
	)

--

on but_makeSnow pressed do try (makesnow())catch()

on sp_thresh changed val do (thresh = sp_thresh.value)
on sp_thresh2 changed val do (thresh2 = sp_thresh2.value)
on sp_blobby changed val do (blobby = sp_blobby.value)
on sp_thicjness changed val do (thickness = sp_thickness.value)
on sp_noisysize changed val do (noisysize = (100 - sp_noisysize.value))
on sp_noisyness changed val do (noisyness = sp_noisyness.value)
on sp_smoothness changed val do (smoothness = sp_smoothness.value)



--
)

-- create the rollout window and add the  rollout
if FloaterExampleFloater != undefined do
				(
				closerolloutfloater FloaterExampleFloater
				)		
FloaterExampleFloater = newRolloutFloater "FloaterExample Floater" 200 222 
addRollout FloaterExample FloaterExampleFloater
)

