#!/bin/bash

INPUT_DIR="/path/to/OG/folder"
OUTPUT_DIR="/path/to/dest/folder"

mkdir -p "$OUTPUT_DIR"

for f in "$INPUT_DIR"/*.{mkv,mp4,webm}; do
    [ -f "$f" ] || continue

    filename=$(basename -- "$f")
    name="${filename%.*}"
    outputFile="$OUTPUT_DIR/${name}.mp4"

    # If already exist on the right
    if [ -f "$outputFile" ]; then
        echo "Già convertito, salto: $filename"
        continue
    fi

    echo "Try GPU conversion: $filename"
    ffmpeg -y -hwaccel cuda -i "$f" -c:v h264_nvenc -preset p3 -cq 20 -c:a copy "$outputFile"

    if [ $? -eq 0 ]; then
        echo "GPU conversion OK: $filename"
    else
        echo "GPU Failed, using software: $filename"
        ffmpeg -y -i "$f" -c:v libx264 -preset medium -crf 20 -c:a copy "$outputFile"
        if [ $? -eq 0 ]; then
            echo "Software conversion succed: $filename"
        else
            echo "Software failed: $filename"
        fi
    fi
done