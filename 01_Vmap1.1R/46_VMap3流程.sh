----------------------------比对--------------------
#ABlineage
  bwa mem -t 20 -R '@RG\tID:Triticum\tPL:illumina\tSM:Triticum' /data1/publicData/wheat/reference/v1.0/ABD/bwaLib/abd_iwgscV1.fa.gz ${i}_1.fq.gz ${i}_2.fq.gz | samtools view -S -b -> ${i}.bam
  samtools sort -n -m 4G -@ 20 -o ${i}.namesort.bam -O bam ${i}.bam && samtools fixmate -@ 20 -m ${i}.namesort.bam ${i}.fixmate.bam && samtools sort -m 4G -@ 20 -o ${i}.fixmate.pos.bam -O bam ${i}.fixmate.bam && rm -f ${i}.namesort.bam && samtools markdup -@ 20 -r ${i}.fixmate.pos.bam ${i}.rmdup.bam && rm -f ${i}.fixmate.bam && rm -f ${i}.fixmate.pos.bam
#Dlineage
  bwa mem -t 20 -R '@RG\tID:Aegilops\tPL:illumina\tSM:Aegilops' /data1/publicData/wheat/reference/v1.0/D/bwaLib/d_iwgscV1.fa.gz ${i}_1.fq.gz ${i}_2.fq.gz | samtools view -S -b -> ${i}.bam
  samtools sort -n -m 4G -@ 20 -o ${i}.namesort.bam -O bam ${i}.bam && samtools fixmate -@ 20 -m ${i}.namesort.bam ${i}.fixmate.bam && samtools sort -m 4G -@ 20 -o ${i}.fixmate.pos.bam -O bam ${i}.fixmate.bam && rm -f ${i}.namesort.bam && samtools markdup -@ 20 -r ${i}.fixmate.pos.bam ${i}.rmdup.bam && rm -f ${i}.fixmate.bam && rm -f ${i}.fixmate.pos.bam
--------------------------Call SNP------------------
#ABlineage:
  先call了1,355个（1,143AABBDD & 212AABB），再call了先导了53个，用bcftools合并。共1,408个样本。
#Dlineage:
  一起call了1,416个样本（1,196AABBDD & 220个DD）。

  java -Xmx300g -jar Tiger.jar -a FastCall2 -p step1_parameters.txt > log/step1.txt
  java -Xmx300g -jar Tiger.jar -a FastCall2 -p step2_parameters.txt > log/step2.txt
  java -Xmx300g -jar Tiger.jar -a FastCall2 -p step3_parameters.txt > log/step3.txt
--------------------------Filter SNP------------------  
#Step1:
Filter reliable library.
#Step2:
hetThresh = 0.05; nonmissingThresh = 0.8; macThresh = 2; biallele.
Chr	All	Filter1	Filter2	5%
1A	40859768	19719684	18464419	923221
1B	54636234	23637233	21902442	1095121
1D	24186096	8104429	7466205	373311
2A	51209740	24907564	23374283	1168715
2B	64055005	27458441	25471708	1273590
2D	29409717	8984132	8359655	417984
3A	46592710	24133410	22804710	1140238
3B	63221243	27429842	25378508	1268926
3D	26782519	9629133	8998462	449924
4A	43130857	20312528	19098719	954935
4B	42784536	22338411	20860455	1043024
4D	20105073	8248501	7777256	388863
5A	45402295	22252096	20881262	1044065
5B	51605516	21648843	19970843	998543
5D	25744052	8747151	8133655	406684
6A	36601572	17863990	16878041	843902
6B	53704899	22268202	20602957	1030147
6D	20114487	6977450	6497893	324895
7A	52739828	24659952	23171506	1158578
7B	54147757	24214948	22486924	1124346
7D	28118390	9224159	8559768	427990
Alineage	316536770	153849224	144672940	7233654
Blineage	384155190	168995920	156673837	7833697
Dlineage	174460334	59914955	55792894	2789651
Total	875152294	382760099	357139671	17857002

------------------------测试数据------------------------
随机选取全基因组 5% 的snp，共 17.86M 做测试。























  
  