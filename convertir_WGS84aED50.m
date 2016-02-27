% INPUT:
% diameterCanopy : Diameter of the canopy (meters).
% separation     : Separation between trees (meters).
%
%OUTPUT:
% Forest         : Forest class.
function [longitud_ED50, latitud_ED50, altura_ED50]=convertir_WGS84aED50(longitud_WGS84, latitud_WGS84, altura_WGS84)
    

    %Variables
%   float  eED50;
% 	float  bED50;
% 	float  eprimaED50, eprima2ED50;
% 	float  x, y, z;
% 	float  r,E2,F,G,c, s, P, Q, r0, U, V, z0, fi_lati, lamb_longi;
% 	float  aux1,aux2,aux3,aux4,aux5;

    %Número de coordenadas
    s = size(longitud_WGS84);
    
    %Dimensiones del elipsoide 
    %WGS-84: Tamaño del semieje mayor
    aWGS84 = 6378137.0;
    %WGS-84: Excentricidad^2
    e2WGS84 = 0.00669437999014;
    %ED50: Tamaño del semieje mayor
    aED50=6378388.0;
    %ED50: Excentricidad^2
    e2ED50 = 0.00672267002233;
    
    %Relación entre Datums
    incX = -84.0;
    incY = -107.0;
    incZ = -120.0;
    
    	
    %ED50: Excentricidad
    eED50 = sqrt(e2ED50);
    %ED50: Tamaño del semieje menor 
	bED50=sqrt((1-eED50)*aED50*aED50);
    
    %ED50: Segunda excentricidad
	eprimaED50=(aED50/bED50)*eED50;
	eprima2ED50=eprimaED50*eprimaED50;
    

    %Paso geodésicas a cartesianas en WGS84 (De LLA a XYZ)
	
    aux1 = (aWGS84.*(1-aWGS84))./(1- e2WGS84*power(sin(latitud_WGS84),2));
    z=(aux1+altura_WGS84).*sin(latitud_WGS84);
        
	y=((aWGS84./(sqrt(1-aux1)))+altura_WGS84).*cos(latitud_WGS84).*sin(longitud_WGS84);
	x=((aWGS84./(sqrt(1-aux1)))+altura_WGS84).*cos(latitud_WGS84).*cos(longitud_WGS84);

	%Paso cartesianas WGS 84 a cartesianas ED50
	x=x-incX;
	y=y-incY;
	z=z-incZ;
    
	%Paso cartesianas ED50 a geodésicas ED50 (De XYZ a LLA)
    
    
    %Latitud y altura ED50
	r=sqrt((x.*x)+(y.*y));
	E2=((aED50.*aED50)-(bED50.*bED50));
	F=54.*bED50.*bED50.*z.*z;
			
	G=(r.*r)+(1-e2ED50).*z.*z-e2ED50.*E2;
	c=(e2ED50.*e2ED50.*F.*r.*r)./(G.*G.*G);
	s=power((1+c+sqrt(c.*c+2.*c)),(1/3));
			
	P=F./(3.*power((s+(1./s)+1),2).*G.*G);
	Q=sqrt(1+2.*e2ED50.*e2ED50.*P);
	aux2=P.*e2ED50.*r./(1+Q);
	aux3=(aED50*aED50./2)*(1+(1./Q));
	aux4=P.*(1-e2ED50).*z.*z./(Q.*(1+Q));
	aux5=(P.*r.*r./2);
	r0=sqrt((aux3-aux4-aux5))-aux2;
					
	U=sqrt((z.*z+power((r-(r0.*e2ED50)),2)));
	V=sqrt((z.*z.*(1-e2ED50)+power((r-r0.*e2ED50),2)));
	z0=(bED50.*bED50.*z./(aED50.*V));
    
	fi_lati=atan((z+eprima2ED50.*z0)./r);

	latitud_ED50 =(fi_lati.*180.0)./pi;
    altura_ED50 =U.*(1-(bED50.*bED50./(aED50.*V)));
    
    %Longitud ED50
    lamb_longi=atan(y./x);
    longitud_ED50 =(lamb_longi.*180.0)./pi;

end