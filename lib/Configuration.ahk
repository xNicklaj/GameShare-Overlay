WriteDefaultConfig(){
    IniWrite, 200, Config.ini, General, IAnimationDuration
    IniWrite, 32, Config.ini, General, ISizeStep
    IniWrite, 16:9, Config.ini, Display, SFormat
    IniWrite, 255, Config.ini, Display, BTransparency
    return
}