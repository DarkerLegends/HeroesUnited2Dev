mob/var/JustBlocked=0
mob/var/mob/StartTarget
mob/proc/Blocked(var/AttackType,var/mob/Attacker,var/GuardDamage=10)
	src.GuardLeft=max(0,src.GuardLeft-GuardDamage)
	src.UpdateGuardHUD();src.CombatTime()
	if(src.GuardLeft<=0)
		src.GuardBroken=1
		ShowEffect(src,"ShieldBreak")
		spawn(50)	src.GuardBroken=0
		PlaySound(view(src),'ShieldBreak.ogg')
		src.HitStun(5,Attacker)
	src.JustBlocked+=1;spawn(3)	src.JustBlocked-=1
	switch(AttackType)	if("Beam","Ki Blast")	if(src.HasPerk("Energy Absorb"))	src.AddKiPercent(5)

mob/CombatNPCs/Enemies
	Character
	Team="Enemy"
	PowerMode="Ki Only"
	New()
		if(src.Character)	src.SetCharacter(src.Character)
		spawn()	src.GuardRecharge()
		spawn()	src.CombatAI()
		return
	proc/SetCharacter(var/Char2Set)
		if(istext(Char2Set))
			src.name=Char2Set;src.AddName()
			for(var/obj/Characters/M in AllCharacters)
				if(M.name==Char2Set)	{src.Character=M;src.icon=src.Character.icon;return}
		world.log<<"* Character Error: [Char2Set]"
	proc/LevelScale(var/NewLevel)
		if(NewLevel>src.Level)
			src.Level=NewLevel
			var/BoostBy=round(src.Level/4)
			src.MaxPL+=BoostBy*10
			src.MaxKi+=BoostBy*20
			src.Str+=BoostBy*2
			src.Def+=BoostBy*1
			src.AddPlPercent(100)
			src.AddKiPercent(100)
	Sparring_Partner
	TW_Guard