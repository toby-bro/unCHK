#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <directory> [--all]"
    exit 1
fi

cd "$1" || { echo "Directory not found"; exit 1; }

rename_all=false
if [ "$2" == "--all" ]; then
    rename_all=true
fi

for file in *; do
    [ -f "$file" ] || continue

    if [ "$rename_all" = false ] && [[ "${file##*.}" != "CHK" ]]; then
        continue
    fi

    mime_type=$(file --mime-type -b "$file")

    case "$mime_type" in
    audio/aac)
        ext="aac"
        ;;
    application/x-abiword)
        ext="abw"
        ;;
    application/octet-stream)
        ext="arc"
        ;;
    video/x-msvideo)
        ext="avi"
        ;;
    application/vnd.amazon.ebook)
        ext="azw"
        ;;
    application/octet-stream)
        ext="bin"
        ;;
    image/bmp)
        ext="bmp"
        ;;
    application/x-bzip)
        ext="bz"
        ;;
    application/x-bzip2)
        ext="bz2"
        ;;
    application/x-csh)
        ext="csh"
        ;;
    text/css)
        ext="css"
        ;;
    text/csv)
        ext="csv"
        ;;
    application/msword)
        ext="doc"
        ;;
    application/vnd.openxmlformats-officedocument.wordprocessingml.document)
        ext="docx"
        ;;
    application/vnd.ms-fontobject)
        ext="eot"
        ;;
    application/epub+zip)
        ext="epub"
        ;;
    image/gif)
        ext="gif"
        ;;
    text/html)
        ext="html"
        ;;
    image/x-icon)
        ext="ico"
        ;;
    text/calendar)
        ext="ics"
        ;;
    application/java-archive)
        ext="jar"
        ;;
    image/jpeg)
        ext="jpeg"
        ;;
    application/javascript)
        ext="js"
        ;;
    application/json)
        ext="json"
        ;;
    audio/midi)
        ext="midi"
        ;;
    video/mpeg)
        ext="mpeg"
        ;;
    application/vnd.apple.installer+xml)
        ext="mpkg"
        ;;
    application/vnd.oasis.opendocument.presentation)
        ext="odp"
        ;;
    application/vnd.oasis.opendocument.spreadsheet)
        ext="ods"
        ;;
    application/vnd.oasis.opendocument.text)
        ext="odt"
        ;;
    audio/ogg)
        ext="oga"
        ;;
    video/ogg)
        ext="ogv"
        ;;
    application/ogg)
        ext="ogx"
        ;;
    font/otf)
        ext="otf"
        ;;
    image/png)
        ext="png"
        ;;
    application/pdf)
        ext="pdf"
        ;;
    application/vnd.ms-powerpoint)
        ext="ppt"
        ;;
    application/vnd.openxmlformats-officedocument.presentationml.presentation)
        ext="pptx"
        ;;
    application/x-rar-compressed)
        ext="rar"
        ;;
    application/rtf)
        ext="rtf"
        ;;
    application/x-sh)
        ext="sh"
        ;;
    image/svg+xml)
        ext="svg"
        ;;
    application/x-shockwave-flash)
        ext="swf"
        ;;
    application/x-tar)
        ext="tar"
        ;;
    image/tiff)
        ext="tiff"
        ;;
    application/typescript)
        ext="ts"
        ;;
    font/ttf)
        ext="ttf"
        ;;
    application/vnd.visio)
        ext="vsd"
        ;;
    audio/x-wav)
        ext="wav"
        ;;
    audio/webm)
        ext="weba"
        ;;
    video/webm)
        ext="webm"
        ;;
    image/webp)
        ext="webp"
        ;;
    font/woff)
        ext="woff"
        ;;
    font/woff2)
        ext="woff2"
        ;;
    application/xhtml+xml)
        ext="xhtml"
        ;;
    application/vnd.ms-excel)
        ext="xls"
        ;;
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
        ext="xlsx"
        ;;
    application/xml)
        ext="xml"
        ;;
    application/vnd.mozilla.xul+xml)
        ext="xul"
        ;;
    application/zip)
        ext="zip"
        ;;
    video/3gpp)
        ext="3gp"
        ;;
    audio/3gpp)
        ext="3gp"
        ;;
    video/3gpp2)
        ext="3g2"
        ;;
    audio/3gpp2)
        ext="3g2"
        ;;
    application/x-7z-compressed)
        ext="7z"
        ;;
    application/vnd.ms-office) # unknown office type : one must try manually
        ext="office"
        ;;
    *)  # Add more MIME types and corresponding extensions as needed
        echo "Unknown file type for $file. Skipping: $mime_type"
        continue
        ;;
    esac

    new_file="${file%.*}.$ext"

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

