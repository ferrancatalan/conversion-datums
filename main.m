%Cargamos datos
load data.txt;
longitud_WGS84 = data(:,1);
latitud_WGS84  = data(:,2);
altura_WGS84  = data(:,3);

[longitud_ED50,latitud_ED50,altura_ED50] = convertir_WGS84aED50(longitud_WGS84,latitud_WGS84,altura_WGS84);

%Guardamos datos
fi = fopen('dataOutput2.txt','wt'); %To create forest file
fprintf(fi,'%.10f, %.10f, %.10f\n',longitud_ED50,latitud_ED50,altura_ED50);
fclose(fi);