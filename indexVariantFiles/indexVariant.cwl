#!/usr/bin/env cwl-runner

# run with: cwltool --outdir output host/variant-calling-cwl.cwl --reference_genome host/data/22.fa --input_dir host/input/

cwlVersion: v1.0
class: Workflow


requirements:
    - class: ShellCommandRequirement
    - class: MultipleInputFeatureRequirement
    - class: InlineJavascriptRequirement
    - class: SubworkflowFeatureRequirement

inputs: 
  input_vcf:
    type: File[]

outputs: 
  outfiles:
    type: File[]
    outputSource: [ tabix/outfiles ]


steps:
  bgzip:
    run: bgzip.cwl
    scatter: in_vcf
    in: 
      in_vcf: input_vcf
    out:
      [outfiles]

  tabix:
    run: tabix.cwl
    scatter: in_gz
    in: 
      in_gz: bgzip/outfiles
    out:
      [outfiles]
  
  #sortVariantFiles:
  # run: sortFiles.cwl
  #  in:
  #    infiles: tabix/outfiles
  #  out:
  #    [outfiles]


  