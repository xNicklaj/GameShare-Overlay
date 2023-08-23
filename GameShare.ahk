SetWorkingDir, %A_ScriptDir%
#Include Lib/Configuration.ahk
#Include Lib/WinEdit.ahk
#Include Lib/Smoothings.ahk
#Include Lib/Ini.ahk

if(!FileExist("Config.ini"))
  WriteDefaultConfig()

; Avoid changing. You can, nothing bad will happen, it's just not recommended.
ahk_id := ""
Config := ReadIniFile("Config.ini")
screen_format_consts := {"16:9": {"W":16, "H":9}, "21:9": {"W":21, "H": 9}}
screen_format := Config["Display"]["sFormat"]
Padding := 8
Delta := Config["General"]["fStepSize"]
Animation_Duration := Config["General"]["fAnimationDuration"]

LastKnownCorner := "tr"
LastKnowHeight := -1

Atoi(String){
  Number := String , Number += 0  ; convert text to number
  if Number is space
    Number := 0 ; convert empty line to 0
  return Number
}

CalculateWidth(Height){
  global screen_format_consts
  global screen_format
  global Config
  W := screen_format_consts[screen_format]["W"]
  H := screen_format_consts[screen_format]["H"]
  if W =
    W := StrSplit(screen_format, ":")[1] + 0
  if H =
    H := StrSplit(screen_format, ":")[2] + 0
  return Height / H * W
}

Minimize(ahk_id){
  global Padding
  global screen_format
  global screen_format_consts
  global Config
  global Animation_Duration
  global LastKnownCorner
  global LastKnownHeight
  


  SysGet, VirtualScreenWidth, 78
  WinHeight := 288
  if(LastKnownHeight > 0)
    WinHeight := LastKnownHeight
  WinWidth := CalculateWidth(WinHeight)
  X := VirtualScreenWidth - WinWidth - Padding
  Y := Padding

  ; WinMove, %ahk_id%, , , , %WinWidth%, %WinHeight%
  if(Config["Display"]["bUseAnimations"] == "True")
    SmoothSetWinPos(ahk_id, WinWidth, WinHeight, GetCornerCoords(WinWidth, WinHeight, LastKnownCorner, "X"), GetCornerCoords(WinWidth, WinHeight, LastKnownCorner, "Y"),Animation_Duration)
  else{
    SetWindowSize(ahk_id, WinWidth, WinHeight)
    MoveToCorner(ahk_id, LastKnownCorner)
  }
  LastKnownHeight := WinHeight
  t := Config["Display"]["fTransparency"]
  WinSet, Transparent, %t%, %ahk_id%
  return
}


Maximize(ahk_id){
  global Padding
  global Animation_Duration
  global Config

  SysGet, VirtualScreenWidth, 78
  SysGet, VirtualScreenHeight, 79
  WinWidth := VirtualScreenWidth - 2 * Padding
  WinHeight := VirtualScreenHeight - 2 * Padding
  X := Padding
  Y := Padding

  WinSet, Transparent, 255, %ahk_id%
  if(Config["Display"]["bUseAnimations"] == "True")
    SmoothSetWinPos(ahk_id, WinWidth, WinHeight, GetCornerCoords(WinWidth, WinHeight, "tl", "X"), GetCornerCoords(WinWidth, WinHeight, "tl", "Y"),Animation_Duration)
  else{
    MoveToCorner(ahk_id, "tl")
    SetWindowSize(ahk_id, WinWidth, WinHeight)
  }
  return
}

IsMaximised(ahk_id){
  global Padding

  SysGet, VirtualScreenWidth, 78
  SysGet, VirtualScreenHeight, 79
  WinWidth := VirtualScreenWidth - 2 * Padding
  WinHeight := VirtualScreenHeight - 2 * Padding

  WinGetPos , , , Width, Height, %ahk_id%
  Maximized := Floor(Width) == Floor(WinWidth) && Floor(Height) == Floor(WinHeight)
  if(Maximized){
    return True
  }
  return False
}

MoveToCorner(ahk_id, corner){
  global Padding
  global Animation_Duration
  global Config
  global LastKnownCorner

  SysGet, VirtualScreenWidth, 78
  SysGet, VirtualScreenHeight, 79
  X := 0
  Y := 0

  WinGetPos , , , Width, Height, %ahk_id%
  if(IsMaximised(ahk_id))
    return

  switch corner{
    case "tl":
      X := Padding
      Y := Padding
    case "tr":
      X := VirtualScreenWidth - Width - Padding
      Y := Padding
    case "bl":
      X := Padding
      Y := VirtualScreenHeight - Height - Padding
    case "br":
      X := VirtualScreenWidth - Width - Padding
      Y := VirtualScreenHeight - Height - Padding
    default:
      return
  }
  if(Config["Display"]["bUseAnimations"] == "True")
    SmoothMoveWindow(ahk_id, X, Y, Animation_Duration)
  Else
    MoveWindow(ahk_id, X, Y)
  LastKnownCorner := corner
  return
}

GetCornerCoords(Width, Height, corner, Coord){
  global Padding
  SysGet, VirtualScreenWidth, 78
  SysGet, VirtualScreenHeight, 79
  X := 0
  Y := 0

  switch corner{
    case "tl":
      X := Padding
      Y := Padding
    case "tr":
      X := VirtualScreenWidth - Width - Padding
      Y := Padding
    case "bl":
      X := Padding
      Y := VirtualScreenHeight - Height - Padding
    case "br":
      X := VirtualScreenWidth - Width - Padding
      Y := VirtualScreenHeight - Height - Padding
    default:
      return
  }
  if(Coord == "X")
    return X
  if(Coord == "Y")
    return Y
  return -1
}

GetCorner(ahk_id){
  global Padding
  SysGet, VirtualScreenWidth, 78
  SysGet, VirtualScreenHeight, 79
  Padding := 8
  WinGetPos, X, Y, Width, Height, %ahk_id%
  if(Floor(X) == Padding && Floor(Y) == Padding)
    return "tl"
  if(Floor(X) == Floor(VirtualScreenWidth) - Floor(Width) - Padding && Floor(Y) == Padding)
    return "tr"
  if(Floor(X) == Padding && Floor(Y) == Floor(VirtualScreenHeight) - Floor(Height) - Padding)
    return "bl"
  if(Floor(X) == Floor(VirtualScreenWidth) - Floor(Width) - Padding && Floor(Y) == Floor(VirtualScreenHeight) - Floor(Height) - Padding)
    return "br"
  return ""
}

ModifyWindowSize(ahk_id, delta){
  global screen_format
  global screen_format_consts
  global Animation_Duration
  global Config
  global LastKnownHeight

  WinGetPos, , , Width, Height, %ahk_id%
  h := Height + delta
  w := CalculateWidth(h)
  if(Config["Display"]["bUseAnimations"] == "True")
    SmoothSetWindowSize(ahk_id, w, h, Animation_Duration)
  Else
    SetWindowSize(ahk_id, w, h)

  LastKnownHeight := h
  return
}

^!T::
  global ahk_id
  WinGetTitle, ahk_id, A
  return

^!S::
  global ahk_id
  global Config
  WinSet, Alwaysontop, , %ahk_id%

  WinGet, ExStyle, ExStyle, %ahk_id%
  if (ExStyle & 0x8) {
	  WinSet, Style, -0xC00000, %ahk_id%
	  Minimize(ahk_id)
  } else {
	  WinSet, Style, +0xC00000, %ahk_id%
	  WinSet, Transparent, 255, %ahk_id%
  }

  return

^!M::
  global ahk_id

  if(!IsMaximised(ahk_id)){
    Maximize(ahk_id)
  }
  else{
    Minimize(ahk_id)
  }
  return


^!Up::
  global ahk_id
  WinGet, ExStyle, ExStyle, %ahk_id%
  if (ExStyle & 0x8){
    switch GetCorner(ahk_id){
      case "br":
        MoveToCorner(ahk_id, "tr")
      case "bl":
        MoveToCorner(ahk_id, "tl")
    }
  }
  return

^!Left::
  global ahk_id
  WinGet, ExStyle, ExStyle, %ahk_id%
  if (ExStyle & 0x8){
    switch GetCorner(ahk_id){
      case "tr":
        MoveToCorner(ahk_id, "tl")
      case "br":
        MoveToCorner(ahk_id, "bl")
    }
  }
  return

^!Down::
  global ahk_id
  WinGet, ExStyle, ExStyle, %ahk_id%
  if (ExStyle & 0x8){
    switch GetCorner(ahk_id){
      case "tl":
        MoveToCorner(ahk_id, "bl")
      case "tr":
        MoveToCorner(ahk_id, "br")
    }
  }
  return

^!Right::
  global ahk_id
  WinGet, ExStyle, ExStyle, %ahk_id%
  if (ExStyle & 0x8){
    switch GetCorner(ahk_id){
      case "tl":
        MoveToCorner(ahk_id, "tr")
      case "bl":
        MoveToCorner(ahk_id, "br")
    }
  }
  return

+!Up::
  global ahk_id
  global Delta
  c := GetCorner(ahk_id)
  ModifyWindowSize(ahk_id, Delta)
  MoveToCorner(ahk_id, c)
  return

^+!Up::
  global ahk_id
  global Delta
  c := GetCorner(ahk_id)
  ModifyWindowSize(ahk_id, 5*Delta)
  MoveToCorner(ahk_id, c)
  return

+!Down::
  global ahk_id
  global Delta
  c := GetCorner(ahk_id)
  ModifyWindowSize(ahk_id, -Delta)
  MoveToCorner(ahk_id, c)
  return

^+!Down::
  global ahk_id
  global Delta
  c := GetCorner(ahk_id)
  ModifyWindowSize(ahk_id, -5*Delta)
  MoveToCorner(ahk_id, c)
  return


^!PrintScreen::
  Config := ReadIniFile("Config.ini")
  for k,v in Config["General"]
  {
    msgbox, %k% - %v%
  }
  for k,v in Config["Display"]
  {
    msgbox, %k% - %v%
  }
  msgbox, %v%
