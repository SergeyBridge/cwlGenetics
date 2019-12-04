#!/usr/bin/env cwl-runner

# run with: cwltool --outdir output host/variant-calling-cwl.cwl --reference_genome host/data/22.fa --input_bam host/input/170172.bam

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
  reference_genome:
    type: File
  input_bam:
    type: File

outputs: 
  output:
    type: File
    #outputSource: variantCallingSamtools/outfiles
    outputSource: [
      countVariants/output,
      #convertVcfFiles/outfiles,
      #indexVariantFiles/outfiles,
      variantCallingFreebayes/outfiles,
      variantCallingHaplotype/outfiles,
      variantCallingSamtools/outfiles,
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
    run: indexBAM/indexing.cwl
    in:
      fileBAM: input_bam
    out:
      [bamFiles]
  
  variantCallingSamtools:
    #scatter: fileBAM
    run: vcSamtools/vcSamtools.cwl
    in:
      fileBAM: [indexBAM/bamFiles]
      input_fa: [ reference/file_with_secondary_files ]
    out:
      [outfiles]
  
  variantCallingFreebayes:
    #scatter: fileBAM
    run: vcFreebayes/vcFreebayes.cwl
    in:
      #fileBAM: [indexBAM/bamFiles]
      #input_fa: [ reference/file_with_secondary_files ]
      fileBAM: [indexBAM/bamFiles]
      input_fa: [ reference/file_with_secondary_files ]
      
    out:
      [outfiles]
  
  variantCallingHaplotype:
    #scatter: fileBAM
    run: vcHaplotype/vcHaplotype.cwl
    in:
      fileBAM: [indexBAM/bamFiles]
      input_fa: [ reference/file_with_secondary_files ]
    out:
      [outfiles]


  indexVariantFiles:
    run: indexVariantFiles/indexVariant.cwl
    in:
      input_vcf: 
        - variantCallingSamtools/outfiles
        - variantCallingFreebayes/outfiles
        - variantCallingHaplotype/outfiles
    out:
      [outfiles]

  intersectVariants:
    run: intersectVariants/intersect.cwl
    in:
      infiles: indexVariantFiles/outfiles
    out:
      [output]

  countVariants:
    run: count/count.cwl
    #scatter: infile
    in:
      infile: intersectVariants/output
      sample: input_bam
    out:
      [output]

  