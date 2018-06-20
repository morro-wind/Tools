#!/bin/bash
for i in 'S0C' 'S1C' 'S0U' 'S1U' 'EC' 'EU' 'OC' 'OU' 'PC' 'PU' 'S0' \
    'S1' 'E' 'O' 'P' 'YGC' 'YGCT' 'FGC' 'FGCT' 'GCT' 'NGCMN' 'NGCMX' \
    'NGC' 'OGCMN' 'OGCMX' 'OGC' 'PGCMN' 'PGCMX' 'PGC' \
    'TT' 'MTT' 'DSS' 'S0CMX' 'S1CMX' 'ECMX'
do
    python jvmstat.py 8080 $i
done
