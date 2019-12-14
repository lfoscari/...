/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;                    /* -c option; centers dmenu on screen */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"monospace:size=8"
};
static const char *prompt = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     		      fg         bg       */
	[SchemeNorm] = 	{ "#000000", "#000000" },
	[SchemeSel]  = 	{ "#000000", "#000000" },
	[SchemeOut]  = 	{ "#000000", "#000000" },

	/* [SchemeNorm] = 	{ "#bbbbbb", "#222222" },
	[SchemeSel]  = 	{ "#eeeeee", "#005577" },
	[SchemeOut]  = 	{ "#ffffff", "#e303e4" }, */
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 10;
static unsigned int lineheight = 50;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
