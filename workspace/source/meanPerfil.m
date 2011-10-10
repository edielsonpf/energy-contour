function [PerfMean] = meanPerfil(perfilData,M_intervalo,M_step)

[NumPerfis,NumSamples] = size(perfilData);

inicio=1;
fim=M_intervalo;
nQuadros=1;

while(fim < NumSamples)

	for i=1:1:NumPerfis
		PerfMean(i,nQuadros) = mean(perfilData(i,inicio:fim));	
	end

	inicio = inicio + M_step;
	fim = fim + M_step;
	nQuadros = nQuadros+1;
end


