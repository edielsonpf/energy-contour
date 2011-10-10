function GeraPerfil()

% Private Definition
FFT_POINTS= 		2048;		%numero de pontos da FFT 
ENERGY_CONTOUR=		9;		%numero de perfis
TIME_INTERVAL_MS=	50;		%intervalo de audio = 50ms
MEAN_INTERVAL=		20;		%number of samples for mean 
MEAN_STEP=		2;		%number of samples for step
DATA_FOLDER=		"./audio/original/";
VAR_NAME=		"meanContour";
%===========================================================

numFiles = 0;
fileData = 1;

fid1 = fopen("file_list.txt","r");
fid2 = fopen("./results/mean_vars/mean_list.txt","wt");
 
while fileData!=0
	
	fileData = fscanf(fid1,"%s",1);
	if(fileData!=0)
		fileName = sprintf("%s%s.wav",DATA_FOLDER,fileData);
		numFiles+=1;
		%Read audio file
		[dataAudio,sampleFreq]=wavread(fileName);
		%Calculate energy contour
		energyContour=perfil(dataAudio,FFT_POINTS,sampleFreq,ENERGY_CONTOUR,TIME_INTERVAL_MS);
		%Calculate mean of energy contour  		
		meanContour=meanPerfil(energyContour,MEAN_INTERVAL,MEAN_STEP);
		%Save variable
		varFileName = sprintf("./results/mean_vars/mean_%s.txt",fileData);
		save(varFileName,VAR_NAME);
		fprintf(fid2,"%s\n",varFileName);
	end
end
fclose(fid1);
fclose(fid2);
