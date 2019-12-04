#!/usr/bin/env cwl-runner

# run with: cwl-runner "createFiles copy".cwl --input_dir input

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
      valueFrom: $(self.basename)


      
outputs:
  faFile:
    type: File
    outputBinding: 
      glob: $(inputs.input_fa.basename).fai
     


baseCommand: ["samtools", "faidx"]
