#!/usr/bin/env cwl-runner

# run with: cwl-runner indexing.cwl --fileBAM sample.bam

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: [ $(inputs.in_vcf) ]


inputs:
  in_vcf:
    type: File
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
      
outputs:
  outfiles:
    type: File
    secondaryFiles: 
      - $(inputs.in_vcf)
    outputBinding: 
      glob: $(inputs.in_vcf.basename).gz

#stdout: $(inputs.in_vcf.basename).gz

baseCommand: [bgzip]
