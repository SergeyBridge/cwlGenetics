#!/usr/bin/env cwl-runner

# run with: cwltools referenceDict.cwl --input_fa input/22.fa

cwlVersion: v1.0
class: CommandLineTool

inputs:
  input_fa:
    type: File
    inputBinding:
      position: 1
      prefix: "-uf"


  BAM:
    type: File
    inputBinding:
      position: 2
      
outputs:
  fileBcf:
    type: stdout

stdout:
  $(inputs.BAM.nameroot).bcf

baseCommand: [samtools, mpileup]
  

