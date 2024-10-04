# unCHK

## Presentation

This simple script is meant to be handy once Windows decided to play dumb and rename all the files on USB sticks to `FILE[0-9]+.CHK`. This script just tries to identify the [mime-type](https://en.wikipedia.org/wiki/Media_type) of the so called "broken" files, then, using [MDN's documentation](https://developer.mozilla.org/fr/docs/Web/HTTP/MIME_types/Common_types), it fixes the extensions accordingly.

## Usage

```bash
./unCHK.sh <dir> [--all]
# dir is the dir to be repaired 
# use --all if you also want to rename files which do not have the .CHK file extension
```

## File Types

The list of correspondances is based on the USB keys I have had to repair.

One case must nevertheless be mentionned :
The `.office` file type does not exist. The script renames a file like this, when the file cannot be identified for certain, but seems to be a file type provided by microsoft office suite.

The list of correspondances can be improved, feel free to do so.

Hoping this will help somebody else repair it's USB sticks once windows bullied it.

