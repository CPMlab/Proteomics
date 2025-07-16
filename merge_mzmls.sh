#!/bin/bash

MZML_ROOT="01.mzml"

echo "Starting mzML merging..."

find "$MZML_ROOT" -type d -name individual | while read INDIV_DIR; do
    SAMPLE_DIR=$(dirname "$INDIV_DIR")
    SAMPLE_NAME=$(basename "$SAMPLE_DIR")

    PREFIX=$(echo "$SAMPLE_NAME" | cut -d'_' -f2)

    OUT_FILE="$SAMPLE_DIR/${PREFIX}_merged.mzML"


    echo "[$SAMPLE_NAME] merging files in $INDIV_DIR"
    FileMerger -in "$INDIV_DIR"/*.mzML -out "$OUT_FILE"
    echo "[$SAMPLE_NAME] merged to $OUT_FILE"
done

echo "All mzML files merged."

