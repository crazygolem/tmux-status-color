# Determines which of black or white has the highest contrast with the specified
# color.
#
# USAGE
#
#     awk -f legible_with.awk RRGGBB
#
# Resources:
# - https://contrastchecker.online/color-relative-luminance-calculator
# - https://contrast-ratio.com

function parsehex(hex,    i, dec) {
    for (i = 1; i <= length(hex); i++)
        dec = dec * 16 + index("123456789abcdef", substr(hex, i, 1))

    return dec
}

# Luminance of single color channel
# https://www.w3.org/TR/WCAG20/#relativeluminancedef
function lum(chan) {
    return (chan <= 0.03928) ? chan / 12.92 : ((chan + 0.055) / 1.055) ^ 2.4
}

# https://www.w3.org/TR/WCAG20/#relativeluminancedef
function relative_luminance(col,    r, g, b) {
    r = parsehex(substr(col, 1, 2)) / 255
    g = parsehex(substr(col, 3, 2)) / 255
    b = parsehex(substr(col, 5, 2)) / 255

    return 0.2126 * lum(r) + 0.7152 * lum(g) + 0.0722 * lum(b)
}

# https://www.w3.org/TR/WCAG20/#contrast-ratiodef
function contrast_ratio(col1, col2,    lum1, lum2, tmp) {
    lum1 = relative_luminance(col1)
    lum2 = relative_luminance(col2)

    if (lum1 < lum2) { tmp = lum1; lum1 = lum2; lum2 = tmp }
    return (lum1 + 0.05) / (lum2 + 0.05)
}

function highest_contrast(colref, col1, col2,    ratio1, ratio2) {
    ratio1 = contrast_ratio(colref, col1)
    ratio2 = contrast_ratio(colref, col2)

    return (ratio1 < ratio2) ? col2 : col1
}

BEGIN {
    print highest_contrast(ARGV[1], "000000", "ffffff")
}
