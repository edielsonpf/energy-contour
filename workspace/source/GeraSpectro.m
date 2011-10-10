function GeraSpectro()

% Private Definition
FFT_POINTS= 		2048;		%numero de pontos da FFT 
%ENERGY_CONTOUR=		9;		%numero de perfis
TIME_INTERVAL_MS=	50;		%intervalo de audio = 50ms
MEAN_INTERVAL=		20;		%number of samples for mean 
MEAN_STEP=		2;		%number of samples for step
DATA_FOLDER=		"./audio/original/";
VAR_NAME=		"meanContour";
%===========================================================

numFiles = 0;
audioFileName = 1;
varFileName = 1;

fid1 = fopen("file_list.txt","r");
fid2 = fopen("./results/mean_vars/mean_list.txt","r");
 
while varFileName!=0
	
	varFileName = fscanf(fid2,"%s",1);
	audioFileName = fscanf(fid1,"%s",1);
	if(varFileName!=0)
		numFiles+=1;
		%Read audio file		
		fileName = sprintf("%s%s.wav",DATA_FOLDER,audioFileName);		
		[dataAudio,sampleFreq]=wavread(fileName);
		%Read Mean Energy Contour
		[varData]=load(varFileName);
		[ENERGY_CONTOUR,NUM_SAMPLES] = size(varData.meanContour);
		%Ploting
		dataLength=length(dataAudio);
		timeMax=dataLength/sampleFreq;
		time=0:timeMax/length(varData.meanContour):(timeMax-1/length(varData.meanContour));
		
		figure		
		clf
		hold
		j=0;
		for i=1:1:ENERGY_CONTOUR
			indexColor = sprintf("%d",j);
			plot(time,varData.meanContour(i,:),indexColor)
			j=j+1;
			if(j==7)
				j=0;
			end
		end
		axis([0 max(time)])
		grid
		title('Perfil de Energia 10% a 90%')
		ylabel('Freq. KHz')
		xlabel('time s')
	end
end
fclose(fid1);
fclose(fid2);
