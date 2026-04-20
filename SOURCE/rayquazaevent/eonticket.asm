INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsmew.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 0,35 ; Route 119
	db 41   ; item

	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd



	db MIX_RECORDS_ITEM
	db 1  ; ???
IF REGION == REGION_DE
	db 5  ; distribution limit from German debug ROM
ELSE
	db 30 ; distribution limit from English release
ENDC
	dw EON_TICKET



	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS


GoSeeYourFather:
	Text_DE "Ein gewaltiger Schatten zieht über\n"
	Text_DE "ROUTE 119...@"

	Text_EN "A massive shadow was seen streaking\n"
	Text_EN "across route 119...@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart

		   checkitemroom LUM_BERRY, 1

		   compare LASTRESULT, 0

		   virtualgotoif 1, NoRoomToGive

		   setwildbattle $196, $64, $001 ; RAYQUAZA, level 100 ($64), holding MASTER_BALL ($001)

		   copyvarifnotzero $8000, LUM_BERRY

		   copyvarifnotzero $8001, 1

		   checkitemtype $0005

		   callstd 1

		   closeonkeypress

		   fadeout $3

		   virtualmsgbox Shadow

		   waitmsg

		   waitkeypress

		   release

		   setvar $8004, $000F

	   	   setvar $8005, $000F

		   setvar $8006, $0FF3

		   setvar $8007, $000F

		   special $13D

		   sound $13

		   waitstate

		   pause $28

		   special $13D

		   sound $13

		   waitstate

		   pause $28

		   callasm $2028E5D

		   callasm $2028E75

		   callasm $2028E8D

		   callasm $2028E8D ; change to 2028EA1 for JP ROM

		   virtualmsgbox Pokemon

		   waitmsg

		   waitkeypress

		   release

		   virtualmsgbox Rayquaza

		   playmoncry $196, $0

                   waitmoncry

		   waitmsg

		   waitkeypress

		   release

		   special $138

		   playsong $0166, $0

.delete_script
	killscript


		   EVENTLEGAL2
		   METLOCATION
		   GAMEORIGIN
		   GAMELANG

NoRoomToGive:
		   virtualmsgbox ItemsPocketIsFull
		   waitmsg
		   waitkeypress
		   release
		   end



ItemsPocketIsFull:
	Text_DE "Die Beeren-Tasche in deinem BEUTEL\n"
	Text_DE "ist voll.@"

	Text_EN "The Berry Pocket in your Bag\n"
	Text_EN "is full.@"

Shadow:
	Text_DE "Was ist das für ein Schatten?@"

	Text_EN "What’s that shadow in the sky?@"

Pokemon:
	Text_DE "Ein POKéMON!@"

	Text_EN "It’s a Pokémon!@"

Rayquaza:
	Text_DE "RAYQUAZA: Graaaoohh!@"

	Text_EN "Rayquaza: Graaaoohh!@"




NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

		   clearflag $03DB

		   virtualloadpointer GoSeeYourFather

		   setbyte 2

		   end




DataEnd:
	EOF
