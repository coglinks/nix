#!/usr/bin/bash

handle_image() {
    local DEFAULT_SIZE="1920x1080"
    local FILE_PATH="${2}"  # Define the FILE_PATH
    local IMAGE_CACHE_PATH="${3}"  # Define the IMAGE_CACHE_PATH
    local mimetype="${1}"

    case "${mimetype}" in
        # SVG
        image/svg+xml|image/svg)
            convert -- "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && return 6 || return 1
            ;;

        # Video
        video/*)
            # Thumbnail
            ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && return 6 || return 1
            ;;

        # PDF
        application/pdf)
            pdftoppm -f 1 -l 1 \
                     -scale-to-x "${DEFAULT_SIZE%x*}" \
                     -scale-to-y -1 \
                     -singlefile \
                     -jpeg -tiffcompression jpeg \
                     -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" \
                && return 6 || return 1
            ;;

        *)
            echo "Unsupported mimetype: ${mimetype}"
            return 1
            ;;
    esac
}
