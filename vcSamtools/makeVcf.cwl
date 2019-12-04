#!/usr/bin/env cwl-runner

# run with: cwltools referenceDict.cwl --input_fa input/22.fa

cwlVersion: v1.0
class: CommandLineTool

inputs:
  fileBcf:
    type: File
    inputBinding:
      position: 1
      
outputs:
  outfiles:
  #bcfFile:
    type: stdout

stdout:
  samtools.vcf

baseCommand: [bcftools, view, -vcg]
  

