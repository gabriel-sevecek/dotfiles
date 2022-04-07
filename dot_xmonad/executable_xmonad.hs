import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.IfMaxAlt
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run
import XMonad.Layout.Gaps
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops

import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

defaultTall = Tall 1 (3/100) (1/2)

addBarIfMultiple x = IfMaxAlt 1 x topBar
  where
    topBar = noFrillsDeco shrinkText coolTheme $ mySpacing x
    coolTheme =
        def
            { fontName = font
            , inactiveBorderColor = grey
            , inactiveColor = grey
            , inactiveTextColor = grey
            , activeBorderColor = blue
            , activeColor = blue
            , activeTextColor = blue
            , urgentTextColor = blue
            , urgentBorderColor = blue
            , decoHeight = decorationHeight
            , decoWidth = 50
            }
      where
        decorationHeight = 4
        blue = "#84a0c6"
        grey = "#272935"
        font = "xft:monospace:size=10" -- doesn't matter because of `shrinkText`

myTerm = "kitty"
-- myTerm = "alacritty"
myLauncher = "rofi -theme ~/.config/rofi/themes/Nord.rasi -matching fuzzy -modi drun,window -show drun -drun-match-fields name,exec"
myModMask = mod4Mask
myKeys = 
    [ ((myModMask, xK_p), spawn myLauncher)
    , ((myModMask, xK_Print), spawn "gnome-screenshot --interactive")
    , ((mod1Mask, xK_Tab), windows W.focusDown)
    ]
    -- ++ 
    -- [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- -- | (key, sc) <- zip [xK_w, xK_e] [1,0], (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    -- ]

mySpacing l =
  spacingRaw True (Border 0 0 0 0) False (Border 5 5 5 5) True l

_topXmobarPP h = xmobarPP {
    ppCurrent = xmobarColor "#e2a478" "" . wrap "[" "]"
    , ppVisible = xmobarColor "#e2a478" "" . wrap "" ""
    , ppHidden = xmobarColor "#b4be82" "" . wrap "" ""
    , ppHiddenNoWindows = xmobarColor "#a093c7" ""
    , ppSep = "<fc=#ffffff> | </fc>" 
    , ppTitle = xmobarColor "#84a0c6" "" . shorten 60
    , ppLayout = xmobarColor "#e27878" ""
    , ppOutput = hPutStrLn h
    --, ppExtras  = [windowCount]
    , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]}

main = do
  _topXmobar <- spawnPipe "xmobar /home/g.sevecek@sportradar.local/.config/xmobar/xmobar.config"
  xmonad $ ewmh $ desktopConfig
    { terminal = myTerm
    , modMask = myModMask
    --, logHook = dynamicLogWithPP $ _topXmobarPP _topXmobar
    , layoutHook = desktopLayoutModifiers $ avoidStruts $ noBorders $ (addBarIfMultiple $ ThreeColMid 1 (3/100) (1/2)) ||| (addBarIfMultiple $ defaultTall) ||| (addBarIfMultiple $ Mirror defaultTall) ||| (addBarIfMultiple $ reflectHoriz defaultTall) ||| Full ||| simpleTabbed
    , handleEventHook = docksEventHook <+> fullscreenEventHook <+> handleEventHook desktopConfig
    }
    `additionalKeys` myKeys
