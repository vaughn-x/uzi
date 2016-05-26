;// vim: set ft=tf
;;;;;;;Autochange script.

/if ({cweap}=~'') /set cweap=1%;/endif
/if ({pweap}=~'') /set pweap=1%;/endif

/def w = \
    /if (leading=1) \
        /if (%{1} =/ "slay") \
            gt use &+Rslay %2%;\
        /elseif ({1}=/"") \
            gt use &+Rnormal%;\
        /else \
            gt use &+R%1%;\
        /endif%;\
;        gt :dam &+W$[replace("-","&+r-",replace("!","&+R!",replace("/","&+g/&+W",replace("slay/","slay ",replace(" ","/",{*})))))]%;\
    /endif%;\
    /weapon %*


/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \'(H|h)(ORGAR|orgar)\'' cweaphorgar = \
    /if ({horgarslay} !~ '') \
        /weapon horgar%;\
    /else \
        /weapon fire%;\
    /endif%;\
    /d fire

/def -mregexp -p9999 -F -t'^You tell the group, \'(H|h)(ORGAR|orgar)\'' cweaphorgar2 = \
    /if ({horgarslay} !~ '') \
        /weapon horgar%;\
    /else \
        /weapon fire%;\
    /endif%;\
    /d fire


/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \'(USE|use) ([A-Za-z/\ ]*)\'' leadercweap = \
    /if ({P1}=/{tank}) \
        /let _newdam=$[replace('/',' ', {P3})]%;\
        /let _newdam=$[replace('or',' ', {_newdam})]%;\
        /let _newdam=$[replace('slay ','slay', {_newdam})]%;\
        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
        /if (_newdam =/ 'iron') \
            /d %_newdam%;\
            /weapon %_newdam%;\
        /elseif (_newdam =/ 'unlife') \
            /d %_newdam dark magical%;\
            /weapon unlife dark magical%;\
        /elseif (_newdam =/ 'pure*') \
            /d %_newdam light%;\
            /weapon %_newdam light slaydemon%;\
        /else \
            /d %_newdam%;\
            /weapon %_newdam%;\
        /endif%;\
    /endif

/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \':dam ([A-Za-z/\ ]*)\'' leadercweapbps = \
    /if ({P1}=/{tank}) \
        /let _newdam=$[replace('/',' ', {P2})]%;\
        /let _newdam=$[replace('or',' ', {_newdam})]%;\
        /let _newdam=$[replace('slay ','slay', {_newdam})]%;\
        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
        /if (_newdam =/ 'iron') \
            /d %_newdam%;\
            /weapon %_newdam%;\
        /elseif (_newdam =/ 'unlife') \
            /d %_newdam dark magical%;\
            /weapon unlife dark magical%;\
        /elseif (_newdam =/ 'pure*') \
            /d %_newdam light%;\
            /weapon %_newdam light slaydemon%;\
        /else \
            /d %_newdam%;\
            /weapon %_newdam%;\
        /endif%;\
    /endif


;;;;;;;;;;;;;;;;;;
;PathWeaver
;;;;;;;;;;;;;;;;;;
/def weaver = \
    /if ({1}=/'fire'|{1}=/'slayorc'|{1}=/'slaygoblin'|{1}=/'slaytroll'|{1}=/'slaylugroki') \
        /if ({pweavertype}!/'death') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
            say baru goth deathflame%;wield pathweaver%;/set pweavertype=death%;\
        /elseif (weapon!/'pathweaver') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
        /endif%;\
    /elseif ({1}=/'ice'|{1}=/'slayde') \
        /if ({pweavertype}!/'hail') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
            say bwaihna cur hailstrike%;wield pathweaver%;/set pweavertype=hail%;\
        /elseif (weapon!/'pathweaver') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
        /endif%;\
    /else \
        /if ({pweavertype}!/'normal') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
            say cuntoh magu%;wield pathweaver%;/set pweavertype=normal%;\
        /elseif (weapon!/'pathweaver') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
        /endif%;\
    /endif




;;;;;;;;;;;;;;;;;
;WEAPON SWITCHER;
;;;;;;;;;;;;;;;;;
/def cweap = \
    /if ({1} =/ 'on') \
        /set cweap=1%;\
        /ecko Will now autochange Weapon.%;\
    /elseif ({1} =/ 'off') \
        /set cweap=0%;\
        /ecko Won't autochange Weapon.%;\
    /else \
        /if (rogue>0 & quickdraw=1 & fighting=1) \
            /let _wieldcmd=quickdraw%;\
        /else \
            /let _wieldcmd=wield%;\
        /endif%;\
        /if ({2}!~('')|(' ')|('0')) \
            /if (({2}!/weapon)|({2}=/'pathweaver')) \
;                /if ({2}=/'pathweaver') \
;                /else \
;                    /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2%2%htxt)%;\
;                /endif%;\
                /if ({2}=/'mord*') \
                    mord%;\
                /elseif ({2}=/'pathweaver') \
                    /if ({weapon}!/'pathweaver') \
                        /if (pweap=1) \
                            gc %{2} weapon!%;\
                            /if (quickdraw=1 & fighting=1) \
                                quickdraw %2%;\
                            /else \
                                remove %weapon%;\
                            /endif%;\
                            wield %2%;\
                            /repeat -0:00:01 1 pc %{weapon} weapon!%;\
                        /else \
                            /if (quickdraw=1 & fighting=1) \
                                quickdraw %2%;\
                            /else \
                                remove %weapon%;\
                            /endif%;\
                            wield %2%;\
                        /endif%;\
                    /endif%;\
                    /weaver %1%;\
                /else \
                    /if (pweap=1) \
                        gc %{2} weapon!%;\
                        /if (quickdraw=1 & fighting=1) \
                            quickdraw %2%;\
                        /else \
                            remove %weapon%;\
                        /endif%;\
                        wield %2%;\
                        /repeat -0:00:01 1 pc %{weapon} weapon!%;\
                    /else \
                        /if (quickdraw=1 & fighting=1) \
                            quickdraw %2%;\
                        /else \
                            remove %weapon%;\
                        /endif%;\
                        wield %2%;\
                    /endif%;\
                    /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2%2%htxt)%;\
                /endif%;\
                /set weapon=%{2}%;\
            /endif%;\
        /else \
            /if (slayalt1!~''|slayalt1!~' '|slayalt1!~'0') \
                /weapon %slayalt1 %slayalt2%;\
            /elseif (normslay!~('')|(' ')|('0')) /weapon%;\
            /endif%;\
        /endif%;\
    /endif

/def weapon = \
    /if (cweap=1) \
        /set slayalt1=0%;/set slayalt2=0%;\
        /set slayalt1=%{2}%;\
        /set slayalt2=%{3}%;\
        /if ({1} =/ 'acid') \
            /cweap Acid %acidslay%;\
        /elseif ({1} =/ 'air') \
            /cweap Air %airslay%;\
        /elseif ({1} =/ 'bleed') \
            /cweap Bleed %bleedslay%;\
        /elseif ({1} =/ 'dark') \
            /cweap Dark %darkslay%;\
        /elseif ({1} =/ 'earth') \
            /cweap Earth %earthslay%;\
        /elseif ({1} =/ 'electricity') \
            /cweap Electricity %electricityslay%;\
        /elseif ({1} =/ 'energy') \
            /cweap Energy %energyslay%;\
        /elseif ({1} =/ 'fire') \
            /cweap Fire %fireslay%;\
        /elseif ({1} =/ 'horgar') \
            /cweap HorgarWeapon %horgarslay%;\
        /elseif ({1} =/ 'gas') \
            /cweap Gas %gasslay%;\
        /elseif ({1} =/ 'ice') \
            /cweap Ice %iceslay%;\
        /elseif ({1} =/ 'iron') \
            /cweap Iron %ironslay%;\
        /elseif ({1} =/ 'light') \
            /cweap Light %lightslay%;\
        /elseif ({1} =/ 'normal') \
            /cweap Normal %normalslay%;\
        /elseif ({1} =/ 'magic') \
            /cweap Magic %magicslay%;\
        /elseif ({1} =/ 'mental') \
            /cweap Mental %mentalslay%;\
        /elseif ({1} =/ 'poison') \
            /cweap Poison %poisonslay%;\
        /elseif ({1} =/ 'pure') \
            /cweap Pure %pureslay%;\
        /elseif ({1} =/ 'silver') \
            /cweap Silver %silverslay%;\
        /elseif ({1} =/ 'stun') \
            /cweap Stun %stunslay%;\
        /elseif ({1} =/ 'superlarge') \
            /cweap Superlarge %superlargeslay%;\
        /elseif ({1} =/ 'unlife') \
            /cweap Unlife %unlifeslay%;\
        /elseif ({1} =/ 'water') \
            /cweap Water %waterslay%;\
        /elseif ({1} =/ 'wood') \
            /cweap Wood %woodslay%;\
        /elseif ({1} =/ 'slayanimal') \
            /cweap SlayANIMAL %animalslay%;\
        /elseif ({1} =/ 'slaybotanic') \
            /cweap SlayBOTANIC %botanicslay%;\
        /elseif ({1} =/ 'slaydemon') \
            /cweap SlayDEMON %demonslay%;\
        /elseif ({1} =/ 'slaydinosaur') %;\
            /cweap SlayDINOSAUR %dinosaurslay%;\
        /elseif ({1} =/ 'slaydragon') \
            /cweap SlayDRAGON %dragonslay%;\
        /elseif ({1} =/ 'slayde' | {1} =/ 'slaydrowelf' | {1} =/ 'slaydrow-elf') \
            /cweap SlayDE %drowelfslay%;\
        /elseif ({1} =/ 'slaydwarf') \
            /cweap SlayDWARF %dwarfslay%;\
        /elseif ({1} =/ 'slayelemental') \
            /cweap SlayELEMENTAL %elementalslay%;\
        /elseif ({1} =/ 'slayelf') \
            /cweap SlayELF %elfslay%;\
        /elseif ({1}=/ 'slayfairie'| {1} =/ 'slayfairy') \
            /Cweap SlayFAIRIE %fairieslay%;\
        /elseif ({1} =/ 'slaygiant') \
            /cweap SlayGIANT %giantslay%;\
        /elseif ({1} =/ 'slaygnome') \
            /cweap SlayGNOME %gnomeslay%;\
        /elseif ({1} =/ 'slaygoblin') \
            /cweap SlayGOBLIN %goblinslay%;\
        /elseif ({1} =/ 'slayhe' | {1} =/ 'slayhalfelf') \
            /cweap SlayHE %halfelfslay%;\
        /elseif ({1} =/ 'slayho' | {1} =/ 'slayhalforc') \
            /cweap SlayHO %halforcslay%;\
        /elseif ({1} =/ 'slayhobbit') \
            /cweap SlayHOBBIT %hobbitslay%;\
        /elseif ({1} =/ 'slayhuman') \
            /cweap SlayHUMAN %humanslay%;\
        /elseif ({1} =/ 'slayinsect') \
            /cweap SlayINSECT %insectslay%;\
        /elseif ({1} =/ 'slayinsubstantial') \
            /cweap SlayINSUBSTANTIAL %insubstantialslay%;\
        /elseif ({1} =/ 'slaylugroki') \
            /cweap SlayLUGROKI %lugrokislay%;\
        /elseif ({1} =/ 'slaymythical') \
            /cweap SlayMYTHICAL %mythicalslay%;\
        /elseif ({1} =/ 'slaymagical') \
            /cweap SlayMAGICAL %magicalslay%;\
        /elseif ({1} =/ 'slayorc') \
            /cweap SlayORC %orcslay%;\
        /elseif ({1} =/ 'slayrodent') \
            /cweap SlayRODENT %rodentslay%;\
        /elseif ({1} =/ 'slaysnake') \
            /cweap SlaySNAKE %snakeslay%;\
        /elseif ({1} =/ 'slaytroll') \
            /cweap SlayTROLL %trollslay%;\
        /elseif ({1} =/ 'slayundead') \
            /cweap SlayUNDEAD %undeadslay%;\
        /elseif ({1} =/ 'slayvampire') \
            /cweap SlayVAMPIRE %vampireslay%;\
        /elseif ({1} =/ 'fireslash') \
            /cweap Fireslash %fireslash%;\
        /else \
            /eval /set _tmpweap=%%{%{1}slay}%;\
            /if (_tmpweap !~ '') \
                /cweap $[toupper({1})] %_tmpweap%;\
            /elseif (slayalt1 !~ '') \
                /weapon %slayalt1 %slayalt2%;\
            /else \
                /if (weapon!~normslay) \
                    /cweap Normal %normslay%;\
                /endif%;\
            /endif%;\
        /endif%;\
    /endif

/def addweapon = \
    /if ({1} !~ '' & {2} !~ '') \
        /let _newdamtype=$[tolower({1})]%;\
        /eval /set %{_newdamtype}slay=%{2}%;\
        /ecko Added:%htxt2 %_newdamtype%ntxt To use it type%htxt2 /w %_newdamtype%;\
    /else \
        /uecko Usage: /addweapon <type> <weapon-name>%;\
    /endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;Mob/Room name triggs;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Gorm
/def -mglob -t'A gorm {mage|priestess|warrior}*' cweap1 = \
    /weapon acid poison fire%;\
    /d fire light poison

/def -mglob -t'A huge, ancient tree towers above you.' cweap2 = \
    /weapon slaybotanic acid%;\
    /d normal

; The soulstealers laboratory
/def -F -mglob -t'*{A soulcrusher lurks in the shadows here.|The soulcrusher glances at you with fear.|A blurred figure stands here.}*' cweap3 = \
    /weapon slaydemon%;\
    /d light pure

/def -F -mglob -t'*{A great soulcrusher stands here.|A Long Hallway in the Twisted Laboratory}*' cweap4 = \
    /weapon slaydemon pure iron light%;\
    /d light pure

; Dungeons of Ceanyth
/def -F -msimple -t'Entrance to the Dark Dungeons' cweap5 = \
    /weapon beast fire pure light%;\
    /d beast pure light fire

; Dragonspyre
/def -F -mglob -t'{Walking through DragonSpyre|The star spawn|The deep one|The hunting horror}*' cweap6 = \
    /weapon normal%;\
    /d normal

; Obelisk
/def -F -mglob -t'*rubs the*' cweap7 = \
    /weapon normal%;\
    /d normal

; Antiriad
/def -mglob -t'{Entrance to the City of Antiriad.|Outside Ye Olde Shoppe.}*' cweap8 = \
    /weapon slaylugroki%;\
    /d fire pure light

; Antiriad - Poltergeist
/def -mglob -t'The abandoned shop.' cweap9 = \
    /weapon energy%;\
    /d energy

; Upper Argo (black and white trolls)
/def -mglob -t'Mt. Ulmo Pass' cweap10 = \
    /weapon slaytroll fire acid mental%;\
    /d fire light pure

; The Citadel
/def -mglob -t'The Gatehouse of the Citadel' cweap12 =\
    /weapon slayelf unlife dark iron%;\
    /d unlife

; Kaltor
/def -mglob -t'Entrance to the Ruins of Kaltor' cweap13 = \
    /weapon slaymagical unlife%;\
    /d unlife

; Earthsea
/def -mglob -t'The Entrance To EarthSea' cweap15 = \
    /weapon slaymagical unlife%;\
    /d unlife

; Inglestone
/def -mglob -t'The entrance to the great Dwarven kingdom, Inglestone' cweap16 =\
    /weapon slaydwarf magic superlarge water%;\
    /d magic water

; Alterac - Entrance
/def -mglob -t'The Gatekeeper of the stronghold stands here proudly' cweap17 = \
    /weapon slayhuman%;\
    /d normal

; Drow City/Shadowdwell
/def -msimple -t'Outside the City Gates' cweap18 = \
    /weapon slaydrowelf pure light ice%;\
    /d pure light ice

; Kaltor - Skeletons (does anyone kill these nowadays?)
/def -mglob -t'You {*} The Skeleton with your *' cweap19 = \
    /weapon slayundead pure light silver%;\
    /d heal

; The desolate plains
/def -mglob -p2 -F -t'The slope down.' cweap20 = \
    /weapon slaymagical unlife%;\
    /d unlife

; The amphitheatre
/def -mglob -t'The upper seatings' cweap21 =\
    /weapon medjai slayhuman iron light%;\
    /d medjai light

; Great red wyrm
/def -mglob -t'A huge red dragon lies on a huge hoard of treasures, sleeping.' cweap22 = \
    /weapon slaydragon%;\
    /d normal

; Olympus
/def -mglob -t'The Temple of Olympus' cweap23 = \
    /weapon slaymythical%;\
    /d normal

; FS
/def -mglob -t'The Fountain Square of Karandras' cweap24 =\
    /weapon slayhuman%;\
    /d normal

; Leviathan, entrance to ice wall
/def -mglob -t'Leviathan is here, looking at you with a quizzical expresion.' cweap25 = \
    /weapon slaymagical unlife%;\
    /d unlife

/def -msimple -t'Western Manyfolk' cweap26 = \
    /weapon slaydemon pure light iron%;\
    /d pure light

/def -mglob -t'An ugly orc stands here.' cweap27 =\
    /weapon slayorc fire pure light%;\
    /d fire light

; Sarakesh
/def -msimple -F -t'The temple of Sarakesh' cweap28 =\
    /weapon slayundead silver mental light%;\
    /d light

; Myrridon
/def -msimple -F -t'Temple square of Myrridon' cweap29 =\
    /weapon slayhuman%;\
    /d normal

; Khronatio - Ghosts
/def -msimple -F -t'Central Khronstreet' cweap30 = \
    /weapon decap water%;\
    /d decap water

/def -mregexp -F -t'^The den of the Black Dragon' cweap32 = \
    /weapon slaydragon%;\
    /d normal

/def -msimple -F -p1000 -t'Deep down in the ravine' cweap41 = \
 /weapon slaydrowelf ice pure light%;\
 /d ice pure light

/def -mregexp -t'Korr, the Overlord of Chaos stands here grinning wickedly.\
    |A Chaos Knight Sergeant stands here pondering the boulders situation' cweap42 = \
    /weapon slayhuman%;\
    /d normal

/def -F -mregexp -t'The Grand Hallway.' cweap50 =\
    /weapon slayelf unlife dark iron%;\
    /d unlife

/def -F -mregexp -t'Entrance to the King\'s Castle' cweap52 =\
    /weapon slayhuman%;\
    /d normal

/def -F -mglob -t'You feel a sensation as you travel through the essence flows.' cweap53 = \
    /weapon normal%;\
    /d normal

; Cohn Shar
/def -F -mregexp -t'A warrior stands here overseeing the protection of Egypt.\
    |A warrior stands here protecting the gates of the palace.\
    |A warrior stands here protecting the palace.\
    |A warrior stands here looking at antiquity.\
    |A warrior lies here resting.' cweap54 = \
    /weapon medjai slayhuman iron light%;\
    /d medjai light

/def -F -msimple -t'A Path In The Mountains' cweap55 = \
    /weapon slaysnake%;\
    /d normal


;; Hit cweaps
/def -mglob -F -p10000 -t'You {*} A ghost of a decapitated woman with your *' hit_cweap0 = \
    /weapon decap water%;\
    /d decap water

/def -mglob -F -p10000 -t'You {*} A Guard of Khron with your *' hit_cweap1 = \
    /weapon khron slayhuman water%;\
    /d khron water

