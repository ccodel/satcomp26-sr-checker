#!/bin/sh

# Usage: ./check.sh <cnf> <proof>

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path-to-cnf-file> <path-to-proof-file>"
    exit 1
fi

CNF="$1"
PROOF="$2"
LSR_PROOF="${PROOF%.*}.lsr"

DSR_TRIM="./dsr-trim/dsr-trim"
LEAN_CHECK="./lean-check"

if [ ! -f "$CNF" ]; then
    echo "CNF file not found: $CNF"
    exit 1
fi

if [ ! -f "$PROOF" ]; then
    echo "Proof file not found: $PROOF"
    exit 1
fi

# First, produce the LSR file, in ASCII (-A), even if the proof is compressed
echo "c Running dsr-trim..."
"$DSR_TRIM" "$CNF" "$PROOF" "$LSR_PROOF" -A > /dev/null 2>&1

# Check that dsr-trim was successful
if [ $? -ne 0 ]; then
    echo "c Error: dsr-trim failed to produce LSR file."
    exit 1
else
    echo "c dsr-trim successful, proof at: $LSR_PROOF"
fi

# Next, run the Lean checker
echo "c "
echo "c Running lean-check..."
"$LEAN_CHECK" "$CNF" "$LSR_PROOF" -b

if [ $? -ne 0 ]; then
    echo "c Error: lean-check failed."
    exit 1
fi
