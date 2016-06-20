#!/usr/bin/env python

import fileinput
import re
import textwrap

def main():
    wc = textwrap.TextWrapper(replace_whitespace=False, break_long_words=False)
    for line in fileinput.input():
        twlines = wc.wrap(line)
        match = re.match(r'\W+', line)
        if match and len(twlines) > 1:
            indent = match.end() * ' '
            print ('\n' + indent).join(twlines)
        else:
            print '\n'.join(twlines)

if __name__ == "__main__":
    main()
