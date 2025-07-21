#!/bin/bash

RAW_ROOT="00.raw"
MZML_ROOT="01.mzml"
THREADS=15

echo "🧪 Starting raw → mzML conversion (parallel)..."

# 모든 .raw 파일 찾기
find "$RAW_ROOT" -type f -name "*.raw" > raw_list.txt

# 병렬 변환
cat raw_list.txt | parallel -j $THREADS '
  RAW_FILE="{}"
  REL_PATH="${RAW_FILE#'$RAW_ROOT'/}"               # raw_root 기준 상대 경로
  RAW_NAME=$(basename "$RAW_FILE")
  TARGET_DIR="'$MZML_ROOT'/$(dirname "$REL_PATH")/individual"

  mkdir -p "$TARGET_DIR"

  echo "   🔸 Converting: $RAW_NAME → $TARGET_DIR"
  ThermoRawFileParser -i "$RAW_FILE" -o "$TARGET_DIR" -f 1
'

echo "✅ All .raw files converted in parallel."

