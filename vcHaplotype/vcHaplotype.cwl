#!/usr/bin/env cwl-runner

# run with: cwltools referenceDict.cwl --input_fa input/22.fa

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: 
      - $(inputs.input_fa)
      - $(inputs.fileBAM)

inputs:
  input_fa:
    type: File
    inputBinding:
      position: 1
      prefix: "-R"
      valueFrom: $(self.basename)

  fileBAM:
    type: File
    inputBinding:
      position: 2
      prefix: "-I"
      valueFrom: $(self.basename)

outputs:
  outfiles:
    type: File
    outputBinding:
      glob: haplotype.vcf


baseCommand: [java]
arguments:
  - -jar
  - /opt/gatk/GenomeAnalysisTK.jar
  - -T
  -  HaplotypeCaller
  - -l
  - "OFF"
  - --out
  - haplotype.vcf
  

