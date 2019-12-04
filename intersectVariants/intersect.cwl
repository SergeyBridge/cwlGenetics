#!/usr/bin/env cwl-runner

# run with: cwl-runner indexing.cwl --fileBAM sample.bam

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: $(inputs.infiles)


inputs:
  infiles:
    type: File[]
      
outputs:
  output:
    type: stdout

stdout: common_variants.vcf

baseCommand: [vcf-isec, -f, -n, "+2" ]
arguments:
  - samtools.vcf.gz
  - freebayes.vcf.gz
  - haplotype.vcf.gz
