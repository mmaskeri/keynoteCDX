# keynoteCDX

Copyright (c) 2020 Mark A. Maskeri (see LICENSE)

Extracts ChemDraw CDX data embedded in Keynote documents; complementary to keyClip utility (github.com/mmaskeri/keyClip).

For ChemDraw schemes embedded in Keynote documents from early version of ChemDraw, Keynote archives the graphic information in the .pict format, which includes an instance of the relevant binary CDX. By locating the header for this binary, the graphics may be extracted from Keynote documents in editable CDX format.

This utility operates on a copy of the provided Keynote document. Script is provided as is.

Setup
-----
keynoteCDX requires executable permissions; grant with `sudo chmod +x keynoteCDX.sh`.

Usage
-----
Usage proceeds as `_path_/keynoteCDX.sh <filename>.key` and provides CDX files (if available) in the created directory "_filename_\_cdxFromPict"

Troubleshooting
---------------
If the script does not locate any CDX information, verify that the .pict format is in use:
- Make a copy of your Keynote file and change the extension to .zip
- Open the .zip; if there are not .pict files in this directory, consider attempting to use the keyClip utility (_vide supra_)
