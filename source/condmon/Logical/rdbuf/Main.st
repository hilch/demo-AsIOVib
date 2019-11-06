
PROGRAM _INIT
	fb.paramMain.pModulePath := ADR('IF6.ST1');
	fb.paramMain.sensitivitySensor01 := 100;
	fb.paramMain.sensitivitySensor02 := 100;
	fb.paramMain.sensitivitySensor03 := 100;
	fb.paramMain.sensitivitySensor04 := 100;

	fb.paramBufferUpload.moduleBuffer := 9; (* Buffer: Rohsignal Beschleunigung Kanal 1 *)
	fb.paramBufferUpload.nrArrayElements:= SIZEOF(moduleData.xAxis)/SIZEOF(moduleData.xAxis[0]);
	fb.paramBufferUpload.pArrayXaxis:= ADR(moduleData.xAxis);
	fb.paramBufferUpload.pArrayYaxis:= ADR(moduleData.yAxis);
	fb.enable := 1;

	rtinfo.enable := 1;
	rtinfo();
	step := 0;
	 
END_PROGRAM


PROGRAM _CYCLIC
	CASE( step) OF
		0:
		(* clear requests *)
		fb.requestBufferLock := 0;
		fb.uploadBuffer := 0;
		IF( fb.initDone AND fb.moduleCfgUploadDone )THEN
			step := 100;
		END_IF

		(* wait for command *)
		100:
		IF( cmdUploadBuffer = 1 )THEN			
			cmdUploadBuffer := 2; (* busy *)
			step := 110;
		END_IF
		
		110:
		(* wait until buffer is locked *)
		fb.requestBufferLock := 1;  (* request for locking buffer *)
		IF( fb.bufferLockValid )THEN
			cycleCounter := 0;
			fb.uploadBuffer := 1;
			step := 120;
		END_IF


		120:
		cycleCounter := cycleCounter + 1 ;
		(* wait until buffer is uploaded *)
		IF( fb.bufferUploadDone )THEN
			(* do something with data *)
			fb.requestBufferLock := 0;  (* clear requests *)
			fb.uploadBuffer := 0;
			cmdUploadBuffer := 0; (* ready *)
			step := 100;
			bufferUploadDuration := (cycleCounter * rtinfo.cycle_time) / 1000;
		END_IF

	END_CASE
	fb();
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

