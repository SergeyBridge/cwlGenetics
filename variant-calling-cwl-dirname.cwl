#!/usr/bin/env cwl-runner

# run with: cwltool --outdir output host/variant-calling-cwl.cwl --reference_genome host/data/22.fa --input_dir host/input/

cwlVersion: v1.0
class: Workflow


requirements:
    - class: ShellCommandRequirement
    - class: ScatterFeatureRequirement
    - class: MultipleInputFeatureRequirement
    - class: InlineJavascriptRequirement
    #- class: DockerRequirement
    #  dockerPull: parseq/stepik-variant-calling-tools-cwl
    - class: SubworkflowFeatureRequirement

inputs: 
  input_dir: 
    type: Directory
  reference_genome:
    type: File
  #input_bam:
  #  type: File

outputs: 
  output:
    type: File
    #outputSource: variantCallingSamtools/outfiles
    outputSource: [
      variantCallingFreebayes/fileVcf,
      variantCallingSamtools/outfiles,
      variantCallingHaplotype/fileVcf,
      #reference/file_with_secondary_files,
       ]


steps:
  referenceIndex:
    run: reference/referenceIndex.cwl
    in: 
      input_fa: reference_genome
      input_dict: referenceDict/dictFile
    out:
      [faFile]

  referenceDict:
    run: reference/referenceDict.cwl
    in: 
      input_fa: reference_genome
    out:
      [dictFile]

  reference:
    run: reference/reference.cwl
    in:
      main_file: reference_genome
      secondary_files: 
        - referenceDict/dictFile
        - referenceIndex/faFile
    out:
      [file_with_secondary_files]
      
  indexBAM:
    run: indexBAM/indexBAM.cwl
    in:
      input_dir: input_dir
    out:
      [bamFiles]
  
  variantCallingSamtools:
    scatter: fileBAM
    run: vcSamtools/vcSamtools.cwl
    in:
      fileBAM: [indexBAM/bamFiles]
      input_fa: [ reference/file_with_secondary_files ]
    out:
      [outfiles]
  
  variantCallingFreebayes:
    scatter: fileBAM
    run: vcFreebayes/vcFreebayes.cwl
    in:
      fileBAM: [indexBAM/bamFiles]
      input_fa: [ reference/file_with_secondary_files ]
      
    out:
      [fileVcf]
  
  variantCallingHaplotype:
    scatter: fileBAM
    run: vcHaplotype/vcHaplotype.cwl
    in:
      fileBAM: [indexBAM/bamFiles]
      input_fa: [ reference/file_with_secondary_files ]
  #    input_dict: [ referenceDict/dictFile]
    out:
      [fileVcf]

