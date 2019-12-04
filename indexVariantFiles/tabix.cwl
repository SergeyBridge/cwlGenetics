#!/usr/bin/env cwl-runner

# run with: cwl-runner indexing.cwl --fileBAM sample.bam

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: 
      - $(inputs.in_gz)

inputs:
  in_gz:
    type: File
    inputBinding:
      position: 1
      valueFrom:
        $(self.basename)
      
outputs:
  outfiles:
    type: File
    secondaryFiles: .tbi
    outputBinding: 
      glob: $(inputs.in_gz.basename)

#stdout: $(inputs.in_gz.basename).tbi

baseCommand: [tabix, -p, vcf]
