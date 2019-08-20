#!/usr/bin/bash

inputBam=$1
outputPrefix=$2

samtools view -H ${inputBam} > ${outputPrefix}.sam
samtools view ${inputBam}  | grep -vP '^@' | perl -nale 'if($_ =~/NM:i:(\d+)/){$distance=$1;$readLength=length($F[9]); $identity = 100-$distance/$readLength*100;  if($identity>=98){print $_};}'  >> ${outputPrefix}.sam
samtools view -h -b ${outputPrefix}.sam > ${outputPrefix}.bam

