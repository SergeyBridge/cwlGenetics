#!/usr/bin/env cwl-runner

# run with: cwl-runner "createFiles copy".cwl --input_dir input

cwlVersion: v1.0
class: ExpressionTool 
 
requirements:
  - class: InlineJavascriptRequirement

expression: |
  ${
    inputs.main_file["secondaryFiles"] =  inputs.secondary_files
    var arr = {
      "file_with_secondary_files": inputs.main_file
    }
    return arr
  }


doc: Step to put secondary input files in the same folder as a main file
inputs:
  main_file:
    type: File
  secondary_files:
    type: File[]

outputs:
  file_with_secondary_files:
    type: File


