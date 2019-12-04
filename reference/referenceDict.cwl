#!/usr/bin/env cwl-runner

# run with: cwltools referenceDict.cwl --input_fa input/22.fa

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: 
      - $(inputs.input_fa)

inputs:
  input_fa:
    type: File
    inputBinding:
      position: 1
      prefix: "R="
      
outputs:
  dictFile: 
    type: File
    outputBinding:
      glob: $(inputs.input_fa.nameroot).dict

baseCommand: java
arguments: 
  - -jar
  - /opt/picard/picard.jar
  - CreateSequenceDictionary
  - O=$(inputs.input_fa.nameroot).dict