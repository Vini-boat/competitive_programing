#!/bin/bash

g++ "$(basename $(pwd)).cpp" -o "$(basename $(pwd))" -std=c++17 -O2 -Wall -Wextra -Wshadow