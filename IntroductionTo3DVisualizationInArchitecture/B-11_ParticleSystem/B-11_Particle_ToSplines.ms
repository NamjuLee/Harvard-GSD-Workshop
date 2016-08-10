-- maxscript - particles2splines
-- author: andrei kletskov (111) - http://andklv.narod.ru - andklv@mail.ru
-- description: this script creates spline or splines from simple emitters (except particle flow)
-- history:
-- 			v0.1 - (14 july 2009) - initial version 



ss_to_delete = #()


rollout ak_about "About ----- v0.1" 
(
	label lbl3 "(c) 2009" pos:[5,5] width:100 height:20
	label lbl4 "Andrei Kletskov (111)" pos:[5,20] width:110 height:20
	label lbl5 "http://andklv.narod.ru" pos:[5,35] width:110 height:20
	label lbl6 "andklv@mail.ru" pos:[5,50] width:100 height:20
)


rollout p2s "particles2splines" 
(
	label lbl1 "start:      end:      step:" pos:[3,3] width:120 height:16
	spinner spn3 "" pos:[1,20] width:40 height:16 type:#integer range:[-999999999,999999999,animationrange.start]
	spinner spn4 "" pos:[40,20] width:40 height:16 type:#integer range:[-999999999,999999999,animationrange.end]
	spinner spn5 "" pos:[79,20] width:36 height:16 range:[1,10000000,10] type:#integer
	checkbox chb1 "spline per particle" pos:[1,38] height:16
	button b1 "go!" width:113 pos:[2,55] height:24
	button b2 "update" pos:[2,80] width:56 height:14
	button b3 "delete" pos:[59,80] width:56 height:14
	
	on b2 pressed do
	(
		try
		(
			delete ss_to_delete
			ss_to_delete = #()
			b1.pressed()
		)
		catch
		(
			messagebox "cannot update spline from particle"
		)

	)
	
	on b3 pressed do -- deleting spline
	(
		try
		(
			delete ss_to_delete
			ss_to_delete = #()
		)
		catch
		(
			messagebox "cannot delete spline from particle"
		)
	)
	
	
	on b1 pressed do
	(
		try
		(

		psys = selection[1] -- particle system
		scount = 0 --- spline counter in shape
		mystep = spn5.value -- step for knots
		mystarttime = spn3.value -- start time
		myendtime = spn4.value -- end time
		separate = chb1.state -- a separate spline per particle
		ss = undefined -- global for spline

		if separate then
		(
			
		)
		else
		(
			ss = SplineShape pos:[0,0,0]
			ss_to_delete = ss
			--ss.name = "particlespline_" + ss.name
		)


		for p = 1 to (particleCount psys) do
		(
			try
			(
				if separate then
				(
					ss = SplineShape pos:[0,0,0]
					append ss_to_delete ss
					ss.name = "particlespline_"+ (p as string)
					addNewSpline ss
					scount = 0 
				)
				else
				(
					addNewSpline ss
				)
				
				
				for t = mystarttime to myendtime by mystep do
				(
					at time t 
					--slidertime = t
					(
						ppos = (particlePos psys p)
						if ppos != undefined then	addKnot ss (scount+1) #smooth #curve ppos
					)
				)
				scount = scount + 1
				updateShape ss
			)
			catch (messagebox "error creating spines")
		)
		) -- end try
		catch
		(
			messagebox "error creating slines from particles. select simple particle emitter"
		)
	) -- end b1 pressed
) -- end rollout


rf = newRolloutFloater "111_p2s" 130 150
addRollout p2s rf  
addRollout ak_about rf
ak_about.open = 0

