;������: ��) �е��ֻ�
;���߽�����: 2023�� 6�� 17��

if not A_IsAdmin {
	MsgBox, ������ �������� �������ּ���
	ExitApp
}

#SingleInstance, off
#NoEnv
#Persistent
#KeyHistory 0
#NoTrayIcon
#Warn All, Off

ListLines, OFF
DetectHiddenText, On
DetectHiddenWindows, On
CoordMode, Mouse, Client
CoordMode, pixel, Client
SetWinDelay, 0
SetControlDelay, 0
SetKeyDelay, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetTitleMatchMode,3
SetBatchLines, -1

Global Coin,WindowTitle,WindowTitle1,WindowTitle2,WindowTitle3,WindowTitle4,WindowTitle5,WindowTitle6,WindowTitle7,WindowTitle8,WindowTitle9,WindowTitle10
Global WinMode

isFirstTimeRunThisCode := 0

Global jElancia_Count := Get_jElancia_Titles()

loop,jElancia_Count{
	WindowTitle := WindowTitle%A_INDEX%
	ride_enable()
	}
WindowTitle := WindowTitle1

gosub, Setting_Values
gosub, LoadData
gosub, ShowGui

SetStaticColor(hTest1, 0xFF0000)
return

Setting_Values:
	Global Category := ["Basic_Setting","Char_Setting","Tab1_Setting","wanteditems","Mines","InTab_Check_Menu", "AutoBuyItem","AutoBuyInk","AutoBuyPant","AutoBuyNeckla"]
	Global Category_Count := 0
	for key, value in Category
		Category_Count++

	Global Basic_Setting := ["GuiX", "GuiY", "WinMode"]
	Loop, 10
	{
		Basic_Setting.Insert("Player" . A_Index . "Title")
		Basic_Setting.Insert("Player" . A_Index . "Title_Selected")
	}
	Loop, 7
	{
		Basic_Setting.Insert("partyPlayer" . A_Index . "Title")
		Basic_Setting.Insert("partyPlayer" . A_Index . "Title_Selected")
	}

	Global Char_Setting := ["critical_hppercent","hpshortcut","critical_mppercent","mpshortcut","critical_fppercent","fpshortcut","Mode"]

	Global critical_hppercent, hpshortcut, critical_mppercent, mpshortcut, critical_fppercent, fpshortcut, Mode

	Global Tab1_Setting := ["readShortCut", "CheaseShortCut", "SearchDelay", "Book", "BreadShortCut","Bread_Sellers","SearchMoveDelay","Bread_Select","Cheese_Select","meditation","talk","meditation_select","talk_select"]

	Global wanteditems := ["�����ѹ�","����","���𳯰�","����������","õ","���","��","���ϰ���"]

	Global Mines := ["����", "����", "�Ľø���","�̸���","�����ÿ�","�׽��ÿ�","�긮��","��Ʈ","ī�߸���","����","����","������","��Ÿ��Ʈ","�ʱ�","�ֱ��ݻ�","�ֱ�����","�̸�","�̾�","����","��������"]

	Global AutoBuyItem := ["����","����","����","����","�а������","����","��","���","�丶��","���","����","��","����","���İ�Ƽ��","�����Ұ��","�ø���⸧","����ũ�ҽ���","����","�ް�","����","�ұ�","����"]

	Global AutoBuyInk := ["�Ͼ��","��ȫ��"]

	Global AutoBuyPant := ["�Ͼ��","��ȫ��"]

	Global AutoBuyNeckla := ["����","�����̾��"]

	Loop, %Category_Count% {
		Category_Key := A_Index
		Category_Value := Category[Category_Key]
		Temp_Variable := Category_Value
		%Temp_Variable%_Count := 0
		for key, value in %Temp_Variable%
			%Temp_Variable%_Count++
		}
	Return

LoadData:
	gosub, Setting_Values
	IfExist %A_ScriptName%.ini
		{
		Loop, %Category_Count% {
			Category_Key := A_Index
			Category_Value := Category[Category_Key]
			Temp_Variable := Category_Value
			Temp_Count := 0
			for key, value in %Temp_Variable%
			Temp_Count++
			Loop, %Temp_Count% {
				Temp_Key := A_Index
				Temp_Value := %Temp_Variable%[Temp_Key]
				Temp_Variable_Child := %Temp_Value%
				if(Category_Value = "wanteditems"||Category_Value = "Mines"||Category_Value = "AutoBuyItem"||Category_Value = "AutoBuyInk"||Category_Value = "AutoBuyPant"||Category_Value = "AutoBuyNeckla")
					IniRead, %Temp_Variable%%Temp_Value%, %A_ScriptName%.ini, %Temp_Variable%, %Temp_Value%
				else
					IniRead, %Temp_Value%, %A_ScriptName%.ini, %Temp_Variable%, %Temp_Value%

				}
			}
		}
	else{
		Loop, %Category_Count% {
			Category_Key := A_Index
			Category_Value := Category[Category_Key]
			Temp_Variable := Category_Value
			Temp_Count := 0
			for key, value in %Temp_Variable%
			Temp_Count++
			Loop, %Temp_Count% {
				Temp_Key := A_Index
				Temp_Value := %Temp_Variable%[Temp_Key]
				Temp_Variable_Child := %Temp_Value%

				if(Category_Value = "wanteditems"||Category_Value = "Mines"||Category_Value = "AutoBuyItem"||Category_Value = "AutoBuyInk"||Category_Value = "AutoBuyPant"||Category_Value = "AutoBuyNeckla")
					%Temp_Variable%%Temp_Value% := 0
				else
					%Temp_Value% := 0

				}
			}
		}
	Return

SaveData:
	Gui, Submit, Nohide
	gosub, Setting_Values
	Loop, %Category_Count% {
		Category_Key := A_Index
		Category_Value := Category[Category_Key]
		Temp_Variable := Category_Value
		Temp_Count := 0
		for key, value in %Temp_Variable%
			Temp_Count++
		Loop, %Temp_Count% {
			Temp_Key := A_Index
			Temp_Value := %Temp_Variable%[Temp_Key]

			if(Category_Value = "wanteditems"||Category_Value = "Mines"||Category_Value = "AutoBuyItem"||Category_Value = "AutoBuyInk"||Category_Value = "AutoBuyPant"||Category_Value = "AutoBuyNeckla")
				Temp_Variable_Child := %Category_Value%%Temp_Value%
			else
				Temp_Variable_Child := %Temp_Value%
			IniWrite, %Temp_Variable_Child%, %A_ScriptName%.ini, %Temp_Variable%, %Temp_Value%
		}
	}
	Return

ShowGui:


	Gui, Font, S8 Arial ,
	Tab0_Name:= "Basic_Setting"
	X_Align_Base := 10
	X_Align_Step := 20
	loop,6 {
		X_Align_%A_index% := X_Align_Base + X_Align_Step * A_Index
		}

	Y_Align_Base := 5
	Y_Align_Step := 25
	loop,11 {
		Y_Align_%A_index% := Y_Align_Base + Y_Align_Step * A_Index
		}

	if(Player1Title = 0)
		Variable_Temp := WindowTitle1
	if(Player1Title != 0)
		Variable_Temp := Player1Title
	Gui, Add, DropDownList, x%X_Align_Base% y%Y_Align_Base%+1 w84 h130 +gReselectWinTitle vPlayer1Title choose1, %Variable_Temp%
	Loop, %jElancia_Count%{
		temp_Variable := WindowTitle%A_Index%
		if(Variable_Temp!=temp_Variable)
			GuiControl,, Player1Title, %temp_Variable%
	}


	;Mode_kinds := ["����üũ","�ڵ�����","�ڵ�����","����ĳ��","�ڻ����","�׼�����","���ø���","��Ž����","��������","������","���ü��"]
	Mode_kinds := ["����üũ","����ĳ��","�ڻ����","��Ž����","������","�׼�����" ] ; alpha version 1.0.0 7/1

	Mode_kinds_Count := 0

	for key, value in Mode_kinds
		Mode_kinds_Count++


	if(Mode != 0)
		Variable_Temp := Mode
	else
		Variable_Temp := "����üũ"

	Gui, Add, DropDownList, x%X_Align_Base% y%Y_Align_1% w84 h130 vMode choose1, %Variable_Temp%
	Loop, %Mode_kinds_Count%{
		Key := A_Index
		temp_Variable := Mode_kinds[Key]
		if(Variable_Temp!=temp_Variable)
			GuiControl,, Mode, %temp_Variable%
	}

	Gui, Add, Button, x95 y%Y_Align_Base%-3 w74 h17 gRefleshWindowList1,���ΰ�ħ

	Gui, Add, Button, x95 y%Y_Align_1%-3 w36 h17 gRun_this, ����
	Gui, Add, Button, x133 y%Y_Align_1%-3 w36 h17 gStop_this, ����

	Gui, Add, Text, x%X_Align_Base% y%Y_Align_2% w164 h20 BackgroundTrans vCharLocation, ��ġ :

	Gui, Add, Text, x%X_Align_Base% y%Y_Align_3% w164 h20 BackgroundTrans vCharCurrentPos, ��ǥ :

	Gui, Add, Text, x%X_Align_Base% y%Y_Align_4% w164 h20 BackgroundTrans vCharCurrentHP cRed, HP :
	if (critical_hppercent!=0)
		Variable_Temp := critical_hppercent / 10
	else
		Variable_Temp := 5
	Gui, Add, DropDownList, x%X_Align_1% y%Y_Align_5% w38 h60 choose1 +gSettingChanged vcritical_hppercent choose%Variable_Temp%,10|20|30|40|50|60|70|80|90

	if (hpshortcut=0||hpshortcut="����")
		Variable_Temp := 11
	else
		Variable_Temp := hpshortcut
	Gui, Add, DropDownList, x%X_Align_6% y%Y_Align_5% w40 h100 choose1 +gSettingChanged vhpshortcut choose%Variable_Temp%,1|2|3|4|5|6|7|8|9|0|����

	Gui, Add, Text, x%X_Align_Base% y%Y_Align_6% w164 h20 BackgroundTrans vCharCurrentmp cBlue, MP :
	if (critical_mppercent!=0)
		Variable_Temp := critical_mppercent / 10
	else
		Variable_Temp := 5
	Gui, Add, DropDownList, x%X_Align_1% y%Y_Align_7% w38 h60 choose1 +gSettingChanged vcritical_mppercent choose%Variable_Temp%,10|20|30|40|50|60|70|80|90

	if (mpshortcut=0||mpshortcut="����")
		Variable_Temp := 11
	else
		Variable_Temp := mpshortcut
	Gui, Add, DropDownList, x%X_Align_6% y%Y_Align_7% w40 h100 choose1 +gSettingChanged vmpshortcut choose%Variable_Temp%,1|2|3|4|5|6|7|8|9|0|����


	Gui, Add, Text, x%X_Align_Base% y%Y_Align_8% w164 h20 BackgroundTrans vCharCurrentfp cGreen, FP :
	if (critical_fppercent!=0)
		Variable_Temp := critical_fppercent / 10
	else
		Variable_Temp := 5
	Gui, Add, DropDownList, x%X_Align_1% y%Y_Align_9% w38 h60 choose1 +gSettingChanged vcritical_fppercent choose%Variable_Temp%,10|20|30|40|50|60|70|80|90


	Y_Align_5 := Y_Align_5+2
	Gui, Add, Text, x%X_Align_Base% y%Y_Align_5% BackgroundTrans, hp
	Gui, Add, Text, x%X_Align_3% y%Y_Align_5% BackgroundTrans, `% ����`,Ŭ��
	Gui, Add, Text, x%X_Align_Base% y%Y_Align_7% BackgroundTrans, mp
	Gui, Add, Text, x%X_Align_3% y%Y_Align_7% BackgroundTrans, `% ����`,Ŭ��
	Gui, Add, Text, x%X_Align_Base% y%Y_Align_9% BackgroundTrans, fp
	Gui, Add, Text, x%X_Align_3% y%Y_Align_9% BackgroundTrans, `% ����`,Ŭ��

	if (fpshortcut=0||fpshortcut="����")
		Variable_Temp := 11
	else
		Variable_Temp := fpshortcut
	Gui, Add, DropDownList, x%X_Align_6% y%Y_Align_9%-5 w40 h100 choose1 +gSettingChanged vfpshortcut choose%Variable_Temp%,1|2|3|4|5|6|7|8|9|0|����



	Gui, Add, Text, x5 y%Y_Align_10% w154 BackgroundTrans vCharCurrentGalid ,������ :
	Gui, Add, Text, x5 y%Y_Align_11% w154 BackgroundTrans vCharCurrentItem, ������ĭ :
	Gui, Add, Text, x5 y320 w470 h40 BackgroundTrans vStatusline, ����ǥ����: [�����]
	Gui, Color, FFFFFF

	Gui, Add, Tab3, vTab2 x530 y10 w200 h270, �丮���|������|����|��Ŭ����
	Sub_Category_1 := ["AutoBuyItem","AutoBuyInk","AutoBuyPant","AutoBuyNeckla"]
	loop,4 {
		Key := A_Index
		Gui, Tab, %Key% ; �丮���
			;5x_base := 310 - 95
			5x_base := 450
			5x_step := 91
			;5y_base := 55
			5y_base := 32 + 20
			5y_step := 20
			temp_X := 5x_base
			temp_Y := 5y_base
			tabname := Sub_Category_1[Key]
			temp_count := %tabname%_Count
			A := 1
			Loop, %temp_count%
				{
					Value := %tabname%[A_Index]
					if (Mod(A_Index-1, 11) = 0){
						temp_X := temp_X + 5x_step
						temp_Y := 5y_base
						}
					if (%tabname%%Value% = 1) {
					;Gui, Add, Checkbox, w95 h20 +gSettingChanged v%tabname%%Value% checked, %Value%
					Gui, Add, Checkbox, x%temp_X% y%temp_Y% w90 h20 +gSettingChanged v%tabname%%Value% checked, %Value%
						}
					else if (%tabname%%Value% != 1) {
					;Gui, Add, Checkbox,  w95 h20 +gSettingChanged v%tabname%%Value%, %Value%
					Gui, Add, Checkbox, x%temp_X% y%temp_Y% w90 h20 +gSettingChanged v%tabname%%Value%, %Value%
						}
					temp_Y := temp_Y + 5y_step
				}
			}

	Gui, Add, Tab2, +Theme vTab1 gTab1 x175 y2 w330 h315 , ��Ž����|��üȰ��|���ü��|�ڵ�����|����ĳ��|�ڻ����|���ø���|��Ž���|��Ȯõ��|��Ÿ����

	gui, tab, 10 ;��Ÿ����
		x_temp:=190
		y_temp:=47
		y_temp_:=y_temp-2

		x_temp1:=x_temp+75
		x_temp2:=x_temp+95
		x_temp3:=x_temp2+95
		y_temp1:=y_temp+25
		y_temp1_:=y_temp1-2
		loop,8{
			Temp:=A_Index+1
			y_temp%Temp% := y_temp%A_Index%+25
			y_temp%Temp%_ := y_temp%Temp%-2
		}
		Gui, Add, Text,  x%x_temp% y%y_temp% w100 h20 , �ػ� ����
		Gui, Add, Button, x%x_temp% y%y_temp1% w84 h20 gSettingto800, 800x600
		Gui, Add, Button, x%x_temp% y%y_temp2% w84 h20 gSettingto1600, 1600x1200

		Gui, Add, Text,  x%x_temp% y%y_temp4% w90 h20 , �ΰ��� �� �׽�Ʈ
		Gui, Add, Checkbox, x%x_temp% y%y_temp5% w84 h20 +gfreezehack vfreezehack_check, �̵�
		Gui, Add, Checkbox, x%x_temp% y%y_temp6% w84 h20 +gwallhack vwallhack_check, ��
		Gui, Add, Checkbox, x%x_temp% y%y_temp7% w84 h20 +gcharhack vcharhack_check, ĳ��
		Gui, Add, Checkbox, x%x_temp% y%y_temp8% w84 h20 +gfloorhack vfloorhack_check, �ٴ�

		Gui, Add, Text,  x%x_temp2% y%y_temp% w100 h20 , ���Ǻ� �׽�Ʈ
		Gui, Add, Button, x%x_temp2% y%y_temp1% w84 h20 , STEP112
		Gui, Add, Button, x%x_temp2% y%y_temp2% w84 h20 , STEP113
		Gui, Add, Button, x%x_temp2% y%y_temp3% w84 h20 , STEP114
		Gui, Add, Button, x%x_temp2% y%y_temp4% w84 h20 , STEP115
		Gui, Add, Button, x%x_temp2% y%y_temp5% w84 h20 , STEP116
		Gui, Add, Button, x%x_temp2% y%y_temp6% w84 h20 , STEP117

		Gui, Add, Text,  x%x_temp3% y%y_temp% w120 h20 , �ڵ���Ƽ ��Ƽ��=1��
			y_base := y_temp1
			x_base := x_temp3
			x_base2 := x_base+20
			x_base3 := x_base2+90
			loop, 7 {
				A:=A_INDEX
				if(partyPlayer%A%Title = 0)
					Variable_Temp := WindowTitle%A%
				else if(partyPlayer%A%Title != 0)
					Variable_Temp := partyPlayer%A%Title
				if(partyPlayer%A%Title_Selected = 1)
					Gui, Add, CheckBox, x%x_base% y%y_base% w15 h15 vpartyPlayer%A%Title_Selected checked,
				else if(partyPlayer%A%Title_Selected != 1)
					Gui, Add, CheckBox, x%x_base% y%y_base% w15 h15 vpartyPlayer%A%Title_Selected,

				Gui, Add, DropDownList, x%x_base2% y%y_base% w84 h130 +gReselectWinTitle vpartyPlayer%A%Title choose1, %Variable_Temp%
				Loop, %jElancia_Count%{
					temp_Variable := WindowTitle%A_Index%
					if(Variable_Temp!=temp_Variable)
						GuiControl,, partyPlayer%A%Title, %temp_Variable%
					}
					y_base := y_base + 25
				}
			Gui, Add, Button, x%x_base2% y%y_base% w84 h15 gparty, ��Ƽ�α�

	gui, tab, 1 ;��Ž����

		Bread_Sellers_list := ["ī����","����Ʈ","ī��Ǫ","�����ǳ�","��Ű","����"]
		Bread_Sellers_list_Count := 0

		for key, value in Bread_Sellers_list
			Bread_Sellers_list_Count++

		if(Bread_Sellers = 0)
			Variable_Temp := "ī����"
		else
			Variable_Temp := Bread_Sellers

		x_temp:=190
		y_temp:=47
		y_temp_:=y_temp-2

		x_temp1:=x_temp+75
		x_temp2:=x_temp+130

		y_temp1:=y_temp+25
		y_temp1_:=y_temp1-2
		loop,8{
			Temp:=A_Index+1
			y_temp%Temp% := y_temp%A_Index%+25
			y_temp%Temp%_ := y_temp%Temp%-2
		}

		Gui, Add, Text, x%x_temp% y%y_temp% w84 h20 ,���� �Ǹ���:
		Gui, Add, Text, x%x_temp% y%y_temp1% w84 h20 ,�Ļ� ����Ű:
		if(Bread_Select = 1)
			Gui, Add, Checkbox, x%x_temp2% y%y_temp1_% w20 h15 +gSettingChanged vBread_Select checked,
		else
			Gui, Add, Checkbox, x%x_temp2% y%y_temp1_% w20 h15 +gSettingChanged vBread_Select,
		Gui, Add, Text, x%x_temp% y%y_temp2% w84 h20 ,ġ�� ����Ű:
		if(Cheese_Select = 1)
			Gui, Add, Checkbox, x%x_temp2% y%y_temp2_% w20 h15 +gSettingChanged vCheese_Select checked,
		else
			Gui, Add, Checkbox, x%x_temp2% y%y_temp2_% w20 h15 +gSettingChanged vCheese_Select,
		Gui, Add, Text, x%x_temp% y%y_temp3% w84 h20 ,��Žå ����Ű:
		Gui, Add, Text, x%x_temp% y%y_temp4% w84 h20 ,��Ž ������:
		Gui, Add, Text, x%x_temp2% y%y_temp4% w84 h20 ,ms
		Gui, Add, Text, x%x_temp% y%y_temp6% w84 h20 ,��ȭ ����Ű:
		Gui, Add, Text, x%x_temp% y%y_temp7% w84 h20 ,��� ����Ű:


		Gui, Add, DropDownList, x%x_temp1% y%y_temp_% w70 h130 vBread_Sellers choose1, %Variable_Temp%
		Loop, %Bread_Sellers_list_Count%{
			Key := A_Index
			temp_Variable := Bread_Sellers_list[Key]
			if(Variable_Temp!=temp_Variable)
				GuiControl,, Bread_Sellers, %temp_Variable%
		}

		textwidth := 45
		textwidth_double := 55
		textheight := 15

		if (BreadShortCut!=0)
			Variable_Temp := BreadShortCut
		else
			Variable_Temp := 2
		Gui, Add, DropDownList, x%x_temp1% y%y_temp1_% w%textwidth% h100 BackgroundTrans +gSettingChanged  vBreadShortCut choose%Variable_Temp%, 1|2|3|4|5|6|7|8|9|0

		if (CheaseShortCut!=0)
			Variable_Temp := CheaseShortCut
		else
			Variable_Temp := 3
		Gui, Add, DropDownList, x%x_temp1% y%y_temp2_% w%textwidth% h100 BackgroundTrans +gSettingChanged vCheaseShortCut choose%Variable_Temp%, 1|2|3|4|5|6|7|8|9|0

		if (Book!=0)
			Variable_Temp := Book
		else
			Variable_Temp := 1
		Gui, Add, DropDownList, x%x_temp1% y%y_temp3_% w%textwidth% h100 BackgroundTrans +gSettingChanged vBook choose%Variable_Temp%, 1|2|3|4|5|6|7|8|9|0

		if (SearchMoveDelay!=0)
			Variable_Temp := SearchMoveDelay
		else
			Variable_Temp := 1500
		Gui, Add, Edit, x%x_temp1% y%y_temp4_% w%textwidth% h%textheight% BackgroundTrans +gSettingChanged vSearchMoveDelay, %variable_temp%

		if (talk!=0)
			Variable_Temp := talk
		else
			Variable_Temp := 1
		Gui, Add, DropDownList, x%x_temp1% y%y_temp6_% w%textwidth% h100 BackgroundTrans +gSettingChanged vtalk choose%Variable_Temp%, 1|2|3|4|5|6|7|8|9|0
		if(Cheese_Select = 1)
			Gui, Add, Checkbox, x%x_temp2% y%y_temp6_% w20 h15 +gSettingChanged vtalk_Select checked,
		else
			Gui, Add, Checkbox, x%x_temp2% y%y_temp6_% w20 h15 +gSettingChanged vtalk_Select,

		if (meditation!=0)
			Variable_Temp := meditation
		else
			Variable_Temp := 1
		Gui, Add, DropDownList, x%x_temp1% y%y_temp7_% w%textwidth% h100 BackgroundTrans +gSettingChanged vmeditation choose%Variable_Temp%, 1|2|3|4|5|6|7|8|9|0
		if(meditation_Select = 1)
			Gui, Add, Checkbox, x%x_temp2% y%y_temp7_% w20 h15 +gSettingChanged vmeditation_Select checked,
		else
			Gui, Add, Checkbox, x%x_temp2% y%y_temp7_% w20 h15 +gSettingChanged vmeditation_Select,


		gui, tab, 2 ; ��üȰ��

			y_base := 47+10
			x_base := 190
			x_base2 := 210
			x_base3 := 300
			loop, 10 {
				A:=A_INDEX
				Gui, Add, text, x%x_base3% y%y_base% w200 h22 vPlayer%A%status,
				if(Player%A%Title = 0)
					Variable_Temp := WindowTitle%A%
				else if(Player%A%Title != 0)
					Variable_Temp := Player%A%Title
				if(Player%A%Title_Selected = 1)
					Gui, Add, CheckBox, x%x_base% y%y_base% w15 h15 vPlayer%A%Title_Selected checked,
				else if(Player%A%Title_Selected != 1)
					Gui, Add, CheckBox, x%x_base% y%y_base% w15 h15 vPlayer%A%Title_Selected,
				if(A!=1){
				Gui, Add, DropDownList, x%x_base2% y%y_base% w84 h130 +gReselectWinTitle vPlayer%A%Title choose1, %Variable_Temp%
				Loop, %jElancia_Count%{
					temp_Variable := WindowTitle%A_Index%
					if(Variable_Temp!=temp_Variable)
						GuiControl,, Player%A%Title, %temp_Variable%
					}
				}
					y_base := y_base + 25

				}

			A := 1

			2x_base := 310
			2x_step := 95
			2y_base := 45
			2y_step := 20
			temp_X0 := 2x_base
			temp_Y0 := 2y_base
			loop, 5 {
				old_num:= A_INDEX - 1
				temp_X%A_INDEX% := temp_X%old_num% + 2x_step
				temp_Y%A_INDEX% := temp_Y%old_num% + 2y_step
				}
			textw := 35
			textww := 55
			texth := 15

			;Gui, add, text, x%temp_X0% y%temp_Y0%, ����NPC�̿�
			;Gui, Add, radio, x%2x_base% y%2y_base1% w%textw% h14 BackgroundTrans ,
			;Gui, Add, DropDownList, x%x_position% y%y_temp1_% w100 h100 BackgroundTrans +gSettingChanged  vRepairNPCName choose1, 1|2|3|4|5|6|7|8|9|0
			;Gui, Add, radio, x%x_base% y%y_positionA% w%textw% h14 BackgroundTrans ,
			;Gui, Add, Text, x%x_position% y%y_positionA% w%textw% h14 BackgroundTrans , NPC X
			;variable_temp := Player%A%RepairerX
			;Gui, Add, Edit, x%x_positionA% y%y_positionA%+2 w%textw% h14 BackgroundTrans vPlayer%A%RepairerX, %variable_temp%
			;Gui, Add, Text, x%x_positionB% y%y_positionA% w%textw% h14 BackgroundTrans , NPC Y
			;variable_temp := Player%A%RepairerY
			;Gui, Add, Edit, x%x_positionC% y%y_position%+2 w%textw% h14 BackgroundTrans vPlayer%A%RepairerY, %variable_temp%
			;Gui, add, Text, x%x_base% y%y_positionA% w%textw% h14 BackgroundTrans, ������
			;variable_temp := Player%A%WaitRepair
			;Gui, Add, Edit, x%x_positionA% y%y_positionB% w%textw% h14 vPlayer%A%WaitRepair, %variable_temp%
			;Gui, Add, Text, x%x_positionB% y%y_positionB% w%textw% h14 , ��

	gui, tab, 3
		auto_hunt_map := ["����","����"]
		Bread_Sellers_list_Count := 0

		for key, value in Bread_Sellers_list
			Bread_Sellers_list_Count++

		if(Bread_Sellers = 0)
			Variable_Temp := "ī����"
		else
			Variable_Temp := Bread_Sellers

		x_temp:=190
		y_temp:=47
		y_temp_:=y_temp-2

		x_temp1:=x_temp+100
		x_temp2:=x_temp+120

		y_temp1:=y_temp+25
		y_temp1_:=y_temp1-2
		loop,8{
			Temp:=A_Index+1
			y_temp%Temp% := y_temp%A_Index%+25
			y_temp%Temp%_ := y_temp%Temp%-2
		}

		Gui, Add, CheckBox, x%x_temp% y%y_temp% w120 h20 ,�޺����
		Gui, Add, CheckBox, x%x_temp% y%y_temp1% w120 h20 vauto_divine_check,�ڵ����� ������ :
		Gui, Add, CheckBox, x%x_temp% y%y_temp2% w120 h20 vauto_skin_check,�ڵ��Ǻ� ������ :
		Gui, Add, Edit, x%x_temp1% y%y_temp1% w40 h20 vauto_divine_delay,
		Gui, Add, Edit, x%x_temp1% y%y_temp2% w40 h20 vauto_skin_delay,
		loop,4
		{
			Gui, Add, CheckBox, x%x_temp% y%y_temp4% w70 h20 ,���þ��%A_Index%
			Gui, Add, CheckBox, x%x_temp2% y%y_temp4% w100 h20 ,�ڵ��׷��̵�
			y_temp4 := y_temp4 + 25
		}


	gui, tab, 4 ;�ڵ�����

			;���ſ� ��Ž��
			;1  2 3 4 5
			;�Ǹſ� ��Ž��
			;�Ǹ��� �Ҿ�
			;X		Y
			x_temp:=190
			y_temp:=47
			y_temp_:=y_temp-2

			x_temp1:=x_temp+20
			loop,5{
				Temp:=A_Index+1
				x_temp%Temp% := x_temp%A_Index%+20
			}
			y_temp1:=y_temp+20
			y_temp1_:=y_temp1-2
			loop,5{
				Temp:=A_Index+1
				y_temp%Temp% := y_temp%A_Index%+25
				y_temp%Temp%_ := y_temp%Temp%-2
			}

			Gui, Add, Text, x%x_temp% y%y_temp% w110 h20 ,��Ž   ����/�Ǹ�/����
			loop,5 {
				Y_Num := A_INDEX
				Y_Num := y_temp%Y_Num%

				Gui, Add, Text, x%x_temp% y%Y_Num% w35 h20 ,��Ž%A_INDEX%
				Gui, Add, Radio, x%x_temp2% y%Y_Num% w15 h15 vSearch_Book%A_INDEX%_1,
				Gui, Add, Radio, x%x_temp3% y%Y_Num% w15 h15 vSearch_Book%A_INDEX%_2,
				Gui, Add, Radio, x%x_temp4% y%Y_Num% w15 h15 vSearch_Book%A_INDEX%_3,
				sleep,1
				GuiControlGet, SelectedRadio, Search_Book%A_INDEX%_3
				}

	InTab_Check_Menu := ["Mines","wanteditems"]

	tabnumber := 5

	loop,2 {
		Key := A_Index
		tabname := InTab_Check_Menu[Key]

		gui, tab, %tabnumber%
			5x_base := 310
			5x_step := 95
			5y_base := 45
			5y_step := 20
			temp_X := 5x_base
			temp_Y := 5y_base
			temp_count := %tabname%_Count
			A := 1
			Loop, %temp_count%
			{
				Value := %tabname%[A_Index]
				if (Mod(A_Index, 14) = 0){
					temp_X := temp_X + 5x_step
					temp_Y := 5y_base
					}
				if (%tabname%%Value% = 1) {
				Gui, Add, Checkbox, x%temp_X% y%temp_Y% w95 h20 +gSettingChanged v%tabname%%Value% checked, %Value%
					}
				else if (%tabname%%Value% != 1) {
				Gui, Add, Checkbox, x%temp_X% y%temp_Y% w95 h20 +gSettingChanged v%tabname%%Value%, %Value%
					}
				temp_Y := temp_Y + 5y_step
			}
		tabnumber++
		}

		gui, tab, 5 ; ����ĳ��
			x_temp:=190
			y_temp:=42
			y_temp_:=y_temp-2

			x_temp1:=x_temp+20
			loop,5{
				Temp:=A_Index+1
				x_temp%Temp% := x_temp%A_Index%+40
			}

			Y_Num := y_temp
			loop,5 {
				Gui, Add, Text, x%x_temp% y%Y_Num% w110 h15 ,%A_INDEX%������
				Y_Num := Y_Num + 17
				Gui, Add, Text, x%x_temp% y%Y_Num% w40 h15 ,X_POS%A_INDEX%
				Gui, Add, Text, x%x_temp2% y%Y_Num% w40 h15, Y_POS%A_INDEX%
				Y_Num := Y_Num + 17
				Gui, Add, Text, x%x_temp% y%Y_Num% w40 h15 ,CordiX%A_INDEX%
				Gui, Add, Text, x%x_temp2% y%Y_Num% w40 h15, CordiY%A_INDEX%
				Y_Num := Y_Num + 20
				}


	Gui, Color, FFFFFF
	if (guix < 1||guix > 10000)
		guix := 1
	if (guiy < 1 ||guiy > 10000)
		guiy := 1
	Global ThisWindowTitle := "H-Elancia Alpha - V1.0.0"
	Gui, Show, w510 h350 x%guix% y%guiy%, %ThisWindowTitle%
	Return



Tab1:
Gui, Submit, NoHide
if Tab1 = ��üȰ��
	GuiControl, Move, Player1Title, x210 y57
else
	GuiControl, Move, Player1Title, x10 y5

if Tab1 = �ڵ�����
	GuiControl, Move, Tab2, x300 y40
else
	GuiControl, Move, Tab2, x520 y40

WinSet, Redraw, , A
return

GuiClose:
	WinGetPos, GuiX, GuiY, PosW, PosH, %ThisWindowTitle%
	gosub, SaveData
	ExitApp
	return

Run_this:
	Guicontrol,, Statusline, (STEP000)
	Gui, Submit, nohide
	WindowTitle := Player1Title
	Global currentplayer := 1
	A:=1
	Coin:=1
	sleep, 10
	;Global mem := get_mem()
	;Global DllName := "jelancia_core.dll"
	;Global jelanCoreAdd := getModuleBaseAddress()
	;Global moduleBase := mem.getModuleBaseAddress(DllName)
	Global CharStatusCHeck_delay := A_TickCount

	SetTimer, CharStatusCheck, 1000
	Guicontrol,, Statusline, (STEP001)
	sleep, 10
		Guicontrol,, Statusline, (STEP002)
		if(Coin!=1){
			Guicontrol,, Statusline, (STEP000) �����
			KeyClick("AltR")
			return
		}
		else if(Mode="��Ž����"){
			Guicontrol,, Statusline, (STEP101)
			gosub, ��Ž����
			}
		else if(Mode="�ڻ����"){
			Guicontrol,, Statusline, (STEP601)
			gosub, �ڻ����
		}
		else if(Mode="����ĳ��"){
			gosub, ����ĳ��
			Guicontrol,, Statusline, (STEP501)
		}
		else if(Mode="�ڵ�����"){
			gosub, �ڵ�����
			Guicontrol,, Statusline, (STEP401)
		}
		else if(Mode="����üũ"){
;			CharStatusCheck()
			Guicontrol,, Statusline, (STEP1001)
		}
		else if(Mode="������"){
			gosub, ������
			Guicontrol,, Statusline, (STEP3001)
		}
		else if(Mode="�׼�����"){
			gosub, �׼�����
			Guicontrol,, Statusline, (STEP4001)
		}
		if(Coin!=1){
			Guicontrol,, Statusline, (STEP000) �����
			KeyClick("AltR")
			return
		}
	return

Stop_this:
	Coin:=0
	SetTimer, CharStatusCheck, off
	return

CharStatusCheck:
if(Coin=1)
	CharStatusCheck()
return


Search_Book1_1Clicked:
    GuiControl,, Search_Book1_2, Disable
    GuiControl,, Search_Book1_3, Disable
return

Search_Book1_2Clicked:
    GuiControl,, Search_Book1_1, Disable
    GuiControl,, Search_Book1_3, Disable
return

Search_Book1_3Clicked:
    GuiControl,, Search_Book1_1, Disable
    GuiControl,, Search_Book1_2, Disable
return

ReselectWinTitle:
	WindowTitle := Player1Title
	return

RefleshWindowList1:
gui,submit,nohide
	WindowTitle:=Player1title
	IfWinExist, %WindowTitle%
		{
			IfWinNotActive, %WindowTitle%
				{
					WinActivate,%WindowTitle%
				}
		}
	loop,10
		{
			RefleshWindowList(A_INDEX)
		}
	return


freezehack:
Gui, Submit, nohide
	WindowTitle := Player1Title
	if freezehack_check = 1
		Freeze_Move()
	else if freezehack_check = 0
		Un_Freeze_Move()
	return
	wallhack:
		gui, submit, nohide
		WindowTitle := Player1Title
		if wallhack_check = 1
			wall_remove_enable()
		else if wallhack_check = 0
			wall_remove_disable()
		return
	charhack:
		gui, submit, nohide
		WindowTitle := Player1Title
		if wallhack_check = 1
			char_remove_enable()
		else if wallhack_check = 0
			char_remove_disable()
		return
	floorhack:
		gui, submit, nohide
		WindowTitle := Player1Title
		if wallhack_check = 1
			floor_remove_enable()
		else if wallhack_check = 0
			floor_remove_disable()
		return
������:
	Gui, Submit, nohide
	Loop, 10
		{
			Player%A_Index%Delay1 := A_TickCount
			Player%A_Index%Delay2 := A_TickCount
		}
	Guicontrol,, Statusline, (STEP3002)
	loop, {
		if Coin!=1
			break
		loop, 10
			{
				if Coin!=1
					break
				Guicontrol,, Statusline, (STEP3101)
				if(Player%A_Index%Title_Selected = 1){
					WindowTitle := Player%A_Index%Title
					currentplayer := A_Index
					sleep,1
					Guicontrol,, Statusline, (STEP3101) %WindowTitle%
					Delay := A_TickCount - Player%A_Index%Delay1
					if (Delay >= 11000) {
						KeyClick(1)
						KeyClick(1)
						KeyClick(1)
						Player%A_Index%Delay1 := A_TickCount
						}
					Guicontrol,, Statusline, (STEP3102) %WindowTitle% 1��Ű Ŭ��
					Delay := A_TickCount - Player%A_Index%Delay2
					if (Delay >= 60500) {
						sleep, 1
						KeyClick("CTRL1")
						sleep, 100
						KeyClick(6)
						sleep, 100
						KeyClick(6)
						Player%A_Index%Delay2 := A_TickCount
						Guicontrol,, Statusline, (STEP3202) %WindowTitle% CTRL1��Ű �� 6��Ű Ŭ��
						}
					if Coin!=1
						break

				}

			}
		}
	Guicontrol,, Statusline, (STEP3004)
	return

�׼�����:
	Gui, Submit, nohide

	Loop, 10
		{
			if(Player%A_Index%Title_Selected = 1){
				Player%A_Index%Delay1 := A_TickCount
				Player%A_Index%Delay2 := A_TickCount
			}
		}

	Guicontrol,, Statusline, (STEP4002)
	loop, {
		if Coin!=1
			break

		loop, 10
			{
				if Coin!=1
					break
				Guicontrol,, Statusline, (STEP4003)
				Gui, Submit, nohide
				sleep,1
				if(Player%A_Index%Title_Selected = 1){
					WindowTitle := Player%A_Index%Title
					currentplayer := A_Index
					sleep,1
					if(presetting%A_Index% != 1){
						SetTimer, CharStatusCheck, off
						sleep,100
						presetting := GameIslandMacroText()
						sleep,100
						presetting%A_Index% := 1
						Guicontrol,, Statusline, (STEP4101)
						SetTimer, CharStatusCheck, 1000
					}
					sleep,1
					Guicontrol,, Statusline, (STEP4004) %WindowTitle%
					Delay := A_TickCount - Player%A_Index%Delay1
					if (Delay >= 1000) {
						GameIslandMouseClickEvent()
						Player%A_Index%Delay1 := A_TickCount
						}

					if Coin!=1
						break
					Delay := A_TickCount - Player%A_Index%Delay2
					if (Delay >= 2000) {
						GameIslandTextMacro()
						Player%A_Index%Delay2 := A_TickCount
						}
					if Coin!=1
						break
				}

			}
		}
	Guicontrol,, Statusline, (STEP3004)
	return
��Ž����: ;TAB1
	Gui, Submit, nohide

	Guicontrol,, Statusline, ����ǥ����:  [��Ž����] �����غ���
	WindowTitle := Player1Title

	;��Ž�� ���ۼ���
	temp_check := Cheese_Select + bread_Select
	if temp_check = 0
		{
			MsgBox, �Ļ� ġ�� ���߿� �ϳ��� �����ϵ��� �����ؾ� �մϴ�
			Coin := 0
			return
		}

	if(isFirstTimeRunThisCode := 1){
		start_inven := Get_inven()
		if start_inven > 40
		{
			Guicontrol,, Statusline, (STEP104) %start_inven%
			msgbox, �κ��丮�� �ּ� 10ĭ�̻� Ȯ���ϰ� �ٽ� �������ּ���
			Coin := 0
			return
		}
		Guicontrol,, Statusline, (STEP102)
		Freeze_Move()
		wall_remove_enable()
		floor_remove_enable()
		char_remove_enable()
		Move_Buy()
		Move_Sell()
		Move_Repair()
		Buy_Unlimitted()
		KeyClick("AltR")
		if Bread_Sellers = ī����
			NPCNAME := "zkelffk"
		else if Bread_Sellers = ����Ʈ
			NPCNAME := "tispxm"
		else if Bread_Sellers = ī��Ǫ
			NPCNAME := "zkfpvn"
		else if Bread_Sellers = ��Ű
			NPCNAME := "znzl"
		else if Bread_Sellers = ����
			NPCNAME := "qptm"
		else if Bread_Sellers = �����ǳ�
			NPCNAME := "dhdlvlsh"
		Guicontrol,, Statusline, (STEP103) %Bread_Sellers%
		inputmenu(NPCNAME)
		isFirstTimeRunThisCode := 0
		SearchRootCounter := A_TickCount
		talkcounter := A_TickCount
		sleep, 100
		}

	Guicontrol,, Statusline, (STEP105)����ǥ����:  [��Ž����] �۵���
	loop,{
		if Coin!=1
			break
		Galid := Get_Galid()
		if (Galid <= 10000){
			Guicontrol,, Statusline, (STEP104) %Galid%
			MsgBox, ���� ���� ������(%Galid%) �� �ʹ� �����ϴ�.
			break
			}
		SetTimer, CharStatusCheck, off
		if (Get_inven() <= start_inven){
			Guicontrol,, Statusline, (STEP105)����ǥ����:  [��Ž����] �۵��� - �Ļ�������
			BuyBread(Bread_Sellers,start_inven)
			sleep,1
			}
		SetTimer, CharStatusCheck, 1000
		if Coin!=1
			break
		;���� FPȮ��
		FP := Get_FP()
		if(FP.NOW <= 140){
				Guicontrol,, Statusline, (STEP106)
				loop,11{
					if(Bread_Select = 1)
						KeyClick(BreadShortCut)
					if(Cheese_Select = 1)
						KeyClick(CheaseShortCut)
					FP := Get_FP()
					if(FP.Now >= 140)
						break
				}
			}
		if Coin!=1
			break
		Guicontrol,, Statusline, (STEP107)����ǥ����:  [��Ž����] �۵���

		Delay := A_TickCount - talkcounter
		if (Delay >= 100) {
			if meditation_check =1
				keyclick(meditation)
			if meditation_check =1
				keyclick(meditation)
			talkcounter := A_TickCount
			}
		Delay := A_TickCount - SearchRootCounter
		sleep,1
		if (Delay >= SearchMoveDelay) {
			Guicontrol,, Statusline, (STEP108)����ǥ����:  [��Ž����] �۵���
			KeyClick(Book)
			sleep,1

			Num := 0 ;��Ž���� - �⺻ ��Ž��ȣ ������ ���ϸ� ���⸦ ���� 1,2,3,4,5 �� �Ѱ� �Է�
			Search_Book(Num)
			sleep,1
			SearchRootCounter := A_TickCount
			sleep,1
			}
		}
	Un_Freeze_Move()
	wall_remove_disable()
	char_remove_disable()
	floor_remove_disable()
	return

�ڵ�����:
Gui, Submit, Nohide
	if(isFirstTimeRunThisCode := 1){
		Move_Buy()
		Move_Sell()
		Move_Repair()
		Buy_Unlimitted()
		inputallsellers()
		start_inven := Get_inven()
		isFirstTimeRunThisCode := 0
		sleep, 100
		}
	Num:=1
	loop,
	{
	Gui, Submit, nohide
	if Coin!=1
		break
	Freeze_Move()
	Move_buy()
	MapNumber := GetMapNumber()
	if(MapNumber=3204){
		loop,2 {
			if Coin!=1
				break
			keyclick("CTRL7") ; ī��Ǫ�޴�
			sleep, 1000
			NPCMENUCLICK("Buy","CTRL7")
			sleep, 200
			loop, 2 {
				PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
			sleep, 200
			}
		Now_Selected := 1
		;ī��Ǫ�޴�
		C3:="����ũ�ҽ���"
		C10:="����"
		C12:="����"
		C15:="����"
		C19:="�а������"
		C25:="����"
		C26:="ġ��"
		C28:="�Ļ�"
		C29:="�ް�"
		C32:="��"

		loop, 32 {
			if Coin!=1
				break
			target := "C"A_Index
			target := %target%
			target := AutoBuyItem%target%
			if target = 1
				loop,35{
					keyclick("RightArrow")
				}
			sleep, 1
			keyclick("DownArrow")
			Now_Selected++
			}
		sleep,10
		loop,2 {
			PostClick(423,322)
			sleep,1000
			}
		sleep,1000
		PostClick_Right(205,57)
		}

		loop,2 {
		keyclick("CTRL8") ; �����ǳ�޴�
		sleep, 1000
		NPCMENUCLICK("Buy","CTRL8")
		sleep, 200
		loop, 2 {
			PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
		sleep, 200
		}

		Now_Selected := 1
		;�����ǳ�޴�
		D23:="����"
		D27:="����"
		D28:="����"
		D29:="����"
		D33:="�а������"
		D39:="����"
		D40:="ġ��"
		D42:="�Ļ�"
		D45:="��"
		D46:="���"
		D57:="�丶��"
		D60:="���"
		D64:="����"
		D65:="��"
		D66:="����"

		loop, 66 {
			target := "D"A_Index
			target := %target%
			target := AutoBuyItem%target%
			if target = 1
				loop,35{
					keyclick("RightArrow")
				}
			sleep, 1
			keyclick("DownArrow")
			Now_Selected++
			}
		sleep,10
		loop,2 {
			PostClick(423,322)
			sleep,1000
			}
		sleep,1000
		PostClick_Right(205,57)
		}
	}
	else if(MapNumber=4200){
		loop,2 {
			if Coin!=1
				break
		keyclick("CTRL5") ; �����޴�
		sleep, 1000
		NPCMENUCLICK("Buy","CTRL5")
		sleep, 200
		loop, 2 {
			PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
		sleep, 200
		}
		Now_Selected := 1
		;�����޴�
		A17 := "��뼭���ǿ�"
		A18 := "��뼭������"
		A19 := "��뼭�ָ���"
		A20 := "��뼭�׽�"
		A21 := "��뼭�ͱ�"
		A22 := "��뼭�Ҿ�"
		A23 := "����"
		A24 := "�ͻ��"
		A25 := "�ұ�"
		A26 := "����"
		A27 := "����"
		A28 := "����"
		A29 := "����"
		A30 := "�������"
		A31 := "�ٴҶ����"
		A32 := "���ø�����"
		A33 := "�а������"
		A34 := "īī������"
		A35 := "ȭ��Ʈ�ҽ�"
		A36 := "���⤚"
		A37 := "ũ��"
		A38 := "��"
		A39 := "����"
		A40 := "ġ��"
		A41 := "���⸧"
		A42 := "�Ļ�"
		A43 := "��������"
		A44 := "ī������"
		A45 := "��"
		A46 := "���"
		A57 := "�丶��"
		A60 := "���"
		A61 := "����"
		A64 := "����"
		A65 := "��"
		A66 := "����"
		A72 := "���İ�Ƽ��"
		A73 := "�����Ұ��"
		A74 := "�ø���⸧"

		loop, 74 {
			target := "A"A_Index
			target := %target%
			target := AutoBuyItem%target%
			if target = 1
				loop,35{
					keyclick("RightArrow")
				}
			sleep, 1
			keyclick("DownArrow")
			Now_Selected++
			}
		sleep,10
		loop,2 {
			PostClick(423,322)
			sleep,1000
			}
		sleep,1000
		PostClick_Right(205,57)
		}

		loop,2 {
		keyclick("CTRL6") ; ��Ű�޴�
		sleep, 1000
		NPCMENUCLICK("Buy","CTRL6")
		sleep, 200
		loop, 2 {
			PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
		sleep, 200
		}

		Now_Selected := 1
		;��Ű�޴�
		B1:="�߰��"
		B2:="��"
		B3:="����ũ�ҽ���"
		B4:="�ܹ�����"
		B5:="�����������"
		B6:="�������"
		B7:="��������"
		B8:="�ο�߾�"
		B9:="��ģ�߾�"
		B10:="����"
		B12:="����"
		B13:="�ұ�"
		B14:="����"
		B15:="����"
		B18:="���ø�����"
		B19:="�а������"
		B25:="����"
		B26:="ġ��"
		B28:="�Ļ�"
		B29:="�ް�"
		B32:="��"

		loop, 32 {
			target := "B"A_Index
			target := %target%
			target := AutoBuyItem%target%
			if target = 1
				loop,35{
					keyclick("RightArrow")
				}
			sleep, 1
			keyclick("DownArrow")
			Now_Selected++
			}
		sleep,10
		loop,2 {
			PostClick(423,322)
			sleep,1000
			}
		sleep,1000
		PostClick_Right(205,57)
		}
	}
	else if(MapNumber=1214){
		Pos:=GetPos()
		TempX := Pos.PosX
		TempY := Pos.PosY
		if(TempX >=26){
			loop,2 {
				if Coin!=1
					break
				keyclick("CTRL4") ; ����Ʈ �޴�
				sleep, 1000
				NPCMENUCLICK("Buy","CTRL4")
				sleep, 200
				loop, 2 {
					PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
				sleep, 200
				}
				Now_Selected := 1
				I1:="�߰��"
				I2:="��"
				I3:="����ũ�ҽ���"
				I4:="�ܹ�����"
				I5:="�����������"
				I10:="����"
				I11:="�ͻ��"
				I12:="�ұ�"
				I13:="����"
				I14:="����"
				I17:="���ø�����"
				I18:="�а������"
				I24:="����"
				I25:="ġ��"
				I26:="���⸧"
				I27:="�Ļ�"
				I28:="�ް�"
				I31:="��"
				loop, 31 {
					target := "I"A_Index
					target := %target%
					target := AutoBuyItem%target%
					if target = 1
						loop,35{
							keyclick("RightArrow")
						}
					sleep, 1
					keyclick("DownArrow")
					Now_Selected++
					}
				sleep,10
				loop,2 {
					PostClick(423,322)
					sleep,1000
					}
				sleep,1000
				PostClick_Right(205,57)
			}
			Un_Freeze_Move()
			loop, 10{
				Click_CurrentMiniMapPos(-13,-13)
				Sleep,1000
				Pos:=GetPos()
				TempX := Pos.PosX
				TempY := Pos.PosY
				if(TempX <= 24)
					break
			}

			if(TempX <= 24){
				loop,2 {
					Freeze_Move()
					keyclick("CTRL3") ; ����޴�
					sleep, 1000
					NPCMENUCLICK("Buy","CTRL3")
					sleep, 200
					loop, 2 {
						PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
					sleep, 200
					}
					Now_Selected := 1
					;����޴�
					H24:="���"
					H35:="�丶��"
					H38:="���"
					H39:="����"
					H42:="����"
					H43:="��"
					H44:="����"
					loop, 44 {
						target := "H"A_Index
						target := %target%
						target := AutoBuyItem%target%
						if target = 1
							loop,35{
								keyclick("RightArrow")
							}
						sleep, 1
						keyclick("DownArrow")
						Now_Selected++
						}
					sleep,10
					loop,2 {
						PostClick(423,322)
						sleep,1000
						}
					sleep,1000
					PostClick_Right(205,57)
					}
				}
			}
		}
	else if(MapNumber=204){
		Pos:=GetPos()
		TempX := Pos.PosX
		TempY := Pos.PosY
		if(TempY <=17){
			loop,2 {
				if Coin!=1
					break
				keyclick("CTRL1") ; ī���� �޴�
				sleep, 1000
				NPCMENUCLICK("Buy","CTRL1")
				sleep, 200
				loop, 2 {
					PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
				sleep, 200
				}
				Now_Selected := 1
				;ī����޴�
				;CTRL1
				E23:="����"
				E27:="����"
				E31:="�а������"
				E37:="����"
				E38:="ġ��"
				E40:="�Ļ�"
				E43:="��"
				loop, 43 {
					target := "E"A_Index
					target := %target%
					target := AutoBuyItem%target%
					if target = 1
						loop,35{
							keyclick("RightArrow")
						}
					sleep, 1
					keyclick("DownArrow")
					Now_Selected++
					}
				sleep,10
				loop,2 {
					PostClick(423,322)
					sleep,1000
					}
				sleep,1000
				PostClick_Right(205,57)
			}
			Un_Freeze_Move()
			loop, 10{
				Click_CurrentMiniMapPos(+13,+12)
				Sleep,1000
				Pos:=GetPos()
				TempX := Pos.PosX
				TempY := Pos.PosY
				if(TempY >= 24)
					break
			}
			if(TempY >= 24){
				loop,2 {
					if Coin!=1
						break
					Freeze_Move()
					keyclick("CTRL2") ; �� �޴�
					sleep, 1000
					NPCMENUCLICK("Buy","CTRL2")
					sleep, 200
					loop, 2 {
						PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
					sleep, 200
					}
					Now_Selected := 1
					;���޴�
					;CTRL2
					G1:="���"
					G12:="�丶��"
					G15:="���"
					G19:="����"
					G20:="��"
					G21:="����"
					loop, 21 {
						target := "G"A_Index
						target := %target%
						target := AutoBuyItem%target%
						if target = 1
							loop,35{
								keyclick("RightArrow")
							}
						sleep, 1
						keyclick("DownArrow")
						Now_Selected++
						}
					sleep,10
					loop,2 {
						PostClick(423,322)
						sleep,1000
						}
					sleep,1000
					PostClick_Right(205,57)
					}
				}
			}
		}
	if Coin!=1
		return
	Temp:=Get_FP()
	FPNow:=Temp.Now
	FPMax:=Temp.Max
	if FPNow <140
		KeyClick(0)

	inven := Get_inven()

	if(inven>=49){
		Freeze_Move()
		sleep,1000
		Search_Book(1)
		sleep,3000
		;autosellitem()
		break
		}
	Num++
	Search_Book(Num)
	if Num=5
		Num:=2
	Sleep,3000
	}

return


����ĳ��:
	Gui, Submit, Nohide
	Global minimap_steps := 0 , PosX, PosY, MovePosX, MovePosY, stopmoving := 0, temp_x, temp_y
	if(isFirstTimeRunThisCode := 1){
		wall_remove_enable()
		floor_remove_enable()
		char_remove_enable()
		;���� �κ����� Ȯ��
		start_inven := Get_inven()
		isFirstTimeRunThisCode := 0
		sleep, 100
		Global mine_found := 0
		Global Mines_Count := 0
		for key, value in Mines
			Mines_Count++
		Global Mine_Error_Counter := A_TickCount
		Guicontrol,, Statusline, (STEP19) ����ǥ����: [�۵���] ����ĳ�� �����Ϸ� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving%
		}
	loop, {
		Mine_found := 0
		if(Coin!=1)
			break
		Global MapNumber := GetMapNumber()
		Global original_MoveposX,original_MoveposY,remember_previous_posx,remember_previous_posy
		MapBig := ReadMemory(ReadMemory(ReadMemory(ReadMemory(ReadMemory(0x0058DAD0)+0xC)+0x10)+0x8)+0x264)
		if(MapNumber=8){
			loop,4{
				Keyclick("UpArrow")
				sleep,100
				}
			}
	if(MapNumber=237&&MapBig!=1) {
		postclick(725, 484)
		sleep, 100
		}
	Guicontrol,, Statusline, (STEP20) ����ǥ����: [�۵���] ����ĳ�� ���� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving%
	mining()
	}
	Guicontrol,, Statusline, (STEP21) ����ǥ����: [������] ����ĳ�� ���� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving%
	wall_remove_disable()
	floor_remove_disable()
	char_remove_disable()
	Return

�ڻ����: ;TAB6
	Gui, Submit, nohide
	Guicontrol,, Statusline, ����ǥ����:  [�ڻ����] �����غ���
	WindowTitle := Player1Title
	;�ڻ���� ���ۼ���
	if(isFirstTimeRunThisCode := 1){
		wall_remove_enable()
		floor_remove_enable()
		char_remove_enable()
		;���� �κ����� Ȯ��
		start_inven := Get_inven()
		isFirstTimeRunThisCode := 0
		sleep, 100
		}
	if(Coin!=1)
		return
	loop, {
		Gui, Submit, nohide
		if(Coin!=1)
			break
		MapNumber := GetMapNumber()
		sleep,1
		if(MapNumber=2241){
		Click_CurrentMiniMapPos(-1,32)
		sleep,1
		postclick(clixkx,clicky)
		sleep,1
		}
		ItemFound_Click(wanteditems,wanteditems_count)
		sleep, 1
		}
	wall_remove_disable()
	floor_remove_disable()
	char_remove_disable()
	return

Settingto800:
	winmode:=800
	return
Settingto1600:
	winmode:=1600
	return

SettingChanged:
	Global Setting := ["Char_Setting","Tab1_Setting","Mines","wanteditems","AutoBuyItem","AutoBuyInk","AutoBuyPant","AutoBuyNeckla"]
	Global Setting_Count := 0
	for key, value in Setting
		Setting_Count++
	Loop, %Setting_Count% {
		Setting_Key := A_Index
		Setting_Value := Setting[Setting_Key]
		Temp_Variable := Setting_Value
		Temp_Count := 0
		for key, value in %Temp_Variable%
			Temp_Count++
		Loop, %Temp_Count% {
			Temp_Key := A_Index
			Temp_Value := %Temp_Variable%[Temp_Key]
			if(Setting_Value = "wanteditems"||Setting_Value = "Mines"||Setting_Value = "AutoBuyItem"||Setting_Value = "AutoBuyInk"||Setting_Value = "AutoBuyPant"||Setting_Value = "AutoBuyNeckla")
				Temp_Variable_Child := %Temp_Variable%%Temp_Value%
			else
				Temp_Variable_Child := %Temp_Value%
			GuiControlGet, Temp_Variable_Child
			}
		}
	return

party:
	loop, 6
	{
		A := A_Index + 1
		if partyPlayer%A%Title_Selected = 1
			{
				WindowTitle := partyPlayer%A%Title
				target_id := get_jelan_char_id()
				sleep, 100
				WindowTitle := partyPlayer1Title
				sleep, 100
				sendtargetid(target_id)
				sleep, 100
				Doparty()
			}
	}
	return

autosellitem(){
	NPCX := 421
	NPCY := 195
	KeyClick(Book)
	sleep,500
	Search_Book(1)
	sleep,3000

	sleep,10
	loop,2 {
		PostClick(NPCX,NPCY)
		sleep,100
		}
	NPCMENUCLICK("SELL","N")
	loop, 2 {
	PostClick(205,57)
	sleep, 250
	}
	howmanyitems := 40
	loop,%howmanyitems% {
		postmessage, 0x100, 40, 22020097, ,%WindowTitle% ; ���� Ű Lock
		postmessage, 0x101, 40, 22020097, ,%WindowTitle% ; ���� Ű Release
		sleep, 10
		loop,10 {
			KeyClick("RightArrow")
		sleep, 1
			}
		}
	sleep,200
	PostClick(423,322)
	sleep, 300
	PostClick_Right(205,57)
}

CharStatusCheck(){
		Gui, Submit, nohide
		Pos:=GetPos()
		TempX := Pos.PosX
		TempY := Pos.PosY
		Guicontrol,, CharCurrentPos, ��ǥ : X : %TempX%    Y: %TempY%
		SetFormat, integer, d
		Elancia_mapName := Get_Location()
		MapNumber := GetMapNumber()

		Guicontrol,, CharLocation, ��ġ : %Elancia_mapName%(%MapNumber%)
		Temp:=Get_HP()
		HPNow:=Temp.Now
		HPMax:=Temp.Max
		HPPercent:=Temp.Percent
		guicontrolget,critical_hppercent
		guicontrolget,hpshortcut
		Guicontrol,, CharCurrentHP, HP`: %HPNow% / %HPMax% `(%HPPercent%`%`)
		if(HPPercent<=critical_hppercent && hpshortcut != "����")
			keyclick(hpshortcut)
		Temp:=Get_MP()
		MPNow:=Temp.Now
		MPMax:=Temp.Max
		MPPercent:=Temp.Percent
		Guicontrol,, CharCurrentMP, MP`: %MPNow% / %MPMax% `(%MPPercent%`%`)
		guicontrolget,critical_mppercent
		guicontrolget,mpshortcut
		if(MPPercent <= critical_mppercent && mpshortcut != "����")
			keyclick(mpshortcut)
		Temp:=Get_FP()
		FPNow:=Temp.Now
		FPMax:=Temp.Max
		FPPercent:=Temp.Percent
		Guicontrol,, CharCurrentFP, FP`: %FPNow% / %FPMax% `(%FPPercent%`%`)
		guicontrolget,critical_fppercent
		guicontrolget,fpshortcut
		if(FPPercent <= critical_fppercent && fpshortcut != "����")
			{
			keyclick(fpshortcut)
			Temp:=Get_FP()
			increased := FPNow - Temp.Now
			if increased <2
			{
				loop, 30
					keyclick(fpshortcut)
				}
			}
		Galid := Get_Galid()
		Galid := FormatNumber(Galid)
		Guicontrol,, CharCurrentGalid, ������`: %Galid%
		Inven:= Get_inven()
		Guicontrol,, CharCurrentItem, ������`: %inven% / 50
		Guicontrol,, Statusline, ����ǥ����:  [����üũ�Ϸ�] HP: %HPPercent% `% | MP: %MPPercent% `%  | FP: %FPPercent% `%
		Guicontrol,, Player%currentplayer%status,��ġ: %Elancia_mapName%(%MapNumber%) �ι��丮: %inven% / 50
	}

ItemFound_Click(wanteditems,wanteditems_count){
	search_PosX := 2
	search_PosY := 2
	image_PosX := 1 + (search_PosX - 1) * 24
	image_PosY := 1 + (search_PosY - 1) * 24
	image_PosX_limit := 1 + (search_PosX + 25 - 1) * 24
	image_PosY_limit := 1 + (search_PosX + 15 - 1) * 24

		Loop, %wanteditems_count%
		{
			itemKey := A_Index
			itemValue := wanteditems[itemKey]

			tabname := "wanteditems"
			checked := %tabname%%itemValue%
				IfWinNotActive, %WindowTitle%
					WinActivate,%WindowTitle%
			if (checked = 1)
			{
			sleep,1
			ImageSearch, target_PosX, target_PosY, image_PosX, image_PosY, image_PosX_limit, image_PosY_limit, *10 %itemValue%.png
			sleep,1
			if (ErrorLevel = 0)
				{
				Guicontrol,, Statusline, ����ǥ����: [�۵���] �ڻ����, ������ %itemValue% �߰�, ��ǥ X: %target_PosX% | Y: %target_PosY%
				targetX := Floor((target_PosX - 1) / 24) * 24 + 24 - 4 -11
				targetY := Floor((target_PosY) / 24 + 1) * 24 - 23 + 11
				postclick(targetX, targetY)
				postmove(7, 755)
				sleep,1
				break
				}
			else if (ErrorLevel != 0)
				{
				A:=1
				Loop, {
					A++
					IfExist %itemValue%%A%.png
						{
						ImageSearch, target_PosX, target_PosY, image_PosX, image_PosY, image_PosX_limit, image_PosY_limit, *10 %itemValue%%A%.png
						sleep,1
						if (ErrorLevel = 0)
							{
								Guicontrol,, Statusline, ����ǥ����: [�۵���] �ڻ����, ������ %itemValue% �߰�, ��ǥ X: %target_PosX% | Y: %target_PosY%
								targetX := Floor((target_PosX - 1) / 24) * 24 + 24 - 4 -11
								targetY := Floor((target_PosY) / 24 + 1) * 24 - 23 + 11
								postclick(targetX, targetY)
								postmove(7, 755)
								sleep,1
								break
							}
						}
					Else
						break
					}
				Guicontrol,, Statusline, ����ǥ����: [�۵���] �ڻ����, %itemValue% ��ĵ��
				sleep, 100
				}

			}
		}

	}

mine_found_click_minimap(input_x,input_y){
	MapNumber := GetMapNumber()
	if(CheckMiniMap()!=1){
		closemap()
		movemap(MapNumber)
		Mapreopen()
	}
    scale_factor_x := 2
    scale_factor_y := 2
	if(MapNumber=237){
		translation_offset_x := 493
		translation_offset_y := 479
		}
	else if(MapNumber=3300||MapNumber=3301){
		translation_offset_x := 633
		translation_offset_y := 476
		}
	else if(MapNumber=1403){
		translation_offset_x := 594
		translation_offset_y := 400
		}
    output_x := input_x * scale_factor_x + translation_offset_x
    output_y := input_y * scale_factor_y + translation_offset_y
	sleep,10
	postclick(output_x, output_y)
	}

try_search_mine(image_PosX, image_PosY, image_PosX_limit, image_PosY_limit){
    Gui, Submit, Nohide
	Loop, %Mines_Count% {
		if(Coin!=1)
			break
        Key := A_Index
        Value := Mines[Key]
		IfExist %Value%.png
			{
			tabname := "Mines"
			temp_do := %tabname%%Value%

			if (temp_do = 1) {
				IfWinNotActive, %WindowTitle%
					WinActivate,%WindowTitle%
				ImageSearch, target_PosX, target_PosY, image_PosX, image_PosY, image_PosX_limit, image_PosY_limit, *10 %Value%.png
				if (ErrorLevel = 0) {
					result := {"target_PosX":target_PosX, "target_PosY":target_PosY, "ErrorLevel":ErrorLevel}
					return result
					}
				}
				A:=1
				Loop, {
					A++
					IfExist %Value%%A%.png
					{
						if (temp_do = 1) {
							ImageSearch, target_PosX, target_PosY, image_PosX, image_PosY, image_PosX_limit, image_PosY_limit, *10 %Value%%A%.png
							if (ErrorLevel = 0) {
								result := {"target_PosX":target_PosX, "target_PosY":target_PosY, "ErrorLevel":ErrorLevel}
								return result
								}
						}
					}
					Else
						break
					}
			}
		}
	result := {"target_PosX":target_PosX, "target_PosY":target_PosY, "ErrorLevel":ErrorLevel}
	return result
	}

mining_do(){
	if(Coin != 1)
		return
	A := 1
	if(mine_found = 0)
		return
	loop, {
		if(Coin != 1)
			break
		KeyClick(6)
		KeyClick(6)

		Pos:=GetPos()
		PosX:=Pos.PosX
		PosY:=Pos.PosY

		sleep,1
		MovePos:=Get_MovePos()
		MovePosX:=MovePos.MovePosX
		MovePosY:=MovePos.MovePosY

		sleep,1
		if(mine_found = 7) {
			Guicontrol,, Statusline, (STEP16) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving%
			loop, 2 {
				Keyclick("Tab")
				Keyclick("Space")
				Keyclick("Tab")
				sleep,100
				}
			mine_found := 0
			break
			}
		else if(MoveposX = PosX && MoveposY = PosY) {
			Guicontrol,, Statusline, (STEP15) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving%
			loop, 2 {
				Keyclick("Tab")
				Keyclick("Space")
				Keyclick("Tab")
				sleep,100
				}
			mine_found := 0
			break
			}

		else if(MoveposX != PosX || MoveposY != PosY) {
			if(mine_found = 0) {
				delay := A_TickCount - Mine_Error_Counter
				if (delay >= 1000) {
					Pos:=GetPos()
					PosX := Pos.PosX
					PosY := Pos.PosY
					sleep,1
					MovePos := Get_MovePos()
					MovePosX := MovePos.MovePosX
					MovePosY := MovePos.MovePosY
					sleep,1
					Guicontrol,, Statusline, (STEP9) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving% (STEP:Mining_do_02)

					if(remember_previous_posx = PosX && remember_previous_posx = PosY) {
						stopmoving++
						sleep,1
						}
					sleep,1
					remember_previous_posx := PosX
					remember_previous_posx := PosY
					sleep,1
					if(stopmoving >=2) {
						MovePos := Get_MovePos()
						MovePosX := MovePos.MovePosX
						MovePosY := MovePos.MovePosY
						original_MoveposX := MoveposX
						original_MoveposY := MoveposY
						Guicontrol,, Statusline, (STEP10) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving% (STEP:Mining_do_02_01)
						MapNumber := GetMapNumber()
						temp := Get_Map_minimap_click_coordi(MapNumber,minimap_steps)
						;CheckMiniMap()
						;Mapreopen()
						postclick(temp.clickx, temp.clicky)

						Sleep, 100
						stopmoving := 0
						mine_found := 0
						Sleep, 100
						Pos:=GetPos()
						PosX := Pos.PosX
						PosY := Pos.PosY
						sleep,1
						MovePos := Get_MovePos()
						MovePosX := MovePos.MovePosX
						MovePosY := MovePos.MovePosY
						sleep,1
						if(original_MoveposX != MoveposX || original_MoveposY !=MoveposY) {
							Guicontrol,, Statusline, (STEP11) ����ǥ����: [�۵���] ����ĳ�� | ������� ���� - Ż��õ� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving% (STEP:Mining_do_02_02)
							}
						}
					Mine_Error_Counter := A_TickCount
					}
				}

				else if(mine_found = 1) {
					delay := A_TickCount - Mine_Error_Counter
					if (delay >= 1000) {
						mine_found_click_minimap(temp_x,temp_y)
						Pos:=GetPos()
						PosX := Pos.PosX
						PosY := Pos.PosY
						sleep,1
						MovePos := Get_MovePos()
						MovePosX := MovePos.MovePosX
						MovePosY := MovePos.MovePosY
						sleep,1
						Guicontrol,, Statusline, (STEP12) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving% (STEP:Mining_do_03_01)
						Pos:=GetPos()
						PosX := Pos.PosX
						PosY := Pos.PosY
						KeyClick("AltR")
						if(remember_previous_posx = PosX && remember_previous_posy = PosY) {
							stopmoving++
							sleep,1
							}
						sleep,1
						Pos:=GetPos()
						PosX := Pos.PosX
						PosY := Pos.PosY
						remember_previous_posx := PosX
						remember_previous_posy := PosY
						sleep,1
						if(stopmoving >=5) {
							MovePos := Get_MovePos()
							MovePosX := MovePos.MovePosX
							MovePosY := MovePos.MovePosY
							original_MoveposX := MoveposX
							original_MoveposY := MoveposY
							sleep,1
							Guicontrol,, Statusline, (STEP13) ����ǥ����: [�۵���] ����ĳ�� | ������� ���� - Ż��õ� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving% (STEP:Mining_do_03_02)
							MapNumber := GetMapNumber()
							temp := Get_Map_minimap_click_coordi(MapNumber,minimap_steps)
							;CheckMiniMap()
							;Mapreopen()
							Sleep, 100
							postclick(temp.clickx, temp.clicky)
							stopmoving := 0
							mine_found := 0
							Sleep, 100
							Pos:=GetPos()
							PosX := Pos.PosX
							PosY := Pos.PosY
							sleep,1
							MovePos := Get_MovePos()
							MovePosX := MovePos.MovePosX
							MovePosY := MovePos.MovePosY
							sleep,1
							if(original_MoveposX != MoveposX || original_MoveposY != MoveposY) {
								Guicontrol,, Statusline, (STEP14) ����ǥ����: [�۵���] ����ĳ�� | ������� ���� - Ż��õ� ���� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | �����̴ϸ�: %minimap_steps% | �����ð� %stopmoving% (STEP:Mining_do_03_03)
								}
							}
						Mine_Error_Counter := A_TickCount
						}
					}
				}
		else
			return
		}
	}

Get_Map_minimap_click_coordi(MapNumber,minimap_steps){
	Gui, Submit, Nohide
	 MapNumber := GetMapNumber()
	if (minimap_steps = 0) {
		if(MapNumber=237) {
			clickx := 749
			clicky := 563
			elanx := 128
			elany := 42
			}
		else if(MapNumber=3300) {
			clickx := 728
			clicky := 522
			elanx := 48
			elany := 23
			}
		else if(MapNumber=3301) {
			clickx := 637
			clicky := 521
			elanx := 2
			elany := 22
		}
		else{
			clickx := 749
			clicky := 563
			elanx := 128
			elany := 42
			}
		}
	else if (minimap_steps = 1) {
		if(MapNumber=237) {
			clickx := 714
			clicky := 560
			elanx := 110
			elany := 41
			}
		else if(MapNumber=3300) {
			clickx := 750
			clicky := 557
			elanx := 59
			elany := 40
			}
		else if(MapNumber=3301) {
			clickx := 759
			clicky := 502
			elanx := 63
			elany := 13
			}
		else{
			clickx := 714
			clicky := 560
			elanx := 110
			elany := 41
			}
		}
	else if (minimap_steps = 2) {
		if(MapNumber=237) {
			clickx := 732
			clicky := 507
			elanx := 119
			elany := 14
			}
		else if(MapNumber=3300) {
			clickx := 663
			clicky := 572
			elanx := 15
			elany := 48
			}
		else if(MapNumber=3301) {
			clickx := 671
			clicky := 572
			elanx := 19
			elany := 47
			}
		else{
			clickx := 732
			clicky := 507
			elanx := 119
			elany := 14
			}
		}
	else if (minimap_steps = 3) {
		if(MapNumber=237) {
			clickx := 531
			clicky := 507
			elanx := 19
			elany := 14
			}
		else if(MapNumber=3300) {
			clickx := 654
			clicky := 505
			elanx := 11
			elany := 14
			}
		else if(MapNumber=3301) {
			clickx := 755
			clicky := 571
			elanx := 61
			elany := 47
			}
		else{
			clickx := 732
			clicky := 507
			elanx := 119
			elany := 14
			}
		}
	else if (minimap_steps = 4) {
		if(MapNumber=237) {
			clickx := 561
			clicky := 571
			elanx := 34
			elany := 46
			}
		else{
			clickx := 561
			clicky := 571
			elanx := 34
			elany := 46
			}
		}
	Result := { "clickx": clickx, "clicky": clicky, "elanx":elanx, "elany":elany }
	return Result
	}

GameIslandTextMacro(){
MapNumber := GetMapNumber()

if(MapNumber=3601)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 49, 131073, ,%WindowTitle% ; 1 Key Lock
postmessage, 0x101, 49, 131073, ,%WindowTitle% ; 1 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3602)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 50, 196609, ,%WindowTitle% ; 2 Key Lock
postmessage, 0x101, 50, 196609, ,%WindowTitle% ; 2 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3603)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 51, 262145, ,%WindowTitle% ; 3 Key Lock
postmessage, 0x101, 51, 262145, ,%WindowTitle% ; 3 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3604)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 52, 327681, ,%WindowTitle% ; 4 Key Lock
postmessage, 0x101, 52, 327681, ,%WindowTitle% ; 4 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3605)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 53, 393217, ,%WindowTitle% ; 5 Key Lock
postmessage, 0x101, 53, 393217, ,%WindowTitle% ; 5 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3606)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 54, 458753, ,%WindowTitle% ; 6 Key Lock
postmessage, 0x101, 54, 458753, ,%WindowTitle% ; 6 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3607)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 55, 524289, ,%WindowTitle% ; 7 Key Lock
postmessage, 0x101, 55, 524289, ,%WindowTitle% ; 7 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3608)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 56, 589825, ,%WindowTitle% ; 8 Key Lock
postmessage, 0x101, 56, 589825, ,%WindowTitle% ; 8 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3609)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 57, 655361, ,%WindowTitle% ; 9 Key Lock
postmessage, 0x101, 57, 655361, ,%WindowTitle% ; 9 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
else if(MapNumber=3610)
{
loop, 1
{
postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CRTL Lock
postmessage, 0x100, 48, 720897, ,%WindowTitle% ; 0 Key Lock
postmessage, 0x101, 48, 720897, ,%WindowTitle% ; 0 Key Release
postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CRTL Release
sleep, 1
}
}
}

GameIslandMacroText(){
sleep,1000
WinActivate,%WindowTitle%
WinWaitActive,%WindowTitle%
send, !2
sleep,500

send, !m
Sleep,500
send,wntkdnlthsu1{space}apsb{Tab}wntkdnlthsu2{space}apsb{Tab}wntkdnlthsu3{space}apsb{Tab}wntkdnlthsu4{space}apsb{Tab}wntkdnlthsu5{space}apsb{Tab}wntkdnlthsu6{space}apsb{Tab}wntkdnlthsu7{space}apsb{Tab}wntkdnlthsu8{space}apsb{Tab}wntkdnlthsu9{space}apsb{Tab}wntkdnlthsu10{space}apsb{enter}
}

GameIslandMouseClickEvent(){
MapNumber := GetMapNumber()
temp := get_CurrentMiniMapPos()
CurrentMiniMapPosX := temp.CurrentMiniMapPosX
CurrentMiniMapPosY := temp.CurrentMiniMapPosY
Pos:=GetPos()
PosX := Pos.PosX
PosY := Pos.PosY
if (MapNumber == 3600)
{
if (PosX != 19 || PosY != 10)
{
KeyClick("AltR")
sleep, 1
TempX := CurrentMiniMapPosX - 12
TempY := CurrentMiniMapPosY - 29
PostClick(TempX,TempY)
}
else if (PosX = 19 && PosY = 10)
{
KeyClick("AltR")
sleep, 1
TempX := CurrentMiniMapPosX - 14
TempY := CurrentMiniMapPosY - 29
PostClick(TempX,TempY)
}
}
else if (MapNumber >= 3601 && MapNumber <= 3610)
{
if (PosX <= 31 && PosY <= 29)
{
sleep, 1
}
else if (PosY <= 27)
{
sleep, 1
}
else if (PosX = 33 && PosY = 28)
{
KeyClick("AltR")
sleep, 1
TempX := CurrentMiniMapPosX + 14
TempY := CurrentMiniMapPosY + 9
PostClick(TempX,TempY)
Guicontrol,, Statusline, ����ǥ����: [�۵���] ���Ӽ� - ���� ���� ��ҷ� �̵���(Ŭ��1)
}
else if (PosX != 33 || PosY != 28)
{
KeyClick("AltR")
sleep, 1
TempX := CurrentMiniMapPosX + 16
TempY := CurrentMiniMapPosY + 6
PostClick(TempX,TempY)
Guicontrol,, Statusline, ����ǥ����: [�۵���] ���Ӽ� - ���� ���� ��ҷ� �̵���(Ŭ��2)
}
}
}

mining(){
	IfWinNotActive, %WindowTitle%
		WinActivate,%WindowTitle%
	if(Coin!=1)
		return

	;Mapreopen()
	MapNumber := GetMapNumber()
	if(CheckMiniMap()=2)
		MapSetting(MapNumber)

	Sleep, 10
	search_PosX := 17
	search_PosY := 10
	mine_found := 0
	spiral_length := 1
	direction := 0
	steps := 0

	Loop, 10{
		KeyClick(6)
		KeyClick(6)
		Sleep, 10
		if(Coin!=1)
			break
		Pixel_PosX := 1 + (17 - 1) * 24 + 12
		Pixel_PosY := 1 + (10 - 1) * 24 + 12
		IfWinNotActive, %WindowTitle%
			WinActivate,%WindowTitle%
		MapNumber := GetMapNumber()
		KeyClick("AltR")
		PixelGetColor, ColorID, Pixel_PosX, Pixel_PosY, RGB
				; 0x5A3018 := ��Ʈ
				; 0x949294 := ����
				; 0xBDBEB5 := ����(2��)
				; 0x52285A := �Ľø���
				; 0x6365B5 := ī�߷���
				; 0xBD8A42 := ����
				; 0xA57942 := ����(2��)
				; 0x102473 := �ͱ�(���)
				; 0x3961BD := �ͱ�(ǥ��)
				; 0x8CBEEF := �ͱ�(�ϴ�)
				; 0x846952 := �̳���(���) or ��(���)
				; 0x6B0800 := �Ҿ�(�ϴ�)
				; 0xDE8E94 := �Ҿ�(���)
				; 0xDED8DE := �Ҿ�(��� ��ǰ)
				; 0x6365B5 := �̸���
				; 0x420400 := ��������(����)
				; 0x636563 := �׽��ÿ�
				; 0xADA631 := �̸�
				; 0x6B3410 := ī����
				; 0x7B7D73 := �̾�
				; 0xDE3831 := �긮��
				; 0xFFFFFF := ����
				; 0xEF9239 := ������
				; 0xE77D21 := ����
				; 0xEF9239 := �����ÿ�
				; 0x639E21 := �׽�
				; 0x634142 := �̳�Ƽ
				; 0xAD86AD := ��Ÿ��Ʈ
				; 0xC6A6A5 := ����
				; 0xC69A4A := ����
				; 0x000000 := ������ or ����(�ϴ� or ����)
				; 0xADAAE7 := ����(���_��)
				; 0xFFFBFF := ����(���_�޸��)
				; 0x7B498C := �ʱ� or �ֱ�(�����)
				; 0xC6C7D6 := �ֱ�(����) or �ֱ�(ȸ��)
				; 0x7B7D9C := �ֱ�(��ȸ��)
				; 0xFF4942 := �ֱ�(����)

				;Blacklist Pos
				;MapNumber,X,Y
				;(237,118,11) ; �η�����, ��
				;(237,118,12) ; �η�����, ��
				;(2300,82,21) ; ��������, �̳�Ƽ
				;(2300,82,20) ; ��������, �̳�Ƽ
		Sleep, 1
		if(ColorID != 0x000000 && ColorID != 0xDE8E94 && ColorID != 102473){
			Guicontrol,, Statusline, (STEP1) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | ã����ġ: %search_PosX% / %search_PosY% | �����̴ϸ�: %minimap_steps% | ĳ���Ͱ� �������� �ֽ��ϴ� (STEP:Mining_01)
			mine_found := 7
			mining_do()
			}
		else{
			Guicontrol,, Statusline, (STEP2) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | ã����ġ: %search_PosX% / %search_PosY% | �����̴ϸ�: %minimap_steps% | �����ܰ� ������ (STEP:Mining_02_01)
			Pos := GetPos()
			PosX := Pos.PosX
			PosY := Pos.PosY
			search_PosX := search_PosX - 4
			search_PosY := search_PosY - 3
			image_PosX := 1 + (search_PosX - 1) * 24
			image_PosY := 1 + (search_PosY - 1) * 24
			image_PosX_limit := 1 + (search_PosX + 7 - 1) * 24
			image_PosY_limit := 1 + (search_PosX + 7 - 1) * 24
			temp := try_search_mine(image_PosX, image_PosY, image_PosX_limit, image_PosY_limit)
			target_PosX := temp.target_PosX
			target_PosY := temp.target_PosY
			if(Coin!=1)
				break
			if (temp.ErrorLevel = 0){
				Guicontrol,, Statusline, (STEP3) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | ã����ġ: %search_PosX% / %search_PosY% | �����̴ϸ�: %minimap_steps% | ������ ã�ҽ��ϴ�. (�ٰŸ�) (STEP:Mining_03_01)
				targetX := Floor((target_PosX - 1) / 24) * 24 + 24 - 4
				targetY := Floor((target_PosY) / 24 + 1) * 24 - 23
				Pos:=GetPos()
				PosX := Pos.PosX
				PosY := Pos.PosY
				temp_x := Floor((target_PosX - 1) / 24) - 17 + PosX +1
				temp_y := Floor((target_PosY - 1) / 24) - 9 + PosY
				mine_found_click_minimap(temp_x,temp_y)
				sleep,1
				MovePos := Get_MovePos()
				MovePosX := MovePos.MovePosX
				MovePosY := MovePos.MovePosY
				sleep,1
				if(temp_x = MovePosX && temp_y = MovePosY){
					mine_found := 1
					mining_do()
					}
				}
			else{
				Guicontrol,, Statusline, (STEP4) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | ã����ġ: %search_PosX% / %search_PosY% | �����̴ϸ�: %minimap_steps% | ������ ã���ֽ��ϴ�. (�߰Ÿ�) (STEP:Mining_02_01)
				search_PosX := 9
				search_PosY := 2
				image_PosX := 1 + (search_PosX - 1) * 24
				image_PosY := 1 + (search_PosY - 1) * 24
				image_PosX_limit := 1 + (search_PosX + 16 - 1) * 24
				image_PosY_limit := 1 + (search_PosY + 16 - 1) * 24
				temp := try_search_mine(image_PosX, image_PosY, image_PosX_limit, image_PosY_limit)
				target_PosX := temp.target_PosX
				target_PosY := temp.target_PosY
				if(Coin!=1)
					break
				if (temp.ErrorLevel = 0){
					Guicontrol,, Statusline, (STEP5) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | ã����ġ: %search_PosX% / %search_PosY% | �����̴ϸ�: %minimap_steps% | ������ ã�ҽ��ϴ�. (�߰Ÿ�) (STEP:Mining_03_02)
					targetX := Floor((target_PosX - 1) / 24) * 24 + 24 - 4
					targetY := Floor((target_PosY) / 24 + 1) * 24 - 23
					Pos:=GetPos()
					PosX := Pos.PosX
					PosY := Pos.PosY
					temp_x := Floor((target_PosX - 1) / 24) - 17 + PosX +1
					temp_y := Floor((target_PosY - 1) / 24) - 9 + PosY
					mine_found_click_minimap(temp_x,temp_y)
					sleep,1
					MovePos := Get_MovePos()
					MovePosX := MovePos.MovePosX
					MovePosY := MovePos.MovePosY
					sleep,1
					if(temp_x = MovePosX && temp_y = MovePosY){
						mine_found := 1
						mining_do()
						}
					}
				else{
					Guicontrol,, Statusline, (STEP6) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | ã����ġ: %search_PosX% / %search_PosY% | �����̴ϸ�: %minimap_steps% | ������ ã���ֽ��ϴ�. (���Ÿ�) (STEP:Mining_02_01)
					search_PosX := 3
					search_PosY := 1
					image_PosX := 1 + (search_PosX - 1) * 24
					image_PosY := 1 + (search_PosY - 1) * 24
					image_PosX_limit := 1 + (search_PosX + 28 - 1) * 24
					image_PosY_limit := 1 + (search_PosY + 18 - 1) * 24
					mine_found := 0
					temp := try_search_mine(image_PosX, image_PosY, image_PosX_limit, image_PosY_limit)
					target_PosX := temp.target_PosX
					target_PosY := temp.target_PosY
					if(Coin!=1)
						break
					if (temp.ErrorLevel = 0) {
						Guicontrol,, Statusline, (STEP7) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | ã����ġ: %search_PosX% / %search_PosY% | �����̴ϸ�: %minimap_steps% | ������ ã�ҽ��ϴ�. (���Ÿ�) (STEP:Mining_03_03)
						targetX := Floor((target_PosX - 1) / 24) * 24 + 24 - 4
						targetY := Floor((target_PosY) / 24 + 1) * 24 - 23
						Pos:= GetPos()
						PosX := Pos.PosX
						PosY := Pos.PosY
						temp_x := Floor((target_PosX - 1) / 24) - 17 + PosX +1
						temp_y := Floor((target_PosY - 1) / 24) - 9 + PosY
						mine_found_click_minimap(temp_x,temp_y)
						sleep,1
						MovePos := Get_MovePos()
						MovePosX := MovePos.MovePosX
						MovePosY := MovePos.MovePosY
						sleep,1
						if(temp_x = MovePosX && temp_y = MovePosY){
							mine_found := 1
							mining_do()
							}
						}
					else{

						MapNumber := GetMapNumber()
						temp:=Get_Map_minimap_click_coordi(MapNumber,minimap_steps)
						mine_found := 0
						Sleep, 100
						Random varx, 0, 4
						Random vary, 0, 4
						temp.clickx := temp.clickx + ((varx-2) * 2)
						temp.clicky := temp.clicky + ((vary-2) * 2)
 						postclick(temp.clickx, temp.clicky)
						mine_found := 0
						Sleep, 100

						Pos:=GetPos()
						PosX := Pos.PosX
						PosY := Pos.PosY
						Sleep, 100
						Guicontrol,, Statusline, (STEP8) ����ǥ����: [�۵���] ����ĳ�� | ����ġ: %PosX% / %PosY% | ������ %MoveposX% / %MoveposY% | ã����ġ: %search_PosX% / %search_PosY% | �����̴ϸ�: %minimap_steps% | ����ã�� ����, �����̴ϸ����� �̵� (MapNumber:=%MapNumber%)
						if(PosX < temp.elanx + 2 && PosX > temp.elanX - 2 && PosY < temp.elany + 2 && PosY > temp.elany - 2){
							if(MapNumber=237 && minimap_steps = 4)
								minimap_steps := 0
							else if(MapNumber=3300 && minimap_steps = 3)
								minimap_steps := 0
							else if(MapNumber=3301 && minimap_steps = 3)
								minimap_steps := 0
							else
								minimap_steps++
							}
						Sleep, 1
						}
					}
				}
			}
		return
		}
	}

CheckMiniMap(){
	;SetFormat, integer, d
	MapNumber := GetMapNumber()
	temp := get_CurrentMiniMapPos()
	CurrentMiniMapPosX := temp.CurrentMiniMapPosX
	CurrentMiniMapPosY := temp.CurrentMiniMapPosY
	;SetFormat,integer, H
	;Msgbox, CurrentMiniMapPosX %CurrentMiniMapPosX% CurrentMiniMapPosY %CurrentMiniMapPosY%
	sleep,1
	if(MapNumber = 237) ; �η� ����
		{
			if(CurrentMiniMapPosX = 643 && CurrentMiniMapPosY = 538)
				{
					MiniMapStatus := 1
				}
			else if(CurrentMiniMapPosX != 54)
				{
					MiniMapStatus := 2
				}
		}
	else if(MapNumber = 3300 || MapNumber = 3301) ; ũ�� ����
		{
			if(CurrentMiniMapPosX = 712 && CurrentMiniMapPosY = 536)
				{
					MiniMapStatus := 1
				}
			else if(CurrentMiniMapPosX != 54)
				{
					MiniMapStatus := 2
				}
		}
	else if(MapNumber = 1403) ; ���� ����
		{
			if(CurrentMiniMapPosX = 693 && CurrentMiniMapPosY = 499)
				{
					MiniMapStatus := 1
				}
			else if(CurrentMiniMapPosX != 54)
				{
					MiniMapStatus := 2
				}
		}
	else if(MapNumber != 237) ; ���Ӽ�
		{
			if(CurrentMiniMapPosX = 742 && CurrentMiniMapPosY = 542)
				{
					MiniMapStatus := 1
				}
			else if(CurrentMiniMapPosX != 54)
				{
					MiniMapStatus := 2
				}
		}
	return MiniMapStatus
	}

get_jelan_char_id(){
	return
}

sendtargetid(target_id){
	target_id := 0
	return target_id
}

Doparty(){
	return
}

Mapreopen(){
	if(UiTest(1) = 0 ) {
		PostMessage, 0x100, 0xA4, 0,,%WindowTitle%
		PostMessage, 0x100, 0x56, 3080193,,%WindowTitle%
		PostMessage, 0x101, 0xA4, 0,,%WindowTitle%
		MapBig := ReadMemory(ReadMemory(ReadMemory(ReadMemory(ReadMemory(0x0058DAD0)+0xC)+0x10)+0x8)+0x264)
		MapNumber:= GetMapNumber()
		if(MapNumber=237&&MapBig!=1) {
			sleep, 100
			postclick(725, 484)
			}
		}
	}

Search_Book(Num){
	SetFormat,integer, H
	mem := get_mem()
	jelanCoreAdd := getModuleBaseAddress()
	BookX := ReadMemory(ReadMemory(jelanCoreAdd + 0x0018EB48) + 0x0164)-99
	BookY := ReadMemory(ReadMemory(jelanCoreAdd + 0x0018EB48) + 0x0168)-117
	SetFormat,integer, d
	X1 := BookX+27
	Y1 := BookY+45
	Y2 := Y1+36
	Y3 := Y2+36
	Y4 := Y3+36
	Y5 := Y4+36
	MoveX := BookX+148
	MoveY := BookY+207
	;MsgBox, Num %Num% MoveX %MoveX% %MoveY%
	if(Num = 0)
		PostClick(MoveX,MoveY)
	else if(Num = 1){
		PostClick(X1,Y1)
		sleep,100
		PostClick(MoveX,MoveY)
		}
	else if(Num =2){
		PostClick(X1,Y2)
		sleep,100
		PostClick(MoveX,MoveY)
		}
	else if(Num =3){
		PostClick(X1,Y3)
		sleep,100
		PostClick(MoveX,MoveY)
		}
	else if(Num =4){
		PostClick(X1,Y4)
		sleep,100
		PostClick(MoveX,MoveY)
		}
	else if(Num =5){
		PostClick(X1,Y5)
		sleep,100
		PostClick(MoveX,MoveY)
		}
	}

PostMove(MouseX,MouseY){
	MousePos := MouseX | MouseY<< 16
	PostMessage, 0x200, 0, %MousePos% ,,%WindowTitle%
	}

PostClick(MouseX,MouseY){
	IF(winmode=800){
		MouseX := MouseX
		MouseY := MouseY
		}
	IF ELSE (winmode=1600){
		MouseX := MouseX *2
		MouseY := MouseY *2
		}
	MousePos := MouseX | MouseY<< 16
	PostMessage, 0x200, 0, %MousePos% ,,%WindowTitle%
	PostMessage, 0x201, 1, %MousePos% ,,%WindowTitle%
	PostMessage, 0x202, 0, %MousePos% ,,%WindowTitle%
	}

PostClick_Right(MouseX,MouseY){
	MousePos := MouseX | MouseY<< 16
	PostMessage, 0x200, 0, %MousePos% ,,%WindowTitle%
	PostMessage, 0x204, 1, %MousePos% ,,%WindowTitle%
	PostMessage, 0x205, 0, %MousePos% ,,%WindowTitle%
	}

NPCMENUCLICK(what,key){
	ErrorLevel_check := 0
	loop, {
		NPCMenu := ReadMemory(0x0058F0A4)
		if Coin!=1
			break
		if(NPCMenu != 0)
		{
			break
		}
		else if(NPCMenu =0) {
			ErrorLevel_check++
			sleep, 500
			if(ErrorLevel_check >5){
				keyclick(key)
				ErrorLevel_check:=0
			}
		}
	}
	if (what = "Buy"){
		X := ReadMemory(ReadMemory(0x0058F0A4)+0x9A) +10
		Y := ReadMemory(ReadMemory(0x0058F0A4)+0x9E) +15
		}
	else if (what = "Sell"){
		X := ReadMemory(ReadMemory(0x0058F0A4)+0x9A) +31
		Y := ReadMemory(ReadMemory(0x0058F0A4)+0x9E) +15
		}
	else if (what = "Repair"){
		X := ReadMemory(ReadMemory(0x0058F0A4)+0x9A) +55
		Y := ReadMemory(ReadMemory(0x0058F0A4)+0x9E) +15
		}
	loop,2 {
		postclick(x,y)
		sleep,100
		}
}

BuyBread(Bread_Sellers,start_inven){
	gui, submit, nohide
	Move_buy()
	if Coin!=1
		return
	GuiControlGet, Cheese_Select
	GuiControlGet, bread_Select


	keyclick("CTRL1")
	sleep, 1000

	NPCMENUCLICK("Buy","CTRL1")
	sleep, 200
	loop, 2 {
	PostClick(205,57) ;Ű����� �����ϱ� ���� ���콺�� ù��° ������ Ŭ��
	sleep, 200
	}
	if Bread_Sellers = ī����
		{
			FirstItem := 38 ;ġ��
			SecondItem := 40 ;��
		}
	else if Bread_Sellers = ����Ʈ
		{
			FirstItem := 25 ;ġ��
			SecondItem := 27 ;��
		}
	else if Bread_Sellers = ī��Ǫ
		{
			FirstItem := 26 ;ġ��
			SecondItem := 28 ;��
		}
	else if Bread_Sellers = ��Ű
		{
			FirstItem := 26 ;ġ��
			SecondItem := 28 ;��
		}
	else if Bread_Sellers = ����
		{
			FirstItem := 40 ;ġ��
			SecondItem := 42 ;��
		}
	else if Bread_Sellers = �����ǳ�
		{
			FirstItem := 40 ;ġ��
			SecondItem := 42 ;��

		}
;	MsgBox, %Bread_Sellers% %FirstItem% %SecondItem%
	SecondItem := SecondItem - FirstItem
	FirstItem := FirstItem - 1


	loop,%FirstItem%{
		keyclick("DownArrow")
		}

	if Cheese_Select = 1
	{
	sleep, 1
	KeyClick(1)
	sleep, 1
	KeyClick(0)
	sleep, 1
	KeyClick(0)
	sleep, 1
	}
	loop,%SecondItem% {
		keyclick("DownArrow")
		}

	if bread_Select = 1
	{
	sleep, 1
	KeyClick(1)
	sleep, 1
	KeyClick(0)
	sleep, 1
	KeyClick(0)
	sleep, 1
	}

	PostClick(423,322) // ���� OKŬ��
	sleep, 100

	Loop, {
		if Coin!=1
			break
		inven := Get_inven()
		if(inven>=48){
			break
			}
		else{
			PostClick(423,322)
			sleep,1
			}
		}

	loop, 2 {
		PostClick_Right(205,57)
		sleep, 1000
		}

}

CloseMap(){
		PostMessage, 0x100, 0xA4, 0,,%WindowTitle%
		PostMessage, 0x100, 0x56, 3080193,,%WindowTitle%
		PostMessage, 0x101, 0xA4, 0,,%WindowTitle%
	}

inputmenu(NPCNAME){
	IfWinNotActive, %WindowTitle%
		{
			WinActivate,%WindowTitle%
			sleep,30
		}
		;MsgBox, %NPCNAME%
		send, !m
		Sleep,500
		send,%NPCNAME%{space}apsb{enter}
	}

inputallsellers(){
	IfWinNotActive, %WindowTitle%
		{
			WinActivate,%WindowTitle%
			sleep,30
		}
	send, !m
	Sleep,500
	send, zkelffk{space}apsb{tab}tb{space}apsb{tab}zhvp{space}apsb{tab}tispxm{space}apsb{tab}qptm{space}apsb{tab}znzl{space}apsb{tab}zkfpvn{space}apsb{tab}dhdlvlsh{space}apsb{enter}
	sleep,3
	}

Get_inven(){
	inven := ReadMemory(ReadMemory(ReadMemory(ReadMemory(0x0058DAD4)+0x178)+0xBE)+0x14)
	return inven
	}

Get_jElancia_Titles(){
	jElanciaArray := []
	Winget, jElanciaArray, List, ahk_class Nexon.Elancia
	jElancia_Count := 0
	loop, %jElanciaArray%{
		jElancia := jElanciaArray%A_Index%
		WinGetTitle,WindowTitle%A_Index%,ahk_id %jElancia%
		jElancia_Count++
		}
	Return jElancia_Count
	}

Get_HP(){
	Now := ReadMemory(ReadMemory(ReadMemory(0x0058DAd4) + 0x178) + 0x5B)
	Max := ReadMemory(ReadMemory(ReadMemory(0x0058DAd4) + 0x178) + 0x1F)
	Percent := floor((Now / Max) * 100)
	HP := { "Now": Now, "Max": Max, "Percent":Percent }
	return HP
	}

Get_MP(){
	Now := ReadMemory(ReadMemory(ReadMemory(0x0058DAd4) + 0x178) + 0x5F)
	Max  := ReadMemory(ReadMemory(ReadMemory(0x0058DAd4) + 0x178) + 0x23)
	Percent := floor((Now / Max) * 100)
	MP := { "Now": Now, "Max": Max, "Percent":Percent }
	return MP
	}

Get_FP(){
	Now := ReadMemory(ReadMemory(ReadMemory(0x0058DAd4) + 0x178) + 0x63)
	Max := ReadMemory(ReadMemory(ReadMemory(0x0058DAd4) + 0x178) + 0x27)
	Percent := floor((Now / Max) * 100)
	FP := { "Now": Now, "Max": Max, "Percent":Percent }
	return FP
	}

Get_Galid(){
	Galid := ReadMemory(ReadMemory(ReadMemory(0x0058DAd4) + 0x178) + 0x6F)
	return Galid
	}

Get_AGI(){
	AGI := ReadMemory(ReadMemory(ReadMemory(0x0058DAd4) + 0x178) + 0x3F)
	return AGI
	}

Get_Location(){
	mem := get_mem()
	DllName := "jelancia_core.dll"
	;Global jelanCoreAdd := getModuleBaseAddress()
	moduleBase := mem.getModuleBaseAddress(DllName)
	Location := ReadMemoryTxt(ReadMemory(moduleBase + 0x44A28)+ 0xC)
	return Location
	}

GetPos(){
	PosX := ReadMemory(ReadMemory(0x0058DAd4) + 0x10)
	PosY := ReadMemory(ReadMemory(0x0058DAd4) + 0x14)
	result := { "PosX": PosX, "PosY": PosY}
	return result
	}

Get_MovePos(){
	MovePosX := ReadMemory(0x0058EA10)
	MovePosY := ReadMemory(0x0058EA14)
	Result := {"MovePosX":MovePosX, "MovePosY":MovePosY}
	Return Result
	}

GetMapNumber(){
	;SetFormat,integer, H
	jelanCoreAdd := getModuleBaseAddress()
	if(ReadMemory(jelanCoreAdd + 0x0018EB6C) = 0) {
		PostMessage, 0x100, 0xA4, 0,,%WindowTitle%
		PostMessage, 0x100, 0x56, 3080193,,%WindowTitle%
		PostMessage, 0x101, 0xA4, 0,,%WindowTitle%
		}
	MapSize := ReadMemory(ReadMemory(ReadMemory(ReadMemory(ReadMemory(0x0058DAD0)+0xC)+0x10)+0x8)+0x264)
	if(MapSize != 1)
		MapSize := 0
	else If(MapSize = 1)
		MapSize := 1
	MapNumber := ReadMemory(ReadMemory(jelanCoreAdd + 0x0018EB6C) + 0x0188)
	SetFormat,integer, d
	return MapNumber
}

get_CurrentMiniMapPos(){
	CurrentMiniMapPosX := ReadMemory(ReadMemory(0x0058EB48) +0x80)
	CurrentMiniMapPosY := ReadMemory(ReadMemory(0x0058EB48) +0x84)
	result := {"CurrentMiniMapPosX":CurrentMiniMapPosX,"CurrentMiniMapPosY":CurrentMiniMapPosY}
	return result
	}

MapSetting(MapNumber){
		if(UiTest(1) != 0 )
			{
				CloseMap()
				sleep, 10
			}
		MoveMap(MapNumber)
		sleep, 10
		Mapreopen()
	}

MoveMap(MapNumber){
	if(MapNumber=237) ; �η� ����
			{
				WriteMemory(ReadMemory(0x0058EB48) + 0x80, 0x83, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x81, 0x02, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x82, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x83, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x84, 0x1A, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x85, 0x02, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x86, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x87, 0x00, "char")
			}
		else if(MapNumber=3300 || MapNumber=3301) ; ũ�α��� (712,536)
			{
				WriteMemory(ReadMemory(0x0058EB48) + 0x80, 0xC8, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x81, 0x02, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x82, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x83, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x84, 0x18, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x85, 0x02, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x86, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x87, 0x00, "char")
			}
		else if(MapNumber=1403) ; ���ʱ��� (693,499)
			{
				WriteMemory(ReadMemory(0x0058EB48) + 0x80, 0xB5, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x81, 0x02, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x82, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x83, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x84, 0xF3, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x85, 0x01, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x86, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x87, 0x00, "char")
			}
		else if(MapNumber>=3601&&MapNumber<=3610) ; ���Ӽ�
			{
				WriteMemory(ReadMemory(0x0058EB48) + 0x80, 0xE6, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x81, 0x02, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x82, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x83, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x84, 0x1E, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x85, 0x02, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x86, 0x00, "char")
				WriteMemory(ReadMemory(0x0058EB48) + 0x87, 0x00, "char")
			}
		else{
				return
			}
		return
	}

UiTest(TestNum){
	if(TestNum = 1) {
		UIMap := ReadMemory(0x0058EB6C)
		sleep, 1
		return UIMap
	}
	else if(TestNum = 2) {
		UIRas := ReadMemory(0x0058F0CC)
		return UIRas
		}
	}

Click_CurrentMiniMapPos(A,B){
	CurrentMiniMapPosX := ReadMemory(ReadMemory(0x0058EB48) +0x80)+A
	CurrentMiniMapPosY := ReadMemory(ReadMemory(0x0058EB48) +0x84)+B
	postclick(CurrentMiniMapPosX,CurrentMiniMapPosY)
	}

KeyClick(Key){
	if(Key = "AltR"){
		loop, 1 {
			PostMessage, 0x100, 18, 540540929,, %WindowTitle% ; ALT Lock
			PostMessage, 0x100, 82, 1245185,, %WindowTitle%  ; r Lock
			PostMessage, 0x101, 82, 1245185,, %WindowTitle%  ; r release
			PostMessage, 0x101, 18, 540540929,, %WindowTitle% ; ALT Release
			sleep, 1
			}
		}
	else if(Key = "Space"){
		loop, 1 {
			PostMessage, 0x100, 32, 3735553,, %WindowTitle%
			PostMessage, 0x101, 32, 3735553,, %WindowTitle%
			}
		}
	else if(Key = "Tab"){
		loop, 1 {
			PostMessage, 0x100, 9, 983041,, %WindowTitle%
			PostMessage, 0x101, 9, 983041,, %WindowTitle%
			}
		}
	else if(Key = "Alt2"){
		loop, 1 {
			PostMessage, 0x100, 18, 540540929,, %WindowTitle% ; ALT Lock
			postmessage, 0x100, 50, 196609, ,%WindowTitle% ; 2 Key Lock
			postmessage, 0x101, 50, 196609, ,%WindowTitle% ; 2 Key Release
			PostMessage, 0x101, 18, 540540929,, %WindowTitle% ; ALT Release
			sleep, 1
			}
		}
	else if(Key=1){
		loop, 1 {
			postmessage, 0x100, 49, 131073, ,%WindowTitle% ; 1 Key Lock
			postmessage, 0x101, 49, 131073, ,%WindowTitle% ; 1 Key Release
			sleep, 1
			}
		}
	else if(Key=2) {
		loop, 1 {
			postmessage, 0x100, 50, 196609, ,%WindowTitle% ; 2 Key Lock
			postmessage, 0x101, 50, 196609, ,%WindowTitle% ; 2 Key Release
			sleep, 1
			}
		}
	else if(Key=3) {
		loop, 1 {
			postmessage, 0x100, 51, 262145, ,%WindowTitle% ; 3 Key Lock
			postmessage, 0x101, 51, 262145, ,%WindowTitle% ; 3 Key Release
			sleep, 1
			}
		}
	else if(Key=4) {
		loop, 1 {
			postmessage, 0x100, 52, 327681, ,%WindowTitle% ; 4 Key Lock
			postmessage, 0x101, 52, 327681, ,%WindowTitle% ; 4 Key Release
			sleep, 1
			}
		}
	else if(Key=5){
		loop, 1{
			postmessage, 0x100, 53, 393217, ,%WindowTitle% ; 5 Key Lock
			postmessage, 0x101, 53, 393217, ,%WindowTitle% ; 5 Key Release
			sleep, 1
			}
		}
	else if(Key=6){
		loop, 1{
			postmessage, 0x100, 54, 458753, ,%WindowTitle% ; 6 Key Lock
			postmessage, 0x101, 54, 458753, ,%WindowTitle% ; 6 Key Release
			sleep, 1
			}
		}
	else if(Key=7){
		loop, 1{
			postmessage, 0x100, 55, 524289, ,%WindowTitle% ; 7 Key Lock
			postmessage, 0x101, 55, 524289, ,%WindowTitle% ; 7 Key Release
			sleep, 1
			}
		}
	else if(Key=8){
		loop, 1{
			postmessage, 0x100, 56, 589825, ,%WindowTitle% ; 8 Key Lock
			postmessage, 0x101, 56, 589825, ,%WindowTitle% ; 8 Key Release
			sleep, 1
			}
		}
	else if(Key=9){
		loop, 1{
			postmessage, 0x100, 57, 655361, ,%WindowTitle% ; 9 Key Lock
			postmessage, 0x101, 57, 655361, ,%WindowTitle% ; 9 Key Release
			sleep, 1
			}
		}
	else if(Key=0){
		loop, 1{
			postmessage, 0x100, 48, 720897, ,%WindowTitle% ; 0 Key Lock
			postmessage, 0x101, 48, 720897, ,%WindowTitle% ; 0 Key Release
			sleep, 1
			}
		}
	else if(Key="CTRL1"){
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 49, 131073, ,%WindowTitle% ; 1 Key Lock
			postmessage, 0x101, 49, 131073, ,%WindowTitle% ; 1 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL2"){
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 50, 196609, ,%WindowTitle% ; 2 Key Lock
			postmessage, 0x101, 50, 196609, ,%WindowTitle% ; 2 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL3") {
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 51, 262145, ,%WindowTitle% ; 3 Key Lock
			postmessage, 0x101, 51, 262145, ,%WindowTitle% ; 3 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL4") {
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 52, 327681, ,%WindowTitle% ; 4 Key Lock
			postmessage, 0x101, 52, 327681, ,%WindowTitle% ; 4 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL5") {
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 53, 393217, ,%WindowTitle% ; 5 Key Lock
			postmessage, 0x101, 53, 393217, ,%WindowTitle% ; 5 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL6") {
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 54, 458753, ,%WindowTitle% ; 6 Key Lock
			postmessage, 0x101, 54, 458753, ,%WindowTitle% ; 6 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL7") {
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 55, 524289, ,%WindowTitle% ; 7 Key Lock
			postmessage, 0x101, 55, 524289, ,%WindowTitle% ; 7 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL8") {
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 56, 589825, ,%WindowTitle% ; 8 Key Lock
			postmessage, 0x101, 56, 589825, ,%WindowTitle% ; 8 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL9") {
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 57, 655361, ,%WindowTitle% ; 9 Key Lock
			postmessage, 0x101, 57, 655361, ,%WindowTitle% ; 9 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="CTRL0") {
		loop, 1 {
			postmessage, 0x100, 17, 1900545, ,%WindowTitle% ; CTRL Lock
			postmessage, 0x100, 48, 720897, ,%WindowTitle% ; 0 Key Lock
			postmessage, 0x101, 48, 720897, ,%WindowTitle% ; 0 Key Release
			postmessage, 0x101, 17, 1900545, ,%WindowTitle% ; CTRL Release
			sleep, 1
			}
		}
	else if(Key="DownArrow") {
		loop, 1 {
			postmessage, 0x100, 40, 22020097, ,%WindowTitle% ; ���� Ű Lock
			postmessage, 0x101, 40, 22020097, ,%WindowTitle% ; ���� Ű Release
			sleep, 1
			}
		}
	else if(Key="UpArrow") {
		loop, 1 {
			postmessage, 0x100, 38, 21495809, ,%WindowTitle% ; ���� Ű Lock
			postmessage, 0x101, 38, 21495809, ,%WindowTitle% ; ���� Ű Release
			sleep, 1
			}
		}
	else if(Key="RightArrow") {
		loop, 1 {
			postmessage, 0x100, 39, 21823489, ,%WindowTitle% ; ������ Ű Lock
			postmessage, 0x101, 39, 21823489, ,%WindowTitle% ; ������ Ű Release
			sleep, 1
			}
		}
	else if(Key="LeftArrow") {
		loop, 1 {
			postmessage, 0x100, 37, 21692417, ,%WindowTitle% ; ������ Ű Lock
			postmessage, 0x101, 37, 21692417, ,%WindowTitle% ; ������ Ű Release
			sleep, 1
			}
		}
	}

;ü��ȸ���� Ż����
ride_enable(){
	WriteMemory(0x0046035B,  0x90, "char")
	WriteMemory(0x0046035C,  0x90, "char")
	WriteMemory(0x0046035D,  0x90, "char")
	WriteMemory(0x0046035E,  0x90, "char")
	WriteMemory(0x0046035F,  0x90, "char")
	WriteMemory(0x00460360,  0x90, "char")
	}
ride_disable(){
	WriteMemory(0x0046035B,  0x89, "char")
	WriteMemory(0x0046035C,  0x83, "char")
	WriteMemory(0x0046035D,  0x6B, "char")
	WriteMemory(0x0046035E,  0x01, "char")
	WriteMemory(0x0046035F,  0x00, "char")
	WriteMemory(0x00460360,  0x00, "char")
	}

;������
wall_remove_enable(){
	WriteMemory(0x0047AA5B,  0xEB, "char")
	}
wall_remove_disable(){
	WriteMemory(0x0047AA5B,  0x7d, "char")
	}

;������
floor_remove_enable(){
	WriteMemory(0x0047A196,  0xEB, "char")
	}
floor_remove_disable(){
	WriteMemory(0x0047A196,  0x75, "char")
	}

;ĳ���� ����
char_remove_enable(){
	WriteMemory(0x0045D28F,  0xE9, "char")
	WriteMemory(0x0045D290,  0x8A, "char")
	WriteMemory(0x0045D291,  0x0A, "char")
	WriteMemory(0x0045D292,  0x00, "char")
	WriteMemory(0x0045D293,  0x00, "char")
	}
char_remove_disable(){
	WriteMemory(0x0045D28F,  0x0F, "char")
	WriteMemory(0x0045D290,  0x84, "char")
	WriteMemory(0x0045D291,  0xC2, "char")
	WriteMemory(0x0045D292,  0x00, "char")
	WriteMemory(0x0045D293,  0x00, "char")
	}

;ĳ���� ����
Freeze_Move(){
	WriteMemory(0x0047AD78,  0x90, "char")
	WriteMemory(0x0047AD79,  0x90, "char")
	WriteMemory(0x0047AD7A,  0x90, "char")
	}
Un_Freeze_Move(){
	WriteMemory(0x0047AD78, 0x8B, "char")
	WriteMemory(0x0047AD79,  0x4E, "char")
	WriteMemory(0x0047AD7A,  0x04, "char")
	}

Buy_Unlimitted(){
	WriteMemory(0x0042483A, 0xB0, "char")
	WriteMemory(0x0042483B, 0x01, "char")
	WriteMemory(0x0042483C, 0x90, "char")
	WriteMemory(0x0042483D, 0x90, "char")
	WriteMemory(0x0042483E, 0x90, "char")
	WriteMemory(0x0042483F, 0x90, "char")
	}

Move_Buy(){
	WriteMemory(ReadMemory(0x0058EB48) + 0x8C, 233, "UInt")
	WriteMemory(ReadMemory(0x0058EB48) + 0x90, 173, "UInt")
	}

Move_Sell(){
	WriteMemory(ReadMemory(0x0058EB48) + 0x98, 233, "UInt")
	WriteMemory(ReadMemory(0x0058EB48) + 0x9C, 173, "UInt")
	}

Move_Repair(){
	WriteMemory(ReadMemory(0x0058EB48) + 0xA4,  230, "UInt")
	WriteMemory(ReadMemory(0x0058EB48) + 0xA8,  170, "UInt")
	}

FormatNumber(Amount) {
	StringReplace Amount, Amount, -
	IfEqual ErrorLevel,0, SetEnv Sign,-
	Loop Parse, Amount, .
	If (A_Index = 1) {
		len := StrLen(A_LoopField)
		Loop Parse, A_LoopField
		If (Mod(len-A_Index,3) = 0 and A_Index != len)
			x = %x%%A_LoopField%,
		Else x = %x%%A_LoopField%
		}
	Else Return Sign x "." A_LoopField
	Return Sign x
	}

RefleshWindowList(TitleNumber){
	jElancia_Count := Get_jElancia_Titles()
	GuiControl,, Player%TitleNumber%title,|
	Loop, %jElancia_Count%{
		temp_Variable := WindowTitle%A_Index%
		GuiControl,, Player%TitleNumber%title, %temp_Variable%
		}
	GuiControl, Choose, Player%TitleNumber%title, %TitleNumber%
	}

ReadMemory(MADDRESS=0, BYTES=4){
	PROGRAM:= WindowTitle
	Static OLDPROC, ProcessHandle
	VarSetCapacity(buffer, BYTES)

	If (PROGRAM != OLDPROC){
		if ProcessHandle
		closed := DllCall("CloseHandle", "UInt", ProcessHandle), ProcessHandle := 0, OLDPROC := ""

		if PROGRAM{
			WinGet, pid, pid, % OLDPROC := PROGRAM

			if !pid
			return "Process Doesn't Exist", OLDPROC := ""

			ProcessHandle := DllCall("OpenProcess", "Int", 16, "Int", 0, "UInt", pid)
			}
		}

	If !(ProcessHandle && DllCall("ReadProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS, "Ptr", &buffer, "UInt", BYTES, "Ptr", 0))
		return !ProcessHandle ? "Handle Closed: " closed : "Fail"
	else if (BYTES = 1)
		Type := "UChar"
	else if (BYTES = 2)
		Type := "UShort"
	else if (BYTES = 4)
		Type := "UInt"
	else
		Type := "Int64"

	return numget(buffer, 0, Type)
	}

ReadMemoryTxt(MADDRESS) {
	WinGet, pid, PID, %WindowTitle%
	VarSetCapacity(MVALUE, 131, 0)
	ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
	DllCall("ReadProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS, "Str", MVALUE, "UInt", 131, "UInt *", 0)
	return MVALUE
	}

WriteMemory(WriteAddress = "", Data="", TypeOrLength = ""){
	PROGRAM:=WindowTitle
	Static OLDPROC, hProcess, pid
	If (PROGRAM != OLDPROC){
		if hProcess
			closed := DllCall("CloseHandle", "UInt", hProcess), hProcess := 0, OLDPROC := ""
		if PROGRAM{
			WinGet, pid, pid, % OLDPROC := PROGRAM
			jPID = pid
			if !pid
			return "Process Doesn't Exist", OLDPROC := ""
			hProcess := DllCall("OpenProcess", "Int", 0x8 | 0x20, "Int", 0, "UInt", pid)
			}
		}
	If Data is Number
		{
		If TypeOrLength is Integer
			{
			DataAddress := Data
			DataSize := TypeOrLength
			}
		Else{
			If (TypeOrLength = "Double" or TypeOrLength = "Int64")
				DataSize = 8
			Else If (TypeOrLength = "Int" or TypeOrLength = "UInt" or TypeOrLength = "Float")
				DataSize = 4
			Else If (TypeOrLength = "Short" or TypeOrLength = "UShort")
				DataSize = 2
			Else If (TypeOrLength = "Char" or TypeOrLength = "UChar")
				DataSize = 1
			Else {
				Return False
				}
			VarSetCapacity(Buf, DataSize, 0)
			NumPut(Data, Buf, 0, TypeOrLength)
			DataAddress := &Buf
			}
		}
	Else{
		DataAddress := &Data
		If TypeOrLength is Integer
			{
			If A_IsUnicode
			DataSize := TypeOrLength * 2
			Else
			DataSize := TypeOrLength
			}
		Else{
			If A_IsUnicode
				DataSize := (StrLen(Data) + 1) * 2
			Else
				DataSize := StrLen(Data) + 1
			}
		}
	if (hProcess && DllCall("WriteProcessMemory", "UInt", hProcess
	, "UInt", WriteAddress
	, "UInt", DataAddress
	, "UInt", DataSize
	, "UInt", 0))
	return
	else return !hProcess ? "Handle Closed:" closed : "Fail"
	}

SetStaticColor(hStatic, b_color, f_color := 0){
	   static arr := [], GWL_WNDPROC := -4
	   b_color := DllCall("Ws2_32\ntohl", UInt, b_color << 8, UInt)
	   f_color := DllCall("Ws2_32\ntohl", UInt, f_color << 8, UInt)
	   hGui := DllCall("GetParent", Ptr, hStatic, Ptr)
	   if !arr.HasKey(hGui)  {
		  arr[hGui] := {}, arr[hGui].Statics := []
		  arr[hGui].ProcOld := DllCall("SetWindowLong" . (A_PtrSize = 8 ? "Ptr" : ""), Ptr, hGui, Int, GWL_WNDPROC
										, Ptr, RegisterCallback("WindowProc", "", 4, Object(arr[hGui])), Ptr)
		}
	   else if arr[hGui].Statics.HasKey(hStatic)
		  DllCall("DeleteObject", Ptr, arr[hGui].Statics[hStatic].hBrush)
	   arr[hGui].Statics[hStatic] := { b_color: b_color, f_color: f_color
									 , hBrush: DllCall("CreateSolidBrush", UInt, b_color, Ptr) }
	   WinSet, Redraw,, ahk_id %hStatic%
	}

WindowProc(hwnd, uMsg, wParam, lParam) {
	   Critical
	   static WM_CTLCOLORSTATIC := 0x138
	   obj := Object(A_EventInfo)
	   if (uMsg = WM_CTLCOLORSTATIC && k := obj.Statics[lParam])  {
		  DllCall("SetBkColor", Ptr, wParam, UInt, k.b_color)
		  DllCall("SetTextColor", Ptr, wParam, UInt, k.f_color)
		  Return k.hBrush
	   }
	   Return DllCall("CallWindowProc", Ptr, obj.ProcOld, Ptr, hwnd, UInt, uMsg, Ptr, wParam, Ptr, lParam)
	}

getModuleBaseAddress(module := ""){
	WinGet, pid, pid, %WindowTitle%
	if pid                             ; PROCESS_QUERY_INFORMATION + PROCESS_VM_READ
	hProc := DllCall("OpenProcess", "UInt", 0x0400 | 0x0010 , "Int", 0, "UInt", pid)
	else return -2
	if !hProc
	return -3
	if (A_PtrSize = 4) ; AHK 32bit
		{
		DllCall("IsWow64Process", "Ptr", hProc, "Int*", result)
		if !result
		return -5, DllCall("CloseHandle","Ptr",hProc) ; AHK is 32bit and target process is 64 bit, this function wont work
		}
	if (module = "")
		{
		VarSetCapacity(mainExeNameBuffer, 2048 * (A_IsUnicode ? 2 : 1))
		DllCall("psapi\GetModuleFileNameEx", "Ptr", hProc, "UInt", 0
		, "Ptr", &mainExeNameBuffer, "UInt", 2048 / (A_IsUnicode ? 2 : 1))
		mainExeFullPath := StrGet(&mainExeNameBuffer)
		; mainExeName = main executable module of the process (will include full directory path)
		}
	size := VarSetCapacity(lphModule, 4)
	loop
		{
		DllCall("psapi\EnumProcessModules", "Ptr", hProc, "Ptr", &lphModule
		, "UInt", size, "UInt*", reqSize)
		if ErrorLevel
		return -4, DllCall("CloseHandle","Ptr",hProc)
		else if (size >= reqSize)
		break
		else
		size := VarSetCapacity(lphModule, reqSize)
		}
	VarSetCapacity(lpFilename, 2048 * (A_IsUnicode ? 2 : 1))
	loop % reqSize / A_PtrSize ; sizeof(HMODULE) - enumerate the array of HMODULEs
		{
		DllCall("psapi\GetModuleFileNameEx", "Ptr", hProc, "Ptr", numget(lphModule, (A_index - 1) * A_PtrSize)
		, "Ptr", &lpFilename, "UInt", 2048 / (A_IsUnicode ? 2 : 1))
		; module will contain directory path as well e.g C:\Windows\syswow65\GDI32.dll
		moduleFullPath := StrGet(&lpFilename)
		SplitPath, moduleFullPath, fileName ; strips the path so = GDI32.dll
		if (module = "" && mainExeFullPath = moduleFullPath) || (module != "" && module = filename)
			{
			VarSetCapacity(MODULEINFO, A_PtrSize = 4 ? 12 : 24)
			DllCall("psapi\GetModuleInformation", "Ptr", hProc, "Ptr", numget(lphModule, (A_index - 1) * A_PtrSize)
			, "Ptr", &MODULEINFO, "UInt", A_PtrSize = 4 ? 12 : 24)
			return numget(MODULEINFO, 0, "Ptr"), DllCall("CloseHandle","Ptr",hProc)
			}
		}
	return -1, DllCall("CloseHandle","Ptr",hProc) ; not found
	}

get_mem(){
	if (_ClassMemory.__Class != "_ClassMemory")
	{
	msgbox class memory not correctly installed.
	gosub,Stop_this
	}

	mem := new _ClassMemory(WindowTitle,, hProcessCopy)

	if !isObject(mem)
	{
	if (hProcessCopy = 0)
	msgbox The program isn't running (not found) or you passed an incorrect program identifier parameter.
	else if (hProcessCopy = "")
	msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. _ClassMemory.setSeDebugPrivilege() may also be required. Consult A_LastError for more information.
	gosub,Stop_this
	}return mem
	}

/*
    A basic memory class by RHCP:
    This is a wrapper for commonly used read and write memory functions.
    It also contains a variety of pattern scan functions.
    This class allows scripts to read/write integers and strings of various types.
    Pointer addresses can easily be read/written by passing the base address and offsets to the various read/write functions.

    Process handles are kept open between reads. This increases speed.
    However, if a program closes/restarts then the process handle will become invalid
    and you will need to re-open another handle (blank/destroy the object and recreate it)
    isHandleValid() can be used to check if a handle is still active/valid.
    read(), readString(), write(), and writeString() can be used to read and write memory addresses respectively.
    readRaw() can be used to dump large chunks of memory, this is considerably faster when
    reading data from a large structure compared to repeated calls to read().
    For example, reading a single UInt takes approximately the same amount of time as reading 1000 bytes via readRaw().
    Although, most people wouldn't notice the performance difference. This does however require you
    to retrieve the values using AHK's numget()/strGet() from the dumped memory.
    In a similar fashion writeRaw() allows a buffer to be be written in a single operation.

    When the new operator is used this class returns an object which can be used to read that process's
    memory space.To read another process simply create another object.
    Process handles are automatically closed when the script exits/restarts or when you free the object.
    **Notes:
        This was initially written for 32 bit target processes, however the various read/write functions
        should now completely support pointers in 64 bit target applications. The only caveat is that the AHK exe must also be 64 bit.
        If AHK is 32 bit and the target application is 64 bit you can still read, write, and use pointers, so long as the addresses
        fit inside a 4 byte pointer, i.e. The maximum address is limited to the 32 bit range.
        The various pattern scan functions are intended to be used on 32 bit target applications, however:
            - A 32 bit AHK script can perform pattern scans on a 32 bit target application.
            - A 32 bit AHK script may be able to perform pattern scans on a 64 bit process, providing the addresses fall within the 32 bit range.
            - A 64 bit AHK script should be able to perform pattern scans on a 32 or 64 bit target application without issue.
        If the target process has admin privileges, then the AHK script will also require admin privileges.
        AHK doesn't support unsigned 64bit ints, you can however read them as Int64 and interpret negative values as large numbers.

    Commonly used methods:
        read()
        readString()
        readRaw()
        write()
        writeString()
        writeBytes()
        writeRaw()
        isHandleValid()
        getModuleBaseAddress()
    Less commonly used methods:
        getProcessBaseAddress()
        hexStringToPattern()
        stringToPattern()
        modulePatternScan()
        processPatternScan()
        addressPatternScan()
        rawPatternScan()
        getModules()
        numberOfBytesRead()
        numberOfBytesWritten()
        suspend()
        resume()
    Internal methods: (some may be useful when directly called)
        getAddressFromOffsets() ; This will return the final memory address of a pointer. This is useful if the pointed address only changes on startup or map/level change and you want to eliminate the overhead associated with pointers.
        isTargetProcess64Bit()
        pointer()
        GetModuleFileNameEx()
        EnumProcessModulesEx()
        GetModuleInformation()
        getNeedleFromAOBPattern()
        virtualQueryEx()
        patternScan()
        bufferScanForMaskedPattern()
        openProcess()
        closeHandle()
    Useful properties:  (Do not modify the values of these properties - they are set automatically)
        baseAddress             ; The base address of the target process
        hProcess                ; The handle to the target process
        PID                     ; The PID of the target process
        currentProgram          ; The string the user used to identify the target process e.g. "ahk_exe calc.exe"
        isTarget64bit           ; True if target process is 64 bit, otherwise false
        readStringLastError     ; Used to check for success/failure when reading a string
     Useful editable properties:
        insertNullTerminator    ; Determines if a null terminator is inserted when writing strings.

    Usage:
        ; **Note: If you wish to try this calc example, consider using the 32 bit version of calc.exe -
        ;         which is in C:\Windows\SysWOW64\calc.exe on win7 64 bit systems.
        ; The contents of this file can be copied directly into your script. Alternately, you can copy the classMemory.ahk file into your library folder,
        ; in which case you will need to use the #include directive in your script i.e.
            #Include <classMemory>

        ; You can use this code to check if you have installed the class correctly.
            if (_ClassMemory.__Class != "_ClassMemory")
            {
                msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten
                ExitApp
            }
        ; Open a process with sufficient access to read and write memory addresses (this is required before you can use the other functions)
        ; You only need to do this once. But if the process closes/restarts, then you will need to perform this step again. Refer to the notes section below.
        ; Also, if the target process is running as admin, then the script will also require admin rights!
        ; Note: The program identifier can be any AHK windowTitle i.e.ahk_exe, ahk_class, ahk_pid, or simply the window title.
        ; hProcessCopy is an optional variable in which the opened handled is stored.

            calc := new _ClassMemory("ahk_exe calc.exe", "", hProcessCopy)

        ; Check if the above method was successful.
            if !isObject(calc)
            {
                msgbox failed to open a handle
                if (hProcessCopy = 0)
                    msgbox The program isn't running (not found) or you passed an incorrect program identifier parameter. In some cases _ClassMemory.setSeDebugPrivilege() may be required.
                else if (hProcessCopy = "")
                    msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. _ClassMemory.setSeDebugPrivilege() may also be required. Consult A_LastError for more information.
                ExitApp
            }
        ; Get the process's base address.
        ; When using the new operator this property is automatically set to the result of getModuleBaseAddress() or getProcessBaseAddress();
        ; the specific method used depends on the bitness of the target application and AHK.
        ; If the returned address is incorrect and the target application is 64 bit, but AHK is 32 bit, try using the 64 bit version of AHK.
            msgbox % calc.BaseAddress

        ; Get the base address of a specific module.
            msgbox % calc.getModuleBaseAddress("GDI32.dll")
        ; The rest of these examples are just for illustration (the addresses specified are probably not valid).
        ; You can use cheat engine to find real addresses to read and write for testing purposes.

        ; Write 1234 as a UInt at address 0x0016CB60.
            calc.write(0x0016CB60, 1234, "UInt")
        ; Read a UInt.
            value := calc.read(0x0016CB60, "UInt")
        ; Read a pointer with offsets 0x20 and 0x15C which points to a UChar.
            value := calc.read(pointerBase, "UChar", 0x20, 0x15C)
        ; Note: read(), readString(), readRaw(), write(), writeString(), and writeRaw() all support pointers/offsets.
        ; An array of pointers can be passed directly, i.e.
            arrayPointerOffsets := [0x20, 0x15C]
            value := calc.read(pointerBase, "UChar", arrayPointerOffsets*)
        ; Or they can be entered manually.
            value := calc.read(pointerBase, "UChar", 0x20, 0x15C)
        ; You can also pass all the parameters directly, i.e.
            aMyPointer := [pointerBase, "UChar", 0x20, 0x15C]
            value := calc.read(aMyPointer*)

        ; Read a utf-16 null terminated string of unknown size at address 0x1234556 - the function will read until the null terminator is found or something goes wrong.
            string := calc.readString(0x1234556, length := 0, encoding := "utf-16")

        ; Read a utf-8 encoded string which is 12 bytes long at address 0x1234556.
            string := calc.readString(0x1234556, 12)
        ; By default a null terminator is included at the end of written strings for writeString().
        ; The nullterminator property can be used to change this.
            _ClassMemory.insertNullTerminator := False ; This will change the property for all processes
            calc.insertNullTerminator := False ; Changes the property for just this process
    Notes:
        If the target process exits and then starts again (or restarts) you will need to free the derived object and then use the new operator to create a new object i.e.
        calc := [] ; or calc := "" ; free the object. This is actually optional if using the line below, as the line below would free the previous derived object calc prior to initialising the new copy.
        calc := new _ClassMemory("ahk_exe calc.exe") ; Create a new derived object to read calc's memory.
        isHandleValid() can be used to check if a target process has closed or restarted.
*/

class _ClassMemory
{
    ; List of useful accessible values. Some of these inherited values (the non objects) are set when the new operator is used.
    static baseAddress, hProcess, PID, currentProgram
    , insertNullTerminator := True
    , readStringLastError := False
    , isTarget64bit := False
    , ptrType := "UInt"
    , aTypeSize := {    "UChar":    1,  "Char":     1
                    ,   "UShort":   2,  "Short":    2
                    ,   "UInt":     4,  "Int":      4
                    ,   "UFloat":   4,  "Float":    4
                    ,   "Int64":    8,  "Double":   8}
    , aRights := {  "PROCESS_ALL_ACCESS": 0x001F0FFF
                ,   "PROCESS_CREATE_PROCESS": 0x0080
                ,   "PROCESS_CREATE_THREAD": 0x0002
                ,   "PROCESS_DUP_HANDLE": 0x0040
                ,   "PROCESS_QUERY_INFORMATION": 0x0400
                ,   "PROCESS_QUERY_LIMITED_INFORMATION": 0x1000
                ,   "PROCESS_SET_INFORMATION": 0x0200
                ,   "PROCESS_SET_QUOTA": 0x0100
                ,   "PROCESS_SUSPEND_RESUME": 0x0800
                ,   "PROCESS_TERMINATE": 0x0001
                ,   "PROCESS_VM_OPERATION": 0x0008
                ,   "PROCESS_VM_READ": 0x0010
                ,   "PROCESS_VM_WRITE": 0x0020
                ,   "SYNCHRONIZE": 0x00100000}


    ; Method:    __new(program, dwDesiredAccess := "", byRef handle := "", windowMatchMode := 3)
    ; Example:  derivedObject := new _ClassMemory("ahk_exe calc.exe")
    ;           This is the first method which should be called when trying to access a program's memory.
    ;           If the process is successfully opened, an object is returned which can be used to read that processes memory space.
    ;           [derivedObject].hProcess stores the opened handle.
    ;           If the target process closes and re-opens, simply free the derived object and use the new operator again to open a new handle.
    ; Parameters:
    ;   program             The program to be opened. This can be any AHK windowTitle identifier, such as
    ;                       ahk_exe, ahk_class, ahk_pid, or simply the window title. e.g. "ahk_exe calc.exe" or "Calculator".
    ;                       It's safer not to use the window title, as some things can have the same window title e.g. an open folder called "Starcraft II"
    ;                       would have the same window title as the game itself.
    ;                       *'DetectHiddenWindows, On' is required for hidden windows*
    ;   dwDesiredAccess     The access rights requested when opening the process.
    ;                       If this parameter is null the process will be opened with the following rights
    ;                       PROCESS_QUERY_INFORMATION, PROCESS_VM_OPERATION, PROCESS_VM_READ, PROCESS_VM_WRITE, & SYNCHRONIZE
    ;                       This access level is sufficient to allow all of the methods in this class to work.
    ;                       Specific process access rights are listed here http://msdn.microsoft.com/en-us/library/windows/desktop/ms684880(v=vs.85).aspx
    ;   handle (Output)     Optional variable in which a copy of the opened processes handle will be stored.
    ;                       Values:
    ;                           Null    OpenProcess failed. The script may need to be run with admin rights admin,
    ;                                   and/or with the use of _ClassMemory.setSeDebugPrivilege(). Consult A_LastError for more information.
    ;                           0       The program isn't running (not found) or you passed an incorrect program identifier parameter.
    ;                                   In some cases _ClassMemory.setSeDebugPrivilege() may be required.
    ;                           Positive Integer    A handle to the process. (Success)
    ;   windowMatchMode -   Determines the matching mode used when finding the program (windowTitle).
    ;                       The default value is 3 i.e. an exact match. Refer to AHK's setTitleMathMode for more information.
    ; Return Values:
    ;   Object  On success an object is returned which can be used to read the processes memory.
    ;   Null    Failure. A_LastError and the optional handle parameter can be consulted for more information.


    __new(program, dwDesiredAccess := "", byRef handle := "", windowMatchMode := 3)
    {
        if this.PID := handle := this.findPID(program, windowMatchMode) ; set handle to 0 if program not found
        {
            ; This default access level is sufficient to read and write memory addresses, and to perform pattern scans.
            ; if the program is run using admin privileges, then this script will also need admin privileges
            if dwDesiredAccess is not integer
                dwDesiredAccess := this.aRights.PROCESS_QUERY_INFORMATION | this.aRights.PROCESS_VM_OPERATION | this.aRights.PROCESS_VM_READ | this.aRights.PROCESS_VM_WRITE
            dwDesiredAccess |= this.aRights.SYNCHRONIZE ; add SYNCHRONIZE to all handles to allow isHandleValid() to work

            if this.hProcess := handle := this.OpenProcess(this.PID, dwDesiredAccess) ; NULL/Blank if failed to open process for some reason
            {
                this.pNumberOfBytesRead := DllCall("GlobalAlloc", "UInt", 0x0040, "Ptr", A_PtrSize, "Ptr") ; 0x0040 initialise to 0
                this.pNumberOfBytesWritten := DllCall("GlobalAlloc", "UInt", 0x0040, "Ptr", A_PtrSize, "Ptr") ; initialise to 0

                this.readStringLastError := False
                this.currentProgram := program
                if this.isTarget64bit := this.isTargetProcess64Bit(this.PID, this.hProcess, dwDesiredAccess)
                    this.ptrType := "Int64"
                else this.ptrType := "UInt" ; If false or Null (fails) assume 32bit

                ; if script is 64 bit, getModuleBaseAddress() should always work
                ; if target app is truly 32 bit, then getModuleBaseAddress()
                ; will work when script is 32 bit
                if (A_PtrSize != 4 || !this.isTarget64bit)
                    this.BaseAddress := this.getModuleBaseAddress()

                ; If the above failed or wasn't called, fall back to alternate method
                if this.BaseAddress < 0 || !this.BaseAddress
                    this.BaseAddress := this.getProcessBaseAddress(program, windowMatchMode)

                return this
            }
        }
        return
    }

    __delete()
    {
        this.closeHandle(this.hProcess)
        if this.pNumberOfBytesRead
            DllCall("GlobalFree", "Ptr", this.pNumberOfBytesRead)
        if this.pNumberOfBytesWritten
            DllCall("GlobalFree", "Ptr", this.pNumberOfBytesWritten)
        return
    }

    version()
    {
        return 2.92
    }

    findPID(program, windowMatchMode := "3")
    {
        ; If user passes an AHK_PID, don't bother searching. There are cases where searching windows for PIDs
        ; wont work - console apps
        if RegExMatch(program, "i)\s*AHK_PID\s+(0x[[:xdigit:]]+|\d+)", pid)
            return pid1
        if windowMatchMode
        {
            ; This is a string and will not contain the 0x prefix
            mode := A_TitleMatchMode
            ; remove hex prefix as SetTitleMatchMode will throw a run time error. This will occur if integer mode is set to hex and user passed an int (unquoted)
            StringReplace, windowMatchMode, windowMatchMode, 0x
            SetTitleMatchMode, %windowMatchMode%
        }
        WinGet, pid, pid, %program%
        if windowMatchMode
            SetTitleMatchMode, %mode%    ; In case executed in autoexec

        ; If use 'ahk_exe test.exe' and winget fails (which can happen when setSeDebugPrivilege is required),
        ; try using the process command. When it fails due to setSeDebugPrivilege, setSeDebugPrivilege will still be required to openProcess
        ; This should also work for apps without windows.
        if (!pid && RegExMatch(program, "i)\bAHK_EXE\b\s*(.*)", fileName))
        {
            ; remove any trailing AHK_XXX arguments
            filename := RegExReplace(filename1, "i)\bahk_(class|id|pid|group)\b.*", "")
            filename := trim(filename)    ; extra spaces will make process command fail
            ; AHK_EXE can be the full path, so just get filename
            SplitPath, fileName , fileName
            if (fileName) ; if filename blank, scripts own pid is returned
            {
                process, Exist, %fileName%
                pid := ErrorLevel
            }
        }

        return pid ? pid : 0 ; PID is null on fail, return 0
    }
    ; Method:   isHandleValid()
    ;           This method provides a means to check if the internal process handle is still valid
    ;           or in other words, the specific target application instance (which you have been reading from)
    ;           has closed or restarted.
    ;           For example, if the target application closes or restarts the handle will become invalid
    ;           and subsequent calls to this method will return false.
    ;
    ; Return Values:
    ;   True    The handle is valid.
    ;   False   The handle is not valid.
    ;
    ; Notes:
    ;   This operation requires a handle with SYNCHRONIZE access rights.
    ;   All handles, even user specified ones are opened with the SYNCHRONIZE access right.

    isHandleValid()
    {
        return 0x102 = DllCall("WaitForSingleObject", "Ptr", this.hProcess, "UInt", 0)
        ; WaitForSingleObject return values
        ; -1 if called with null hProcess (sets lastError to 6 - invalid handle)
        ; 258 / 0x102 WAIT_TIMEOUT - if handle is valid (process still running)
        ; 0  WAIT_OBJECT_0 - if process has terminated
    }

    ; Method:   openProcess(PID, dwDesiredAccess)
    ;           ***Note:    This is an internal method which shouldn't be called directly unless you absolutely know what you are doing.
    ;                       This is because the new operator, in addition to calling this method also sets other values
    ;                       which are required for the other methods to work correctly.
    ; Parameters:
    ;   PID                 The Process ID of the target process.
    ;   dwDesiredAccess     The access rights requested when opening the process.
    ;                       Specific process access rights are listed here http://msdn.microsoft.com/en-us/library/windows/desktop/ms684880(v=vs.85).aspx
    ; Return Values:
    ;   Null/blank          OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin.
    ;                       _ClassMemory.setSeDebugPrivilege() may also be required.
    ;   Positive integer    A handle to the process.

    openProcess(PID, dwDesiredAccess)
    {
        r := DllCall("OpenProcess", "UInt", dwDesiredAccess, "Int", False, "UInt", PID, "Ptr")
        ; if it fails with 0x5 ERROR_ACCESS_DENIED, try enabling privilege ... lots of users never try this.
        ; there may be other errors which also require DebugPrivilege....
        if (!r && A_LastError = 5)
        {
            this.setSeDebugPrivilege(true) ; no harm in enabling it if it is already enabled by user
            if (r2 := DllCall("OpenProcess", "UInt", dwDesiredAccess, "Int", False, "UInt", PID, "Ptr"))
                return r2
            DllCall("SetLastError", "UInt", 5) ; restore original error if it doesnt work
        }
        ; If fails with 0x5 ERROR_ACCESS_DENIED (when setSeDebugPrivilege() is req.), the func. returns 0 rather than null!! Set it to null.
        ; If fails for another reason, then it is null.
        return r ? r : ""
    }

    ; Method:   closeHandle(hProcess)
    ;           Note:   This is an internal method which is automatically called when the script exits or the derived object is freed/destroyed.
    ;                   There is no need to call this method directly. If you wish to close the handle simply free the derived object.
    ;                   i.e. derivedObject := [] ; or derivedObject := ""
    ; Parameters:
    ;   hProcess        The handle to the process, as returned by openProcess().
    ; Return Values:
    ;   Non-Zero        Success
    ;   0               Failure

    closeHandle(hProcess)
    {
        return DllCall("CloseHandle", "Ptr", hProcess)
    }

    ; Methods:      numberOfBytesRead() / numberOfBytesWritten()
    ;               Returns the number of bytes read or written by the last ReadProcessMemory or WriteProcessMemory operation.
    ;
    ; Return Values:
    ;   zero or positive value      Number of bytes read/written
    ;   -1                          Failure. Shouldn't occur

    numberOfBytesRead()
    {
        return !this.pNumberOfBytesRead ? -1 : NumGet(this.pNumberOfBytesRead+0, "Ptr")
    }
    numberOfBytesWritten()
    {
        return !this.pNumberOfBytesWritten ? -1 : NumGet(this.pNumberOfBytesWritten+0, "Ptr")
    }


    ; Method:   read(address, type := "UInt", aOffsets*)
    ;           Reads various integer type values
    ; Parameters:
    ;       address -   The memory address of the value or if using the offset parameter,
    ;                   the base address of the pointer.
    ;       type    -   The integer type.
    ;                   Valid types are UChar, Char, UShort, Short, UInt, Int, Float, Int64 and Double.
    ;                   Note: Types must not contain spaces i.e. " UInt" or "UInt " will not work.
    ;                   When an invalid type is passed the method returns NULL and sets ErrorLevel to -2
    ;       aOffsets* - A variadic list of offsets. When using offsets the address parameter should equal the base address of the pointer.
    ;                   The address (base address) and offsets should point to the memory address which holds the integer.
    ; Return Values:
    ;       integer -   Indicates success.
    ;       Null    -   Indicates failure. Check ErrorLevel and A_LastError for more information.
    ;       Note:       Since the returned integer value may be 0, to check for success/failure compare the result
    ;                   against null i.e. if (result = "") then an error has occurred.
    ;                   When reading doubles, adjusting "SetFormat, float, totalWidth.DecimalPlaces"
    ;                   may be required depending on your requirements.

    read(address, type := "UInt", aOffsets*)
    {
        ; If invalid type RPM() returns success (as bytes to read resolves to null in dllCall())
        ; so set errorlevel to invalid parameter for DLLCall() i.e. -2
        if !this.aTypeSize.hasKey(type)
            return "", ErrorLevel := -2
        if DllCall("ReadProcessMemory", "Ptr", this.hProcess, "Ptr", aOffsets.maxIndex() ? this.getAddressFromOffsets(address, aOffsets*) : address, type "*", result, "Ptr", this.aTypeSize[type], "Ptr", this.pNumberOfBytesRead)
            return result
        return
    }

    ; Method:   readRaw(address, byRef buffer, bytes := 4, aOffsets*)
    ;           Reads an area of the processes memory and stores it in the buffer variable
    ; Parameters:
    ;       address  -  The memory address of the area to read or if using the offsets parameter
    ;                   the base address of the pointer which points to the memory region.
    ;       buffer   -  The unquoted variable name for the buffer. This variable will receive the contents from the address space.
    ;                   This method calls varsetCapcity() to ensure the variable has an adequate size to perform the operation.
    ;                   If the variable already has a larger capacity (from a previous call to varsetcapcity()), then it will not be shrunk.
    ;                   Therefore it is the callers responsibility to ensure that any subsequent actions performed on the buffer variable
    ;                   do not exceed the bytes which have been read - as these remaining bytes could contain anything.
    ;       bytes   -   The number of bytes to be read.
    ;       aOffsets* - A variadic list of offsets. When using offsets the address parameter should equal the base address of the pointer.
    ;                   The address (base address) and offsets should point to the memory address which is to be read
    ; Return Values:
    ;       Non Zero -   Indicates success.
    ;       Zero     -   Indicates failure. Check errorLevel and A_LastError for more information
    ;
    ; Notes:            The contents of the buffer may then be retrieved using AHK's NumGet() and StrGet() functions.
    ;                   This method offers significant (~30% and up) performance boost when reading large areas of memory.
    ;                   As calling ReadProcessMemory for four bytes takes a similar amount of time as it does for 1,000 bytes.

    readRaw(address, byRef buffer, bytes := 4, aOffsets*)
    {
        VarSetCapacity(buffer, bytes)
        return DllCall("ReadProcessMemory", "Ptr", this.hProcess, "Ptr", aOffsets.maxIndex() ? this.getAddressFromOffsets(address, aOffsets*) : address, "Ptr", &buffer, "Ptr", bytes, "Ptr", this.pNumberOfBytesRead)
    }

    ; Method:   readString(address, sizeBytes := 0, encoding := "utf-8", aOffsets*)
    ;           Reads string values of various encoding types
    ; Parameters:
    ;       address -   The memory address of the value or if using the offset parameter,
    ;                   the base address of the pointer.
    ;       sizeBytes - The size (in bytes) of the string to be read.
    ;                   If zero is passed, then the function will read each character until a null terminator is found
    ;                   and then returns the entire string.
    ;       encoding -  This refers to how the string is stored in the program's memory.
    ;                   UTF-8 and UTF-16 are common. Refer to the AHK manual for other encoding types.
    ;       aOffsets* - A variadic list of offsets. When using offsets the address parameter should equal the base address of the pointer.
    ;                   The address (base address) and offsets should point to the memory address which holds the string.
    ;
    ;  Return Values:
    ;       String -    On failure an empty (null) string is always returned. Since it's possible for the actual string
    ;                   being read to be null (empty), then a null return value should not be used to determine failure of the method.
    ;                   Instead the property [derivedObject].ReadStringLastError can be used to check for success/failure.
    ;                   This property is set to 0 on success and 1 on failure. On failure ErrorLevel and A_LastError should be consulted
    ;                   for more information.
    ; Notes:
    ;       For best performance use the sizeBytes parameter to specify the exact size of the string.
    ;       If the exact size is not known and the string is null terminated, then specifying the maximum
    ;       possible size of the string will yield the same performance.
    ;       If neither the actual or maximum size is known and the string is null terminated, then specifying
    ;       zero for the sizeBytes parameter is fine. Generally speaking for all intents and purposes the performance difference is
    ;       inconsequential.

    readString(address, sizeBytes := 0, encoding := "UTF-8", aOffsets*)
    {
        bufferSize := VarSetCapacity(buffer, sizeBytes ? sizeBytes : 100, 0)
        this.ReadStringLastError := False
        if aOffsets.maxIndex()
            address := this.getAddressFromOffsets(address, aOffsets*)
        if !sizeBytes  ; read until null terminator is found or something goes wrong
        {
            ; Even if there are multi-byte-characters (bigger than the encodingSize i.e. surrogates) in the string, when reading in encodingSize byte chunks they will never register as null (as they will have bits set on those bytes)
            if (encoding = "utf-16" || encoding = "cp1200")
                encodingSize := 2, charType := "UShort", loopCount := 2
            else encodingSize := 1, charType := "Char", loopCount := 4
            Loop
            {   ; Lets save a few reads by reading in 4 byte chunks
                if !DllCall("ReadProcessMemory", "Ptr", this.hProcess, "Ptr", address + ((outterIndex := A_index) - 1) * 4, "Ptr", &buffer, "Ptr", 4, "Ptr", this.pNumberOfBytesRead) || ErrorLevel
                    return "", this.ReadStringLastError := True
                else loop, %loopCount%
                {
                    if NumGet(buffer, (A_Index - 1) * encodingSize, charType) = 0 ; NULL terminator
                    {
                        if (bufferSize < sizeBytes := outterIndex * 4 - (4 - A_Index * encodingSize))
                            VarSetCapacity(buffer, sizeBytes)
                        break, 2
                    }
                }
            }
        }
        if DllCall("ReadProcessMemory", "Ptr", this.hProcess, "Ptr", address, "Ptr", &buffer, "Ptr", sizeBytes, "Ptr", this.pNumberOfBytesRead)
            return StrGet(&buffer,, encoding)
        return "", this.ReadStringLastError := True
    }

    ; Method:  writeString(address, string, encoding := "utf-8", aOffsets*)
    ;          Encodes and then writes a string to the process.
    ; Parameters:
    ;       address -   The memory address to which data will be written or if using the offset parameter,
    ;                   the base address of the pointer.
    ;       string -    The string to be written.
    ;       encoding -  This refers to how the string is to be stored in the program's memory.
    ;                   UTF-8 and UTF-16 are common. Refer to the AHK manual for other encoding types.
    ;       aOffsets* - A variadic list of offsets. When using offsets the address parameter should equal the base address of the pointer.
    ;                   The address (base address) and offsets should point to the memory address which is to be written to.
    ; Return Values:
    ;       Non Zero -   Indicates success.
    ;       Zero     -   Indicates failure. Check errorLevel and A_LastError for more information
    ; Notes:
    ;       By default a null terminator is included at the end of written strings.
    ;       This behaviour is determined by the property [derivedObject].insertNullTerminator
    ;       If this property is true, then a null terminator will be included.

    writeString(address, string, encoding := "utf-8", aOffsets*)
    {
        encodingSize := (encoding = "utf-16" || encoding = "cp1200") ? 2 : 1
        requiredSize := StrPut(string, encoding) * encodingSize - (this.insertNullTerminator ? 0 : encodingSize)
        VarSetCapacity(buffer, requiredSize)
        StrPut(string, &buffer, StrLen(string) + (this.insertNullTerminator ?  1 : 0), encoding)
        return DllCall("WriteProcessMemory", "Ptr", this.hProcess, "Ptr", aOffsets.maxIndex() ? this.getAddressFromOffsets(address, aOffsets*) : address, "Ptr", &buffer, "Ptr", requiredSize, "Ptr", this.pNumberOfBytesWritten)
    }

    ; Method:   write(address, value, type := "Uint", aOffsets*)
    ;           Writes various integer type values to the process.
    ; Parameters:
    ;       address -   The memory address to which data will be written or if using the offset parameter,
    ;                   the base address of the pointer.
    ;       type    -   The integer type.
    ;                   Valid types are UChar, Char, UShort, Short, UInt, Int, Float, Int64 and Double.
    ;                   Note: Types must not contain spaces i.e. " UInt" or "UInt " will not work.
    ;                   When an invalid type is passed the method returns NULL and sets ErrorLevel to -2
    ;       aOffsets* - A variadic list of offsets. When using offsets the address parameter should equal the base address of the pointer.
    ;                   The address (base address) and offsets should point to the memory address which is to be written to.
    ; Return Values:
    ;       Non Zero -  Indicates success.
    ;       Zero     -  Indicates failure. Check errorLevel and A_LastError for more information
    ;       Null    -   An invalid type was passed. Errorlevel is set to -2

    write(address, value, type := "Uint", aOffsets*)
    {
        if !this.aTypeSize.hasKey(type)
            return "", ErrorLevel := -2
        return DllCall("WriteProcessMemory", "Ptr", this.hProcess, "Ptr", aOffsets.maxIndex() ? this.getAddressFromOffsets(address, aOffsets*) : address, type "*", value, "Ptr", this.aTypeSize[type], "Ptr", this.pNumberOfBytesWritten)
    }

    ; Method:   writeRaw(address, pBuffer, sizeBytes, aOffsets*)
    ;           Writes a buffer to the process.
    ; Parameters:
    ;   address -       The memory address to which the contents of the buffer will be written
    ;                   or if using the offset parameter, the base address of the pointer.
    ;   pBuffer -       A pointer to the buffer which is to be written.
    ;                   This does not necessarily have to be the beginning of the buffer itself e.g. pBuffer := &buffer + offset
    ;   sizeBytes -     The number of bytes which are to be written from the buffer.
    ;   aOffsets* -     A variadic list of offsets. When using offsets the address parameter should equal the base address of the pointer.
    ;                   The address (base address) and offsets should point to the memory address which is to be written to.
    ; Return Values:
    ;       Non Zero -  Indicates success.
    ;       Zero     -  Indicates failure. Check errorLevel and A_LastError for more information

    writeRaw(address, pBuffer, sizeBytes, aOffsets*)
    {
        return DllCall("WriteProcessMemory", "Ptr", this.hProcess, "Ptr", aOffsets.maxIndex() ? this.getAddressFromOffsets(address, aOffsets*) : address, "Ptr", pBuffer, "Ptr", sizeBytes, "Ptr", this.pNumberOfBytesWritten)
    }

    ; Method:   writeBytes(address, hexStringOrByteArray, aOffsets*)
    ;           Writes a sequence of byte values to the process.
    ; Parameters:
    ;   address -       The memory address to where the bytes will be written
    ;                   or if using the offset parameter, the base address of the pointer.
    ;   hexStringOrByteArray -  This can either be either a string (A) or an object/array (B) containing the values to be written.
    ;
    ;               A) HexString -      A string of hex bytes.  The '0x' hex prefix is optional.
    ;                                   Bytes can optionally be separated using the space or tab characters.
    ;                                   Each byte must be two characters in length i.e. '04' or '0x04' (not '4' or '0x4')
    ;               B) Object/Array -   An array containing hex or decimal byte values e.g. array := [10, 29, 0xA]
    ;
    ;   aOffsets* -     A variadic list of offsets. When using offsets the address parameter should equal the base address of the pointer.
    ;                   The address (base address) and offsets should point to the memory address which is to be written to.
    ; Return Values:
    ;       -1, -2, -3, -4  - Error with the hexstring. Refer to hexStringToPattern() for details.
    ;       Other Non Zero  - Indicates success.
    ;       Zero            - Indicates write failure. Check errorLevel and A_LastError for more information
    ;
    ;   Examples:
    ;                   writeBytes(0xAABBCC11, "DEADBEEF")          ; Writes the bytes DE AD BE EF starting at address  0xAABBCC11
    ;                   writeBytes(0xAABBCC11, [10, 20, 0xA, 2])

    writeBytes(address, hexStringOrByteArray, aOffsets*)
    {
        if !IsObject(hexStringOrByteArray)
        {
            if !IsObject(hexStringOrByteArray := this.hexStringToPattern(hexStringOrByteArray))
                return hexStringOrByteArray
        }
        sizeBytes := this.getNeedleFromAOBPattern("", buffer, hexStringOrByteArray*)
        return this.writeRaw(address, &buffer, sizeBytes, aOffsets*)
    }

    ; Method:           pointer(address, finalType := "UInt", offsets*)
    ;                   This is an internal method. Since the other various methods all offer this functionality, they should be used instead.
    ;                   This will read integer values of both pointers and non-pointers (i.e. a single memory address)
    ; Parameters:
    ;   address -       The base address of the pointer or the memory address for a non-pointer.
    ;   finalType -     The type of integer stored at the final address.
    ;                   Valid types are UChar, Char, UShort, Short, UInt, Int, Float, Int64 and Double.
    ;                   Note: Types must not contain spaces i.e. " UInt" or "UInt " will not work.
    ;                   When an invalid type is passed the method returns NULL and sets ErrorLevel to -2
    ;   aOffsets* -     A variadic list of offsets used to calculate the pointers final address.
    ; Return Values: (The same as the read() method)
    ;       integer -   Indicates success.
    ;       Null    -   Indicates failure. Check ErrorLevel and A_LastError for more information.
    ;       Note:       Since the returned integer value may be 0, to check for success/failure compare the result
    ;                   against null i.e. if (result = "") then an error has occurred.
    ;                   If the target application is 64bit the pointers are read as an 8 byte Int64 (this.PtrType)

    pointer(address, finalType := "UInt", offsets*)
    {
        For index, offset in offsets
            address := this.Read(address, this.ptrType) + offset
        Return this.Read(address, finalType)
    }

    ; Method:               getAddressFromOffsets(address, aOffsets*)
    ;                       Returns the final address of a pointer.
    ;                       This is an internal method used by various methods however, this method may be useful if you are
    ;                       looking to eliminate the overhead overhead associated with reading pointers which only change
    ;                       on startup or map/level change. In other words you can cache the final address and
    ;                       read from this address directly.
    ; Parameters:
    ;   address             The base address of the pointer.
    ;   aOffsets*           A variadic list of offsets used to calculate the pointers final address.
    ;                       At least one offset must be present.
    ; Return Values:
    ;   Positive integer    The final memory address pointed to by the pointer.
    ;   Negative integer    Failure
    ;   Null                Failure
    ; Note:                 If the target application is 64bit the pointers are read as an 8 byte Int64 (this.PtrType)

    getAddressFromOffsets(address, aOffsets*)
    {
        return  aOffsets.Remove() + this.pointer(address, this.ptrType, aOffsets*) ; remove the highest key so can use pointer() to find final memory address (minus the last offset)
    }

    ; Interesting note:
    ; Although handles are 64-bit pointers, only the less significant 32 bits are employed in them for the purpose
    ; of better compatibility (for example, to enable 32-bit and 64-bit processes interact with each other)
    ; Here are examples of such types: HANDLE, HWND, HMENU, HPALETTE, HBITMAP, etc.
    ; http://www.viva64.com/en/k/0005/



    ; Method:   getProcessBaseAddress(WindowTitle, windowMatchMode := 3)
    ;           Returns the base address of a process. In most cases this will provide the same result as calling getModuleBaseAddress() (when passing
    ;           a null value as the module parameter), however getProcessBaseAddress() will usually work regardless of the bitness
    ;           of both the AHK exe and the target process.
    ;           *This method relies on the target process having a window and will not work for console apps*
    ;           *'DetectHiddenWindows, On' is required for hidden windows*
    ;           ***If this returns an incorrect value, try using (the MORE RELIABLE) getModuleBaseAddress() instead.***
    ; Parameters:
    ;   windowTitle         This can be any AHK windowTitle identifier, such as
    ;                       ahk_exe, ahk_class, ahk_pid, or simply the window title. e.g. "ahk_exe calc.exe" or "Calculator".
    ;                       It's safer not to use the window title, as some things can have the same window title e.g. an open folder called "Starcraft II"
    ;                       would have the same window title as the game itself.
    ;   windowMatchMode     Determines the matching mode used when finding the program's window (windowTitle).
    ;                       The default value is 3 i.e. an exact match. The current matchmode will be used if the parameter is null or 0.
    ;                       Refer to AHK's setTitleMathMode for more information.
    ; Return Values:
    ;   Positive integer    The base address of the process (success).
    ;   Null                The process's window couldn't be found.
    ;   0                   The GetWindowLong or GetWindowLongPtr call failed. Try getModuleBaseAddress() instead.


    getProcessBaseAddress(windowTitle, windowMatchMode := "3")
    {
        if (windowMatchMode && A_TitleMatchMode != windowMatchMode)
        {
            mode := A_TitleMatchMode ; This is a string and will not contain the 0x prefix
            StringReplace, windowMatchMode, windowMatchMode, 0x ; remove hex prefix as SetTitleMatchMode will throw a run time error. This will occur if integer mode is set to hex and matchmode param is passed as an number not a string.
            SetTitleMatchMode, %windowMatchMode%    ;mode 3 is an exact match
        }
        WinGet, hWnd, ID, %WindowTitle%
        if mode
            SetTitleMatchMode, %mode%    ; In case executed in autoexec
        if !hWnd
            return ; return blank failed to find window
       ; GetWindowLong returns a Long (Int) and GetWindowLongPtr return a Long_Ptr
        return DllCall(A_PtrSize = 4     ; If DLL call fails, returned value will = 0
            ? "GetWindowLong"
            : "GetWindowLongPtr"
            , "Ptr", hWnd, "Int", -6, A_Is64bitOS ? "Int64" : "UInt")
            ; For the returned value when the OS is 64 bit use Int64 to prevent negative overflow when AHK is 32 bit and target process is 64bit
            ; however if the OS is 32 bit, must use UInt, otherwise the number will be huge (however it will still work as the lower 4 bytes are correct)
            ; Note - it's the OS bitness which matters here, not the scripts/AHKs
    }

    ; http://winprogger.com/getmodulefilenameex-enumprocessmodulesex-failures-in-wow64/
    ; http://stackoverflow.com/questions/3801517/how-to-enum-modules-in-a-64bit-process-from-a-32bit-wow-process

    ; Method:            getModuleBaseAddress(module := "", byRef aModuleInfo := "")
    ; Parameters:
    ;   moduleName -    The file name of the module/dll to find e.g. "calc.exe", "GDI32.dll", "Bass.dll" etc
    ;                   If no module (null) is specified, the address of the base module - main()/process will be returned
    ;                   e.g. for calc.exe the following two method calls are equivalent getModuleBaseAddress() and getModuleBaseAddress("calc.exe")
    ;   aModuleInfo -   (Optional) A module Info object is returned in this variable. If method fails this variable is made blank.
    ;                   This object contains the keys: name, fileName, lpBaseOfDll, SizeOfImage, and EntryPoint
    ; Return Values:
    ;   Positive integer - The module's base/load address (success).
    ;   -1 - Module not found
    ;   -3 - EnumProcessModulesEx failed
    ;   -4 - The AHK script is 32 bit and you are trying to access the modules of a 64 bit target process. Or the target process has been closed.
    ; Notes:    A 64 bit AHK can enumerate the modules of a target 64 or 32 bit process.
    ;           A 32 bit AHK can only enumerate the modules of a 32 bit process
    ;           This method requires PROCESS_QUERY_INFORMATION + PROCESS_VM_READ access rights. These are included by default with this class.

    getModuleBaseAddress(moduleName := "", byRef aModuleInfo := "")
    {
        aModuleInfo := ""
        if (moduleName = "")
            moduleName := this.GetModuleFileNameEx(0, True) ; main executable module of the process - get just fileName no path
        if r := this.getModules(aModules, True) < 0
            return r ; -4, -3
        return aModules.HasKey(moduleName) ? (aModules[moduleName].lpBaseOfDll, aModuleInfo := aModules[moduleName]) : -1
        ; no longer returns -5 for failed to get module info
    }


    ; Method:                   getModuleFromAddress(address, byRef aModuleInfo)
    ;                           Finds the module in which the address resides.
    ; Parameters:
    ;   address                 The address of interest.
    ;
    ;   aModuleInfo             (Optional) An unquoted variable name. If the module associated with the address is found,
    ;                           a moduleInfo object will be stored in this variable. This object has the
    ;                           following keys: name, fileName, lpBaseOfDll, SizeOfImage, and EntryPoint.
    ;                           If the address is not found to reside inside a module, the passed variable is
    ;                           made blank/null.
    ;   offsetFromModuleBase    (Optional) Stores the relative offset from the module base address
    ;                           to the specified address. If the method fails then the passed variable is set to blank/empty.
    ; Return Values:
    ;   1                       Success - The address is contained within a module.
    ;   -1                      The specified address does not reside within a loaded module.
    ;   -3                      EnumProcessModulesEx failed.
    ;   -4                      The AHK script is 32 bit and you are trying to access the modules of a 64 bit target process.

    getModuleFromAddress(address, byRef aModuleInfo, byRef offsetFromModuleBase := "")
    {
        aModuleInfo := offsetFromModule := ""
        if result := this.getmodules(aModules) < 0
            return result ; error -3, -4
        for k, module in aModules
        {
            if (address >= module.lpBaseOfDll && address < module.lpBaseOfDll + module.SizeOfImage)
                return 1, aModuleInfo := module, offsetFromModuleBase := address - module.lpBaseOfDll
        }
        return -1
    }

    ; SeDebugPrivileges is required to read/write memory in some programs.
    ; This only needs to be called once when the script starts,
    ; regardless of the number of programs being read (or if the target programs restart)
    ; Call this before attempting to call any other methods in this class
    ; i.e. call _ClassMemory.setSeDebugPrivilege() at the very start of the script.

    setSeDebugPrivilege(enable := True)
    {
        h := DllCall("OpenProcess", "UInt", 0x0400, "Int", false, "UInt", DllCall("GetCurrentProcessId"), "Ptr")
        ; Open an adjustable access token with this process (TOKEN_ADJUST_PRIVILEGES = 32)
        DllCall("Advapi32.dll\OpenProcessToken", "Ptr", h, "UInt", 32, "PtrP", t)
        VarSetCapacity(ti, 16, 0)  ; structure of privileges
        NumPut(1, ti, 0, "UInt")  ; one entry in the privileges array...
        ; Retrieves the locally unique identifier of the debug privilege:
        DllCall("Advapi32.dll\LookupPrivilegeValue", "Ptr", 0, "Str", "SeDebugPrivilege", "Int64P", luid)
        NumPut(luid, ti, 4, "Int64")
        if enable
            NumPut(2, ti, 12, "UInt")  ; enable this privilege: SE_PRIVILEGE_ENABLED = 2
        ; Update the privileges of this process with the new access token:
        r := DllCall("Advapi32.dll\AdjustTokenPrivileges", "Ptr", t, "Int", false, "Ptr", &ti, "UInt", 0, "Ptr", 0, "Ptr", 0)
        DllCall("CloseHandle", "Ptr", t)  ; close this access token handle to save memory
        DllCall("CloseHandle", "Ptr", h)  ; close this process handle to save memory
        return r
    }


    ; Method:  isTargetProcess64Bit(PID, hProcess := "", currentHandleAccess := "")
    ;          Determines if a process is 64 bit.
    ; Parameters:
    ;   PID                     The Process ID of the target process. If required this is used to open a temporary process handle.
    ;   hProcess                (Optional) A handle to the process, as returned by openProcess() i.e. [derivedObject].hProcess
    ;   currentHandleAccess     (Optional) The dwDesiredAccess value used when opening the process handle which has been
    ;                           passed as the hProcess parameter. If specifying hProcess, you should also specify this value.
    ; Return Values:
    ;   True    The target application is 64 bit.
    ;   False   The target application is 32 bit.
    ;   Null    The method failed.
    ; Notes:
    ;   This is an internal method which is called when the new operator is used. It is used to set the pointer type for 32/64 bit applications so the pointer methods will work.
    ;   This operation requires a handle with PROCESS_QUERY_INFORMATION or PROCESS_QUERY_LIMITED_INFORMATION access rights.
    ;   If the currentHandleAccess parameter does not contain these rights (or not passed) or if the hProcess (process handle) is invalid (or not passed)
    ;   a temporary handle is opened to perform this operation. Otherwise if hProcess and currentHandleAccess appear valid
    ;   the passed hProcess is used to perform the operation.

    isTargetProcess64Bit(PID, hProcess := "", currentHandleAccess := "")
    {
        if !A_Is64bitOS
            return False
        ; If insufficient rights, open a temporary handle
        else if !hProcess || !(currentHandleAccess & (this.aRights.PROCESS_QUERY_INFORMATION | this.aRights.PROCESS_QUERY_LIMITED_INFORMATION))
            closeHandle := hProcess := this.openProcess(PID, this.aRights.PROCESS_QUERY_INFORMATION)
        if (hProcess && DllCall("IsWow64Process", "Ptr", hProcess, "Int*", Wow64Process))
            result := !Wow64Process
        return result, closeHandle ? this.CloseHandle(hProcess) : ""
    }
    /*
        _Out_  PBOOL Wow64Proces value set to:
        True if the process is running under WOW64 - 32bit app on 64bit OS.
        False if the process is running under 32-bit Windows!
        False if the process is a 64-bit application running under 64-bit Windows.
    */

    ; Method: suspend() / resume()
    ; Notes:
    ;   These are undocumented Windows functions which suspend and resume the process. Here be dragons.
    ;   The process handle must have PROCESS_SUSPEND_RESUME access rights.
    ;   That is, you must specify this when using the new operator, as it is not included.
    ;   Some people say it requires more rights and just use PROCESS_ALL_ACCESS, however PROCESS_SUSPEND_RESUME has worked for me.
    ;   Suspending a process manually can be quite helpful when reversing memory addresses and pointers, although it's not at all required.
    ;   As an unorthodox example, memory addresses holding pointers are often stored in a slightly obfuscated manner i.e. they require bit operations to calculate their
    ;   true stored value (address). This obfuscation can prevent Cheat Engine from finding the true origin of a pointer or links to other memory regions. If there
    ;   are no static addresses between the obfuscated address and the final destination address then CE wont find anything (there are ways around this in CE). One way around this is to
    ;   suspend the process, write the true/deobfuscated value to the address and then perform your scans. Afterwards write back the original values and resume the process.

    suspend()
    {
        return DllCall("ntdll\NtSuspendProcess", "Ptr", this.hProcess)
    }

    resume()
    {
        return DllCall("ntdll\NtResumeProcess", "Ptr", this.hProcess)
    }

    ; Method:               getModules(byRef aModules, useFileNameAsKey := False)
    ;                       Stores the process's loaded modules as an array of (object) modules in the aModules parameter.
    ; Parameters:
    ;   aModules            An unquoted variable name. The loaded modules of the process are stored in this variable as an array of objects.
    ;                       Each object in this array has the following keys: name, fileName, lpBaseOfDll, SizeOfImage, and EntryPoint.
    ;   useFileNameAsKey    When true, the file name e.g. GDI32.dll is used as the lookup key for each module object.
    ; Return Values:
    ;   Positive integer    The size of the aModules array. (Success)
    ;   -3                  EnumProcessModulesEx failed.
    ;   -4                  The AHK script is 32 bit and you are trying to access the modules of a 64 bit target process.

    getModules(byRef aModules, useFileNameAsKey := False)
    {
        if (A_PtrSize = 4 && this.IsTarget64bit)
            return -4 ; AHK is 32bit and target process is 64 bit, this function wont work
        aModules := []
        if !moduleCount := this.EnumProcessModulesEx(lphModule)
            return -3
        loop % moduleCount
        {
            this.GetModuleInformation(hModule := numget(lphModule, (A_index - 1) * A_PtrSize), aModuleInfo)
            aModuleInfo.Name := this.GetModuleFileNameEx(hModule)
            filePath := aModuleInfo.name
            SplitPath, filePath, fileName
            aModuleInfo.fileName := fileName
            if useFileNameAsKey
                aModules[fileName] := aModuleInfo
            else aModules.insert(aModuleInfo)
        }
        return moduleCount
    }



    getEndAddressOfLastModule(byRef aModuleInfo := "")
    {
        if !moduleCount := this.EnumProcessModulesEx(lphModule)
            return -3
        hModule := numget(lphModule, (moduleCount - 1) * A_PtrSize)
        if this.GetModuleInformation(hModule, aModuleInfo)
            return aModuleInfo.lpBaseOfDll + aModuleInfo.SizeOfImage
        return -5
    }

    ; lpFilename [out]
    ; A pointer to a buffer that receives the fully qualified path to the module.
    ; If the size of the file name is larger than the value of the nSize parameter, the function succeeds
    ; but the file name is truncated and null-terminated.
    ; If the buffer is adequate the string is still null terminated.

    GetModuleFileNameEx(hModule := 0, fileNameNoPath := False)
    {
        ; ANSI MAX_PATH = 260 (includes null) - unicode can be ~32K.... but no one would ever have one that size
        ; So just give it a massive size and don't bother checking. Most coders just give it MAX_PATH size anyway
        VarSetCapacity(lpFilename, 2048 * (A_IsUnicode ? 2 : 1))
        DllCall("psapi\GetModuleFileNameEx"
                    , "Ptr", this.hProcess
                    , "Ptr", hModule
                    , "Str", lpFilename
                    , "Uint", 2048 / (A_IsUnicode ? 2 : 1))
        if fileNameNoPath
            SplitPath, lpFilename, lpFilename ; strips the path so = GDI32.dll

        return lpFilename
    }

    ; dwFilterFlag
    ;   LIST_MODULES_DEFAULT    0x0
    ;   LIST_MODULES_32BIT      0x01
    ;   LIST_MODULES_64BIT      0x02
    ;   LIST_MODULES_ALL        0x03
    ; If the function is called by a 32-bit application running under WOW64, the dwFilterFlag option
    ; is ignored and the function provides the same results as the EnumProcessModules function.
    EnumProcessModulesEx(byRef lphModule, dwFilterFlag := 0x03)
    {
        lastError := A_LastError
        size := VarSetCapacity(lphModule, 4)
        loop
        {
            DllCall("psapi\EnumProcessModulesEx"
                        , "Ptr", this.hProcess
                        , "Ptr", &lphModule
                        , "Uint", size
                        , "Uint*", reqSize
                        , "Uint", dwFilterFlag)
            if ErrorLevel
                return 0
            else if (size >= reqSize)
                break
            else size := VarSetCapacity(lphModule, reqSize)
        }
        ; On first loop it fails with A_lastError = 0x299 as its meant to
        ; might as well reset it to its previous version
        DllCall("SetLastError", "UInt", lastError)
        return reqSize // A_PtrSize ; module count  ; sizeof(HMODULE) - enumerate the array of HMODULEs
    }

    GetModuleInformation(hModule, byRef aModuleInfo)
    {
        VarSetCapacity(MODULEINFO, A_PtrSize * 3), aModuleInfo := []
        return DllCall("psapi\GetModuleInformation"
                    , "Ptr", this.hProcess
                    , "Ptr", hModule
                    , "Ptr", &MODULEINFO
                    , "UInt", A_PtrSize * 3)
                , aModuleInfo := {  lpBaseOfDll: numget(MODULEINFO, 0, "Ptr")
                                ,   SizeOfImage: numget(MODULEINFO, A_PtrSize, "UInt")
                                ,   EntryPoint: numget(MODULEINFO, A_PtrSize * 2, "Ptr") }
    }

    ; Method:           hexStringToPattern(hexString)
    ;                   Converts the hex string parameter into an array of bytes pattern (AOBPattern) that
    ;                   can be passed to the various pattern scan methods i.e.  modulePatternScan(), addressPatternScan(), rawPatternScan(), and processPatternScan()
    ;
    ; Parameters:
    ;   hexString -     A string of hex bytes.  The '0x' hex prefix is optional.
    ;                   Bytes can optionally be separated using the space or tab characters.
    ;                   Each byte must be two characters in length i.e. '04' or '0x04' (not '4' or '0x4')
    ;                   ** Unlike the other methods, wild card bytes MUST be denoted using '??' (two question marks)**
    ;
    ; Return Values:
    ;   Object          Success - The returned object contains the AOB pattern.
    ;   -1              An empty string was passed.
    ;   -2              Non hex character present.  Acceptable characters are A-F, a-F, 0-9, ?, space, tab, and 0x (hex prefix).
    ;   -3              Non-even wild card character count. One of the wild card bytes is missing a '?' e.g. '?' instead of '??'.
    ;   -4              Non-even character count. One of the hex bytes is probably missing a character e.g. '4' instead of '04'.
    ;
    ;   Examples:
    ;                   pattern := hexStringToPattern("DEADBEEF02")
    ;                   pattern := hexStringToPattern("0xDE0xAD0xBE0xEF0x02")
    ;                   pattern := hexStringToPattern("DE AD BE EF 02")
    ;                   pattern := hexStringToPattern("0xDE 0xAD 0xBE 0xEF 0x02")
    ;
    ;                   This will mark the third byte as wild:
    ;                   pattern := hexStringToPattern("DE AD ?? EF 02")
    ;                   pattern := hexStringToPattern("0xDE 0xAD ?? 0xEF 0x02")
    ;
    ;                   The returned pattern can then be passed to the various pattern scan methods, for example:
    ;                   pattern := hexStringToPattern("DE AD BE EF 02")
    ;                   memObject.processPatternScan(,, pattern*)   ; Note the '*'

    hexStringToPattern(hexString)
    {
        AOBPattern := []
        hexString := RegExReplace(hexString, "(\s|0x)")
        StringReplace, hexString, hexString, ?, ?, UseErrorLevel
        wildCardCount := ErrorLevel

        if !length := StrLen(hexString)
            return -1 ; no str
        else if RegExMatch(hexString, "[^0-9a-fA-F?]")
            return -2 ; non hex character and not a wild card
        else if Mod(wildCardCount, 2)
            return -3 ; non-even wild card character count
        else if Mod(length, 2)
            return -4 ; non-even character count
        loop, % length/2
        {
            value := "0x" SubStr(hexString, 1 + 2 * (A_index-1), 2)
            AOBPattern.Insert(value + 0 = "" ? "?" : value)
        }
        return AOBPattern
    }

    ; Method:           stringToPattern(string, encoding := "UTF-8", insertNullTerminator := False)
    ;                   Converts a text string parameter into an array of bytes pattern (AOBPattern) that
    ;                   can be passed to the various pattern scan methods i.e.  modulePatternScan(), addressPatternScan(), rawPatternScan(), and processPatternScan()
    ;
    ; Parameters:
    ;   string                  The text string to convert.
    ;   encoding                This refers to how the string is stored in the program's memory.
    ;                           UTF-8 and UTF-16 are common. Refer to the AHK manual for other encoding types.
    ;   insertNullTerminator    Includes the null terminating byte(s) (at the end of the string) in the AOB pattern.
    ;                           This should be set to 'false' unless you are certain that the target string is null terminated and you are searching for the entire string or the final part of the string.
    ;
    ; Return Values:
    ;   Object          Success - The returned object contains the AOB pattern.
    ;   -1              An empty string was passed.
    ;
    ;   Examples:
    ;                   pattern := stringToPattern("This text exists somewhere in the target program!")
    ;                   memObject.processPatternScan(,, pattern*)   ; Note the '*'

    stringToPattern(string, encoding := "UTF-8", insertNullTerminator := False)
    {
        if !length := StrLen(string)
            return -1 ; no str
        AOBPattern := []
        encodingSize := (encoding = "utf-16" || encoding = "cp1200") ? 2 : 1
        requiredSize := StrPut(string, encoding) * encodingSize - (insertNullTerminator ? 0 : encodingSize)
        VarSetCapacity(buffer, requiredSize)
        StrPut(string, &buffer, length + (insertNullTerminator ?  1 : 0), encoding)
        loop, % requiredSize
            AOBPattern.Insert(NumGet(buffer, A_Index-1, "UChar"))
        return AOBPattern
    }


    ; Method:           modulePatternScan(module := "", aAOBPattern*)
    ;                   Scans the specified module for the specified array of bytes
    ; Parameters:
    ;   module -        The file name of the module/dll to search e.g. "calc.exe", "GDI32.dll", "Bass.dll" etc
    ;                   If no module (null) is specified, the executable file of the process will be used.
    ;                   e.g. for calc.exe it would be the same as calling modulePatternScan(, aAOBPattern*) or modulePatternScan("calc.exe", aAOBPattern*)
    ;   aAOBPattern*    A variadic list of byte values i.e. the array of bytes to find.
    ;                   Wild card bytes should be indicated by passing a non-numeric value eg "?".
    ; Return Values:
    ;   Positive int    Success. The memory address of the found pattern.
    ;   Null            Failed to find or retrieve the specified module. ErrorLevel is set to the returned error from getModuleBaseAddress()
    ;                   refer to that method for more information.
    ;   0               The pattern was not found inside the module
    ;   -9              VirtualQueryEx() failed
    ;   -10             The aAOBPattern* is invalid. No bytes were passed

    modulePatternScan(module := "", aAOBPattern*)
    {
        MEM_COMMIT := 0x1000, MEM_MAPPED := 0x40000, MEM_PRIVATE := 0x20000
        , PAGE_NOACCESS := 0x01, PAGE_GUARD := 0x100

        if (result := this.getModuleBaseAddress(module, aModuleInfo)) <= 0
             return "", ErrorLevel := result ; failed
        if !patternSize := this.getNeedleFromAOBPattern(patternMask, AOBBuffer, aAOBPattern*)
            return -10 ; no pattern
        ; Try to read the entire module in one RPM()
        ; If fails with access (-1) iterate the modules memory pages and search the ones which are readable
        if (result := this.PatternScan(aModuleInfo.lpBaseOfDll, aModuleInfo.SizeOfImage, patternMask, AOBBuffer)) >= 0
            return result  ; Found / not found
        ; else RPM() failed lets iterate the pages
        address := aModuleInfo.lpBaseOfDll
        endAddress := address + aModuleInfo.SizeOfImage
        loop
        {
            if !this.VirtualQueryEx(address, aRegion)
                return -9
            if (aRegion.State = MEM_COMMIT
            && !(aRegion.Protect & (PAGE_NOACCESS | PAGE_GUARD)) ; can't read these areas
            ;&& (aRegion.Type = MEM_MAPPED || aRegion.Type = MEM_PRIVATE) ;Might as well read Image sections as well
            && aRegion.RegionSize >= patternSize
            && (result := this.PatternScan(address, aRegion.RegionSize, patternMask, AOBBuffer)) > 0)
                return result
        } until (address += aRegion.RegionSize) >= endAddress
        return 0
    }

    ; Method:               addressPatternScan(startAddress, sizeOfRegionBytes, aAOBPattern*)
    ;                       Scans a specified memory region for an array of bytes pattern.
    ;                       The entire memory area specified must be readable for this method to work,
    ;                       i.e. you must ensure the area is readable before calling this method.
    ; Parameters:
    ;   startAddress        The memory address from which to begin the search.
    ;   sizeOfRegionBytes   The numbers of bytes to scan in the memory region.
    ;   aAOBPattern*        A variadic list of byte values i.e. the array of bytes to find.
    ;                       Wild card bytes should be indicated by passing a non-numeric value eg "?".
    ; Return Values:
    ;   Positive integer    Success. The memory address of the found pattern.
    ;   0                   Pattern not found
    ;   -1                  Failed to read the memory region.
    ;   -10                 An aAOBPattern pattern. No bytes were passed.

    addressPatternScan(startAddress, sizeOfRegionBytes, aAOBPattern*)
    {
        if !this.getNeedleFromAOBPattern(patternMask, AOBBuffer, aAOBPattern*)
            return -10
        return this.PatternScan(startAddress, sizeOfRegionBytes, patternMask, AOBBuffer)
    }

    ; Method:       processPatternScan(startAddress := 0, endAddress := "", aAOBPattern*)
    ;               Scan the memory space of the current process for an array of bytes pattern.
    ;               To use this in a loop (scanning for multiple occurrences of the same pattern),
    ;               simply call it again passing the last found address + 1 as the startAddress.
    ; Parameters:
    ;   startAddress -      The memory address from which to begin the search.
    ;   endAddress -        The memory address at which the search ends.
    ;                       Defaults to 0x7FFFFFFF for 32 bit target processes.
    ;                       Defaults to 0xFFFFFFFF for 64 bit target processes when the AHK script is 32 bit.
    ;                       Defaults to 0x7FFFFFFFFFF for 64 bit target processes when the AHK script is 64 bit.
    ;                       0x7FFFFFFF and 0x7FFFFFFFFFF are the maximum process usable virtual address spaces for 32 and 64 bit applications.
    ;                       Anything higher is used by the system (unless /LARGEADDRESSAWARE and 4GT have been modified).
    ;                       Note: The entire pattern must be occur inside this range for a match to be found. The range is inclusive.
    ;   aAOBPattern* -      A variadic list of byte values i.e. the array of bytes to find.
    ;                       Wild card bytes should be indicated by passing a non-numeric value eg "?".
    ; Return Values:
    ;   Positive integer -  Success. The memory address of the found pattern.
    ;   0                   The pattern was not found.
    ;   -1                  VirtualQueryEx() failed.
    ;   -2                  Failed to read a memory region.
    ;   -10                 The aAOBPattern* is invalid. (No bytes were passed)

    processPatternScan(startAddress := 0, endAddress := "", aAOBPattern*)
    {
        address := startAddress
        if endAddress is not integer
            endAddress := this.isTarget64bit ? (A_PtrSize = 8 ? 0x7FFFFFFFFFF : 0xFFFFFFFF) : 0x7FFFFFFF

        MEM_COMMIT := 0x1000, MEM_MAPPED := 0x40000, MEM_PRIVATE := 0x20000
        PAGE_NOACCESS := 0x01, PAGE_GUARD := 0x100
        if !patternSize := this.getNeedleFromAOBPattern(patternMask, AOBBuffer, aAOBPattern*)
            return -10
        while address <= endAddress ; > 0x7FFFFFFF - definitely reached the end of the useful area (at least for a 32 target process)
        {
            if !this.VirtualQueryEx(address, aInfo)
                return -1
            if A_Index = 1
                aInfo.RegionSize -= address - aInfo.BaseAddress
            if (aInfo.State = MEM_COMMIT)
            && !(aInfo.Protect & (PAGE_NOACCESS | PAGE_GUARD)) ; can't read these areas
            ;&& (aInfo.Type = MEM_MAPPED || aInfo.Type = MEM_PRIVATE) ;Might as well read Image sections as well
            && aInfo.RegionSize >= patternSize
            && (result := this.PatternScan(address, aInfo.RegionSize, patternMask, AOBBuffer))
            {
                if result < 0
                    return -2
                else if (result + patternSize - 1 <= endAddress)
                    return result
                else return 0
            }
            address += aInfo.RegionSize
        }
        return 0
    }

    ; Method:           rawPatternScan(byRef buffer, sizeOfBufferBytes := "", aAOBPattern*)
    ;                   Scans a binary buffer for an array of bytes pattern.
    ;                   This is useful if you have already dumped a region of memory via readRaw()
    ; Parameters:
    ;   buffer              The binary buffer to be searched.
    ;   sizeOfBufferBytes   The size of the binary buffer. If null or 0 the size is automatically retrieved.
    ;   startOffset         The offset from the start of the buffer from which to begin the search. This must be >= 0.
    ;   aAOBPattern*        A variadic list of byte values i.e. the array of bytes to find.
    ;                       Wild card bytes should be indicated by passing a non-numeric value eg "?".
    ; Return Values:
    ;   >= 0                The offset of the pattern relative to the start of the haystack.
    ;   -1                  Not found.
    ;   -2                  Parameter incorrect.

    rawPatternScan(byRef buffer, sizeOfBufferBytes := "", startOffset := 0, aAOBPattern*)
    {
        if !this.getNeedleFromAOBPattern(patternMask, AOBBuffer, aAOBPattern*)
            return -10
        if (sizeOfBufferBytes + 0 = "" || sizeOfBufferBytes <= 0)
            sizeOfBufferBytes := VarSetCapacity(buffer)
        if (startOffset + 0 = "" || startOffset < 0)
            startOffset := 0
        return this.bufferScanForMaskedPattern(&buffer, sizeOfBufferBytes, patternMask, &AOBBuffer, startOffset)
    }

    ; Method:           getNeedleFromAOBPattern(byRef patternMask, byRef needleBuffer, aAOBPattern*)
    ;                   Converts an array of bytes pattern (aAOBPattern*) into a binary needle and pattern mask string
    ;                   which are compatible with patternScan() and bufferScanForMaskedPattern().
    ;                   The modulePatternScan(), addressPatternScan(), rawPatternScan(), and processPatternScan() methods
    ;                   allow you to directly search for an array of bytes pattern in a single method call.
    ; Parameters:
    ;   patternMask -   (output) A string which indicates which bytes are wild/non-wild.
    ;   needleBuffer -  (output) The array of bytes passed via aAOBPattern* is converted to a binary needle and stored inside this variable.
    ;   aAOBPattern* -  (input) A variadic list of byte values i.e. the array of bytes from which to create the patternMask and needleBuffer.
    ;                   Wild card bytes should be indicated by passing a non-numeric value eg "?".
    ; Return Values:
    ;  The number of bytes in the binary needle and hence the number of characters in the patternMask string.

    getNeedleFromAOBPattern(byRef patternMask, byRef needleBuffer, aAOBPattern*)
    {
        patternMask := "", VarSetCapacity(needleBuffer, aAOBPattern.MaxIndex())
        for i, v in aAOBPattern
            patternMask .= (v + 0 = "" ? "?" : "x"), NumPut(round(v), needleBuffer, A_Index - 1, "UChar")
        return round(aAOBPattern.MaxIndex())
    }

    ; The handle must have been opened with the PROCESS_QUERY_INFORMATION access right
    VirtualQueryEx(address, byRef aInfo)
    {

        if (aInfo.__Class != "_ClassMemory._MEMORY_BASIC_INFORMATION")
            aInfo := new this._MEMORY_BASIC_INFORMATION()
        return aInfo.SizeOfStructure = DLLCall("VirtualQueryEx"
                                                , "Ptr", this.hProcess
                                                , "Ptr", address
                                                , "Ptr", aInfo.pStructure
                                                , "Ptr", aInfo.SizeOfStructure
                                                , "Ptr")
    }

    /*
    // The c++ function used to generate the machine code
    int scan(unsigned char* haystack, unsigned int haystackSize, unsigned char* needle, unsigned int needleSize, char* patternMask, unsigned int startOffset)
    {
        for (unsigned int i = startOffset; i <= haystackSize - needleSize; i++)
        {
            for (unsigned int j = 0; needle[j] == haystack[i + j] || patternMask[j] == '?'; j++)
            {
                if (j + 1 == needleSize)
                    return i;
            }
        }
        return -1;
    }
    */

    ; Method:               PatternScan(startAddress, sizeOfRegionBytes, patternMask, byRef needleBuffer)
    ;                       Scans a specified memory region for a binary needle pattern using a machine code function
    ;                       If found it returns the memory address of the needle in the processes memory.
    ; Parameters:
    ;   startAddress -      The memory address from which to begin the search.
    ;   sizeOfRegionBytes - The numbers of bytes to scan in the memory region.
    ;   patternMask -       This string indicates which bytes must match and which bytes are wild. Each wildcard byte must be denoted by a single '?'.
    ;                       Non wildcards can use any other single character e.g 'x'. There should be no spaces.
    ;                       With the patternMask 'xx??x', the first, second, and fifth bytes must match. The third and fourth bytes are wild.
    ;    needleBuffer -     The variable which contains the binary needle. This needle should consist of UChar bytes.
    ; Return Values:
    ;   Positive integer    The address of the pattern.
    ;   0                   Pattern not found.
    ;   -1                  Failed to read the region.

    patternScan(startAddress, sizeOfRegionBytes, byRef patternMask, byRef needleBuffer)
    {
        if !this.readRaw(startAddress, buffer, sizeOfRegionBytes)
            return -1
        if (offset := this.bufferScanForMaskedPattern(&buffer, sizeOfRegionBytes, patternMask, &needleBuffer)) >= 0
            return startAddress + offset
        else return 0
    }
    ; Method:               bufferScanForMaskedPattern(byRef hayStack, sizeOfHayStackBytes, byRef patternMask, byRef needle)
    ;                       Scans a binary haystack for binary needle against a pattern mask string using a machine code function.
    ; Parameters:
    ;   hayStackAddress -   The address of the binary haystack which is to be searched.
    ;   sizeOfHayStackBytes The total size of the haystack in bytes.
    ;   patternMask -       A string which indicates which bytes must match and which bytes are wild. Each wildcard byte must be denoted by a single '?'.
    ;                       Non wildcards can use any other single character e.g 'x'. There should be no spaces.
    ;                       With the patternMask 'xx??x', the first, second, and fifth bytes must match. The third and fourth bytes are wild.
    ;   needleAddress -     The address of the binary needle to find. This needle should consist of UChar bytes.
    ;   startOffset -       The offset from the start of the haystack from which to begin the search. This must be >= 0.
    ; Return Values:
    ;   >= 0                Found. The pattern begins at this offset - relative to the start of the haystack.
    ;   -1                  Not found.
    ;   -2                  Invalid sizeOfHayStackBytes parameter - Must be > 0.

    ; Notes:
    ;       This is a basic function with few safeguards. Incorrect parameters may crash the script.

    bufferScanForMaskedPattern(hayStackAddress, sizeOfHayStackBytes, byRef patternMask, needleAddress, startOffset := 0)
    {
        static p
        if !p
        {
            if A_PtrSize = 4
                p := this.MCode("1,x86:8B44240853558B6C24182BC5568B74242489442414573BF0773E8B7C241CBB010000008B4424242BF82BD8EB038D49008B54241403D68A0C073A0A740580383F750B8D0C033BCD74174240EBE98B442424463B74241876D85F5E5D83C8FF5BC35F8BC65E5D5BC3")
            else
                p := this.MCode("1,x64:48895C2408488974241048897C2418448B5424308BF2498BD8412BF1488BF9443BD6774A4C8B5C24280F1F800000000033C90F1F400066660F1F840000000000448BC18D4101418D4AFF03C80FB60C3941380C18740743803C183F7509413BC1741F8BC8EBDA41FFC2443BD676C283C8FF488B5C2408488B742410488B7C2418C3488B5C2408488B742410488B7C2418418BC2C3")
        }
        if (needleSize := StrLen(patternMask)) + startOffset > sizeOfHayStackBytes
            return -1 ; needle can't exist inside this region. And basic check to prevent wrap around error of the UInts in the machine function
        if (sizeOfHayStackBytes > 0)
            return DllCall(p, "Ptr", hayStackAddress, "UInt", sizeOfHayStackBytes, "Ptr", needleAddress, "UInt", needleSize, "AStr", patternMask, "UInt", startOffset, "cdecl int")
        return -2
    }

    ; Notes:
    ; Other alternatives for non-wildcard buffer comparison.
    ; Use memchr to find the first byte, then memcmp to compare the remainder of the buffer against the needle and loop if it doesn't match
    ; The function FindMagic() by Lexikos uses this method.
    ; Use scanInBuf() machine code function - but this only supports 32 bit ahk. I could check if needle contains wild card and AHK is 32bit,
    ; then call this function. But need to do a speed comparison to see the benefits, but this should be faster. Although the benefits for
    ; the size of the memory regions be dumped would most likely be inconsequential as it's already extremely fast.

    MCode(mcode)
    {
        static e := {1:4, 2:1}, c := (A_PtrSize=8) ? "x64" : "x86"
        if !regexmatch(mcode, "^([0-9]+),(" c ":|.*?," c ":)([^,]+)", m)
            return
        if !DllCall("crypt32\CryptStringToBinary", "str", m3, "uint", 0, "uint", e[m1], "ptr", 0, "uint*", s, "ptr", 0, "ptr", 0)
            return
        p := DllCall("GlobalAlloc", "uint", 0, "ptr", s, "ptr")
        ; if (c="x64") ; Virtual protect must always be enabled for both 32 and 64 bit. If DEP is set to all applications (not just systems), then this is required
        DllCall("VirtualProtect", "ptr", p, "ptr", s, "uint", 0x40, "uint*", op)
        if DllCall("crypt32\CryptStringToBinary", "str", m3, "uint", 0, "uint", e[m1], "ptr", p, "uint*", s, "ptr", 0, "ptr", 0)
            return p
        DllCall("GlobalFree", "ptr", p)
        return
    }

    ; This link indicates that the _MEMORY_BASIC_INFORMATION32/64 should be based on the target process
    ; http://stackoverflow.com/questions/20068219/readprocessmemory-on-a-64-bit-proces-always-returns-error-299
    ; The msdn documentation is unclear, and suggests that a debugger can pass either structure - perhaps there is some other step involved.
    ; My tests seem to indicate that you must pass _MEMORY_BASIC_INFORMATION i.e. structure is relative to the AHK script bitness.
    ; Another post on the net also agrees with my results.

    ; Notes:
    ; A 64 bit AHK script can call this on a target 64 bit process. Issues may arise at extremely high memory addresses as AHK does not support UInt64 (but these addresses should never be used anyway).
    ; A 64 bit AHK can call this on a 32 bit target and it should work.
    ; A 32 bit AHk script can call this on a 64 bit target and it should work providing the addresses fall inside the 32 bit range.

    class _MEMORY_BASIC_INFORMATION
    {
        __new()
        {
            if !this.pStructure := DllCall("GlobalAlloc", "UInt", 0, "Ptr", this.SizeOfStructure := A_PtrSize = 8 ? 48 : 28, "Ptr")
                return ""
            return this
        }
        __Delete()
        {
            DllCall("GlobalFree", "Ptr", this.pStructure)
        }
        ; For 64bit the int64 should really be unsigned. But AHK doesn't support these
        ; so this won't work correctly for higher memory address areas
        __get(key)
        {
            static aLookUp := A_PtrSize = 8
                                ?   {   "BaseAddress": {"Offset": 0, "Type": "Int64"}
                                    ,    "AllocationBase": {"Offset": 8, "Type": "Int64"}
                                    ,    "AllocationProtect": {"Offset": 16, "Type": "UInt"}
                                    ,    "RegionSize": {"Offset": 24, "Type": "Int64"}
                                    ,    "State": {"Offset": 32, "Type": "UInt"}
                                    ,    "Protect": {"Offset": 36, "Type": "UInt"}
                                    ,    "Type": {"Offset": 40, "Type": "UInt"} }
                                :   {  "BaseAddress": {"Offset": 0, "Type": "UInt"}
                                    ,   "AllocationBase": {"Offset": 4, "Type": "UInt"}
                                    ,   "AllocationProtect": {"Offset": 8, "Type": "UInt"}
                                    ,   "RegionSize": {"Offset": 12, "Type": "UInt"}
                                    ,   "State": {"Offset": 16, "Type": "UInt"}
                                    ,   "Protect": {"Offset": 20, "Type": "UInt"}
                                    ,   "Type": {"Offset": 24, "Type": "UInt"} }

            if aLookUp.HasKey(key)
                return numget(this.pStructure+0, aLookUp[key].Offset, aLookUp[key].Type)
        }
        __set(key, value)
        {
             static aLookUp := A_PtrSize = 8
                                ?   {   "BaseAddress": {"Offset": 0, "Type": "Int64"}
                                    ,    "AllocationBase": {"Offset": 8, "Type": "Int64"}
                                    ,    "AllocationProtect": {"Offset": 16, "Type": "UInt"}
                                    ,    "RegionSize": {"Offset": 24, "Type": "Int64"}
                                    ,    "State": {"Offset": 32, "Type": "UInt"}
                                    ,    "Protect": {"Offset": 36, "Type": "UInt"}
                                    ,    "Type": {"Offset": 40, "Type": "UInt"} }
                                :   {  "BaseAddress": {"Offset": 0, "Type": "UInt"}
                                    ,   "AllocationBase": {"Offset": 4, "Type": "UInt"}
                                    ,   "AllocationProtect": {"Offset": 8, "Type": "UInt"}
                                    ,   "RegionSize": {"Offset": 12, "Type": "UInt"}
                                    ,   "State": {"Offset": 16, "Type": "UInt"}
                                    ,   "Protect": {"Offset": 20, "Type": "UInt"}
                                    ,   "Type": {"Offset": 24, "Type": "UInt"} }

            if aLookUp.HasKey(key)
            {
                NumPut(value, this.pStructure+0, aLookUp[key].Offset, aLookUp[key].Type)
                return value
            }
        }
        Ptr()
        {
            return this.pStructure
        }
        sizeOf()
        {
            return this.SizeOfStructure
        }
    }

}