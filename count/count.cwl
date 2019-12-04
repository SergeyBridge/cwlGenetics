#!/usr/bin/env cwl-runner

# run with: cwl-runner indexing.cwl --fileBAM sample.bam

cwlVersion: v1.0
class: CommandLineTool

#requirements:
#  InitialWorkDirRequirement:
#    listing: [ $(inputs.fileBAM) ]


inputs:
  infile:
    type: File
    inputBinding:
      position: 1
      prefix: -c

  sample:
    type: File
      
outputs:
  output:
    type: stdout

stdout: $(inputs.sample.nameroot)_count.txt

baseCommand: [grep, -v, "^#" ]
