import XMonad
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Util.EZConfig (additionalKeysP)

audioKeys = [
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10"),
    ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10") ]

extraKeys = audioKeys

main = xmonad $ desktopConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    } `additionalKeysP` extraKeys
