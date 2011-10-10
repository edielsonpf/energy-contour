function GeraTeste()

% Private Definition
N=10;
NUM_FILES = 13;
INPUT=9;
OUTPUT=13;
%===========================================================

outputData =  ones(OUTPUT,1,1)*-0.7;
fid1 = fopen("./results/test_data/test_data_n1.txt","wt");
fid2 = fopen("./results/test_data/test_data_n2.txt","wt");
fid3 = fopen("./results/test_data/test_data_n3.txt","wt");

fprintf(fid1,"%d %d %d\n",NUM_FILES*N,INPUT,OUTPUT);
fprintf(fid2,"%d %d %d\n",NUM_FILES*N,INPUT,OUTPUT);
fprintf(fid3,"%d %d %d\n",NUM_FILES*N,INPUT,OUTPUT);

for i=1:N 
	numFiles = 0;
	fid4 = fopen("./results/mean_vars/mean_list.txt","r");
	varFileName = 1;	
	while varFileName!=0
	
		varFileName = fscanf(fid4,"%s",1);
		if(varFileName!=0)
			numFiles+=1;
			%Read Mean Energy Contour
			[varData]=load(varFileName);
			[ENERGY_CONTOUR,NUM_SAMPLES] = size(varData.meanContour);
			meanSamples = round(NUM_SAMPLES/3)-1;
			randomSample_n1 = round(rand(1,1)*meanSamples)+1;
			randomSample_n2 = meanSamples + round(rand(1,1)*meanSamples)+1;
			randomSample_n3 = meanSamples*2 + round(rand(1,1)*meanSamples)+1;
			%Save Data for Neural Network Training
			for j=1:ENERGY_CONTOUR
				fprintf(fid1,"%f ", varData.meanContour(j,randomSample_n1));
				fprintf(fid2,"%f ", varData.meanContour(j,randomSample_n2));
				fprintf(fid3,"%f ", varData.meanContour(j,randomSample_n3));
			end
			fprintf(fid1,"\n");
			fprintf(fid2,"\n");
			fprintf(fid3,"\n");
			outputAux = outputData;
			outputAux(numFiles)=outputAux(numFiles)*-1;
			for j=1:OUTPUT
				fprintf(fid1,"%f ",outputAux(j));
				fprintf(fid2,"%f ",outputAux(j));
				fprintf(fid3,"%f ",outputAux(j));
			end
			fprintf(fid1,"\n");
			fprintf(fid2,"\n");
			fprintf(fid3,"\n");
		end
	end
	fclose(fid4);	
end
fclose(fid1);
fclose(fid2);
fclose(fid3);
