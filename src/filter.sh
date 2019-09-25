cd /data/mcgaugheyd/projects/nei/mcgaughey/eyeIntegration_DNTx/data

# convert gencode gtf from chr notation to number notation
~/git/ChromosomeMappings/convert_notation.py -f ~/git/eyeIntegration_DNTx/data/gencode.v29lift37.annotation.sorted.gff3.gz -c ~/git/ChromosomeMappings/GRCh37_UCSC2ensembl.txt > gencode.v29lift37.annotation.ensembl.gff

# identify novel exons and exons not covered by existing exons
# with bedtools intersect -v
bedtools intersect  -v -a <(awk '$3=="exon" {print $0}' stringtie_alltissues_cds_b37.2019_02_19.gff3) \
	-b <(cat gencode.v29lift37.annotation.ensembl.gff | awk '$3=="exon" {print $0}') > \
	novel_exons.gff3

# intersect with UK10K vcf
bedtools intersect -v -a EGAD00001002656_2019.GATK.RESORTED.VT.VEP.VCFANNO.vcf.gz \
		-b novel_exons.gff3 -wa -wb -sorted | \
	bgzip > \
	EGAD00001002656_2019.GATK.RESORTED.VT.VEP.VCFANNO_novel_ST_exons.txt.gz



