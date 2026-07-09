#!/bin/bash

g++ "$(basename $(pwd)).cpp" -o "$(basename $(pwd))" -std=c++17 -g -fsanitize=address -fsanitize=undefined