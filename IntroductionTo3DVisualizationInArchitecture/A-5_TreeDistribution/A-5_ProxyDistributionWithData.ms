--Set the animation keyframes of an object from a text file
--If the object has keyframes already outside the range the file has, they will be kept


fn setAnimToObject GivenObject = 
(

	f1 = getOpenFileName types:"Text(*.txt)|*.txt|All files|*.*|"
	f2 = openFile f1 mode:"r"

	select GivenObject
	
	try (
		while not eof f2 do 
			(
				copyObject = instance(GivenObject)
				inputData = readLine f2 
				inputArray = filterString inputData ","
				
				x = filterString  inputArray[1] "{"
				y = inputArray[2]
				z = filterString  inputArray[3] "}"
				
				x =x[1] as float
				y =  y as float
				z = z [1] as float
								
				rValue = (random distriWithData.rotationMin.value distriWithData.rotationMax.value)
				sValue = (random distriWithData.scaleMin.value distriWithData.scaleMax.value)
				
				copyObject.pos = [x,y,z]

				rotate copyObject (angleaxis rValue [0,0,1])
				scale copyObject [sValue, sValue, sValue]
				
			)		
	) catch ( )
)


try(destroyDialog distriWithData) catch()



rollout distriWithData "Object Distribution With Data 0.0.1 by NJSTUDIO" width:288 height:288
(



	pickbutton 'chooseit' "Pick Object to distribute" pos:[12,27] width:253 height:46 align:#left
	GroupBox 'grp1' "General option" pos:[6,7] width:272 height:93 align:#left
	label 'lbl1' "www.njstudio.co.kr" pos:[10,263] width:266 height:16 align:#left
	
	label 'lbl2' "Developed by NJ, Version 0.0.5" pos:[9,246] width:266 height:16 align:#left
	GroupBox 'grp2' "random" pos:[6,105] width:272 height:93 align:#left
	
	spinner 'scaleMin' "" pos:[87,132] width:86 height:16 range:[0.01,1000,1.0] scale:0.1 align:#left
	spinner 'scaleMax' "" pos:[178,132] width:86 height:16 range:[0.01,1000,1.0] scale:0.1 align:#left
	
	spinner 'rotationMin' "" pos:[87,161] width:86 height:16 range:[-180,0,-15] align:#left
	spinner 'rotationMax' "" pos:[178,160] width:86 height:16 range:[0,180,15] align:#left
	
	label 'scaleLable' "Scale" pos:[20,133] width:44 height:16 align:#left
	label 'lbl4' "Rotation" pos:[20,161] width:44 height:16 align:#left
	label 'lbl5' "Min" pos:[151,114] width:44 height:16 align:#left
	label 'lbl6' "Max" pos:[242,115] width:22 height:16 align:#left
	
	on chooseit picked GivenObject do
	with undo "undo" on
		(
			setAnimToObject GivenObject
		)
)


createdialog distriWithData 288 288