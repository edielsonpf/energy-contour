function [y] = perfil(audio_DATA,N_fft,Fs,N_perfis,T_intervalo)
%audio_DATA	Vetor de audio
%N_fft		Tamanho da FFT
%Fs		Frequencia de amostragem vetor de audio
%N_perfis	Numero de Perfis
%T_intervalo	Tamanho do intervalo em ms (10ms, 20ms, etc.)


Nsamples = fix(Fs*T_intervalo/1000); %numero de amostras em T ms
step=Nsamples;

nQuadros=1;

inicio=1;
fim=Nsamples;

while(fim<length(audio_DATA)) 
    
    fft_DATA=fft(audio_DATA(inicio:fim),N_fft);
    abs_fft_DATA=abs(fft_DATA(1:N_fft/2));
    energia_DATA=(abs_fft_DATA).^2;

    
    Etotal=0;
    for i=1:N_fft/2
	 Etotal=Etotal + 2.*energia_DATA(i);
    end

    Passo = Etotal / (N_perfis + 1);
    Limiar = 0.0;
    ParcialAnterior = 0.0;
    Parcial = 2.*energia_DATA(1);

    j = 1;
    for i=1:N_perfis
  
       Limiar = Limiar + Passo;
       while (Parcial <= Limiar)
    
          ParcialAnterior = Parcial;
          Parcial = Parcial + 2*energia_DATA(j);
          j++;
       end
       if (Parcial > Limiar) % passou do ponto
    
          x1 = (j-2.0)*Fs/N_fft; % em Hertz
          x2 = (j-1.0)*Fs/N_fft; % em Hertz
          y(i,nQuadros) = InterpLinear(x1,ParcialAnterior,x2,Parcial,Limiar);
       else
          y(i,nQuadros) = (j-1.0)*Fs/N_fft; % em Hertz
       end	
    end    
    

    inicio=inicio+step;
    fim=fim+step;
    
    nQuadros=nQuadros+1;
	
    %pause
end
