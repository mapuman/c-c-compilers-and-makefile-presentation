#! /bin/bash

echo "Testujemy kompilacje gcc:"
gcc main.c -O2 -o result
./result

echo 'Testujemy kompilacje g++:'
g++ test.cpp -std=c++20 -o res
./res
