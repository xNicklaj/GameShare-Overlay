WriteDefaultConfig(){
    IniWrite, 200, Config.ini, General, fAnimationDuration
    IniWrite, 32, Config.ini, General, fStepSize
    IniWrite, 16:9, Config.ini, Display, sFormat
    IniWrite, 255, Config.ini, Display, fTransparency
    IniWrite, True, Config.ini, Display, bUseAnimations
    return
}