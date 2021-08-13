# markdown.sh

script to allow viewing of markdown files.  [pandoc](https://pandoc.org) is required.

The script will run the markdown formatted file through pandoc, then attempt to
open a browser tab (with `xdg-open` on Linux or `open` on OSx).

The resulting html file is thrown away once the browser has read it (well, the
script pauses for 3 seconds to allow time for the browser to start and read the
file).
