#!/bin/sh

DSR_TRIM="./dsr-trim"
TRESTLE="./trestle"

set -e

if [ ! -d "$DSR_TRIM" ]; then
    echo "dsr-trim submodule not found. Run from project root directory?"
    exit 1
fi

if [ ! -d "$TRESTLE" ]; then
    echo "trestle submodule not found. Run from project root directory?"
    exit 1
fi

echo "Building dsr-trim..."
cd "$DSR_TRIM"
git checkout main
git pull
make
cd ..

echo ""
echo "Building trestle..."
cd "$TRESTLE"
git checkout dev
git pull
lake update
lake build srcheck
cd ..

echo ""
echo "Making symlinks for lean-check..."
ln -sf "$TRESTLE/.lake/build/bin/srcheck" ./lean-check

echo "All done!"