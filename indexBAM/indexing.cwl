#!/usr/bin/env cwl-runner

# run with: cwl-runner indexing.cwl --fileBAM sample.bam

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: [ $(inputs.fileBAM) ]


inputs:
  fileBAM:
    type: File
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
      
outputs:
  bamFiles:
    type: File
    secondaryFiles: .bai
    outputBinding: 
      glob: $(inputs.fileBAM.basename)

#stdout: $(inputs.fileBAM.basename).bai

baseCommand: [samtools, index]
