--detach faces, add name on the last created object, put pivot at the center of object (single face in this case)
fn detachOneByOne obj my_prefix: cntPivot: =
	(
	 local poDetach = polyOp.detachFaces
	 for face = obj.faces.count to 1 by -1 do poDetach obj #{face} delete:true asNode:true name:(my_prefix+face as string)
	 if cntPivot do centerPivot objects
	)
	
fn detachAllFaces affectFirstObj:on = if selection.count != 0 do
	(   
	 local objArr = for o in selection where isKindOf o geometryClass and not isKindOf o TargetObject collect (if not isKindOf o Editable_Poly do convertToPoly o ; o)
	 if objArr.count == 0 then messageBox "Select Geometry Objects Only!" title:"Warning" beep:off else
		 (
		 if affectFirstObj then 
			 (
			 detachOneByOne objArr my_prefix:"newFace_" cntPivot:on
			 delete objArr
			 ) 
			 else 
			 (
			 for o in objArr do (detachOneByOne o my_prefix:(o.name+"_newFace_") cntPivot:on)
			 delete objArr
			 )
		 clearSelection() ; free objArr
		 )
	)
--if you want to detach all faces from first object in selection then run:
detachAllFaces()
--or if you want to affect all selected objects then use next line
detachAllFaces affectFirstObj:off