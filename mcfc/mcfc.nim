# Copyright (c) 2023 woidzero
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import system as sys
import std/strutils
import std/tables
import os


if defined windows:
    discard os.execShellCmd("color");


const 
    RESET = "\e[0m"
    BLACK = "\e[30m"
    WHITE = "\e[97m"
    DARK_RED = "\e[31m"
    DARK_GREEN = "\e[32m"
    GOLD = "\e[33m"
    DARK_BLUE = "\e[34m"
    DARK_PURPLE = "\e[35m"
    DARK_AQUA = "\e[36m"
    GRAY = "\e[37m"
    DARK_GRAY = "\e[90m"

    RED = "\e[91m"
    GREEN = "\e[92m"
    YELLOW = "\e[93m"
    BLUE = "\e[94m"
    PURPLE = "\e[95m"
    AQUA = "\e[96m"
    
    BOLD = "\e[1m"
    UNDERLINE = "\e[4m"
    STRIKETHROUGH = "\e[9m"
    ITALIC = "\e[3m"

    # custom
    BLINK = "\e[5m"
    OVERLINE = "\e[53m"
    DOUBLE_UNDERLINE = "\e[21m"
    INVERT = "\e[7m"


const COLOR_CODES: auto = {
    "&0": BLACK,
    "&f": WHITE,
    "&8": DARK_GRAY,
    "&7": GRAY,
    "&1": DARK_BLUE,
    "&9": BLUE,
    "&2": DARK_GREEN,
    "&a": GREEN,
    "&3": DARK_AQUA,
    "&b": AQUA,
    "&4": DARK_RED,
    "&c": RED,
    "&5": DARK_PURPLE,
    "&d": PURPLE,
    "&6": GOLD,
    "&e": YELLOW,
    "&r": RESET,
    "&l": BOLD,
    "&n": UNDERLINE,
    "&m": STRIKETHROUGH,
    "&o": ITALIC,
    "&j": BLINK,
    "&p": OVERLINE,
    "&w": DOUBLE_UNDERLINE,
    "&i": INVERT
}.toTable


proc print*(values: varargs[string]): string {.discardable.} = 
    ## Prints the colored text to a stream, or to system.stdout by default.
    var text: string = values.join(" ")

    for code, _ in COLOR_CODES:
        text = replace(text, code, COLOR_CODES[code])
    
    sys.stdout.write(text & RESET & "\n") 


proc info*(): void {.discardable.} = 
    ## Prints all available formatting codes.

    print """
    Text can be formatted using the section sign (&) followed by a character.

    ----- Default formatting codes:

    &00            &88            &77            &ff
    &11            &99            &22            &aa
    &33            &bb            &44            &cc
    &55            &dd            &66            &ee
    &rr (reset)&r                 &ll (bold)&r
    &nn (underline)&r             &oo (italic)&r
    &mm (strikeout)&r             

    ----- Custom formatting codes (Not widely supported.):

    &jj (blink)&r                 &pp (overline)&r
    &ww (double underline)&r      &ii (invert)&r
    """
