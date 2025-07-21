#!/usr/bin/env bash

MZML_ROOT="01.mzml"
OUT_TSV="grouped_mzml_paths.tsv"

> "$OUT_TSV"
declare -A grouped_paths

while IFS= read -r FILE; do
    TYPE=$(basename "$(dirname "$(dirname "$(dirname "$FILE")")")")
    FILE_QUOTED="\"$FILE\""

    if [ -z "${grouped_paths[$TYPE]}" ]; then
        grouped_paths[$TYPE]="$FILE_QUOTED"
    else
        grouped_paths[$TYPE]="${grouped_paths[$TYPE]},$FILE_QUOTED"
    fi
done < <(find "$MZML_ROOT" -type f -name "*_merged.mzML")

echo -e "type\tpaths" > "$OUT_TSV"
for TYPE in "${!grouped_paths[@]}"; do
    echo -e "${TYPE}\t${grouped_paths[$TYPE]}" >> "$OUT_TSV"
done

echo "✅ Grouped TSV created at: $OUT_TSV"

