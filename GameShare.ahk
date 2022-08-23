#SingleInstance force

ahk_id := ""

; Avoid changing. You can, nothing bad will happen, it's just not recommended.
screen_format_consts := {"16:9": {"W":16, "H":9}, "21:9": {"W":21, "H": 9}}
screen_format := "16:9"
Padding := 8
Delta := 16

Minimize(ahk_id){
  global Padding
  global screen_format
  global screen_format_consts

  SysGet, VirtualScreenWidth, 78
  WinHeight := 288
  WinWidth := WinHeight / screen_format_consts[screen_format]["H"] * screen_format_consts[screen_format]["W"]
  X := VirtualScreenWidth - WinWidth - Padding
  Y := Padding

  ; WinMove, %ahk_id%, , , , %WinWidth%, %WinHeight%
  SetWindowSize(ahk_id, WinWidth, WinHeight)
  MoveToCorner(ahk_id, "tr")
  WinSet, Transparent, 240, %ahk_id%
  return
}

Maximize(ahk_id){
  global Padding

  SysGet, VirtualScreenWidth, 78
  SysGet, VirtualScreenHeight, 79
  WinWidth := VirtualScreenWidth - 2 * Padding
  WinHeight := VirtualScreenHeight - 2 * Padding
  X := Padding
  Y := Padding
  
  WinSet, Transparent, 255, %ahk_id%
  MoveToCorner(ahk_id, "tl")
  SetWindowSize(ahk_id, WinWidth, WinHeight)
  ; WinMove, %ahk_id%, , %X%, %Y%, %WinWidth%, %WinHeight%
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
  WinMove, %ahk_id%, , %X%, %Y%, , 
  return
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

SetWindowSize(ahk_id, width, height){ 
  WinMove, %ahk_id%, , , , %width%, %height%
  return
}

ModifyWindowSize(ahk_id, delta){
  global screen_format
  global screen_format_consts
  WinGetPos, , , Width, Height, %ahk_id%
  h := Height + delta
  w := Height / screen_format_consts[screen_format]["H"] * screen_format_consts[screen_format]["W"]
  SetWindowSize(ahk_id, w, h)
  return
}

^!T::
  global ahk_id
  WinGetTitle, ahk_id, A
  return

^!S::
  global ahk_id 
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


+!Down::
  global ahk_id
  global Delta
  c := GetCorner(ahk_id)
  ModifyWindowSize(ahk_id, -Delta)
  MoveToCorner(ahk_id, c)
  return