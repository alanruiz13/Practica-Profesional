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

% Determinamos el número de características
n=round(length(Xdat.X)/2);

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
                % Aplicamos la Transformada de Fourier
                CLIP=fft(clip);
                % Guardamos los datos de la FFT
                X(t,:)=CLIP(1:n);
                % Nos preparamos para la siguiente grabación
                t=t+1;
            end
        end
    end
end
%% GUARDAMOS LA MATRIZ DE CARACTERÍSTICAS
save('XdigitosEspaniol','X');