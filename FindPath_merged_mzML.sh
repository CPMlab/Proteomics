#!/bin/bash

MZML_ROOT="01.mzml"
OUT_TSV="grouped_mzml_paths.tsv"

# 임시 파일 초기화
> "$OUT_TSV"

# 타입별 path 리스트를 만들기 위한 associative array 사용 (bash 4+)
declare -A grouped_paths

# 파일들 순회
while IFS= read -r FILE; do
    TYPE=$(basename "$(dirname "$(dirname "$FILE")")")  # Proteome / GlycoProteome / PhosphoProteome
    FILE_QUOTED="\"$FILE\""

    # 쉼표로 연결하여 추가
    if [ -z "${grouped_paths[$TYPE]}" ]; then
        grouped_paths[$TYPE]="$FILE_QUOTED"
    else
        grouped_paths[$TYPE]="${grouped_paths[$TYPE]},$FILE_QUOTED"
    fi
done < <(find "$MZML_ROOT" -type f -name "*_merged.mzML")

# 헤더 작성
echo -e "type\tpaths" > "$OUT_TSV"

# 결과 출력
for TYPE in "${!grouped_paths[@]}"; do
    echo -e "${TYPE}\t${grouped_paths[$TYPE]}" >> "$OUT_TSV"
done

echo "✅ Grouped TSV created at: $OUT_TSV"

