import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run
import XMonad.Layout.Gaps
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows
import XMonad.Layout.IfMax
import XMonad.Layout.Simplest
import XMonad.Actions.Navigation2D
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

myFocusedBorderColor = "#7aa2f7"
myNormalBorderColor = "#1f2335"

myTabTheme = def
    --{ fontName              = myFont
    { activeColor           = myFocusedBorderColor
    , inactiveColor         = myNormalBorderColor
    , activeBorderColor     = myFocusedBorderColor
    , inactiveBorderColor   = myNormalBorderColor
    , activeTextColor       = myNormalBorderColor
    , inactiveTextColor     = myFocusedBorderColor
    }

myTerm = "kitty"
myLauncher = "rofi -theme ~/.config/rofi/themes/Nord.rasi -matching fuzzy -modi drun,window -show drun -drun-match-fields name,exec"
myModMask = mod4Mask
myKeys = 
    [ ((myModMask, xK_p), spawn myLauncher)
    , ((myModMask, xK_Print), spawn "gnome-screenshot --interactive")
    , ((mod1Mask, xK_Tab), windows W.focusDown)
    , ((myModMask .|. controlMask, xK_h), sendMessage $ pullGroup L)
    , ((myModMask .|. controlMask, xK_l), sendMessage $ pullGroup R)
    , ((myModMask .|. controlMask, xK_k), sendMessage $ pullGroup U)
    , ((myModMask .|. controlMask, xK_j), sendMessage $ pullGroup D)
    , ((myModMask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
    , ((myModMask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))
    , ((myModMask .|. controlMask, xK_period), onGroup W.focusDown')
    , ((myModMask .|. controlMask, xK_comma), onGroup W.focusUp')
    , ((myModMask, xK_j), focusDown)
    , ((myModMask, xK_k), focusUp)
    , ((controlMask, xK_h), windowSwap L True)
    , ((controlMask, xK_j), windowSwap D True)
    , ((controlMask, xK_k), windowSwap U True)
    , ((controlMask, xK_l), windowSwap R True)
    ]
    -- ++ 
    -- [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- -- | (key, sc) <- zip [xK_w, xK_e] [1,0], (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    -- ]

myLayout =
  let
    tall = Tall 1 (3/100) (1/2)
    threeColMid = ThreeColMid 1 (3/100) (1/2)
    horizontall = Mirror tall
    mirroredTall = reflectHoriz tall
    modifiers =  desktopLayoutModifiers . windowNavigation . addTabs shrinkText myTabTheme . subLayout [] Simplest . boringWindows
  in
    modifiers $ smartSpacing 5 . smartBorders $ threeColMid ||| tall ||| horizontall ||| mirroredTall ||| Full

_topXmobarPP h = xmobarPP {
    ppCurrent = xmobarColor "#e2a478" "" . wrap "[" "]"
    , ppVisible = xmobarColor "#e2a478" "" . wrap "" ""
    , ppHidden = xmobarColor "#b4be82" "" . wrap "" ""
    , ppHiddenNoWindows = xmobarColor "#a093c7" ""
    , ppSep = "<fc=#ffffff> | </fc>" 
    , ppTitle = xmobarColor "#84a0c6" "" . shorten 60
    -- hack to drop "Spacing Tabbed"
    , ppLayout = xmobarColor "#e27878" "" . unwords . drop 2 . words
    , ppOutput = hPutStrLn h
    --, ppExtras  = [windowCount]
    , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]}

main = do
  _topXmobar <- spawnPipe "xmobar /home/gabriel/.config/xmobar/xmobar.config"
  xmonad $ ewmh . docks . ewmhFullscreen $ desktopConfig
    { terminal = myTerm
    , modMask = myModMask
    , logHook = dynamicLogWithPP $ _topXmobarPP _topXmobar
    , layoutHook = myLayout
    , handleEventHook = handleEventHook desktopConfig
    , focusedBorderColor = myFocusedBorderColor
    , normalBorderColor = myNormalBorderColor
    , borderWidth = 3
    }
    `additionalKeys` myKeys
