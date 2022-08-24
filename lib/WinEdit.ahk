SetWorkingDir, %A_ScriptDir%
MoveWindow(ahk_id, X, Y){ 
  WinMove, %ahk_id%, , %X%, %Y%, , 
  return
}

SetWindowSize(ahk_id, width, height){ 
  SetWinDelay, -1
  WinMove, %ahk_id%, , , , %width%, %height%
  return
}
