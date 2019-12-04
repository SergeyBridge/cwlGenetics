#!/usr/bin/env cwl-runner

# run with: cwl-runner createFiles.cwl --input_dir input
cwlVersion: v1.0
class: ExpressionTool

#requirements:
#    - class: InlineJavascriptRequirement



inputs:
  indir:
    Directory

outputs:
  bamFiles: 
    type: File[]

expression: |
  ${
    var r = [];
    var l = inputs.indir.listing
    for (var i=0; i<l.length; i++) {
      var name = l[i].basename
      var le = name.length
      if (name[0] != "." && 
          name[le-1] == "m" &&
          name[le-2] == "a" &&
          name[le-3] == "b" &&
          name[le-4] == "." 
          ) {
        r.push( l[i] )
      }              
    } 
    return r = {'bamFiles': r}
  }
