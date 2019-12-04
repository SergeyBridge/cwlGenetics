#!/usr/bin/env cwl-runner

# run with: cwl-runner "createFiles copy".cwl --input_dir input

cwlVersion: v1.0
class: Workflow


inputs: 
  fileBAM: 
    type: File
  input_fa:
    type: File

outputs: 
  outfiles:
    type: File
    outputSource: makeVcf/outfiles


steps:
  makeBcf:
    run: makeBcf.cwl
    in:
      BAM: [fileBAM]
      input_fa: input_fa

    out:
      [fileBcf]  
  makeVcf:
    run: makeVcf.cwl
    in:
      fileBcf: [makeBcf/fileBcf]
    out:
      [outfiles]

