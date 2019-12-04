#!/usr/bin/env cwl-runner

# run with: cwl-runner "createFiles copy".cwl --input_dir input

cwlVersion: v1.0
class: Workflow
 
inputs: 
  input_dir: 
    type: Directory

outputs: 
  bamFiles:
    type: File[]
    outputSource: makeIndex/bamFiles


steps:
  read:
    run: readDir.cwl
    in:
      indir: input_dir
    out:
      [bamFiles]
  makeIndex:
    scatter: fileBAM
    run: indexing.cwl
    in:
      fileBAM: [read/bamFiles]
    out:
      [bamFiles]

