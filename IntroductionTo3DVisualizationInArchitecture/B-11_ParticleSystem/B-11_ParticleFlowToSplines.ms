--**use at your own risk**--

--Particle Flow Spliner
--this script draws splines along the path all particls within a flow based
--on a specified time increment.

--Usage--
--Set endOFPRAnimation, endFrame, and fIncrmnt vaiables as desired
--Select a Particle Flow scene object and run the script.

--written by Charley Carlat
--Update -- This script was written long ago and may have many areas for improvement






--Dieses Script wurde wie oben erläutert nicht von mir selbst entwickelt!!!




lasframe = 280

pf = $
i2 = 1
pTest = false
endOfPFAnimation = lasframe --hier wird das ende der partikelemission gesetzt
endFrame = lasframe -- hier wird das ende der Splineberechnung gesetzt
fIncrmnt = 4 --hier werden die abstände der Knotensetzung der Splines gesetzt. D.h. in jedem wievielten Frame die Position eines Patikels ermittelt wird

-----hier wird überprüft, wie viele der emittierten partikel valide sind, also zur berechnung herangezogen werden können--------
sliderTime = endOfPFAnimation
while not pTest do
(
	pf.particleIndex = i2
	if pf.particlePosition == [0,0,0] then
	(
		pTest = true
		global numParts = i2 - 1
	)--End If
	i2 += 1
)--End Do
--------------------------------Splines werden erzeugt-----------------------------
for i in 1 to numParts do
(
	newShp = splineShape() --hier wird festgelegt, welche art shape erzeugt werden soll, in unserem falle splineShapes, also Splines...
	addNewSpline newShp
	newShp.name = ("ParticleSpline_" + i as string) --hier kann ein beliebiger Name für die Spliens vergeben werden, in meinem Fall lautet er ParticleSpline_n (n = die durchnummerierung) achtet unbedingt darauf, das der name auch noch an anderen stellen im script eingegeben werden muss (noch an vier weiteren stellen, am besten mit Search&Replace austauschen)
)--end For
-------------------Hier werden Knotenpunkte an den oben festgelegten Intervallen gesetzt (in unsererm fall in jedem zweiten frame)-------------
for t in 0 to (endFrame/fIncrmnt) do
(
	sliderTime = (t * fIncrmnt)--hier wird festgelegt, wie viele knoten eingefügt werden (SliderTime = die zeitleiste, fIncrment = das Intervall), in unserem Fall 50 Knotenpunkte (100Frames Animation und in jedem zweiten Frame ein Knoten...)
	for i in 1 to numParts do
	(
		pf.particleIndex = i
		pId = pf.particleID
		if pId != 0 then
		(
			ParticleSplineShp = execute ("$ParticleSpline_" + pId as string)
			addKnot ParticleSplineShp 1 #smooth #line pf.particlePosition
		)--End If
	)
)--End For

select $'ParticleSpline_*' --hier werden die Splines allesamt ausgewählt, damit gleich ein Shader assigned werden kann oder ähnliches
updateShape $