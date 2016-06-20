#!/usr/bin/env python2
from yaml import load
from jinja2 import Environment
from sys import argv
import re

yam = argv[1]
tmp = argv[2]

TEXFILE = False
if tmp.endswith(".tex.jinja"):
    TEXFILE = True

with open(yam) as fd:
    yamtext = fd.read()
    #if TEXFILE:
    #    yamtext = yamtext.replace(r'&', r'\\&')
    #    yamtext = yamtext.replace(r'_', r'\\_')
    #    yamtext = yamtext.replace(r'%', r'\\%')
    #    yamtext = yamtext.replace(r'$', r'\\$')
    #    yamtext = yamtext.replace(r'?', r'\\?')
    data = load(yamtext)

with open(tmp) as fd:
    template = fd.read()

env = Environment(lstrip_blocks=True, trim_blocks=True)
if TEXFILE:
    env.block_start_string = "[[%"
    env.block_end_string = "%]]"
    env.variable_start_string = "[["
    env.variable_end_string = "]]"
    env.comment_start_string = "[[="
    env.comment_end_string = "=]]"
render = env.from_string(template)
print render.render(data)
