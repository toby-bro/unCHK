#!/bin/bash

# Check if a directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Navigate to the specified directory
cd "$1" || { echo "Directory not found"; exit 1; }

# Loop through all files in the directory
for file in *; do
    # Skip if it's not a file
    [ -f "$file" ] || continue

    # Get the MIME type of the file
    mime_type=$(file --mime-type -b "$file")

    # Extract the extension from the MIME type
    case "$mime_type" in
	application/msword)
	    new_ext="docx"
	    ;;
	application/x-wine-extension-ini)
	    new_ext="ini"
	    ;;
	text/rtf)
	    new_ext="rtf"
	    ;;
	application/javascript)
	    new_ext="js"
	    ;;
	video/x-ms-asf)
	    new_ext="asf"
	    ;;
	application/vnd.openxmlformats-officedocument.presentationml.presentation)
	    new_ext="pptx"
	    ;;
	application/vnd.ms-powerpoint)
	    new_ext="pptx"
	    ;;
	application/vnd.ms-excel)
	    new_ext="xlsx"
	    ;;
	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
	    new_ext="xlsx"
	    ;;
	image/gif)
            new_ext="gif"
            ;;
        application/vnd.oasis.opendocument.text)
            new_ext="odt"
            ;;
	application/vnd.openxmlformats-officedocument.wordprocessingml.document)
            new_ext="docx"
            ;;
        application/vnd.oasis.opendocument.presentation)
            new_ext="odp"
            ;;
        audio/mpeg)
            new_ext="mp3"
            ;;
        video/mp4)
            new_ext="mp4"
            ;;
        text/plain)
            new_ext="txt"
            ;;
        image/jpeg)
            new_ext="jpg"
            ;;
        image/png)
            new_ext="png"
            ;;
        application/pdf)
            new_ext="pdf"
            ;;
        application/zip)
            new_ext="zip"
            ;;
	image/tiff)
	    new_ext="tff"
	    ;;
	application/x-tar)
	    new_ext="tar"
	    ;;
	application/vnd.ms-office) # unknown office file one must try manually
	    new_ext="office"
	    ;;
        # Add more MIME types and corresponding extensions as needed
        *)
            echo "Unknown file type for $file. Skipping: $mime_type"
            continue
            ;;
    esac

    # Construct the new file name
    new_file="${file%.*}.$new_ext"

    # Rename the file if the new name is different
    if [ "$file" != "$new_file" ]; then
        if [ ! -f "$new_file" ]; then
            mv -i "$file" "$new_file" && echo "Renamed '$file' to '$new_file'"
        else
            echo "'$new_file' already exists. Skipping rename."
        fi
    else
        echo "'$file' already has the correct extension."
    fi
done

