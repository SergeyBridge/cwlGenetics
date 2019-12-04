#!/usr/bin/env cwl-runner

# run with: cwltools referenceDict.cwl --input_fa input/22.fa

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: 
      - $(inputs.input_fa)
      - $(inputs.fileBAM)

inputs:
  input_fa:
    type: File
    inputBinding:
      position: 1
      prefix: "-f"
      valueFrom: $(self.basename)

  fileBAM:
    type: File
    inputBinding:
      position: 2
      prefix: -b
      valueFrom: $(self.basename)
      
outputs:
  outfiles:
    type: File
    outputBinding:
      glob: freebayes.vcf



baseCommand: [freebayes]
arguments: 
  - --vcf
  - freebayes.vcf
  - --min-base-quality
  - "0"
  

