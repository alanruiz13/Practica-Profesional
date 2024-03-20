%% ESTE SCRIPT PERMITE CARGAR ARCHIVOS DE AUDIO Y APLICAR 
% TRANSFORMADA DE FOURIER Y ANALISIS DE PCA COMO EXTRACTOR DE 
% INFORMACI�N Y REDUCCION DE DIMENSIONES

%% PROGRAMA PRINCIPAL
%----------------------------------------------------------------
% Creamos variables auxiliares para la lectura de los datos
personas={'benjamin','lucia'};
% Ubicaci�n de los archivos:
ubicacion='C:\Users\Benjam�n\Documents\Servicio Social\Grabaciones\';
% Creamos la ruta y nombre del archivo
file=[ubicacion,'0_',personas{1},'_1.mat'];
% Abrimos un archivo para conocer el n�mero de caracteristicas 
Xdat=load(file);

% Determinamos el n�mero de caracter�sticas
n=round(length(Xdat.X)/2);

%% ANALISIS DE LOS D�GITOS EN ESPA�OL
% Determinamos el n�mero de personas
numPersonas=length(personas);
% Inicializamos la matriz de caracter�sticas
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
                % Extraemos el s-�simo clip
                clip=Xdat.X(:,s);
                % Aplicamos la Transformada de Fourier
                CLIP=fft(clip);
                % Guardamos los datos de la FFT
                X(t,:)=CLIP(1:n);
                % Nos preparamos para la siguiente grabaci�n
                t=t+1;
            end
        end
    end
end
%% GUARDAMOS LA MATRIZ DE CARACTER�STICAS
save('XdigitosEspaniol','X');