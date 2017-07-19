#!/usr/bin/env python

import sys
from subprocess import check_output, STDOUT, CalledProcessError


def print_link_test_result(command_output):
    # Constant string patterns
    NEW_PAGE_TEST_START_REGEX = "Getting links from:"
    BROKEN_PAGE_START_REGEX = "BROKEN"
    PAGE_TEST_END_REGEX = "Finished! "

    # Initialize flags with happy case
    current_page = ""
    current_page_broken = False
    current_page_broken_links = ""

    for line in command_output.splitlines():
        if line.startswith(NEW_PAGE_TEST_START_REGEX):
            # New page test is starting. Reset the flags
            current_page = line.split(NEW_PAGE_TEST_START_REGEX)[1]
            current_page_broken = False
            current_page_broken_links = ""

        if line.find(BROKEN_PAGE_START_REGEX) != -1:
            current_page_broken = True
            current_page_broken_links += "\n" + line.split(BROKEN_PAGE_START_REGEX)[1]

        if line.startswith(PAGE_TEST_END_REGEX):
            if current_page_broken:
                print("URL - " + current_page)
                print("Broken Links")
                print(current_page_broken_links)

# Command to check broken links
cmd = "blc http://mxnet.io/ -ro"
print("START - Broken link test")
try:
    command_output = check_output(cmd, stderr=STDOUT, shell=True)
    print("No broken links in http://mxnet.io/")
    print("END - Broken link test")
    sys.exit(0)
except CalledProcessError as ex:
    print_link_test_result(ex.output)
    print("END - Broken link test")
    sys.exit(-1)
