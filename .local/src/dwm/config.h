/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 16;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  = 0;   /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor */
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Noto Sans:size=9:style=Bold", "JetBrainsMono NF:size=9" };
static const char dmenufont[]       = "JetBrainsMono NF:size=10";
static const char col_gray1[]       = "#282828";
static const char col_gray2[]       = "#3c3836";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_orng[]        = "#d65d0e";
static const char *colors[][3]      = {
	/*              fg         bg         border   */
	[SchemeNorm] = {col_gray3, col_gray1, col_gray2},
	[SchemeSel]  = {col_gray4, col_orng,  col_orng},
    [SchemeStatus] = {col_gray3, col_gray1, "#000000"},
    [SchemeTagsSel] = {col_gray4, col_orng, "#000000"},
    [SchemeTagsNorm] = {col_gray3, col_gray1, "#000000"},
    [SchemeInfoSel] = {col_gray4, col_gray1, "#000000"},
    [SchemeInfoNorm] = {col_gray3, col_gray1, "#000000"},
};

static const char *const autostart[] = {
    "dwmblocks", NULL,
    "dunst", NULL,
    "clipmenud", NULL,
    NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance    title       tags mask     isfloating   monitor */
    { "TelegramDesktop",NULL,       NULL,       1 << 1,       0,           -1 },
	{ "Firefox",        NULL,       NULL,       1 << 1,       0,           -1 },
    {"gnome-calculator",NULL,       NULL,       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.5;  /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 0; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },    /* first entry is default */
	{ "[M]",      monocle },
	{ "><>",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALT    Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "rofi", "-show", "drun", "-theme", "config", NULL };

#include <X11/XF86keysym.h>
#define FnAudioMute      XF86XK_AudioMute
#define FnAudioUp        XF86XK_AudioRaiseVolume
#define FnAudioDown      XF86XK_AudioLowerVolume
#define FnBrightnessUp   XF86XK_MonBrightnessUp
#define FnBrightnessDown XF86XK_MonBrightnessDown
static const Key keys[] = {
	/* modifier         key         function        argument */
    {MODKEY,            XK_a,       spawn,          {.v = dmenucmd}},
    {MODKEY,            XK_Return,  spawn,          SHCMD("st")}
	{MODKEY|ShiftMask,  XK_Return,  spawn,          SHCMD("alacritty")},
	{MODKEY,            XK_b,       spawn,          SHCMD("firefox")},
    {MODKEY|ShiftMask,  XK_t,       spawn,          SHCMD("telegram-desktop")},
    {MODKEY|ShiftMask,  XK_w,       spawn,          SHCMD("feh --randomize --no-fehbg --bg-fill ~/wallpaper")},
    {0,                 XK_Print,   spawn,          SHCMD("flameshot gui")},
    {0|ShiftMask,       XK_Print,   spawn,          SHCMD("flameshot gui -d 3000")},
    {ALT,               XK_F4,      spawn,          SHCMD("~/.local/bin/powermenu.sh")},
    {MODKEY,            XK_v,       spawn,          SHCMD("export CM_LAUNCHER=rofi && clipmenu -p 'Clipboard' -theme clipmenu")},
    {MODKEY|ControlMask,XK_period,  spawn,          SHCMD("~/.local/bin/kbsetup.sh")},
    {MODKEY|ShiftMask,  XK_x,       spawn,          SHCMD("~/.local/bin/color-pick.sh")},
    {MODKEY|ShiftMask,  XK_b,       togglebar,      {0}},
    {ALT,               XK_Tab,     focusstack,     {.i = +1}},
	{MODKEY,            XK_j,       focusstack,     {.i = +1}},
	{MODKEY,            XK_k,       focusstack,     {.i = -1}},
	{MODKEY,            XK_s,       incnmaster,     {.i = +1}},
	{MODKEY,            XK_d,       incnmaster,     {.i = -1}},
    {MODKEY|ShiftMask,  XK_h,       moveresize,     {.v = "-25x 0y 0w 0h" }},
    {MODKEY|ShiftMask,  XK_j,       moveresize,     {.v = "0x 25y 0w 0h" }},
    {MODKEY|ShiftMask,  XK_k,       moveresize,     {.v = "0x -25y 0w 0h" }},
    {MODKEY|ShiftMask,  XK_l,       moveresize,     {.v = "25x 0y 0w 0h" }},
    {MODKEY|ControlMask,XK_h,       moveresize,     {.v = "0x 0y -25w 0h" }},
    {MODKEY|ControlMask,XK_j,       moveresize,     {.v = "0x 0y 0w 25h" }},
    {MODKEY|ControlMask,XK_k,       moveresize,     {.v = "0x 0y 0w -25h" }},
    {MODKEY|ControlMask,XK_l,       moveresize,     {.v = "0x 0y 25w 0h" }},
	{MODKEY|ALT,        XK_h,       setmfact,       {.f = -0.025}},
	{MODKEY|ALT,        XK_l,       setmfact,       {.f = +0.025}},
    {MODKEY|ALT,        XK_j,       setcfact,       {.f = +0.05}},
    {MODKEY|ALT,        XK_k,       setcfact,       {.f = -0.05}},
    {MODKEY,            XK_z,       zoom,           {0}},
	{MODKEY,            XK_Tab,     view,           {0}},
	{MODKEY,            XK_q,       killclient,     {0}},
	{MODKEY,            XK_t,       setlayout,      {.v = &layouts[0]}},
	{MODKEY,            XK_m,       setlayout,      {.v = &layouts[1]}},
    {MODKEY,            XK_f,       togglefloating, {0}},
	{MODKEY,            XK_0,       view,           {.ui = ~0 }},
	{MODKEY|ShiftMask,  XK_0,       tag,            {.ui = ~0 }},
	{MODKEY,            XK_comma,   focusmon,       {.i = -1 }},
	{MODKEY,            XK_period,  focusmon,       {.i = +1 }},
	{MODKEY|ShiftMask,  XK_comma,   tagmon,         {.i = -1 }},
	{MODKEY|ShiftMask,  XK_period,  tagmon,         {.i = +1 }},
	{MODKEY|ShiftMask,  XK_q,       quit,           {0}},
    {MODKEY,            XK_space,   spawn,          SHCMD("pkill -RTMIN+1 dwmblocks")},
    {MODKEY|ShiftMask,  XK_r,       spawn,          SHCMD("pkill -RTMIN+10 dwmblocks")},
    {0|ShiftMask,       FnAudioMute,spawn,          SHCMD("pactl set-source-mute @DEFAULT_SOURCE@ toggle && pkill -RTMIN+3 dwmblocks")},
    {0|ShiftMask,       FnAudioUp,  spawn,          SHCMD("pactl set-source-volume @DEFAULT_SOURCE@ +5% && pkill -RTMIN+3 dwmblocks")},
    {0|ShiftMask,       FnAudioDown,spawn,          SHCMD("pactl set-source-volume @DEFAULT_SOURCE@ -5% && pkill -RTMIN+3 dwmblocks")},
    {0,                 FnAudioMute,spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle && pkill -RTMIN+2 dwmblocks")},
    {0,                 FnAudioUp,  spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +5% && pkill -RTMIN+2 dwmblocks")},
    {0,                 FnAudioDown,spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -5% && pkill -RTMIN+2 dwmblocks")},
    {0,         FnBrightnessUp,     spawn,          SHCMD("brightnessctl -q s +10%")},
    {0,         FnBrightnessDown,   spawn,          SHCMD("brightnessctl -q s 10%-")},
	TAGKEYS(            XK_1,       0)
	TAGKEYS(            XK_2,       1)
	TAGKEYS(            XK_3,       2)
	TAGKEYS(            XK_4,       3)
	TAGKEYS(            XK_5,       4)
	TAGKEYS(            XK_6,       5)
	TAGKEYS(            XK_7,       6)
	TAGKEYS(            XK_8,       7)
	TAGKEYS(            XK_9,       8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* Click      EventMask Button   Function        Argument */
	{ClkLtSymbol,   0,      Button1, setlayout,      {0}},
	{ClkLtSymbol,   0,      Button3, setlayout,      {.v = &layouts[2]}},
	{ClkWinTitle,   0,      Button2, zoom,           {0}},
	{ClkStatusText, 0,      Button2, spawn,          SHCMD("alacritty")},
	{ClkClientWin,  MODKEY, Button1, movemouse,      {0}},
	{ClkClientWin,  MODKEY, Button2, togglefloating, {0}},
	{ClkClientWin,  MODKEY, Button3, resizemouse,    {0}},
	{ClkTagBar,     0,      Button1, view,           {0}},
	{ClkTagBar,     0,      Button3, toggleview,     {0}},
	{ClkTagBar,     MODKEY, Button1, tag,            {0}},
	{ClkTagBar,     MODKEY, Button3, toggletag,      {0}},
};

