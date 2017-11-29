Fs = 44100;
vozGravada = audiorecorder(Fs,16,1);

%% c�digo para gravar o audio por 6 segundos
disp('Grave seu audio com assoviu por 6 segundos');
recordblocking(vozGravada, 6);
disp('pare de falar');

%% DANDO PLAY NO AUDIO GRAVADO
play(vozGravada);

%% Gravando o auido em formado de array e em double-precision.
vetorAudio = getaudiodata(vozGravada);


%%plotando audio
figure();
plot(vetorAudio);


%%configura��es para o filtro
fpass = 800 ; %frequ�ncia de passagem para inicio do filtro
fstop = 1000; %frequ�ncia de parada para final do filtro


%%normaliza��o das frequencias em unidades de pi
wp = (fpass/(Fs/2))*pi; %frequ�ncia angular relacionada � frequ�ncia de passagem
ws = (fstop/(Fs/2))*pi; %frequ�ncia angular relacionada � frequ�ncia de parada

wt = ws - wp; %frequ�ncia de transi��o
wc = (ws + wp)/2; %frequ�ncia de corte ou frequ�ncia de canto

M = ceil((6.2*pi/wt)) + 1; %comprimento do filtro passando o valor de 6.2*pi para uso na janela de HANNING

hd = my_lp_ideal(wc,M); %aplicando a fun��o sinc(x) para passa baixas ideal


w_hann = hanning(M)'; %Calcula a janela de hamming
h = hd.*w_hann; %multiplica os vetores
vozFiltrada = conv(h,vetorAudio); %convolu��o entre os sinais

figure();
plot(vozFiltrada);

figure();
my_fft(vetorAudio,Fs);

figure();
my_fft(vozFiltrada,Fs);


disp('rodand o audio ap�s o filtro');
sound(vozFiltrada,Fs);


