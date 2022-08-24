SetWorkingDir, %A_ScriptDir%
#Include lib/WinEdit.ahk

EaseInExpo(x){
  if(x == 0)
    return 0
  return Exp(10 * x - 10)
}

SmoothMoveWindow(ahk_id, X, Y, duration){
  Steps := Ceil(duration * 60 / 1000)
  WinGetPos, CurrX, CurrY, , , %ahk_id%
  XDelta := X - CurrX
  YDelta := Y - CurrY
  XStep := Abs(XDelta) / Steps
  YStep := Abs(YDelta) / Steps
  i := 1
  while(i <= Steps){
    X := CurrX + XDelta * EaseInExpo(i / Steps)
    Y := CurrY + YDelta * EaseInExpo(i / Steps)
    MoveWindow(ahk_id, X, Y)
    Sleep, 20
    i++
  }
  return
}

SmoothSetWindowSize(ahk_id, W, H, duration){
  Steps := Ceil(duration * 60 / 1000)
  WinGetPos, , , CurrW, CurrH, %ahk_id%
  WDelta := W - CurrW
  HDelta := H - CurrH
  WStep := Abs(WDelta) / Steps
  HStep := Abs(YHDelta) / Steps
  i := 1
  while(i <= Steps){
    W := CurrW + WDelta * EaseInExpo(i / Steps)
    H := CurrH + HDelta * EaseInExpo(i / Steps)
    SetWindowSize(ahk_id, W, H)
    Sleep, 20
    i++
  }
}

SmoothSetWinPos(ahk_id, W, H, X, Y, duration){
  Steps := Ceil(duration * 60 / 1000)
  WinGetPos, CurrX, Curry, CurrW, CurrH, %ahk_id%
  if(X != -1 && Y != -1){
    XDelta := X - CurrX
    YDelta := Y - CurrY
    XStep := Abs(XDelta) / Steps
    YStep := Abs(YDelta) / Steps
  }
  if(W != -1 && H != -1){
    WDelta := W - CurrW
    HDelta := H - CurrH
    WStep := Abs(WDelta) / Steps
    HStep := Abs(YHDelta) / Steps
  }
  i := 1
  while(i <= Steps){
    W := CurrW + WDelta * EaseInExpo(i / Steps)
    H := CurrH + HDelta * EaseInExpo(i / Steps)
    X := CurrX + XDelta * EaseInExpo(i / Steps)
    Y := CurrY + YDelta * EaseInExpo(i / Steps)
    SetWindowSize(ahk_id, W, H)
    MoveWindow(ahk_id, X, Y)
    Sleep, 20
    i++
  }
}