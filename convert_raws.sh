#!/bin/bash

RAW_ROOT="00.raw"
MZML_ROOT="01.mzml"
THREADS=4

echo "🧪 Starting raw → mzML conversion (parallel)..."

# 모든 .raw 파일 찾기
find "$RAW_ROOT" -type f -name "*.raw" > raw_list.txt

# 병렬 변환
cat raw_list.txt | parallel -j $THREADS '
  RAW_FILE={}
  RAW_NAME=$(basename "$RAW_FILE")
  SAMPLE_DIR=$(basename $(dirname "$RAW_FILE"))
  SAMPLE_PARENT=$(basename $(dirname $(dirname "$RAW_FILE")))

  SAMPLE_NAME="${SAMPLE_PARENT}_${SAMPLE_DIR}"
  OUT_DIR="'$MZML_ROOT'/$SAMPLE_NAME/individual"

  mkdir -p "$OUT_DIR"

  echo "   🔸 Converting: $RAW_NAME → $OUT_DIR"
  ThermoRawFileParser -i "$RAW_FILE" -o "$OUT_DIR" -f 1
'

echo "✅ All .raw files converted in parallel."

