proc/QuickPad(var/n)
	if(n<10)	return "0[n]"
	return n

mob/Test/verb
	Reset_Clan_Upgrades()
		set category="Test"
		if(alert("Reset all Clan Upgrades and Exp Gains?","Reset Clan Upgrades","Reset","Cancel")=="Reset")
			for(var/datum/Clan/C in Clans)
				C.Exp=0
				C.Upgrades=list()
				C.ExpEarners=list()
			src<<"Reset Clan Exp and Upgrades"
	Toggle_PM_Focus()
		set category="Test"
		global.FocusPMs=!global.FocusPMs
		src<<"Focus PMs: [global.FocusPMs]"
	Guard_Drain()
		set category="Test"
		while(src.GuardLeft>0)
			src.CombatTime()
			src.Blocked("Melee",src)
			sleep(1)
	End_Duels()
		set category="Test"
		var/DuelsEnded=0
		var/FlagsCounted=0
		src<<"Ending Duels..."
		for(var/obj/Supplemental/DuelFlag/D)	FlagsCounted+=1
		for(var/mob/M in world)	if(M.Dueling)
			M<<"[src] Ended your Duel"
			DuelsEnded+=1
			M.EndDuel()
		src<<"[DuelsEnded] Duels Ended : [FlagsCounted] Flags Counted"
	Old_Parts()
		set category="Test"
		var/obj/Items/Lootable/Parts/Common_Parts/Green_Chip/P=new()
		P.suffix="10";src.PartsInventory+=P
		src<<"Replacable Parts Added"
	Spawn_Parts()
		set category="Test"
		src.SpawnPart(src.loc,Times=20,Min=3,Max=5,DropRate=50)
	Reset_Medals()
		set category="Test"
		if(alert("Reset your Medals?","Reset Medals","Reset","Cancel")=="Reset")
			src.Medals=list()
			src<<"Medals Reset"
	Fake_Leave_Clan()
		set category="Test"
		src.Clan=null
		src.LeftClan()
	Add_Clan_Exp()
		set category="Test"
		var/Amt2Add=input("How Much Clan Exp to Add?","Add Clan Exp") as num
		if(src.Clan)	src.Clan.AddClanExp(Amt2Add,src)
		src<<"Added [FullNum(Amt2Add)] Clan Exp"
	Full_Respec()
		set category="Test"
		src.FullRespec()
	GuardTapping()
		set category="Test"
		while(1)
			src<<src.GuardTapping
			sleep(1)
	FlickLava()
		set category="Test"
		for(var/turf/T in oview())	flick("Lava",T)
	ReadableDates()
		set category="Test"
		var/DD=text2num(time2text(world.timeofday,"DD"))
		var/MM=text2num(time2text(world.timeofday,"MM"))
		var/YY=text2num(time2text(world.timeofday,"YY"))
		while(1)
			var/DateTag="[QuickPad(YY)][QuickPad(MM)][QuickPad(DD)]"
			src<<"[time2text(world.timeofday,"YYMMDD")]-[DateTag]	[ReadableLastDate(DateTag)]"
			DD-=1
			if(DD<1)	{DD=31;MM-=1}
			if(MM<1)	{MM=12;YY-=1}
			sleep(1)
	Territory_War()
		set category="Test"
		if(src.z==10)
			src.loc=locate(96,178,1)
			src.client.screen-=TWMMMs
		else
			src.loc=locate(200,200,10)
			src.client.screen+=TWMMMs
	View_Angles()
		set category="Test"
		for(var/obj/Supplemental/AngleHUD/H in global.AngleHUDs)	src<<H.Angle
	Start_CW()
		set category="Test"
		global.StartCW()
	Ghost_Mode()
		set category="Test"
		src.GhostMode()
	CapsuleChar()
		set category="Test"
		src.CapsuleChars=list(new/obj/CapsuleChars/Piccolo)
		src<<"Chars Given"
	SubKey()
		set category="Test"
		src<<SubKeyCheck(input("Input Key to Check for Sub","Input",src.key) as text)
	Populate_Clan()
		set category="Test"
		for(var/i=1;i<=1000;i++)
			src.Clan.Members+="[i]"
			src.Clan.Members["[i]"]=src.Clan.DefaultRank
		src<<"Clan Populated with 1,000 Entries"
	IT_OutOf_WT()
		set category="Test"
		global.TournStatus="Face-Off"
		src.InTournament=1
		src<<"IT to Test"
	Cancel_BeamBattle()
		set category="Test"
		src.CancelBeamBattle()
	FlyCancel()
		set category="Test"
		src.ForceCancelFlight()
	Delete_KiBlasts()
		set category="Test"
		src<<"Deleting..."
		var/counter=0
		for(var/obj/Blasts/B in world)	{counter+=1;del B}
		src<<"[counter] Deleted!"
	LostKiBlasts()
		set category="Test"
		var/TotalKBs=0
		var/ErrorKBs=0
		var/NullKBs=0
		src<<"<b>Scanning..."
		for(var/obj/Blasts/B in world)
			TotalKBs+=1
			if(B.icon_state=="ErrorKB")	ErrorKBs+=1
			if(B.loc==null)	NullKBs+=1
			else	{src.client.eye=B;sleep(5)}
		src.client.eye=src
		src<<"[TotalKBs] Total:"
		src<<"[ErrorKBs] Errors?"
		src<<"[NullKBs] Null Locs?"
	Pixel_Size()
		set category="Test"
		src.client.pixel_step_size=input("client.pixel_step_size:","PSS",src.client.pixel_step_size) as num
	PlayerTabs()
		set category="Test"
		var/list/Viewing=list()
		for(var/mob/M in Players)
			if(!(M.client.statpanel in Viewing))	Viewing+=M.client.statpanel
			Viewing[M.client.statpanel]+=1
		for(var/v in Viewing)
			src<<"[v]: [Viewing[v]]"
	MissingIconStates()
		set category="Test"
		var/list/AllStates=list("face","","fly","punch1","punch2","kick1","Guard","HitStun","KnockBack","kiblast","KiBlast2","charge","Beam","powerup","transform","revert","Sprint","IT","koed")
		for(var/obj/Characters/C in AllCharacters)
			//var/list/ExtraStates=icon_states(C.icon)-AllStates
			//if(ExtraStates.len)	for(var/v in ExtraStates)	src<<"<b>[C.icon] (E) [v]"
			var/list/MissingStates=AllStates-icon_states(C.icon)
			if(MissingStates.len)	for(var/v in MissingStates)	if(v!="revert" && (v!="transform" || C.Transes.len))	src<<"[C.icon] (M) [v]"
			var/TransIndex=0
			for(var/datum/TransDatum/D in C.Transes)
				TransIndex+=1
				//ExtraStates=icon_states(D.icon)-AllStates
				//if(ExtraStates.len)	for(var/v in ExtraStates)	src<<"<b>[D.icon] (E) [v]"
				MissingStates=AllStates-icon_states(D.icon)
				if(MissingStates.len)	for(var/v in MissingStates)	if(v!="koed" && (v!="transform" || TransIndex<C.Transes.len))	src<<"[D.icon] (M) [v]"
	Test_OffScreen_Flick()
		set category="Test"
		var/obj/O=new(locate(src.x+20,src.y,src.z))
		O.icon='VegetaSS4.dmi'
		flick("koed",src)
	Test_Screen_Offset()
		set category="Test"
		var/obj/O=new
		O.screen_loc="0:-1,0:-1"
		src.client.screen+=O
	TestLocation()
		set category="Test"
		src.loc=locate(input("New x","New x",src.x) as num,input("New y","New y",src.y) as num,input("New z","New z",src.z) as num)
	Chest_Count()
		set category="Test"
		var/Chests=src.GetTrackedStat("Chests Opened",src.TempTracked)
		src<<Chests;src<<isnum(Chests)
	Drop_Flag()
		set category="Test"
		src.DropFlag("Testing")
	AddDamage()
		set category="Test"
		src.TrackStat("Damage Taken",1)
		src.TrackStat("Damage Dealt",2)
		src.ResetTrackedStats(list("Damage Taken","Damage Dealt"))
		src<<"Tracked Total Damage: [src.GetTrackedStat("Damage Taken",src.RecordedTracked)]"
	ResetRecordedTracked()
		set category="Test"
		src.RecordedTracked=list()
		src<<"Reset"
	GotoTH()
		set category="Test"
		if(TreasureHunterChest.loc)	src.loc=TreasureHunterChest.loc
		else	src<<"Not Spawned"
	CreateChest()
		set category="Test"
		new/obj/Items/Destroyable/Chests/Chest(src.loc)
	CreateGoldenChest()
		set category="Test"
		new/obj/Items/Destroyable/Chests/Golden_Chest(src.loc)
	QuitTrainingBtn()
		set category="Test"
		var/obj/HUD/QuitTraining/T=new
		T.screen_loc=input("screen_loc","Screen Location",T.screen_loc) as text
		src.client.screen+=T
	ClientDir()
		set category="Test"
		src.client.dir=input("Input a new client.dir:","client.dir",src.client.dir) as num
	FullPower()
		set category="Test"
		src.AddKiPercent(100)
		src.AddPlPercent(100)
	AptTest()
		set category="Test"
		src.loc=locate(20,15,7)
	LevelUp()
		set category="Test"
		usr.AddExp(100*input("Levels to Give:","Give Levels",1) as num,input("Optional Reason:","Reason") as null|text)
	DuelSelf()
		set category="Test"
		usr.Duel()
	WindowSize(var/t as text)
		set category="Test"
		usr<<winget(usr,"[t]","size")
	MaxStatPoints()
		set category="Test"
		usr.TraitPoints=999999
	CountAI()
		set category="Test"
		var/Counter=0
		for(var/mob/CombatNPCs/E in world)	Counter+=1
		usr<<"[Counter] Combat AIs Found"
	MobDeltest()
		set category="Test"
		var/mob/M=new(usr.loc);M.loc=null
	CancelButtons()
		set category="Test"
		src.CancelButtonCombo()
	MyInstanceName()
		set category="Test"
		if(src.InstanceObj)	src<<initial(src.InstanceObj.name)
		else	usr<<"No Instance..."
	Shake_Screen()
		set category="Test"
		usr.ScreenShake()
	Split_Test()
		set category="Test"
		var/String1="1,2,3"
		world<<String1
		for(var/v in Split(String1))	world<<v

		String1="1,2,3,"
		world<<String1
		for(var/v in Split(String1))	world<<v
	ChangeLocation()
		set category="Test"
		var/NewX=input("Input new X","New X",usr.x) as num
		var/NewY=input("Input new Y","New Y",usr.y) as num
		var/NewZ=input("Input new Z","New Z",usr.z) as num
		usr.loc=locate(NewX,NewY,NewZ)
	ShiftIcon()
		set category="Test"
		var/icon/I=new(usr.icon)
		I.Shift(WEST,4)
		usr.icon=I
	BlendIcon()
		set category="Test"
		var/icon/I=new(usr.icon)
		I.Blend('Goku.dmi',ICON_OVERLAY)
		usr.icon=I
	Test_md5()
		set category="Test"
		var/md5ed=md5(input("Input a string to test the md5() value of","md5 Test") as text)
		world<<md5ed
		world<<isnull(md5ed)
	NoPl()
		set category="Test"
		usr.PL=0
		usr.UpdatePlHUD()
	NoKi()
		set category="Test"
		usr.Ki=0
		usr.UpdateKiHUD()
	TestPercentFormula()
		set category="Test"
		var/BaseStat=1000
		for(var/i=1;i<=1000;i++)
			var/BoostAmt=round(BaseStat*1/100)
			BaseStat+=BoostAmt
			usr<<"Level [i]: [BaseStat] ([BoostAmt])"
	SetIS()
		set category="Test"
		usr.icon_state=input("input new icon_state","Set IS",usr.icon_state) as text
	TestLoop()
		set category="Test"
		world<<world.contents.len
		while(1)
			for(var/obj/Items/DragonBalls/B in world)	if(!B)	world<<1
			sleep(1)
	KoTest()
		set category="Test"
		src.PL=0
		src.KnockOut(src,"Test")
	ThrowSelf()
		set category="Test"
		usr.Throw(usr,7,usr.dir)
	FusionStatTest(var/Stat1 as num,var/Stat2 as num)
		set category="Test"
		var/Lower=Stat1;var/Higher=Stat2
		if(Stat2<Stat1)
			Lower=Stat2;Higher=Stat1
		world<<Lower
		world<<Higher
		var/Avg=round(Lower/2)
		world<<Avg
		world<<Lower+Avg
		world<<"Average: [round(Stat1+Stat2)/2]"