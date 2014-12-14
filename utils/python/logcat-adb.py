#!/usr/bin/python

'''
    Copyright 2009, The Android Open Source Project

    Licensed under the Apache License, Version 2.0 (the "License"); 
    you may not use this file except in compliance with the License. 
    You may obtain a copy of the License at 

        http://www.apache.org/licenses/LICENSE-2.0 

    Unless required by applicable law or agreed to in writing, software 
    distributed under the License is distributed on an "AS IS" BASIS, 
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
    See the License for the specific language governing permissions and 
    limitations under the License.
'''
TAG_V, TAG_D, TAG_I, TAG_W, TAG_E, TAG_F = range(6)

# adb logcat arguments for default
DEFAULT_ARGS = "-b main"
# TAGs masked, which not print
MASK_TAGS = [ "HWC-JZX2D", "ACRA", "StrictMode", "Settings" ]
# TAGs need to display, if not null, other tags will be masked
NEED_TAGS = { "AKIM":TAG_V, "DEBUG":TAG_V, "dalvikvm":TAG_W, "linker":TAG_V }

# script to highlight adb logcat output for console
# written by jeff sharkey, http://jsharkey.org/
# piping detection and popen() added by other android team members

import os, sys, re, StringIO
import fcntl, termios, struct

# unpack the current terminal width/height
data = fcntl.ioctl(sys.stdout.fileno(), termios.TIOCGWINSZ, '1234')
HEIGHT, WIDTH = struct.unpack('hh',data)

BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)

def format(fg=None, bg=None, bright=False, bold=False, dim=False, reset=False):
    # manually derived from http://en.wikipedia.org/wiki/ANSI_escape_code#Codes
    codes = []
    if reset: codes.append("0")
    else:
        if not fg is None: codes.append("3%d" % (fg))
        if not bg is None:
            if not bright: codes.append("4%d" % (bg))
            else: codes.append("10%d" % (bg))
        if bold: codes.append("1")
        elif dim: codes.append("2")
        else: codes.append("22")
    return "\033[%sm" % (";".join(codes))


def indent_wrap(message, indent=0, width=80):
    wrap_area = width - indent
    messagebuf = StringIO.StringIO()
    current = 0
    while current < len(message):
        next = min(current + wrap_area, len(message))
        messagebuf.write(message[current:next])
        if next < len(message):
            messagebuf.write("\n%s" % (" " * indent))
        current = next
    return messagebuf.getvalue()


LAST_USED = [RED,GREEN,YELLOW,BLUE,MAGENTA,CYAN,WHITE]
KNOWN_TAGS = {
    "dalvikvm": BLUE,
    "Process": BLUE,
    "ActivityManager": CYAN,
    "ActivityThread": CYAN,
    "AKIM": MAGENTA,
    "DEBUG": RED,
}

def allocate_color(tag):
    # this will allocate a unique format for the given tag
    # since we dont have very many colors, we always keep track of the LRU
    if not tag in KNOWN_TAGS:
        KNOWN_TAGS[tag] = LAST_USED[0]
    color = KNOWN_TAGS[tag]
    LAST_USED.remove(color)
    LAST_USED.append(color)
    return color


RULES = {
    #re.compile(r"([\w\.@]+)=([\w\.@]+)"): r"%s\1%s=%s\2%s" % (format(fg=BLUE), format(fg=GREEN), format(fg=BLUE), format(reset=True)),
}

TAGTYPE_WIDTH = 3
TAG_WIDTH = 10
PROCESS_WIDTH = 6 # 8 or -1
HEADER_SIZE = TAGTYPE_WIDTH + 1 + TAG_WIDTH + 1 + PROCESS_WIDTH + 1

TAGLVLS = { "V": TAG_V, "D": TAG_D, "I": TAG_I, "W": TAG_W, "E": TAG_E, "F": TAG_F }
TAGTYPES = {
    "V": "%s%s%s" % (format(fg=WHITE, bg=BLACK), "V".center(TAGTYPE_WIDTH), format(reset=True)),
    "D": "%s%s%s" % (format(fg=BLACK, bg=BLUE), "D".center(TAGTYPE_WIDTH), format(reset=True)),
    "I": "%s%s%s" % (format(fg=BLACK, bg=GREEN), "I".center(TAGTYPE_WIDTH), format(reset=True)),
    "W": "%s%s%s" % (format(fg=BLACK, bg=YELLOW), "W".center(TAGTYPE_WIDTH), format(reset=True)),
    "E": "%s%s%s" % (format(fg=BLACK, bg=RED), "E".center(TAGTYPE_WIDTH), format(reset=True)),
    "F": "%s%s%s" % (format(fg=BLACK, bg=RED), "E".center(TAGTYPE_WIDTH), format(reset=True)),
}

retag = re.compile("^([A-Z])/([^\(]*)\(([^\)]+)\): (.*)$")

# to pick up -d or -e
if len(sys.argv) > 1:
    adb_args = ' '.join(sys.argv[1:])
else:
    adb_args = DEFAULT_ARGS

# if someone is piping in to us, use stdin as input.  if not, invoke adb logcat
if os.isatty(sys.stdin.fileno()):
    print("adb logcat %s" % adb_args)
    inpipe = os.popen("adb logcat %s" % adb_args)
else:
    inpipe = sys.stdin

while True:
    try:
        line = inpipe.readline()
    except KeyboardInterrupt:
        break

    match = retag.match(line)
    if not match is None:
        tagtype, tag, owner, message = match.groups()
        linebuf = StringIO.StringIO()

        tag = re.compile("\s*$").sub("",tag);
        if len(NEED_TAGS) > 0 and tag in NEED_TAGS:
            if TAGLVLS[tagtype] < NEED_TAGS[tag]:
                continue
        else:
            continue
        if tag in MASK_TAGS:
            continue

        # write out tagtype colored edge
        if not tagtype in TAGTYPES:
            print("bad tag: %s" % tagtype)
            break
        linebuf.write(TAGTYPES[tagtype])

        # center process info
        if PROCESS_WIDTH > 0:
            owner = owner.strip().center(PROCESS_WIDTH)
            linebuf.write("%s%s%s" % (format(fg=BLACK, bg=BLACK, bright=True),
                                      owner, format(reset=True)))

        # right-align tag title and allocate color if needed
        tag = tag.strip()
        color = allocate_color(tag)
        #tag = tag[-TAG_WIDTH:].rjust(TAG_WIDTH)
        linebuf.write("%s%s %s" % (format(fg=color, dim=False), tag, format(reset=True)))

        # insert line wrapping as needed
        message = indent_wrap(message, HEADER_SIZE, WIDTH)

        # format tag message using rules
        for matcher in RULES:
            replace = RULES[matcher]
            message = matcher.sub(replace, message)

        linebuf.write(message)
        line = linebuf.getvalue()

    print (line);
    if len(line) == 0:
        print("space line!!!")
        break

