% INPUT:
% diameterCanopy : Diameter of the canopy (meters).
% separation     : Separation between trees (meters).
%
%OUTPUT:
% Forest         : Forest class.
function [longitud_ ED50, latitud_ ED50, altura_ED50]=convertir_WGS84aED50(longitud_WGS84, latitud_WGS84, altura_WGS84)
    //Variables

	int i;
	float  longWGS84,longED50;
	float  latiWGS84, latiED50;
	float  hWGS84, hED50;
	float  aWGS84 = 6378137.0;
	float  e2WGS84 = 0.00669437999014;
	float  aED50=6378388.0;
	float  e2ED50 = 0.00672267002233;
	float  eED50;
	float  bED50;
	float  eprimaED50, eprima2ED50;
	float  x, y, z;
	float  r,E2,F,G,c, s, P, Q, r0, U, V, z0, fi_lati, lamb_longi;

	//Leemos los datos
		
	latiWGS84=WGS84.coordwgs84[i].W_latitud;
	longWGS84=WGS84.coordwgs84[i].W_longitud;
	hWGS84=WGS84.coordwgs84[i].W_altura;
	eED50 = sqrt(e2ED50);
	bED50=sqrt((1-eED50)*aED50*aED50);
	eprimaED50=(aED50/bED50)*eED50;
	eprima2ED50=eprimaED50*eprimaED50;

	//Paso geodésicas a cartesianas en WGS84

	float  aux1, aux2, aux3, aux4, aux5;
	aux1=e2WGS84*pow(sin(latiWGS84),2);
	z=(((aWGS84*(1-e2WGS84))/(sqrt(1-aux1)))+hWGS84)*sin(latiWGS84);
	y=((aWGS84/(sqrt(1-aux1)))+hWGS84)*cos(latiWGS84)*sin(longWGS84);
	x=((aWGS84/(sqrt(1-aux1)))+hWGS84)*cos(latiWGS84)*cos(longWGS84);

	//Paso cartesianas WGS 84 a cartesianas ED50

	x=x+84.0;
	y=y+107.0;
	z=z+120.0;
	//Paso cartesianas ED50 a geodésicas ED50

	r=sqrt((x*x)+(y*y));
	E2=((aED50*aED50)-(bED50*bED50));
	F=54*bED50*bED50*z*z;
			
	G=(r*r)+(1-e2ED50)*z*z-e2ED50*E2;
	c=(e2ED50*e2ED50*F*r*r)/(G*G*G);
	s=pow((1+c+sqrt(c*c+2*c)),(1/3));
			
	P=F/(3*pow((s+(1/s)+1),2)*G*G);
	Q=sqrt(1+2*e2ED50*e2ED50*P);
	aux2=P*e2ED50*r/(1+Q);
	aux3=(aED50*aED50/2)*(1+(1/Q));
	aux4=P*(1-e2ED50)*z*z/(Q*(1+Q));
	aux5=(P*r*r/2);
	r0=sqrt((aux3-aux4-aux5))-aux2;
					
	U=sqrt((z*z+pow((r-(r0*e2ED50)),2)));
	V=sqrt((z*z*(1-e2ED50)+pow((r-r0*e2ED50),2)));
	z0=(bED50*bED50*z/(aED50*V));
			
	hED50=U*(1-(bED50*bED50/(aED50*V)));
	fi_lati=atan((z+eprima2ED50*z0)/r);
	lamb_longi=atan(y/x);

	//Datos finales
			
	longED50 =(lamb_longi*180.0)/pi;
	latiED50 =(fi_lati*180.0)/pi;

end