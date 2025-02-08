// See LICENSE file for copyright and license details.

#include <stdint.h>
#define int8 int8_t
// appearance
static const int8 borderpx = 2; // border pixel of windows
static const int8 snap = 16; // snap pixel
static const int8 showsystray = 1; // 0 means no systray
static const int8 systrayonleft = 0; // 0: systray in the right corner, >0: systray on left of status text
static const int8 systrayspacing = 2; // systray spacing
static const int8 systraypinning = 0; // 0: sloppy systray follows selected monitor, >0: pin systray to monitor X
static const int8 systraypinningfailfirst = 1; // 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor
static const int8 gappih = 8; // horiz inner gap between windows
static const int8 gappiv = 8; // vert inner gap between windows
static const int8 gappoh = 8; // horiz outer gap between windows and screen edge
static const int8 gappov = 8; // vert outer gap between windows and screen edge
static       int8 smartgaps = 0; // 1 = no outer gap when there is only one window
static const int8 showbar = 1; // 0 = no bar
static const int8 topbar = 1; // 0 = bottom bar
static const int8 user_bh = 12; // 2 - default spacing around the bar's font
static const char *fonts[]          = { "Noto Sans:size=10:style=Bold", "JetBrainsMono NF:size=10" };
static const char dmenufont[]       = "JetBrainsMono NF:size=10";

static char normfgcolor[]           = "#bbbbbb";
static char normbgcolor[]           = "#282828";
static char normbordercolor[]       = "#3c3836";
/*static char normfloatcolor[]        = "#db8fd9";*/

static char selfgcolor[]            = "#fbf1c7";
static char selbgcolor[]            = "#d65d0e";
static char selbordercolor[]        = "#d65d0e";
/*static char selfloatcolor[]         = "#d65d0e";*/

static char statusbgcolor[]         = "#282828";
static char statusfgcolor[]         = "#bbbbbb";

static char tagsnormfgcolor[]       = "#ebdbb2";
static char tagsnormbgcolor[]       = "#282828";
static char tagsselfgcolor[]        = "#fbf1c7";
static char tagsselbgcolor[]        = "#d65d0e";

static char tagsemptynormfgcolor[]  = "#7c7c7c";
static char tagsemptynormbgcolor[]  = "#282828";
static char tagsemptyselfgcolor[]   = "#7c7c7c";
static char tagsemptyselbgcolor[]   = "#d65d0e";

static char infonormfgcolor[]       = "#bbbbbb";
static char infonormbgcolor[]       = "#282828";
static char infoselfgcolor[]        = "#eeeeee";
static char infoselbgcolor[]        = "#282828";

static char *colors[][3]      = {
	//                    fg                bg                border
	[SchemeNorm]      = { normfgcolor,      normbgcolor,      normbordercolor },
	[SchemeSel]       = { selfgcolor,       selbgcolor,       selbordercolor  },
	[SchemeStatus]    = { statusfgcolor,    statusbgcolor,    "#000000" },
	[SchemeTagsSel]   = { tagsselfgcolor,   tagsselbgcolor,   "#000000" },
	[SchemeTagsNorm]  = { tagsnormfgcolor,  tagsnormbgcolor,  "#000000" },
	[SchemeTagsEmptyNorm] = { tagsemptynormfgcolor, tagsemptynormbgcolor, "#000000" },
	[SchemeTagsEmptySel] = { tagsemptyselfgcolor, tagsemptyselbgcolor, "#000000" },
	[SchemeInfoSel]   = { infoselfgcolor,   infoselbgcolor,   "#000000" },
	[SchemeInfoNorm]  = { infonormfgcolor,  infonormbgcolor,  "#000000" },
};

static const char *const autostart[] = {
    "dunst", NULL, // Notification daemon
    "clipmenud", NULL, // Clipboard history
    "dwmblocks", NULL,
	NULL // terminate
};

// tagging
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	// class      instance    title       tags mask     isfloating   monitor
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	/*{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },*/
};

// layouts
static const float mfact = 0.5; // factor of master area size
static const int8 nmaster = 1; // number of clients in master area
static const int8 resizehints = 1; // 1 = respect size hints in tiled resizals
static const int8 attachbelow = 1; // 1 = attach after the currently active window
static const int8 lockfullscreen = 0; // 1 = force focus on the fullscreen window

#define FORCE_VSPLIT 1 // nrowgrid layout: force two clients to always split vertically
#include "vanitygaps.c"

static const Layout layouts[] = {
	// symbol, arrange function
	{ "[T]", tile },
	{ "[M]", monocle },
	{ "[@]", spiral },
	{ "[\\]", dwindle },
	{ "H[]", deck },
	{ "TTT", bstack },
	{ "===", bstackhoriz },
	{ "HHH", grid },
	{ "###", nrowgrid },
	{ "---", horizgrid },
	{ ":::", gaplessgrid },
	{ "|M|", centeredmaster },
	{ ">M>", centeredfloatingmaster },
	{ "><>", NULL }, // no layout function means floating behavior
	{ NULL, NULL },
};

// key definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

// helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#define STATUSBAR "dwmblocks"

// commands
static char dmenumon[2] = "0"; // component of dmenucmd, manipulated in spawn()
static const char *dmenucmd[] = { "rofi", "-show", "drun", "-theme", "config", NULL };

#include <X11/XF86keysym.h>
#include "movestack.c"
static const Key keys[] = {
  // modifier, key, function, argument
  { MODKEY, XK_a, spawn, {.v = dmenucmd } },
  { MODKEY, XK_Return, spawn, SHCMD("kitty") },
  { MODKEY, XK_b, spawn, SHCMD("firefox") },
  { MODKEY|ShiftMask, XK_t, spawn, SHCMD("telegram-desktop") },
  { 0, XK_Print, spawn, SHCMD("flameshot gui") },
  { 0|ShiftMask, XK_Print, spawn, SHCMD("flameshot gui -d 3000") },
  { Mod1Mask, XK_F4, spawn, SHCMD("~/.local/bin/powermenu.sh") },
  { MODKEY, XK_v, spawn, SHCMD("export CM_LAUNCHER=rofi && clipmenu -p 'Clipboard' -theme clipmenu") },
  { MODKEY|ControlMask, XK_period, spawn, SHCMD("~/.local/bin/kbsetup.sh") },
  { MODKEY|ShiftMask, XK_x, spawn, SHCMD("~/.local/bin/color-pick.sh") },

  { MODKEY|ShiftMask, XK_b, togglebar, {0} },
  { MODKEY|ShiftMask, XK_b, spawn, SHCMD("killall dwmblocks && dwmblocks") },
  { Mod1Mask, XK_Tab, focusstack, {.i = +1 } },
  { MODKEY, XK_j, focusstack, {.i = +1 } },
  { MODKEY, XK_k, focusstack, {.i = -1 } },
  { MODKEY, XK_s, incnmaster, {.i = +1 } },
  { MODKEY, XK_d, incnmaster, {.i = -1 } },
  { MODKEY|ShiftMask, XK_h, moveresize, {.v = (int []){ -25, 0, 0, 0 } } },
  { MODKEY|ShiftMask, XK_j, moveresize, {.v = (int []){ 0, 25, 0, 0 } } },
  { MODKEY|ShiftMask, XK_k, moveresize, {.v = (int []){ 0, -25, 0, 0 } } },
  { MODKEY|ShiftMask, XK_l, moveresize, {.v = (int []){ 25, 0, 0, 0 } } },
  { MODKEY|ControlMask, XK_h, moveresize, {.v = (int []){ 0, 0, -25, 0 } } },
  { MODKEY|ControlMask, XK_j, moveresize, {.v = (int []){ 0, 0, 0, 25 } } },
  { MODKEY|ControlMask, XK_k, moveresize, {.v = (int []){ 0, 0, 0, -25 } } },
  { MODKEY|ControlMask, XK_l, moveresize, {.v = (int []){ 0, 0, 25, 0 } } },
  { MODKEY|Mod1Mask, XK_h, setmfact, {.f = -0.025} },
  { MODKEY|Mod1Mask, XK_l, setmfact, {.f = +0.025} },
  { MODKEY|Mod1Mask, XK_j, setcfact, {.f = -0.05} },
  { MODKEY|Mod1Mask, XK_k, setcfact, {.f = +0.05} },
  { MODKEY|Mod1Mask|ShiftMask, XK_j, movestack, {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask, XK_k, movestack, {.i = -1 } },
  { MODKEY|ShiftMask, XK_o, setcfact, {.f =  0.00} },
  { MODKEY, XK_z, zoom, {0} },
  { MODKEY|Mod1Mask, XK_u, incrgaps, {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask, XK_u, incrgaps, {.i = -1 } },
  { MODKEY|Mod1Mask, XK_i, incrigaps, {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask, XK_i, incrigaps, {.i = -1 } },
  { MODKEY|Mod1Mask, XK_o, incrogaps, {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask, XK_o, incrogaps, {.i = -1 } },
  { MODKEY|Mod1Mask|ControlMask, XK_6, incrihgaps, {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask, XK_6, incrihgaps, {.i = -1 } },
  { MODKEY|Mod1Mask|ControlMask, XK_7, incrivgaps, {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask, XK_7, incrivgaps, {.i = -1 } },
  { MODKEY|Mod1Mask|ControlMask, XK_8, incrohgaps, {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask, XK_8, incrohgaps, {.i = -1 } },
  { MODKEY|Mod1Mask|ControlMask, XK_9, incrovgaps, {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask, XK_9, incrovgaps, {.i = -1 } },
  { MODKEY|Mod1Mask, XK_minus, togglegaps, {0} },
  { MODKEY|Mod1Mask|ShiftMask, XK_0, defaultgaps, {0} },
  { MODKEY, XK_Tab, view, {0} },
  { MODKEY, XK_q, killclient, {0} },
  { MODKEY, XK_t, setlayout, {.v = &layouts[0]} },
  { MODKEY, XK_m, setlayout, {.v = &layouts[1]} },
  { MODKEY|Mod1Mask, XK_1, setlayout, {.v = &layouts[2]} },
  { MODKEY|Mod1Mask, XK_2, setlayout, {.v = &layouts[3]} },
  { MODKEY|Mod1Mask, XK_3, setlayout, {.v = &layouts[4]} },
  { MODKEY|Mod1Mask, XK_4, setlayout, {.v = &layouts[5]} },
  { MODKEY|Mod1Mask, XK_5, setlayout, {.v = &layouts[6]} },
  { MODKEY|Mod1Mask, XK_6, setlayout, {.v = &layouts[7]} },
  { MODKEY|Mod1Mask, XK_7, setlayout, {.v = &layouts[8]} },
  { MODKEY|Mod1Mask, XK_8, setlayout, {.v = &layouts[9]} },
  { MODKEY|Mod1Mask, XK_9, setlayout, {.v = &layouts[10]} },
  { MODKEY|Mod1Mask, XK_0, setlayout, {.v = &layouts[11]} },
  { MODKEY, XK_f, togglefloating, {0}  },
  { MODKEY, XK_0, view, {.ui = ~0 } },
  { MODKEY|ShiftMask, XK_0, tag, {.ui = ~0 } },
  { MODKEY, XK_comma, focusmon, {.i = -1 } },
  { MODKEY, XK_period, focusmon, {.i = +1 } },
  { MODKEY|ShiftMask, XK_comma, tagmon, {.i = -1 } },
  { MODKEY|ShiftMask, XK_period, tagmon, {.i = +1 } },
  { MODKEY|ShiftMask, XK_q, quit, {0} },
  { MODKEY, XK_space, spawn, SHCMD("pkill -RTMIN+1 dwmblocks") },
  { MODKEY|ShiftMask, XK_r, spawn, SHCMD("pkill -RTMIN+10 dwmblocks") },
  { 0|ShiftMask, XF86XK_AudioMute, spawn, SHCMD("wpctl set-mute @DEFAULT_SOURCE@ toggle && pkill -RTMIN+3 dwmblocks") },
  { 0|ShiftMask, XF86XK_AudioRaiseVolume, spawn, SHCMD("wpctl set-volume @DEFAULT_SOURCE@ 5%+ && pkill -RTMIN+3 dwmblocks") },
  { 0|ShiftMask, XF86XK_AudioLowerVolume, spawn, SHCMD("wpctl set-volume @DEFAULT_SOURCE@ 5%- && pkill -RTMIN+3 dwmblocks") },
  { 0, XF86XK_AudioMute, spawn, SHCMD("wpctl set-mute @DEFAULT_SINK@ toggle && pkill -RTMIN+2 dwmblocks") },
  { 0, XF86XK_AudioRaiseVolume, spawn, SHCMD("wpctl set-volume @DEFAULT_SINK@ 5%+ && pkill -RTMIN+2 dwmblocks") },
  { 0, XF86XK_AudioLowerVolume, spawn, SHCMD("wpctl set-volume @DEFAULT_SINK@ 5%- && pkill -RTMIN+2 dwmblocks")},
  { 0, XF86XK_MonBrightnessUp,  spawn, SHCMD("brightnessctl -q s +10%") },
  { 0, XF86XK_MonBrightnessDown, spawn, SHCMD("brightnessctl -q s 10%-")},

  TAGKEYS(XK_1, 0)
  TAGKEYS(XK_2, 1)
  TAGKEYS(XK_3, 2)
  TAGKEYS(XK_4, 3)
  TAGKEYS(XK_5, 4)
  TAGKEYS(XK_6, 5)
  TAGKEYS(XK_7, 6)
  TAGKEYS(XK_8, 7)
  TAGKEYS(XK_9, 8)
};

// button definitions
// click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin
static const Button buttons[] = {
	// click, event mask, button, function, argument
	{ ClkLtSymbol, 0, Button1, setlayout, {0} },
	{ ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]} },
	{ ClkWinTitle, 0, Button2, zoom, {0} },
	{ ClkStatusText, 0, Button1, sigstatusbar, {.i = 1} },
	{ ClkStatusText, 0, Button2, sigstatusbar, {.i = 2} },
	{ ClkStatusText, 0, Button3, sigstatusbar, {.i = 3} },
	{ ClkStatusText, 0, Button4, sigstatusbar, {.i = 4} },
	{ ClkStatusText, 0, Button5, sigstatusbar, {.i = 5} },
	{ ClkClientWin, MODKEY, Button1, movemouse, {0} },
	{ ClkClientWin, MODKEY, Button2, togglefloating, {0} },
	{ ClkClientWin, MODKEY, Button3, resizemouse, {0} },
	{ ClkTagBar, 0, Button1, view, {0} },
	{ ClkTagBar, 0, Button3, toggleview, {0} },
	{ ClkTagBar, MODKEY, Button1, tag, {0} },
	{ ClkTagBar, MODKEY, Button3, toggletag, {0} },
};
