#!/bin/bash

echo ""
echo "======================================"
echo "=== Old Keynote -> CDX Last Resort ==="
echo "===          2020 Maskeri          ==="
echo "======================================"
echo ""
echo "Attempts to find embedded CDX data in embedded Keynote 09-style OSX .pict files."
echo ""

if [ -z ${1} ]
then
    echo "!!! No input provided. Consumes as input name of Keynote '09 file as only argument."
    echo ""
    exit
fi

DIR=`uuidgen`
INFILE=${1}
mkdir ${DIR}

echo "... Provided input file: \"${INFILE}\""
echo ""
echo "... CDX data parsed from .pict files will be placed in directory \"${INFILE%.*}_cdxFromPict/\" if .pict files are located"
echo ""
echo "... Working directory \"${DIR}\" will be removed on clean exit."
echo ""

mkdir -p ${INFILE%.*}_cdxFromPict/
cp ${INFILE} ${DIR}/
cd ${DIR}/
mv ${INFILE} ${INFILE}.zip

echo "... Unzipping ${INFILE}"
echo ""

unzip -q ${INFILE}.zip

PICTS=`ls *.pict`

if [ -z "${PICTS}" ]
then
    echo "!!! No embedded .pict files located. Attempt other methods of CDX/CDXML recovery or remake graphics."
    echo ""
    exit
fi

echo "... .pict files located; attempting recovery"
echo ""

for PICT in ${PICTS}
do
    sed -n '/VjCD0100/,$p' ${PICT} | perl -pe 's/.*(VjCD0100)/$1/' > ${PICT%.*}.cdx
done

echo "... Cleaning up and removing files of zero size"
echo ""

find . -type f -empty -delete

NUMFOUND=`ls *.cdx | wc -l`

mv *.cdx ../${INFILE%.*}_cdxFromPict/
cd ..
rm -r ${DIR}

echo "... Recovered ${NUMFOUND} .cdx file(s) from ${INFILE}"
echo ""
echo "... done"
