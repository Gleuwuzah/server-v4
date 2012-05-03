#!/bin/sh

ND="NaturalDocs"
if [ -x "$(which naturaldocs)" ]; then
    ND="naturaldocs"
fi

if [ ! -d "output" ]; then
    mkdir output
fi

${ND} -i ../script -p . -o HTML output -s Small
