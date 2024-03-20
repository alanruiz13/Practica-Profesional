%% ESTE SCRIPT PERMITE CARGAR ARCHIVOS DE AUDIO Y APLICAR 
% TRANSFORMADA DE FOURIER Y ANALISIS DE PCA COMO EXTRACTOR DE 
% INFORMACIÓN Y REDUCCION DE DIMENSIONES

%% PROGRAMA PRINCIPAL
%----------------------------------------------------------------
% Creamos variables auxiliares para la lectura de los datos
personas={'benjamin','lucia'};
% Ubicación de los archivos:
ubicacion='C:\Users\Benjamín\Documents\Servicio Social\Grabaciones\';
% Creamos la ruta y nombre del archivo
file=[ubicacion,'0_',personas{1},'_1.mat'];
% Abrimos un archivo para conocer el número de caracteristicas 
Xdat=load(file);
% Parametros del espectrograma
datosxventana=256;
traslape=250;
numeroFrec=datosxventana;
fs=8e3;
keyboard
[CLIP,f,tt]=spectrogram(Xdat.X(:,1),datosxventana,traslape,numeroFrec,fs,'yaxis');
% Determinamos el número de características
[numFrec,numTime]=size(CLIP);
% Establecemos el número de caracteristicas
n= numFrec*numTime;

%% ANALISIS DE LOS DÍGITOS EN ESPAÑOL
% Determinamos el número de personas
numPersonas=length(personas);
% Inicializamos la matriz de características
X=zeros(numPersonas*50*10,n);
% Inicializamos el el numero de grabaciones
t=1;
% Analizamos los datos de voz
for p=1:numPersonas
    % Cada persona tiene 10 digitos, 
    % 5 archivos con 10 clips
    for q=0:9           % DIGITO 
        for r=1:5       % ARCHIVO
            % Creamos la ruta y nombre del archivo
            file=[ubicacion,...
                num2str(q), '_', personas{p}, '_',...
                num2str(r), '.mat'];
            % Cargamos el archivo actual de la persona
            Xdat=load(file);
            for s=1:10  % CLIP
                % Extraemos el s-ésimo clip
                clip=Xdat.X(:,s);
                % Generamos el espectrograma del clip
                [CLIP,f,tt]=spectrogram(clip,datosxventana,...
                    traslape,numeroFrec,fs,'yaxis');
                % Guardamos los datos de la FFT
                X(t,:)=CLIP(1:n);
                % Nos preparamos para la siguiente grabación
                t=t+1;
            end
        end
    end
end
%% GUARDAMOS LA MATRIZ DE CARACTERÍSTICAS
% save('XdigitosEspaniolEspectrograma','X');
%% ANALISIS DE PCA
% Aplicamos análisis de PCA
[signals,PC,V] = pca2(abs(X));
%% MOSTRAMOS RESULTADOS DEL ANÁLISIS PCA
scatter(PC(1:50,1),PC(1:50,2),'r');
hold on
scatter(PC(51:100,1),PC(51:100,2),'b');
scatter(PC(101:150,1),PC(101:150,2),'g');
scatter(PC(151:200,1),PC(151:200,2),'k');
hold off
