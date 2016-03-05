--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: actualizar_profesor(character, character varying, character varying, character varying, character varying, character varying, boolean); Type: FUNCTION; Schema: public; Owner: cecilia
--

CREATE FUNCTION actualizar_profesor(character, character varying, character varying, character varying, character varying, character varying, boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vref ALIAS FOR $1;
    vtitulo ALIAS FOR $2;
    vnombre ALIAS FOR $3;
    vapem ALIAS FOR $4;
    vapep ALIAS FOR $5;
    vemail ALIAS FOR $6;
    vhab ALIAS FOR $7;
 
BEGIN
    update profesor set titulo =vtitulo, nombre=vnombre, apellidop = vapep, apellidom = vapem, correo_e = vemail, habilitado = vhab
     where id = vref;
RETURN 0;
END;
$_$;


ALTER FUNCTION public.actualizar_profesor(character, character varying, character varying, character varying, character varying, character varying, boolean) OWNER TO cecilia;

--
-- Name: addalumno(character varying, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addalumno(character varying, character varying, character varying, character varying, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vid ALIAS FOR $1;
    vnombre ALIAS FOR $2;
    vapep ALIAS FOR $3;
    vapem ALIAS FOR $4;
    vgrupo ALIAS FOR $5;
 
BEGIN
    insert into alumno(id, nombre, apellidop,apellidom,grupo) values(vid,vnombre,vapep,vapem,vgrupo);
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addalumno(character varying, character varying, character varying, character varying, integer) OWNER TO postgres;

--
-- Name: addalumno(character varying, character varying, character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addalumno(character varying, character varying, character varying, character varying, integer, character varying, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vid ALIAS FOR $1;
    vnombre ALIAS FOR $2;
    vapem ALIAS FOR $3;
    vapep ALIAS FOR $4;
    vgrupo ALIAS FOR $5;
    vemail ALIAS FOR $6;
    vbrigada ALIAS FOR $7;
BEGIN
    insert into alumno(id, nombre, apellidom,apellidop,grupo,correo_e,brigada) values(vid,vnombre,vapem,vapep,vgrupo,vemail,vbrigada);
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addalumno(character varying, character varying, character varying, character varying, integer, character varying, integer) OWNER TO postgres;

--
-- Name: addbuzon(character varying, character varying, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addbuzon(character varying, character varying, boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE

	viduser ALIAS FOR $1;
    vcomen ALIAS FOR $2;
    vseguir ALIAS FOR $3;

    
BEGIN
    insert into buzon(idbuzon,usuario,comen,seguir, fecha) values(nextval('s_buzon'),viduser,vcomen,vseguir,current_date);
	RETURN 1;
END;
$_$;


ALTER FUNCTION public.addbuzon(character varying, character varying, boolean) OWNER TO postgres;

--
-- Name: addcal(integer, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addcal(integer, character) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vhorario ALIAS FOR $1;
	vsemestre ALIAS FOR $2;
    
BEGIN
    insert into calendarizacion(idcal, horario, semestre) values(nextval('s_cal'),vhorario,vsemestre);
	RETURN currval('s_cal');
END;
$_$;


ALTER FUNCTION public.addcal(integer, character) OWNER TO postgres;

--
-- Name: addcalxpractica(integer, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addcalxpractica(integer, integer, character, character) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	
	vidcal ALIAS FOR $1;
	vpractica ALIAS FOR $2;
    vinicio ALIAS FOR $3;
	vfin ALIAS FOR $4;
BEGIN
    insert into calxpractica(idcxp, idcal,practica,fechainicio,fechafin) values(nextval('s_cxp'),vidcal,vpractica,to_date(vinicio, 'DD-MM-YYYY'),to_date(vfin,'DD-MM-YYYY'));
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addcalxpractica(integer, integer, character, character) OWNER TO postgres;

--
-- Name: addencuesta(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addencuesta(character varying, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE

	vidalumno ALIAS FOR $1;
    vidcxp ALIAS FOR $2;

    
BEGIN
    insert into i_encuestas(idencuesta,ncuenta,idcxp,fecha) values(nextval('s_encuesta'),vidalumno,vidcxp,current_date);
	RETURN currval('s_encuesta');
END;
$_$;


ALTER FUNCTION public.addencuesta(character varying, integer) OWNER TO postgres;

--
-- Name: addencuestaq(integer, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addencuestaq(integer, integer, integer, character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	vid_enc ALIAS FOR $1;
    vpregunta ALIAS FOR $2;
	vopcion ALIAS FOR $3;
	vcomen ALIAS FOR $4;
	
BEGIN
    
	IF(vopcion != 15) THEN
	insert into encuestas(idencuesta,npregunta,opcion) values(vid_enc,vpregunta, vopcion);
	END IF;
	IF(vcomen  !~~  '') THEN
	insert into comentarios(idencuesta,idpregunta,comentario) values(vid_enc,vpregunta, vcomen);
	END IF;
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addencuestaq(integer, integer, integer, character varying) OWNER TO postgres;

--
-- Name: addgrupo(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addgrupo(character varying, character varying, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vgrupo ALIAS FOR $1;
    vprofesor ALIAS FOR $2;
    vcal ALIAS FOR $3;
	     
BEGIN
    insert into grupo(idgrupo,grupo,profesor,idcal) values(nextval('s_grupo'),vgrupo, vprofesor, vcal);
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addgrupo(character varying, character varying, integer) OWNER TO postgres;

--
-- Name: addhorario(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addhorario(character) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  
	vdescripcion ALIAS FOR $1;
	
BEGIN
    insert into horarios values(nextval('s_horario'),vdescripcion);
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addhorario(character) OWNER TO postgres;

--
-- Name: addhorario(character varying); Type: FUNCTION; Schema: public; Owner: cecilia
--

CREATE FUNCTION addhorario(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vdes ALIAS FOR $1;
  
 
BEGIN
    
          insert into horarios values(nextval('s_horario'),vdes);
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addhorario(character varying) OWNER TO cecilia;

--
-- Name: addpracticas(character varying, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addpracticas(character varying, character) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE

	vnombre ALIAS FOR $1;
	vtipo ALIAS FOR $2;

	BEGIN
    insert into practicas values(nextval('s_practica'),vnombre,vtipo);
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addpracticas(character varying, character) OWNER TO postgres;

--
-- Name: addprofesor(character varying, character varying, character varying, character varying, character varying, character varying, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addprofesor(character varying, character varying, character varying, character varying, character varying, character varying, boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vid ALIAS FOR $1;
	vtitulo ALIAS FOR $2;
    vnombre ALIAS FOR $3;
    vapem ALIAS FOR $4;
    vapep ALIAS FOR $5;
    vemail ALIAS FOR $6;
    vhabil ALIAS FOR $7;
	
BEGIN
    insert into profesor values(vid,vtitulo, vnombre,vapem,vapep,vemail,vhabil);
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addprofesor(character varying, character varying, character varying, character varying, character varying, character varying, boolean) OWNER TO postgres;

--
-- Name: addsemestre(character, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addsemestre(character, date, date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  
	vid ALIAS FOR $1;
	vinicio ALIAS FOR $2;
	vfin ALIAS FOR $3;
BEGIN
    insert into semestres values(vid,vinicio,vfin);
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.addsemestre(character, date, date) OWNER TO postgres;

--
-- Name: adduseradmon(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION adduseradmon(character varying, character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vnameuser ALIAS FOR $1;
    vpass ALIAS FOR $2;

BEGIN
    insert into usuarios values(nextval('s_user'),vnameuser,vpass,'3');
	RETURN 1;	
END;
$_$;


ALTER FUNCTION public.adduseradmon(character varying, character varying) OWNER TO postgres;

--
-- Name: adduseralumno(character varying, character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION adduseralumno(character varying, character varying, integer, character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vnameuser ALIAS FOR $1;
    vpass ALIAS FOR $2;
	vbrigada ALIAS FOR $3;
	vmail ALIAS FOR $4;
BEGIN
    insert into usuarios values(nextval('s_user'),vnameuser,vpass,'1');
	update alumno set brigada = vbrigada where id=vnameuser; 
	update alumno set correo_e = vmail where id=vnameuser; 
	RETURN 1;	
END;
$_$;


ALTER FUNCTION public.adduseralumno(character varying, character varying, integer, character varying) OWNER TO postgres;

--
-- Name: addvaluseralumno(character varying, character varying, character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addvaluseralumno(character varying, character varying, character varying, integer, character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vnameuser ALIAS FOR $1;
    vpass1 ALIAS FOR $2;
    vpass2 ALIAS FOR $3;
    
	vbrigada ALIAS FOR $4;
	vmail ALIAS FOR $5;
	 vnombre  varchar;

	
BEGIN


	perform vnombre FROM alumno where id = vnameuser;
	IF NOT FOUND THEN
	RETURN 'Numero de cuenta inexistente';
	END IF;
	
	perform vnombre FROM usuarios where nameuser = vnameuser;
	IF FOUND THEN
	RETURN 'El usuario ya existe';
	END IF;
	
	IF not vpass1 like vpass2 THEN
	RETURN 'Las contrasenas no coinciden';
	END IF;

	IF NOT vmail like '_%@_%.%' THEN
	RETURN 'Correo electronico invalido';
	END IF;

	IF (vbrigada > 8)  or (vbrigada =0) THEN
	RETURN 'Brigada no valida';
	
	ELSE 

	insert into usuarios values(nextval('s_user'),vnameuser,vpass1,'1');
	update alumno set brigada = vbrigada where id=vnameuser; 
	update alumno set correo_e = vmail where id=vnameuser; 
	RETURN 'good';

	END IF;
	
     
END;
$_$;


ALTER FUNCTION public.addvaluseralumno(character varying, character varying, character varying, integer, character varying) OWNER TO postgres;

--
-- Name: addvaluserprofesor(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addvaluserprofesor(character varying, character varying, character varying, character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vnameuser ALIAS FOR $1;
    vpass1 ALIAS FOR $2;
    vpass2 ALIAS FOR $3;
    
	
	vmail ALIAS FOR $4;
	 vnombre  varchar;

	
BEGIN


	perform vnombre FROM profesor where id = vnameuser;
	IF NOT FOUND THEN
	RETURN 'Profesor  no registrasdo';
	END IF;
	
	perform vnombre FROM usuarios where nameuser = vnameuser;
	IF FOUND THEN
	RETURN 'El usuario ya existe';
	END IF;
	
	IF not vpass1 like vpass2 THEN
	RETURN 'Las contrasenas no coinciden';
	END IF;

	IF NOT vmail like '_%@_%.%' THEN
	RETURN 'Correo electronico invalido';
	END IF;

	insert into usuarios values(nextval('s_user'),vnameuser,vpass1,'2');
	update profesor set correo_e = vmail where id=vnameuser; 
	RETURN 'good';

	
	
     
END;
$_$;


ALTER FUNCTION public.addvaluserprofesor(character varying, character varying, character varying, character varying) OWNER TO postgres;

--
-- Name: arreglaralumnos(); Type: FUNCTION; Schema: public; Owner: cecilia
--

CREATE FUNCTION arreglaralumnos() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    vapep varchar;
    vapem varchar;
    vid varchar;
    r alumno%rowtype;
BEGIN
   --insert into alumno(id, nombre, apellidop,apellidom,grupo) values(vid,vnombre,vapep,vapem,vgrupo);
	FOR r IN SELECT * FROM alumno where grupo in(17,18,19,20)

	    LOOP
                 vid = r.id;
                 vapep = r.apellidom;
                 vapem= r.apellidop;

                   UPDATE alumno set apellidop = vapep, apellidom = vapem  where id=vid;
                  

	     
		--RETURN NEXT r; -- return current row of SELECT
	    END LOOP;	
	RETURN 0;
END;
$$;


ALTER FUNCTION public.arreglaralumnos() OWNER TO cecilia;

--
-- Name: buscaralumnos(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscaralumnos(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vid ALIAS FOR $1;
 vnombre  varchar;
    
BEGIN

  
 
perform vnombre FROM alumno where id = vid;
IF NOT FOUND THEN
    RETURN 0;
ELSE
    RETURN 1;
END IF;

END;
$_$;


ALTER FUNCTION public.buscaralumnos(character varying) OWNER TO postgres;

--
-- Name: consultauser(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION consultauser(character varying, character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vnameuser ALIAS FOR $1;
    vpass ALIAS FOR $2;
    vusuario integer;
  
BEGIN
       
       -- set client_encoding ='latin1';
        select iduser into vusuario from usuarios where nameuser=vnameuser and passwd =vpass ;
RETURN vusuario;
END;

$_$;


ALTER FUNCTION public.consultauser(character varying, character varying) OWNER TO postgres;

--
-- Name: deletehorario(integer); Type: FUNCTION; Schema: public; Owner: cecilia
--

CREATE FUNCTION deletehorario(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vid ALIAS FOR $1;
  
 
BEGIN
    
        delete from horarios where id =vid;
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.deletehorario(integer) OWNER TO cecilia;

--
-- Name: edithorario(integer, character varying); Type: FUNCTION; Schema: public; Owner: cecilia
--

CREATE FUNCTION edithorario(integer, character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    vid ALIAS FOR $1;
    vdes ALIAS FOR $2;
  
 
BEGIN
    
          update horarios set descripcion = vdes where id=vid;
	RETURN 0;
END;
$_$;


ALTER FUNCTION public.edithorario(integer, character varying) OWNER TO cecilia;

--
-- Name: getavg(character varying, character, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getavg(semestre character varying, tipo character, npregunta integer) RETURNS double precision
    LANGUAGE plpgsql
    AS $_$
DECLARE 

vsemestre ALIAS FOR $1;
vtipo ALIAS FOR $2;
vpregunta ALIAS FOR $3;
promedio float ;
BEGIN
select avg(opcion) into promedio from 

semestres as s inner join 
calendarizacion as cal on(s.id = cal.semestre) inner join
calxpractica as cxp on(cxp.idcal = cal.idcal ) inner join
practicas as p on(p.idpractica = cxp.practica) inner join
i_encuestas as ie on (cal.idcal = cxp.idcal ) inner join

encuestas as e on (e.idencuesta = ie.idencuesta)

where
s.id = vsemestre and
p.tipo = vtipo  and e.npregunta=vpregunta;

RETURN promedio;
END;
$_$;


ALTER FUNCTION public.getavg(semestre character varying, tipo character, npregunta integer) OWNER TO postgres;

--
-- Name: getgrupo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getgrupo(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$

DECLARE
    vgrupo ALIAS FOR $1;
    grupo integer;
BEGIN

	select g.idgrupo into grupo from grupo as g
	inner join calendarizacion as c on(g.idcal = c.idcal)
	where g.grupo = vgrupo;

	RETURN grupo;	
END;
 $_$;


ALTER FUNCTION public.getgrupo(character varying) OWNER TO postgres;

--
-- Name: getgruposprofesor(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getgruposprofesor(character varying, character varying) RETURNS TABLE(idgrupo integer, grupo character varying, horario character varying)
    LANGUAGE plpgsql
    AS $_$

declare

vprofesor ALIAS for $1;
vsemestre ALIAS for $2;

profesor varchar;
date1 date;
date2 date;

begin
RETURN QUERY 


--elect into date1 inicio  id from semestres;
--select into date2 fin from semestres;

	
select g.idgrupo, g.grupo, h.descripcion 
from grupo as  g
inner join profesor as p on(p.id = g.profesor)
inner join calendarizacion as cal on (g.idcal = cal.idcal)
inner join semestres as s on (s.id = cal.semestre)
inner join horarios as h on (cal.horario = h.id)

where s.id = vsemestre and p.id = vprofesor;


END;
$_$;


ALTER FUNCTION public.getgruposprofesor(character varying, character varying) OWNER TO postgres;

--
-- Name: l_alumnosnoregistrados(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION l_alumnosnoregistrados() RETURNS TABLE(alumno character varying, a_nombre character varying, a_apep character varying, a_apem character varying, grupo character varying, iuser integer)
    LANGUAGE plpgsql
    AS $$
declare
BEGIN RETURN QUERY
select a.id as alumno, a.nombre, a.apellidoP, a.apellidoM, g.grupo, u.iduser 
--from l_faltantes(16) as lf
from  alumno as a
left outer join usuarios as u on(a.id= u.nameuser)
inner join grupo as g on(a.grupo = g.idgrupo) 
inner join calendarizacion as cal on(g.idcal = cal.idcal)
inner join semestres as s on(s.id = cal.semestre)
where current_date between s.inicio and s.fin and u.iduser is null and a.activo = true
order by g.grupo;
END;
$$;


ALTER FUNCTION public.l_alumnosnoregistrados() OWNER TO postgres;

--
-- Name: l_alumnosxgrupo(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION l_alumnosxgrupo(integer) RETURNS TABLE(alumno character varying, nombre character varying, apep character varying, apem character varying)
    LANGUAGE plpgsql
    AS $_$
  
declare
    vgrupo ALIAS FOR $1;
    BEGIN
    RETURN QUERY 

SELECT a.id,   a.apellidop, a.apellidom, a.nombre
from  alumno as a
where grupo = vgrupo and activo=true
order by a.apellidop;
    END;
$_$;


ALTER FUNCTION public.l_alumnosxgrupo(integer) OWNER TO postgres;

--
-- Name: l_encuestasxalumno(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION l_encuestasxalumno(character varying) RETURNS TABLE(encuesta integer, idp integer, practica character varying, tipo character)
    LANGUAGE plpgsql
    AS $_$
declare
    valumno ALIAS FOR $1;
    BEGIN
    RETURN QUERY 


SELECT ie.idencuesta, p.idpractica ,p.nombre, p.tipo
from  
i_encuestas as ie 
inner join calxpractica  as cxp on(ie.idcxp = cxp.idcxp) 
inner join practicas as p on(cxp.practica = p.idpractica)
where ie.ncuenta = valumno 
order by p.idpractica ;
    END;
$_$;


ALTER FUNCTION public.l_encuestasxalumno(character varying) OWNER TO postgres;

--
-- Name: l_faltantes(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION l_faltantes(integer) RETURNS TABLE(encuesta integer, cxp integer, alumno character varying, practica integer, p_nombre character varying, a_nombre character varying, a_apep character varying, a_apem character varying, a_correo character varying)
    LANGUAGE plpgsql
    AS $_$
declare
vgrupo alias for $1;
BEGIN RETURN QUERY
select ie.idencuesta, cxp.idcxp ,a.id as alumno, p.idpractica, p.nombre, a.nombre, a.apellidoP, a.apellidoM, a.correo_e 
--from l_faltantes(16) as lf
from grupo as g 
inner join calendarizacion as cal on(g.idcal = cal.idcal)
inner join calxpractica as cxp on(cal.idcal = cxp.idcal)
inner join practicas as p on (p.idpractica =cxp.practica)
inner join alumno as a on(a.grupo  = g.idgrupo)
left join i_encuestas ie on(cxp.idcxp = ie.idcxp and ie.ncuenta = a.id)
where g.idgrupo = vgrupo and idencuesta is null and current_date > cxp.fechainicio and a.activo = true --a.id = '305292308'
order by p.idpractica;
END;
$_$;


ALTER FUNCTION public.l_faltantes(integer) OWNER TO postgres;

--
-- Name: l_gruposxsemestre(character varying); Type: FUNCTION; Schema: public; Owner: cecilia
--

CREATE FUNCTION l_gruposxsemestre(character varying) RETURNS TABLE(idg integer, grupo character varying, profesor character, p_titulo character varying, p_nombre character varying, p_apep character varying, p_apem character varying)
    LANGUAGE plpgsql
    AS $_$
declare
vsemestre alias for $1;

 begin
 return QUERY	
 
select g.idgrupo, g.grupo, g.profesor, p.titulo ,p.nombre, p.apellidop, p.apellidom from grupo as g
inner join calendarizacion as  cal  on(g.idcal = cal.idcal)
inner join semestres as s on(s.id=cal.semestre) 
inner join profesor as p on (p.id = g.profesor)
where semestre = vsemestre
order by 1;
end;

$_$;


ALTER FUNCTION public.l_gruposxsemestre(character varying) OWNER TO cecilia;

--
-- Name: p_alumno(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION p_alumno(character varying) RETURNS TABLE(idp integer, practica character varying, idcxp integer, tipo character)
    LANGUAGE plpgsql
    AS $_$
declare
 valumno ALIAS FOR $1;
    BEGIN
    RETURN QUERY 


SELECT p.idpractica, p.nombre, cxp.idcxp, p.tipo
from grupo as g 
inner join alumno as a on(a.grupo = g.idgrupo)
inner join calxpractica as cxp on(cxp.idcal = g.idcal)
inner join practicas as p  on(cxp.practica = p.idpractica)

where current_date > cxp.fechainicio  and a.id = valumno 

except 

SELECT p.idpractica, p.nombre, cxp.idcxp,  p.tipo
from  grupo as g

inner join calendarizacion as c on(c.idcal = g.idcal)
inner join calxpractica as cxp on(cxp.idcal = c.idcal)
inner join i_encuestas as ie on(cxp.idcxp = ie.idcxp)
inner join practicas as p  on(cxp.practica = p.idpractica)
where current_date > cxp.fechainicio and ie.ncuenta = valumno 

order by idpractica;



end;
    
$_$;


ALTER FUNCTION public.p_alumno(character varying) OWNER TO postgres;

--
-- Name: prueba(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION prueba() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  
v1 varchar;

BEGIN
    
v1 = 'áéíóú';
RETURN 0;
END;
$$;


ALTER FUNCTION public.prueba() OWNER TO postgres;

--
-- Name: readbuzon(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION readbuzon() RETURNS TABLE(buzon integer, comen character varying, seguir boolean, fecha date, apellidop character varying, apellidom character varying, nombre character varying, cuenta character varying, respuesta character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN RETURN QUERY

        select b.idbuzon as buzon , b.comen, b.seguir , b.fecha,  a.apellidoP, a.apellidoM, a.nombre, a.id as cuenta, b.respuesta from buzon as b
inner join usuarios as usr on(b.usuario = usr.nameuser) 
inner join alumno as a on(b.usuario = a.id)
where usr.tipo= '1' and 
 b.fecha between  (select inicio from semestres where (current_date > inicio and current_date < fin))   and  (select fin   from semestres where (current_date > inicio and current_date < fin))
 order by 1 desc;

END;
$$;


ALTER FUNCTION public.readbuzon() OWNER TO postgres;

--
-- Name: readbuzon(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION readbuzon(character varying) RETURNS TABLE(buzon integer, comen character varying, seguir boolean, fecha date, apellidop character varying, apellidom character varying, nombre character varying, cuenta character varying, respuesta character varying)
    LANGUAGE plpgsql
    AS $_$
DECLARE

vsem ALIAS FOR $1;

BEGIN RETURN QUERY

select b.idbuzon as buzon , b.comen, b.seguir , b.fecha,  a.apellidoP, a.apellidoM, a.nombre, a.id as cuenta, b.respuesta from buzon as b
inner join usuarios as usr on(b.usuario = usr.nameuser) 
inner join alumno as a on(b.usuario = a.id)
inner join grupo as g on(g.idgrupo = a.grupo)
inner join calendarizacion as cal on(cal.idcal= g.idcal)
inner join semestres as s on(s.id= cal.semestre)
where usr.tipo= '1'  and s.id=vsem
order by 1 desc;

END;
$_$;


ALTER FUNCTION public.readbuzon(character varying) OWNER TO postgres;

--
-- Name: readbuzon(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION readbuzon(character varying, integer) RETURNS TABLE(buzon integer, comen character varying, seguir boolean, fecha date, apellidop character varying, apellidom character varying, nombre character varying, cuenta character varying, respuesta character varying)
    LANGUAGE plpgsql
    AS $_$
DECLARE

vsem ALIAS FOR $1;
vqueja ALIAS FOR $2;
BEGIN RETURN QUERY

select b.idbuzon as buzon , b.comen, b.seguir , b.fecha,  a.apellidoP, a.apellidoM, a.nombre, a.id as cuenta, b.respuesta from buzon as b
inner join usuarios as usr on(b.usuario = usr.nameuser) 
inner join alumno as a on(b.usuario = a.id)
inner join grupo as g on(g.idgrupo = a.grupo)
inner join calendarizacion as cal on(cal.idcal= g.idcal)
inner join semestres as s on(s.id= cal.semestre)
where usr.tipo= '1'  and s.id=vsem and b.idbuzon =vqueja
order by 1 desc;

END;
$_$;


ALTER FUNCTION public.readbuzon(character varying, integer) OWNER TO postgres;

--
-- Name: readbuzonnoalumnos(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION readbuzonnoalumnos(character varying) RETURNS TABLE(buzon integer, comen character varying, seguir boolean, fecha date, apellidop character varying, apellidom character varying, nombre character varying, rfc character, respuesta character varying)
    LANGUAGE plpgsql
    AS $_$
DECLARE

vsem ALIAS FOR $1;

BEGIN RETURN QUERY
select b.idbuzon as buzon , b.comen, b.seguir , b.fecha, a.apellidoP, a.apellidoM, a.nombre, a.id as rfc, b.respuesta 
from buzon as b
inner join usuarios as usr on(b.usuario = usr.nameuser) 
inner join profesor as a on(usr.nameuser =a.id)
where usr.tipo != '1'   and
b.fecha between  (select inicio from semestres as s where s.id='2015-1')   and  (select fin   from semestres as s where s.id='2015-1')
 order by 1 desc;

END;
$_$;


ALTER FUNCTION public.readbuzonnoalumnos(character varying) OWNER TO postgres;

--
-- Name: recuperarpasswd(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION recuperarpasswd(character varying) RETURNS TABLE(email character varying, pswwd character varying)
    LANGUAGE plpgsql
    AS $_$
declare
 valumno ALIAS FOR $1;
    BEGIN
    RETURN QUERY 
	select a.correo_e, u.passwd from 
    alumno as a  inner join usuarios as u on(a.id = u.nameuser)
	where a.id=valumno;
END;
$_$;


ALTER FUNCTION public.recuperarpasswd(character varying) OWNER TO postgres;

--
-- Name: remplaces(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION remplaces() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
  DECLARE
    vstr1 varchar;
    vstr2 varchar;

  BEGIN

   select into vstr1 comentarios from comentarios  where  idencuesta=23 and idpregunta=18;
perform replace(vstr1, 'ÃÂ¡', '');
  RETURN vstr1;
  END; $$;


ALTER FUNCTION public.remplaces() OWNER TO postgres;

--
-- Name: saveanswerbuzon(integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION saveanswerbuzon(integer, character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$

DECLARE
 vbuzon ALIAS FOR $1;
 vmensaje ALIAS FOR $2;

 valumno varchar;
 vcorreo varchar;
 
BEGIN 


update buzon 
set respuesta = vmensaje where idbuzon = vbuzon;

select into valumno usuario from buzon where idbuzon = vbuzon;
select into vcorreo correo_e from alumno where id = valumno;

return vcorreo;


END;
$_$;


ALTER FUNCTION public.saveanswerbuzon(integer, character varying) OWNER TO postgres;

--
-- Name: saveencserv(integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION saveencserv(integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$

DECLARE
    i1 ALIAS FOR $1;  v1 ALIAS FOR $2;
    i2 ALIAS FOR $3;  v2 ALIAS FOR $4;
    i3 ALIAS FOR $5;  v3 ALIAS FOR $6;
    i4 ALIAS FOR $7;  v4 ALIAS FOR $8;
    i5 ALIAS FOR $9;  v5 ALIAS FOR $10;
    i6 ALIAS FOR $11;  v6 ALIAS FOR $12;
    i7 ALIAS FOR $13;  v7 ALIAS FOR $14;
    i8 ALIAS FOR $15;  v8 ALIAS FOR $16;
    i9 ALIAS FOR $17;  v9 ALIAS FOR $18;
    i10 ALIAS FOR $19;  v10 ALIAS FOR $20;
    i11 ALIAS FOR $21;  v11 ALIAS FOR $22;
    i12 ALIAS FOR $23;  v12 ALIAS FOR $24; 	
    i13 ALIAS FOR $25;  v13 ALIAS FOR $26;	
    i14 ALIAS FOR $27;  v14 ALIAS FOR $28;	

  
				
    vidcxp ALIAS FOR $29; valumno ALIAS FOR $30; 	
	
    i integer;
    
BEGIN
  perform addEncuesta(valumno,vidcxp);
   i = currval('s_encuesta');
   perform CAST(i AS integer);

   perform  addEncuestaQ(i,1,i1,v1);
   perform  addEncuestaQ(i,2,i2,v2);
    perform  addEncuestaQ(i,3,i3,v3);
    perform addEncuestaQ(i,4,i4,v4);
    perform  addEncuestaQ(i,5,i5,v5);
    perform  addEncuestaQ(i,6,i6,v6);
    perform  addEncuestaQ(i,7,i7,v7);
    perform  addEncuestaQ(i,8,i8,v8);
    perform  addEncuestaQ(i,9,i9,v9);
    perform  addEncuestaQ(i,10,i10,v10);
   perform addEncuestaQ(i,11,i11,v11);
    perform  addEncuestaQ(i,12,i12,v12);
   perform  addEncuestaQ(i,13,i13,v13);
    perform  addEncuestaQ(i,14,i14,v14);
  
	return 1;
END;
$_$;


ALTER FUNCTION public.saveencserv(integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying) OWNER TO postgres;

--
-- Name: savepoll(integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION savepoll(integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$

DECLARE
    i1 ALIAS FOR $1;  v1 ALIAS FOR $2;
    i2 ALIAS FOR $3;  v2 ALIAS FOR $4;
    i3 ALIAS FOR $5;  v3 ALIAS FOR $6;
    i4 ALIAS FOR $7;  v4 ALIAS FOR $8;
    i5 ALIAS FOR $9;  v5 ALIAS FOR $10;
    i6 ALIAS FOR $11;  v6 ALIAS FOR $12;
    i7 ALIAS FOR $13;  v7 ALIAS FOR $14;
    i8 ALIAS FOR $15;  v8 ALIAS FOR $16;
    i9 ALIAS FOR $17;  v9 ALIAS FOR $18;
    i10 ALIAS FOR $19;  v10 ALIAS FOR $20;
    i11 ALIAS FOR $21;  v11 ALIAS FOR $22;
    i12 ALIAS FOR $23;  v12 ALIAS FOR $24; 	
    i13 ALIAS FOR $25;  v13 ALIAS FOR $26;	
    i14 ALIAS FOR $27;  v14 ALIAS FOR $28;	
    i15 ALIAS FOR $29;  v15 ALIAS FOR $30;	
    i16 ALIAS FOR $31;  v16 ALIAS FOR $32; 
    i17 ALIAS FOR $33;  v17 ALIAS FOR $34; 
    i18 ALIAS FOR $35;  v18 ALIAS FOR $36; 
    vidcxp ALIAS FOR $37; valumno ALIAS FOR $38; 	
	
    i integer;
    
BEGIN
  perform addEncuesta(valumno,vidcxp);
   i = currval('s_encuesta');
   perform CAST(i AS integer);

   perform  addEncuestaQ(i,1,i1,v1);
   perform  addEncuestaQ(i,2,i2,v2);
   perform  addEncuestaQ(i,3,i3,v3);
   perform addEncuestaQ(i,4,i4,v4);
   perform  addEncuestaQ(i,5,i5,v5);
   perform  addEncuestaQ(i,6,i6,v6);
   perform  addEncuestaQ(i,7,i7,v7);
   perform  addEncuestaQ(i,8,i8,v8);
   perform  addEncuestaQ(i,9,i9,v9);
   perform  addEncuestaQ(i,10,i10,v10);
   perform addEncuestaQ(i,11,i11,v11);
   perform  addEncuestaQ(i,12,i12,v12);
   perform  addEncuestaQ(i,13,i13,v13);
   perform  addEncuestaQ(i,14,i14,v14);
   perform  addEncuestaQ(i,15,i15,v15);
   perform  addEncuestaQ(i,16,i16,v16);
   perform  addEncuestaQ(i,17,i17,v17);
   perform  addEncuestaQ(i,18,i18,v18);
  
	return 1;
END;
$_$;


ALTER FUNCTION public.savepoll(integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying, integer, character varying) OWNER TO postgres;

--
-- Name: semestre_actual(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION semestre_actual() RETURNS character varying
    LANGUAGE plpgsql
    AS $$

declare

semestre varchar;

begin

	
select into semestre id  from semestres  
where inicio < current_date and fin > current_date;

return semestre;

END;
$$;


ALTER FUNCTION public.semestre_actual() OWNER TO postgres;

--
-- Name: showcomentariossemestre(integer, character varying); Type: FUNCTION; Schema: public; Owner: cecilia
--

CREATE FUNCTION showcomentariossemestre(integer, character varying) RETURNS TABLE(grupo integer, grupo_name character varying, titulo character varying, apep character varying, amem character varying, nombre_p character varying)
    LANGUAGE plpgsql
    AS $$
declare
BEGIN RETURN QUERY

select  a.grupo, b.grupo, b.titulo, b.apellidop, b.apellidom, b.nombre 
from l_comentarios as a inner join l_grupo as  b on(a.grupo = b.idgrupo) 
where a.pregunta=  vpregunta and a.tipo = 'A' 
group by 1, 2,3,4,5,6;


END;
$$;


ALTER FUNCTION public.showcomentariossemestre(integer, character varying) OWNER TO cecilia;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alumno; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE alumno (
    id character varying(15) NOT NULL,
    apellidop character varying(20),
    apellidom character varying(20),
    nombre character varying(20),
    correo_e character varying(50),
    brigada integer,
    grupo integer,
    activo boolean DEFAULT true
);


ALTER TABLE public.alumno OWNER TO postgres;

--
-- Name: buzon; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE buzon (
    idbuzon integer NOT NULL,
    usuario character varying(15) NOT NULL,
    comen character varying(500),
    seguir boolean,
    fecha date,
    respuesta character varying
);


ALTER TABLE public.buzon OWNER TO postgres;

--
-- Name: buzonalumnos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW buzonalumnos AS
 SELECT readbuzon.buzon,
    readbuzon.comen,
    readbuzon.seguir,
    readbuzon.fecha,
    readbuzon.apellidop,
    readbuzon.apellidom,
    readbuzon.nombre,
    readbuzon.cuenta,
    readbuzon.respuesta
   FROM readbuzon() readbuzon(buzon, comen, seguir, fecha, apellidop, apellidom, nombre, cuenta, respuesta);


ALTER TABLE public.buzonalumnos OWNER TO postgres;

--
-- Name: calendarizacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE calendarizacion (
    idcal integer NOT NULL,
    horario integer NOT NULL,
    semestre character(7)
);


ALTER TABLE public.calendarizacion OWNER TO postgres;

--
-- Name: calxpractica; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE calxpractica (
    idcxp integer NOT NULL,
    idcal integer,
    practica integer,
    fechainicio date,
    fechafin date
);


ALTER TABLE public.calxpractica OWNER TO postgres;

--
-- Name: comentarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comentarios (
    idencuesta integer NOT NULL,
    idpregunta integer NOT NULL,
    comentario character varying(250)
);


ALTER TABLE public.comentarios OWNER TO postgres;

--
-- Name: encuestas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE encuestas (
    idencuesta integer NOT NULL,
    npregunta integer NOT NULL,
    opcion integer
);


ALTER TABLE public.encuestas OWNER TO postgres;

--
-- Name: i_encuestas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE i_encuestas (
    idencuesta integer NOT NULL,
    ncuenta character varying(30) NOT NULL,
    idcxp integer NOT NULL,
    fecha date
);


ALTER TABLE public.i_encuestas OWNER TO postgres;

--
-- Name: practicas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE practicas (
    idpractica integer NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo character(1) NOT NULL
);


ALTER TABLE public.practicas OWNER TO postgres;

--
-- Name: consultaencuesta; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW consultaencuesta AS
 SELECT e.idencuesta AS a,
    e.npregunta AS b,
    e.opcion AS c,
    c.comentario AS d
   FROM (encuestas e
     LEFT JOIN comentarios c ON (((e.npregunta = c.idpregunta) AND (e.idencuesta = c.idencuesta))))
UNION
 SELECT comentarios.idencuesta AS a,
    comentarios.idpregunta AS b,
    1 AS c,
    comentarios.comentario AS d
   FROM (((comentarios
     JOIN i_encuestas ie ON ((ie.idencuesta = comentarios.idencuesta)))
     JOIN calxpractica cxp ON ((cxp.idcxp = ie.idcxp)))
     JOIN practicas p ON ((p.idpractica = cxp.practica)))
  WHERE (((p.tipo = 'A'::bpchar) AND (comentarios.idpregunta = 18)) OR ((p.tipo = 'B'::bpchar) AND (comentarios.idpregunta = 14)))
  ORDER BY 2;


ALTER TABLE public.consultaencuesta OWNER TO postgres;

--
-- Name: grupo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE grupo (
    idgrupo integer NOT NULL,
    grupo character varying(5),
    idcal integer,
    profesor character(10)
);


ALTER TABLE public.grupo OWNER TO postgres;

--
-- Name: consultaencuestainfo; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW consultaencuestainfo AS
 SELECT ie.idencuesta,
    ie.ncuenta,
    p.nombre AS practica,
    a.apellidop,
    a.apellidom,
    a.nombre,
    g.grupo,
    a.brigada,
    ie.fecha,
    c.semestre
   FROM (((((i_encuestas ie
     JOIN alumno a ON (((ie.ncuenta)::text = (a.id)::text)))
     JOIN grupo g ON ((a.grupo = g.idgrupo)))
     JOIN calxpractica cxp ON ((cxp.idcxp = ie.idcxp)))
     JOIN calendarizacion c ON ((cxp.idcal = c.idcal)))
     JOIN practicas p ON ((cxp.practica = p.idpractica)));


ALTER TABLE public.consultaencuestainfo OWNER TO postgres;

--
-- Name: consultapracticas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW consultapracticas AS
 SELECT ie.idencuesta,
    ie.ncuenta,
    a.grupo,
    p.nombre,
    p.idpractica
   FROM (((i_encuestas ie
     JOIN calxpractica cxp ON ((cxp.idcxp = ie.idcxp)))
     JOIN alumno a ON (((ie.ncuenta)::text = (a.id)::text)))
     JOIN practicas p ON ((cxp.practica = p.idpractica)))
  ORDER BY a.grupo, ie.ncuenta, cxp.practica;


ALTER TABLE public.consultapracticas OWNER TO postgres;

--
-- Name: semestres; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE semestres (
    id character(7) NOT NULL,
    inicio date,
    fin date
);


ALTER TABLE public.semestres OWNER TO postgres;

--
-- Name: getalumno; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW getalumno AS
 SELECT a.nombre AS name,
    a.apellidop AS apep,
    a.apellidom AS apem,
    g.grupo,
    a.id AS cuenta,
    a.brigada,
    a.correo_e AS mail,
    s.id AS semestre,
    a.grupo AS idgrupo
   FROM (((alumno a
     JOIN grupo g ON ((a.grupo = g.idgrupo)))
     JOIN calendarizacion cal ON ((g.idcal = cal.idcal)))
     JOIN semestres s ON ((s.id = cal.semestre)));


ALTER TABLE public.getalumno OWNER TO postgres;

--
-- Name: getpractica; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW getpractica AS
 SELECT p.idpractica AS id,
    p.nombre,
    p.tipo AS t,
    c.semestre,
    a.id AS alumno
   FROM ((((alumno a
     JOIN grupo g ON ((a.grupo = g.idgrupo)))
     JOIN calendarizacion c ON ((g.idcal = c.idcal)))
     JOIN calxpractica cxp ON ((c.idcal = cxp.idcal)))
     JOIN practicas p ON ((cxp.practica = p.idpractica)));


ALTER TABLE public.getpractica OWNER TO postgres;

--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios (
    iduser integer NOT NULL,
    nameuser character varying(15) NOT NULL,
    passwd character varying(12) NOT NULL,
    tipo character(1) NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: getuser; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW getuser AS
 SELECT usuarios.iduser AS us,
    usuarios.tipo AS tu
   FROM usuarios;


ALTER TABLE public.getuser OWNER TO postgres;

--
-- Name: horarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE horarios (
    id integer NOT NULL,
    descripcion character varying(100)
);


ALTER TABLE public.horarios OWNER TO postgres;

--
-- Name: l_comentarios; Type: VIEW; Schema: public; Owner: cecilia
--

CREATE VIEW l_comentarios AS
 SELECT s.id AS semestre,
    a.grupo AS idgrupo,
    g.grupo,
    ie.ncuenta,
    a.brigada,
    c.idencuesta,
    p.nombre,
    c.idpregunta AS pregunta,
    c.comentario,
    p.tipo,
    cxp.practica
   FROM (((((((comentarios c
     JOIN i_encuestas ie ON ((c.idencuesta = ie.idencuesta)))
     JOIN calxpractica cxp ON ((ie.idcxp = cxp.idcxp)))
     JOIN practicas p ON ((cxp.practica = p.idpractica)))
     JOIN alumno a ON (((a.id)::text = (ie.ncuenta)::text)))
     JOIN grupo g ON ((a.grupo = g.idgrupo)))
     JOIN calendarizacion cal ON ((cal.idcal = g.idcal)))
     JOIN semestres s ON ((cal.semestre = s.id)))
  ORDER BY s.id, g.grupo, ie.ncuenta, c.idencuesta, p.nombre, c.idpregunta;


ALTER TABLE public.l_comentarios OWNER TO cecilia;

--
-- Name: l_comentariosd; Type: VIEW; Schema: public; Owner: cecilia
--

CREATE VIEW l_comentariosd AS
 SELECT c.idencuesta,
    c.idpregunta,
    c.comentario,
    ie.ncuenta,
    a.brigada,
    a.grupo,
    s.id AS semestre
   FROM (((((comentarios c
     JOIN i_encuestas ie ON ((c.idencuesta = ie.idencuesta)))
     JOIN alumno a ON (((a.id)::text = (ie.ncuenta)::text)))
     JOIN grupo g ON ((a.grupo = g.idgrupo)))
     JOIN calendarizacion cal ON ((cal.idcal = g.idcal)))
     JOIN semestres s ON ((cal.semestre = s.id)));


ALTER TABLE public.l_comentariosd OWNER TO cecilia;

--
-- Name: q_encuestas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW q_encuestas AS
 SELECT ie.idencuesta,
    e.npregunta,
    e.opcion,
    ie.ncuenta,
    cal.semestre,
    g.grupo,
    p.tipo,
    p.idpractica
   FROM (((((encuestas e
     JOIN i_encuestas ie ON ((e.idencuesta = ie.idencuesta)))
     JOIN calxpractica cxp ON ((ie.idcxp = cxp.idcxp)))
     JOIN calendarizacion cal ON ((cal.idcal = cxp.idcal)))
     JOIN practicas p ON ((cxp.practica = p.idpractica)))
     JOIN grupo g ON ((g.idcal = cal.idcal)));


ALTER TABLE public.q_encuestas OWNER TO postgres;

--
-- Name: l_encuestas_practicas; Type: VIEW; Schema: public; Owner: cecilia
--

CREATE VIEW l_encuestas_practicas AS
 SELECT cal.semestre,
    g.idgrupo,
    g.grupo,
    g.profesor,
    q.ncuenta,
    q.idencuesta,
    q.npregunta,
    q.opcion
   FROM ((grupo g
     JOIN calendarizacion cal ON ((g.idcal = cal.idcal)))
     JOIN q_encuestas q ON (((cal.semestre = q.semestre) AND ((g.grupo)::text = (q.grupo)::text))))
  WHERE (q.tipo = 'A'::bpchar);


ALTER TABLE public.l_encuestas_practicas OWNER TO cecilia;

--
-- Name: l_encuestas_servicio; Type: VIEW; Schema: public; Owner: cecilia
--

CREATE VIEW l_encuestas_servicio AS
 SELECT cal.semestre,
    g.idgrupo,
    g.grupo,
    g.profesor,
    q.ncuenta,
    q.idencuesta,
    q.npregunta,
    q.opcion
   FROM ((grupo g
     JOIN calendarizacion cal ON ((g.idcal = cal.idcal)))
     JOIN q_encuestas q ON (((cal.semestre = q.semestre) AND ((g.grupo)::text = (q.grupo)::text))))
  WHERE (q.tipo = 'B'::bpchar);


ALTER TABLE public.l_encuestas_servicio OWNER TO cecilia;

--
-- Name: profesor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profesor (
    id character(10) NOT NULL,
    titulo character varying(6),
    nombre character varying(20),
    apellidop character varying(20),
    apellidom character varying(20),
    correo_e character varying(50),
    habilitado boolean
);


ALTER TABLE public.profesor OWNER TO postgres;

--
-- Name: l_grupo; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW l_grupo AS
 SELECT g.idgrupo,
    g.grupo,
    p.titulo,
    p.apellidop,
    p.apellidom,
    p.nombre,
    p.id AS profe
   FROM (((grupo g
     JOIN profesor p ON ((g.profesor = p.id)))
     JOIN calendarizacion cal ON ((g.idcal = cal.idcal)))
     JOIN semestres s ON ((cal.semestre = s.id)))
  WHERE ((('now'::text)::date >= s.inicio) AND (('now'::text)::date <= s.fin))
  ORDER BY g.grupo;


ALTER TABLE public.l_grupo OWNER TO postgres;

--
-- Name: l_horarios; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW l_horarios AS
 SELECT c.idcal,
    h.descripcion
   FROM (calendarizacion c
     JOIN horarios h ON ((c.horario = h.id)))
  WHERE (c.semestre = '2015-1'::bpchar);


ALTER TABLE public.l_horarios OWNER TO postgres;

--
-- Name: l_profecsores_comentarios; Type: VIEW; Schema: public; Owner: cecilia
--

CREATE VIEW l_profecsores_comentarios AS
 SELECT DISTINCT c.idgrupo,
    g.grupo,
    g.p_titulo,
    g.p_nombre,
    g.p_apep,
    g.p_apem
   FROM (l_comentarios c
     JOIN l_gruposxsemestre('2015-1'::character varying) g(idg, grupo, profesor, p_titulo, p_nombre, p_apep, p_apem) ON ((c.idgrupo = g.idg)))
  WHERE (c.semestre = '2015-1'::bpchar)
  ORDER BY g.grupo;


ALTER TABLE public.l_profecsores_comentarios OWNER TO cecilia;

--
-- Name: l_profesores; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW l_profesores AS
 SELECT p.id AS profesor,
    p.titulo,
    p.nombre,
    p.apellidop AS apa,
    p.apellidom AS ama,
    p.correo_e,
    p.habilitado AS activo
   FROM (profesor p
     LEFT JOIN usuarios u ON (((u.nameuser)::bpchar = p.id)));


ALTER TABLE public.l_profesores OWNER TO postgres;

--
-- Name: l_profesores_comentarios; Type: VIEW; Schema: public; Owner: cecilia
--

CREATE VIEW l_profesores_comentarios AS
 SELECT DISTINCT c.idgrupo,
    g.grupo,
    g.p_titulo,
    g.p_nombre,
    g.p_apep,
    g.p_apem
   FROM (l_comentarios c
     JOIN l_gruposxsemestre('2015-1'::character varying) g(idg, grupo, profesor, p_titulo, p_nombre, p_apep, p_apem) ON ((c.idgrupo = g.idg)))
  WHERE (c.semestre = '2015-1'::bpchar)
  ORDER BY g.grupo;


ALTER TABLE public.l_profesores_comentarios OWNER TO cecilia;

--
-- Name: listarsemestre; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW listarsemestre AS
 SELECT semestres.id,
    semestres.inicio,
    semestres.fin
   FROM semestres;


ALTER TABLE public.listarsemestre OWNER TO postgres;

--
-- Name: prac_alumno; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW prac_alumno AS
 SELECT p.idpractica,
    p.nombre
   FROM ((grupo g
     JOIN calxpractica cxp ON ((cxp.idcal = g.idcal)))
     JOIN practicas p ON ((cxp.practica = p.idpractica)))
  WHERE (('now'::text)::date > cxp.fechafin)
EXCEPT
 SELECT p.idpractica,
    p.nombre
   FROM (((grupo g
     JOIN calxpractica cxp ON ((cxp.idcal = g.idcal)))
     JOIN i_encuestas ie ON ((cxp.idcxp = ie.idcxp)))
     JOIN practicas p ON ((cxp.practica = p.idpractica)))
  WHERE ((('now'::text)::date > cxp.fechafin) AND ((ie.ncuenta)::text = '410051630'::text));


ALTER TABLE public.prac_alumno OWNER TO postgres;

--
-- Name: q_encuestas_profesor; Type: VIEW; Schema: public; Owner: cecilia
--

CREATE VIEW q_encuestas_profesor AS
 SELECT ie.idencuesta,
    e.npregunta,
    e.opcion,
    ie.ncuenta,
    cal.semestre,
    g.idgrupo,
    p.tipo,
    p.idpractica,
    g.profesor
   FROM (((((encuestas e
     JOIN i_encuestas ie ON ((e.idencuesta = ie.idencuesta)))
     JOIN calxpractica cxp ON ((ie.idcxp = cxp.idcxp)))
     JOIN calendarizacion cal ON ((cal.idcal = cxp.idcal)))
     JOIN practicas p ON ((cxp.practica = p.idpractica)))
     JOIN grupo g ON ((g.idcal = cal.idcal)));


ALTER TABLE public.q_encuestas_profesor OWNER TO cecilia;

--
-- Name: s_buzon; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_buzon
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_buzon OWNER TO postgres;

--
-- Name: s_cal; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_cal
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_cal OWNER TO postgres;

--
-- Name: s_cxp; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_cxp
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_cxp OWNER TO postgres;

--
-- Name: s_encuesta; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_encuesta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_encuesta OWNER TO postgres;

--
-- Name: s_grupo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_grupo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_grupo OWNER TO postgres;

--
-- Name: s_horario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_horario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_horario OWNER TO postgres;

--
-- Name: s_idreportebimestral; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_idreportebimestral
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_idreportebimestral OWNER TO postgres;

--
-- Name: s_idreportesemestral; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_idreportesemestral
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_idreportesemestral OWNER TO postgres;

--
-- Name: s_practica; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_practica
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_practica OWNER TO postgres;

--
-- Name: s_user; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE s_user
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s_user OWNER TO postgres;

--
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY alumno (id, apellidop, apellidom, nombre, correo_e, brigada, grupo, activo) FROM stdin;
308279647	ISABEL NAYELI	ZAMORA	HERNANDEZ	r_chabela@hotmail.com	2	9	t
307176969	FATIMA CECILIA	GONZALEZ	MARTINEZ	fa_hula@hotmail.com	4	9	t
307093211	LIZA EDITH	MARES	HUITRON	\N	\N	9	t
307189499	DIEGO EDUARDO	HERNANDEZ	MENDOZA	\N	\N	9	t
306099887	JOSE ERNESTO	CONDE	BADILLO	pepeneto5@hotmal.com	1	9	t
308250772	CESAR	CRUZ	GONZALEZ	\N	\N	9	t
308080629	CARLOS	PINELO	GONZALEZ	car_6662@hotmail.com	3	9	t
308244681	SALVADOR	GARCIA	LINARES	\N	\N	9	t
308090622	YAIR ARI	RIVAS	LOPEZ	lapicito_yair@hotmail.com	3	9	t
409093629	PORFIRIO	RESENDIZ	NUÑEZ	\N	\N	9	t
307331801	GABRIELA IVONNE	OCHOA	GOMEZ	ivonne_2109@hotmail.com	4	9	t
309138424	MELISSA ARIADNE	CASTANEDA	PIEDRA	melissa_ariadne@yahoo.com.mx	4	11	t
307127545	JORGE ANTONIO	ALVAREZ	DIAZ	le.vago@hotmail.com	5	8	t
308072826	CHAIM	GONZALEZ	CORREA	chaimcg@hotmail.com	1	8	t
308071915	ERIK	FERNANDEZ	CABRERA	cabrera_pantera@hotmail.com	7	8	t
308626807	MARIO OSCAR	ORDAZ	MARTINEZ	mario_martinez_91@hotmail.com	4	5	t
307604426	LUIS EDUARDO	RAMOS	NAVARRETE	cope2012_hds@hotmail.com	3	8	t
308056646	CESAR FERNANDO	GRANADOS	GRANADOS	csargrana2@gmail.com	1	6	t
308313606	ERIK	SERRATO	HERRERA	erhs_1005@hotmail.com	2	5	t
308107638	JOSE ANTONIO	SANCHEZ	SUAREZ	germany_92_8@hotmail.com	4	6	t
308324912	VERONICA	MARTINEZ	SILVA	silva_ver21@hotmail.com	7	5	t
308105445	PAMELA ANDREA	BARBIER	ROSALES	shaistar10@hotmail.com	4	6	t
411004983	ROBERTO	ARGUELLES	GUTIERREZ	rguti91@comunidad.unam.mx	3	6	t
308045653	JOSE ARMANDO	CARRASCO	ARELLANO	havvi89@hotmail.com	2	5	t
308033498	GILBERTO JOEL	IRAGORRI	CEDEÃO	gilcr10@hotmail.com	1	7	t
308220034	OSCAR ALBERTO	GONZALEZ	RODRIGUEZ	oscar.rodriguez234@gmail.com	6	6	t
308192472	JOSE ANGEL	URIBE	MERCADO	ric_mmm@hotmail.com	3	5	t
308042999	FABIAN	JURADO	PRADEL	fabian_p_j@hotmail.com	4	5	t
308249284	JONATHAN	HERNANDEZ	ESCOBAR	jescobarnandez@gmail.com	8	6	t
308029631	VANESSA MONTSERRAT	GALINDO	GARCIA	van.gg@live.com.mx	1	5	t
308041947	MIGUEL ANGEL	PEREZ	FLORES	legion_98@hotmail.com	6	6	t
308162291	CESAR EDUARDO	RAMIREZ	CORNEJO	cornel1601@outlook.com	1	5	t
105000194	JOEL ANTONIO	ROMERO	BENITEZ	nonplusultra10@hotmail.com	6	8	t
306306282	VERONICA	VALENCIA	RODRIGUEZ	verolas29@hotmail.com	5	7	t
308151246	MARIANA ALEJANDRA	PALACIOS	ROCHA	mariana_rocha@comunidad.unam.mx	7	8	t
307616052	JOSE MARIA	GARCIA	SANTIAGO	chema10_20@hotmail.com	3	8	t
411036395	VICTOR	CEDILLO	TAPIA	marlboro_007@outlook.com	1	7	t
303843258	FRANCISCO JOSE	ARIZMENDI	CAMPOS	campos_arizmendi_f@hotmail.com	5	5	t
105001933	GENARO	ACOSTA	MARCOS	genaromarcosac@outlook.com	5	6	t
307168702	RICARDO ALEJANDRO	VILLANUEVA	LOPEZ	alex_cloe@hotmail.com	8	6	t
308334582	JORGE ISAAC	LOPEZ	GARCIA	jorgeisaac_59@hotmail.com	3	5	t
308253072	JOSE MARIA	DIAZ	MORA	moraJ_92@hotmail.com	1	6	t
308240308	GUSTAVO MONTEGUIU	VELAZQUEZ	JACOBI	monte_jacobi@hotmail.com	7	5	t
308023189	BRYAN ANGEL	GALVAN	FONSECA	arknafck07_@hotmail.com	7	8	t
307239123	ANGEL ABRAHAM	DOMINGUEZ	MARTINEZ	the_beatles.ang@hotmail.com	5	7	t
308012392	DANIEL ALEJANDRO	ANGELES	ANGULO	arguestr@gmail.com	5	6	t
308086937	MIJAEL	CASTAÃEDA	HERNANDEZ	mij_ballack@hotmail.com	8	5	t
308222722	KARLA VICTORIA	REYES	HERNANDEZ	khpuma@hotmail.com	6	7	t
306055904	ALEJANDRO IVAN	LARA	HERNANDEZ	ivan50191@hotmail.com	5	8	t
308268063	LUIS DARIO	DELGADO	REYES	ldariord@comunidad.unam.mx	1	8	t
308051926	GUSTAVO EDUARDO	GRANADOS	GALINDO	guzzland_10@hotmail.com	1	8	t
307097855	DAVID	LOPEZ	MONTES	david_fi2010@hotmail.com	2	6	t
308078419	ISRAEL	ABISAI	DE_LA_ROSA_GUDIÃO	gladgley@hotmail.com	6	8	t
308304806	DIEGO ALBERTO	GARCIA	ENDEJE	diegogo27@hotmail.com	3	8	t
308203792	JORGE GUSTAVO	RAMIREZ	ROSSANO	adiurd_1@hotmail.com	6	7	t
308102585	GERARDO IVAN	AMEZQUITA	ROMERO	krakon_laster@hotmail.com	2	8	t
308106411	EMMANUEL	ORDUÃA	VAZQUEZ	emmanuel.vazdu@comunidad.unam.mx	2	8	t
306146620	GALILEO	RAMIREZ	ARIAS	galileotkd@gmail.com 	2	7	t
306005459	CLAUDIA CITLALI	PEREZ	GASPAR	claudia_citlali@hotmail.com	6	8	t
307048455	ALEXIS	VILLARAUZ	CORTES	alexisjacovi@gmail.com	3	7	t
411003254	GERARDO	QUIÃONES	ALONSO	gerardo.aq@live.com.mx	8	5	t
307068743	CLAUDIA PAOLA	HUERTA	GONZALEZ	clau12_91@hotmail.com	7	7	t
306240168	MITZI ALI	RODRIGUEZ	SAUVINETT	sauvinett@gmail.com	3	7	t
307214201	CARLOS	GRANADOS	SEGURA	the.number.is.51@gmail.com	5	7	t
307093077	IRENE	CALDERON	HERNANDEZ	nevermore.poe0@gmail.com	3	7	t
306069204	CARLOS DANIEL	TEMIX	ALVAREZ	cd.temix4@comunidad.unam.mx	7	6	t
410085912	HECTOR ADRIAN	RAMIREZ	AVILES	fc.barcelona@live.com.mx	2	7	t
308124437	EDUARDO	HERNANDEZ	MARTINEZ	martinezhe12@hotmail.com	6	7	t
307292335	EDUARDO	SANCHEZ	ZARZA	zsedu@hotmail.com	2	7	t
307129013	YOLANDA ALEJANDRA	VILLANUEVA	PALACIOS	ale.palacios.villanueva@gmail.com	3	7	t
306160909	ALEJANDRO	RAMIREZ	HERNANDEZ	alexhdz15@hotmail.com	4	7	t
307594017	EMILIO JAVIER	AMBRIZ	MANRIQUE	fora_fromhell@hotmail.com	5	8	t
408011415	JONATAN EDUARDO	GARCIA	GUZMAN	\N	\N	5	f
307171469	CARLOS ARIEL	CATALAN	LOPEZ	\N	\N	6	f
307132615	ANGELO	VILLEGAS	SANDOVAL	yelo91@hotmail.com	4	7	t
412009730	ISAAC	ENRIQUEZ	RAMIREZ	shadowfax_15_13@hotmail.com	7	11	t
309238610	DANIEL	LEDESMA	HERNANDEZ	kaiser_lede_10@hotmail.com	1	10	t
106003600	MAURO ALBERTO	ESPINDOLA	RIVERO	maurofimec@gmail.com	6	11	t
308192386	DIANA ITZEL	HERNANDEZ	MERINO	itzelita_333@hotmail.com	5	10	t
309292386	VICTOR MANUEL	SANDOVAL	HERNANDEZ	bademecum@hotmail.com	1	10	t
307003908	VICTOR HUGO	RODRIGUEZ	HUITRON	heavengv@comunidad.unam.mx	6	10	t
308211289	JOSE ALVARO	REZA	LOPEZ	pepiux27@hotmail.com	4	10	t
307312383	FERNANDO	HERNANDEZ	VEGA	fernandovh91@gmail.com	4	11	t
309299749	CHRISTIAN MARTIN	PIEDRA	VELEZ	chrispanter_tam@hotmail.com	7	12	t
309028716	LUIS RODRIGO	JUNCO	CALIXTO	rocaneon@hotmail.com	6	12	t
309014588	DIANA CARELI	ROMERO	CAMACHO	dianacarelic.r.7@hotmail.com	3	12	t
308247125	ERICK	RAMIREZ	RAMOS	mecabeatle7@gmail.com	1	10	t
308240559	ANA LAURA	DUVINAN	MATIAS	ana.matias.duvinan@gmail.com	3	10	t
309125736	PERSEO DANIEL	ALQUICIRA	CASAS	perseo_casas@hotmail.com	2	12	t
308187072	HECTOR ALBERTO	BOBADILLA	FERNANDEZ	nemontemin_octo@hotmail.com	1	12	t
308102767	FRANCISCO	BUSTOS	MUÑOZ	franciscombfi@gmail.com	3	10	t
307542898	ARTURO	GALICIA	ISLAS	arturoislas_unam@hotmail.com	7	11	t
308230202	GIBRAN ESAU	TAPIA	RIVERO	esau286@hotmail.com	8	10	t
308188378	ARMANDO	HUARACHA	AYALA	monche_1205@hotmail.com	3	9	t
411035659	LAYLET	TERRAZAS	ROJAS	Lart_terrazas@hotmail.com	6	10	t
411080996	JESUS	FABIAN	TEXIS	jesus_ft2@hotmail.com	8	10	t
308048812	IVETTE	RODRIGUEZ	COLIN	du.s.t15@hotmail.com	5	10	t
412001112	GUSTAVO ADOLFO	FERNANDEZ	MALDONADO	gustavooo32_4@hotmail.com	2	11	t
309011532	MARIANA CATALINA	PEREZ	GOMEZ	marigate12@hotmail.com 	8	12	t
308044687	PABLO	BALLHAUS	GARCIA	ballhaus-17@hotmail.com	4	12	t
309126245	IVAN	JIMENEZ	FLORES	fji15@live.com.mx	8	12	t
308178234	ADRIAN	PADRON	GUTIERREZ	adrian_05@comunidad.unam.mx	5	12	t
308205435	FRED	AMENEYRO	VALDEZ	f.r.e.d.x@hotmail.com	7	10	t
308318326	PABLO	MORALES	BECERRA	pablo.becerra10@outlook.com	3	11	t
309239143	JESUS	COYOTZI	HERNANDEZ	jesus_coyotzi@hotmail.com	2	12	t
309104630	JORGE LUIS	PACHECO	HERNANDEZ	nadieeselmejor@hotmail.com	7	12	t
308227318	JESUS	ESPINOSA	CASTAÑEDA	jesuscast91@hotmail.com	1	11	t
305670698	RAUL	FRAGA	PEREZGAMA	raulpgf@comunidad.unam.mx	2	9	t
309292599	OSCAR	DELGADO	JUAREZ	oscar5-juarez@hotmail.com	3	12	t
308103630	ADRIANA	COSMES	VALADEZ	adriana.valadez.cosmes@hotmail.com	2	9	t
309528955	ALDO	HERNANDEZ	MARIACA	mahayo2404@gmail.com	5	12	t
410060492	LUIS MANUEL	RUIZ	VENTURA	\N	\N	9	t
412054345	JESUS ALBERTO	CELERINO	PERALTA	jealperalta@gmail.com	6	12	t
308307962	GASPAR ANTONIO	ZETINA	CESAR	gaspar_lana@yahoo.com.mx	8	11	t
308020652	HUGO ALEJANDRO	DELGADO	BARONA	barona_delgado_hugo_2b@hotmail.com	6	10	t
412005361	JOSE	PIECK	BAÑUELOS	josebapieck@hotmail.com	2	10	t
309014124	JOSE ALFREDO	ROMERO	CARSI	alfredocarsi@hotmail.com	2	10	t
308263422	ERNESTO	RUBIO	CORTES	\N	\N	10	t
308328532	ADRIAN	CEDILLO	GUZMAN	sionagch@gmail.com	7	10	t
308260775	RUTH YUNUEN	GONZALEZ	GUZMAN	rutsiana_leo@Hotmail. com	3	10	t
307105844	NAYELI	GARCIA	HERNANDEZ	Nayeli_Akwid@hotmail.com	5	10	t
309692724	MAURICIO	RODRIGUEZ	MORALES	mauricio_silver@hotmail.com	8	11	t
309262026	ANDRES	CORTES	OSORIO	aoc_keane@hotmail.com	6	11	t
308253632	JORGE LUIS	GAYTAN	PARDO	jorgpg5@yahoo.com.mx	2	11	t
308227617	ERICK EDUARDO	MENDOZA	PEDRO	ing_erick91@hotmail.com 	1	11	t
308194548	ULISES	CARMONA	RAMIREZ	uli_punkanarquia@hotmail.com	1	12	t
411000576	OMAR	HERNANDEZ	TOMAS	omar_th28@hotmail.com	4	12	t
308315198	ISRAEL	GUERRERO	MORALES	ex.627@hotmail.com	4	10	t
307039387	RAUL GIOVANI	SALINAS	ESPINOSA	pareja-2009@hotmail.com	4	9	t
308323551	ANDREY GUILLERMO	ALCALA	TORRES	andrey_alcala@hotmail.com	3	11	t
309038434	ADAN	GONZALEZ	ALEJANDRO	\N	\N	16	t
307058647	AGUILAR	SALINAS	JOSE DAVID	\N	\N	16	t
308055333	CABRERA	ORTEGA	JORGE	\N	\N	16	t
307226349	CASILLAS	SANTANA	FRANCISCO ABNER	\N	\N	16	t
620161056	CORREA	GONZÃLEZ	MIGUEL EDUARDO	\N	\N	16	t
309628512	GARCIA	ALVAREZ	ALEXIS STEFANO	\N	\N	16	t
307330402	HERNANDEZ	ISLAS	JOSUE	\N	\N	16	t
309094788	JAIMES	ALVARADO	LEONARDO	\N	\N	16	t
307219866	MONCADA	ALVARADO	SEBASTIAN	\N	\N	16	t
307259033	MONTES	CERON	JESUS	\N	\N	16	t
305071318	PEREZ	REYES	PANALI	\N	\N	16	t
309215620	PIOQUINTO	PEREZ	LUIS FELIPE	\N	\N	16	t
410086854	QUIJADA	JIMENEZ	MAURICIO	\N	\N	16	t
307162652	REYES	PEREZ	RODRIGO	\N	\N	16	t
309115245	ROMERO	ROBLES	MARIO RUBEN	\N	\N	16	t
309338222	VICENTEÃO	HERNANDEZ	CHRISTIAN	\N	\N	16	t
412007499	CRUZ	ALFONSO	ALFONSO	\N	\N	13	t
309096287	CRUZ	MORENO	HUMBERTO ALEJANDRO	\N	\N	13	t
309044408	DIAZ	GOMEZ	ISAAC ROBERTO	\N	\N	13	t
310053442	FERNANDEZ	HERNANDEZ	HERNANN ARENKKAR	\N	\N	13	t
307079080	GONZALEZ	CABRERA	DAN EMMANUEL	\N	\N	13	t
309146540	HERNANDEZ	SANCHEZ	SERGIO	\N	\N	13	t
309235592	LOPEZ	TORRES	MARIA ESTHER	\N	\N	13	t
309161840	MENDOZA	VICTORIA	ANDRES	\N	\N	13	t
309303091	MORALES	VALENCIA	YULER IVAN	\N	\N	13	t
411019819	ORTIZ	CASTILLO	MIGUEL ANGEL	\N	\N	13	t
309286927	PEREZ	RIVERA	ERICK JAIR	\N	\N	13	t
309137740	QUINTANAR	HARO	ISAI	\N	\N	13	t
310119126	RAMIREZ	CONTRERAS	HECTOR MANUEL	\N	\N	13	t
310282383	REYES	GIL	ALAN	\N	\N	13	t
309307020	RODRIGUEZ	HUITRON	SAMUEL	\N	\N	13	t
309138747	RODRIGUEZ	MEZA	EDUARDO	\N	\N	13	t
309342498	XALA	ESTRADA	ERIK ALFONSO	\N	\N	13	t
308016369	ALQUICIRA	BALDERAS	MARCO ANTONIO	\N	\N	14	t
309087968	AZUARA	DOMINGUEZ	JORGE LUIS	\N	\N	14	t
309017448	BARCENAS	HERNANDEZ	IVONNE	\N	\N	14	t
309025777	BOCHE	LUCIO	ASIELY SCARLET	\N	\N	14	t
309010188	DEL	RIO	CRUZ VANIA	\N	\N	14	t
413093257	ESPINOSA	RAMIREZ	CARLOS	\N	\N	14	t
309053514	GONZALEZ	CAIRE	ARTURO DANIEL	\N	\N	14	t
309056137	GONZALEZ	SORIANO	OSCAR ALEJANDRO	\N	\N	14	t
307187330	GUTIERREZ	CAMPOS	ROBERTO ANTONIO	\N	\N	14	t
309103774	GUTIERREZ	VICTORIA	MIGUEL ANGEL	\N	\N	14	t
309107507	MONTIEL	BENITEZ	RAUL	\N	\N	14	t
412006935	RODRIGUEZ	CRUZ	LUIS CARLOS	\N	\N	14	t
412056899	ROMERO	CARRERA	ARTURO	\N	\N	14	t
412053348	ROSAS	RAYA	MIGUEL ANGEL	\N	\N	14	t
309331357	VEZ	ROJO	BRENDA CAROLINA	\N	\N	14	t
309339717	VILLEGAS	MERLOS	JESSICA	\N	\N	14	t
309017400	ALMAGUER	LOYOLA	LUIS FERNANDO	\N	\N	15	t
309035172	CERON	RICO	FRANCISCO EMMANUEL	\N	\N	15	t
309037781	CHAVEZ	ROMERO	MISAEL	\N	\N	15	t
410082966	COCOLETZI	CABRERA	GILBERTO	\N	\N	15	t
106000654	GUTIERREZ	SANTILLAN	GABRIEL	\N	\N	15	t
309094128	HUATO	SOLORIO	JULIO CESAR	\N	\N	15	t
307259521	MEJIA	ALVAREZ	ERICK	\N	\N	15	t
412051069	ORTIZ	SANCHEZ	EDUARDO URIEL	\N	\N	15	t
307154749	RAMIREZ	CABALLERO	ANGEL EDUARDO	\N	\N	15	t
309209962	RANGEL	FUERTE	IGNACIO	\N	\N	15	t
309131652	REYES	ALCARAZ	TANIA VIVIANA	\N	\N	15	t
309315115	ROMERO	HERNANDEZ	MIGUEL ANGEL	\N	\N	15	t
412005457	RUIZ	MARQUEZ	JUAN PEDRO	\N	\N	15	t
309328274	SOTO	JAIME	CESAR DAVID	\N	\N	15	t
309161022	TEMELO	AVILES	RAQUEL	\N	\N	15	t
307109677	MARIO ALBERTO	GUTIERREZ	OLVERA	yarelajate_xthing-messi@hotmail.com	5	6	t
410054040	DIMITRI ALEJANDRO	RAMIREZ	COVARRUBIAS	d.a.c.r_91@hotmail.com	1	6	t
620151031	DANIEL GUADALUPE	GONZÃLEZ	ARREOLA	danielarreola.tepe@gmail.com	1	7	t
307294937	VALENTIN	IBAÃEZ	DAVID	\N	\N	7	t
309200536	GARCIA	ONTIVEROS	EDUARDO	\N	\N	17	t
309028709	CALIXTO	JUNCO	LUIS IVAN	gtgt@hotmail.com	4	13	t
307082613	MIRANDA	GARCIA	DANIEL	\N	\N	17	t
309204053	VILLALPANDO	GARCIA	SANDRA MONTSERRAT	\N	\N	17	t
310189402	GARCIA	GONZALEZ	MAGALI	\N	\N	17	t
309031686	GUZMAN	GONZALEZ	ALAN JESUS	\N	\N	17	t
307036269	MORALES	GUTIERREZ	AURORA	\N	\N	17	t
310170705	ORTIZ	HERNANDEZ	OSCAR	\N	\N	17	t
309190488	SEGURA	LINARES	VASCO ALBERTO	\N	\N	17	t
413025274	MARIN	MARES	GUILLERMO	\N	\N	17	t
309182915	SUASTEGUI	MARTINEZ	RICARDO JAVIER	\N	\N	17	t
309148898	CALDERON	MORALES	ETHIEL SALVADOR	\N	\N	17	t
309263731	CINENCIO	PEREZ	DANIEL JOSUE	\N	\N	17	t
310300265	VAZQUEZ	PEREZ	ALEJANDRO	\N	\N	17	t
309310976	GONZALEZ	SALINAS	FRANCISCO MICHELL	\N	\N	17	t
309041524	TOVAR	CABELLO	EMMANUEL ANTONIO	prueba@prueba.com.mx	1	17	t
412055861	GUZMAN	SOLANO	CARLOS JAVIER	\N	\N	17	t
412002384	FLORES	FLORES	RODRIGO	\N	\N	18	t
310035440	MEJIA	GOMEZ	VICTOR DANIEL	\N	\N	18	t
310095187	GONZALEZ	GUTIERREZ	LESLIE RAFAELA	\N	\N	18	t
309218391	RESENDIZ	HERNANDEZ	CHRISTOPHER	\N	\N	18	t
310199670	MORA	MARAVILLAS	ERICK	\N	\N	18	t
309566702	SORIANO	MONTERO	DIEGO ALAN	\N	\N	18	t
310199917	SIERRA	PEREZ	SAID ULISES	\N	\N	18	t
310254395	LEONARDO	PINEDA	CESAR	\N	\N	18	t
309145354	FERNANDEZ	RAMOS	ALONSO	\N	\N	18	t
310737876	MARTINEZ	RODRIGUEZ	PABLO ESTEBAN	\N	\N	18	t
310205067	CASTILLEJOS	SANCHEZ	LEOBARDO	\N	\N	18	t
308157334	HERRERA	SOLIS	LUIS EDUARDO	\N	\N	18	t
310135492	MONTERRUBIO	UEJI	KAZUYUKI OBED	\N	\N	18	t
310339432	LOPEZ	URBINA	LETICIA XIMENA	\N	\N	18	t
309527752	LA	DE	CABADA DE LA	cgomezca89@gmail.com	2	18	t
\.


--
-- Data for Name: buzon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY buzon (idbuzon, usuario, comen, seguir, fecha, respuesta) FROM stdin;
2	411004983	Mi grupo aparece mal en el sistema, aparece como grupo 6, cuando soy del grupo 4	t	2014-09-11	\\nHola, gracias por tu notificación\\nDesde que navegador no tuviste problema?\\n\\nSaludos
2	412054345	Bueno, olvidé intentar contestar la encuesta desde otro navegador y afortunadamente sé se pudo.	t	2015-02-25	\\nHola, gracias por tu notificación\\nDesde que navegador no tuviste problema?\\n\\nSaludos
6	308023189	Tengo problemas con responder las encuestas de las prácitcas 4 y 5, van 3 intentos, me dice que fue exitoso mi envío, peor me siguen marcando como si no las hubiese contestado, Gracias	f	2014-10-06	\\N
4	308105445	Buenas tardes, ya había enviado un correo diciendo que mi nombre estaba mal y aún sigue igual, mi nombre correcto es Pamela Andrea Rosales Barbier. Gracias	t	2014-09-28	\\N
7	105001933	Envié la encuesta de la practica 12 y sigue apareciendo que no la eh conestado	f	2014-10-08	\\N
5	308304806	Algunas mesas neumáticas no están bien niveladas y se mueven cuando se accionan los pistones. 	f	2014-10-06	\\N
14	308124437	no me aparecen las encuestas 13,14,15.	f	2014-11-18	\\N
3	411036395	Quiero felicitarles por su esfuerzo tan grande de mejorar cada día el laboratorio de automatización, ya que de esta forma tendremos un ambiente mas cómodo gracias al nuevo mobiliario y los anaqueles para las mochilas.\\nMuchas felicidades por el logro!!! 	f	2014-09-21	Hola,\n\nLa manera de saber si se ha enviado bien la encuesta es porque ya no te aparece más en el menú, si siguen apareciendo es porque no se han registrado.
8	308012392	cuando pongo comentarios obligatorios en las encuestas se tardan tanto en enviarse que termino sin enviar nada.	t	2014-10-10	\\N
15	105001933	El sistema dice que no tengo encuestas	f	2014-11-19	Gracias por tu notificación. \\n\\nSaludos. \\n
9	307168702	no me registra el numero de practicas que se estan contestando. Ya realice las encuestas 4,6,8 y 10, pero no las registra.\\n	f	2014-10-15	\\N
3	412054345	Hola, mi nombre es Jesús Alberto Peralta Celerino, del grupo 2. Ya había llenado las encuestas de las prácticas que se han hecho, pero volví a llenarlas porque se me dijo que no se había registrado ninguna. Abro y cierro mi sesión y puedo volver a llenar dichas encuestas. Cada que finalizo me aparece un mensaje de que mi encuesta se ha enviado. ¿Cómo aseguro que eso es cierto? Por otra aparte me sigue dando la opción de volverlas a llenar. Gracias.	t	2015-03-05	Hola,\n\nLa manera de saber si se ha enviado bien la encuesta es porque ya no te aparece más en el menú, si siguen apareciendo es porque no se han registrado.
10	308105445	Ya conteste la encuesta 12 y sigue apsreciendo.	t	2014-10-17	\\N
0	309104630	prueba buzon 20151	f	2015-02-13	\\N
11	308012392	no puedo enviar la encuesta 12 porque no se termina de cargar la página después de contestarla por completo. 	t	2014-10-20	\\N
12	306160909	BUEN DIA, HE LLENADO TODAS LAS ENCUESTAS Y ME SIGUEN APARECIENDO COMO SI NO LAS HUBIESE LLENADO. \\natte: ALEJANDRO HERNANDEZ RAMIREZ, \\n      #CUENTA: 306160909\\n      AUTOMATIZACION INDUSTRIAL, GPO:3	f	2014-10-23	\\N
1	308105445	Buenas tardes, en las encuestas que llene mi nombre sale mal escrito, debería de ser Rosales Barbier Pamela Andrea y por otro lado el grupo es el 4 no el 6. Gracias 	t	2014-09-07	Hola,\\n\\nPor favor revisa que hayas llenado todos los campos de comentarios donde hayas evaluado con menos de 10, otro problema puede ser que tengas comentarios con menos de 10 caracteres.\\n\\nSi te sigue sucediendo tomale una foto a tu encuesta y enviala por el correo labautomatizacionindsutrial@gmail.com  para poder saber más  sobre tu porblema.\\n\\nSaludos\\n\\n
13	308071915	Hola, conteste tres veces la evaluacián de servicio 1 y a pesar de que la envéo y el sistema me marca que dicha encuesta ya fue enviada, me sigue apareciendo en el apartado de encuestas. \\nMuchas gracias por su atención	f	2014-11-04	\\N
1	412054345	Hola. A la hora de enviar el cuestionario, me aparece un mensaje que dice "Corrige", y no me permite terminar con el llenado de la encuesta  ¿qué debo hacer? Ya revisé si me faltá llenar algún campo. 	t	2015-02-25	Hola,\\n\\nPor favor revisa que hayas llenado todos los campos de comentarios donde hayas evaluado con menos de 10, otro problema puede ser que tengas comentarios con menos de 10 caracteres.\\n\\nSi te sigue sucediendo tomale una foto a tu encuesta y enviala por el correo labautomatizacionindsutrial@gmail.com  para poder saber más  sobre tu porblema.\\n\\nSaludos\\n\\n
\.


--
-- Data for Name: calendarizacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY calendarizacion (idcal, horario, semestre) FROM stdin;
5	1	2015-1 
6	2	2015-1 
7	1	2015-2 
8	2	2015-2 
9	1	2016-1 
10	2	2016-1 
11	1	2016-2 
12	2	2016-2 
\.


--
-- Data for Name: calxpractica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY calxpractica (idcxp, idcal, practica, fechainicio, fechafin) FROM stdin;
1	6	1	2014-08-19	2014-08-21
2	5	1	2014-08-18	2014-08-22
3	6	2	2014-08-21	2014-08-28
4	5	2	2014-08-18	2014-08-22
5	6	3	2014-08-26	2014-08-28
6	5	3	2014-08-25	2014-08-29
7	6	4	2014-09-02	2014-09-04
8	5	4	2014-09-01	2014-09-05
9	6	5	2014-09-09	2014-09-11
10	5	5	2014-09-08	2014-09-12
11	6	6	2014-09-16	2014-09-25
12	5	6	2014-09-22	2014-09-26
13	6	7	2014-09-16	2014-09-25
14	5	7	2014-09-22	2014-09-26
15	6	8	2014-09-23	2014-09-25
16	5	8	2014-09-22	2014-09-26
17	6	9	2014-09-23	2014-09-25
18	5	9	2014-09-22	2014-09-26
19	6	10	2014-09-30	2014-10-02
20	5	10	2014-09-29	2014-10-03
21	6	11	2014-09-30	2014-10-07
22	5	11	2014-09-29	2014-10-03
23	6	12	2014-10-07	2014-10-16
24	5	12	2014-10-06	2014-10-10
25	6	13	2014-10-28	2014-10-30
26	5	13	2014-10-27	2014-10-31
27	6	14	2014-10-28	2014-10-30
28	5	14	2014-10-27	2014-10-31
29	6	15	2014-11-04	2014-11-11
30	5	15	2014-11-03	2014-11-07
31	6	16	2014-11-04	2014-11-11
32	5	16	2014-11-03	2014-11-07
34	7	1	2015-01-26	2015-01-30
35	7	16	2015-05-04	2015-05-08
36	7	2	2015-02-09	2015-02-13
37	7	3	2015-02-16	2015-02-20
38	7	4	2015-02-23	2015-02-27
39	7	5	2015-03-02	2015-03-06
40	7	6	2015-03-16	2015-03-20
41	7	7	2015-03-16	2015-03-20
42	7	8	2015-03-23	2015-03-27
43	7	9	2015-03-23	2015-03-27
44	7	10	2015-03-23	2015-03-27
45	7	11	2015-03-23	2015-03-27
46	7	12	2015-04-06	2015-04-10
47	7	13	2015-04-27	2015-05-01
49	7	14	2015-04-27	2015-05-01
50	7	15	2015-05-04	2015-05-08
51	8	1	2015-02-10	2015-02-12
52	8	2	2015-02-10	2015-02-12
53	8	3	2015-02-17	2015-02-19
54	8	4	2015-02-24	2015-02-26
55	8	5	2015-03-03	2015-03-05
56	8	6	2015-03-17	2015-03-19
57	8	7	2015-03-17	2015-03-19
58	8	8	2015-03-24	2015-03-26
59	8	9	2015-04-07	2015-04-09
60	8	10	2015-04-07	2015-04-09
61	8	11	2015-04-14	2015-04-16
62	8	12	2015-04-14	2015-04-16
63	8	13	2015-04-21	2015-04-23
64	8	14	2015-04-21	2015-04-23
65	8	15	2015-05-05	2015-05-07
66	8	16	2015-05-05	2015-05-07
67	10	1	0015-08-25	0015-08-27
68	10	2	0015-08-25	0015-08-27
69	10	3	0015-09-01	0015-09-03
70	10	4	0015-09-08	0015-09-10
71	10	5	0015-09-15	0015-09-17
72	10	6	0015-09-29	0015-10-01
73	10	7	0015-09-29	0015-10-01
74	10	8	0015-10-06	0015-10-08
75	10	9	0015-10-13	0015-10-15
76	10	10	0015-10-13	0015-10-15
77	10	11	0015-10-20	0015-10-22
78	10	12	0015-10-20	0015-10-22
79	10	13	0015-10-27	0015-10-29
80	10	14	0015-10-27	0015-10-29
81	10	15	0015-11-10	0015-11-12
82	10	16	0015-11-12	0015-12-15
83	9	1	0015-08-24	0015-08-28
84	9	2	0015-08-24	0015-08-28
85	9	3	0015-10-01	0015-09-04
86	9	4	0015-09-07	0015-09-11
87	9	5	0015-09-14	0015-09-18
88	9	6	0015-09-28	0015-10-02
89	9	7	0015-09-28	0015-10-02
90	9	8	0015-10-28	0015-10-02
91	9	9	0015-10-28	0015-10-02
92	9	10	0015-10-05	0015-10-09
93	9	11	0015-10-05	0015-10-09
94	9	12	0015-10-12	0015-10-16
95	9	13	0015-10-26	0015-10-30
96	9	14	0015-10-26	0015-10-30
97	9	15	0015-11-09	0015-11-13
98	9	16	0015-11-13	0015-12-15
99	11	1	2016-02-01	2016-02-05
100	11	2	2016-02-15	2016-02-19
101	11	3	2016-02-15	2016-02-19
102	11	4	2016-02-22	2016-02-26
103	11	5	2016-02-29	2016-03-04
104	11	6	2016-03-07	2016-03-11
105	11	7	2016-03-28	2016-04-01
106	11	8	2016-03-28	2016-04-01
107	11	9	2016-03-28	2016-04-01
108	11	10	2016-04-04	2016-04-08
109	11	11	2016-04-04	2016-04-08
110	11	12	2016-04-11	2016-04-15
111	11	13	2016-05-02	2016-05-06
112	11	14	2016-05-02	2016-05-06
113	11	15	2016-05-16	2016-05-20
114	11	16	2016-05-16	2016-05-20
115	12	1	2016-02-16	2016-02-18
116	12	2	2016-02-16	2016-02-18
117	12	3	2016-02-23	2016-02-25
118	12	4	2016-03-01	2016-03-03
119	12	5	2016-03-08	2016-03-10
120	12	6	2016-03-29	2016-03-31
121	12	7	2016-03-29	2016-03-31
122	12	8	2016-04-05	2016-04-07
123	12	9	2016-04-12	2016-04-14
124	12	10	2016-04-12	2016-04-14
125	12	11	2016-04-19	2016-04-21
126	12	12	2016-04-19	2016-04-21
127	12	13	2016-04-26	2016-04-28
128	12	14	2016-04-26	2016-04-28
129	12	15	2016-05-10	2016-05-12
130	12	16	2016-05-10	2016-05-12
\.


--
-- Data for Name: comentarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comentarios (idencuesta, idpregunta, comentario) FROM stdin;
14	16	Los contadores se aplicaron de buena manera
21	5	La temporización se vuelve ligeramente complicada al mezclar con los contactos N/A  físicos y en el programa. Recomendaría un ejemplo más antes de la práctica.
16	16	Porque se logró conseguir que funcionara lo solicitado.
18	16	Se pudo realizar con éxito el proceso que se solicito.
21	18	Recomendaría comenzar la práctica antes, ya que salimos media hora después.
22	16	Aprendí a usar y monitorear contadores
19	16	Logramos ver el funcionamiento de los registros de corrimiento
9	16	El comportamiento esperado fue satisfactorio.
20	16	Porque aprendí a usar salidas autoenclavadas
24	8	A veces no alcanza el espacio en las mesas para poder escribir apuntes
30	16	Se aprendió el uso de salidas autoenclavadas
23	18	Creo que estaría bien ver un ejemplo más de la aplicación de los parámetros del SFR bit de inicio y numero de bits.
49	18	Deberían agregar mesas de trabajo o asientos junto al equipo de trabajo (PLC y material neumático)
49	16	Porque se comprendió perfectamente el uso y la programación de contadores en el micro 1
31	16	Se dieron ejemplos claros para utilizar los timers
32	16	Se realizaron ejemplos claros sobre los contadores
33	16	Se realizaron ejemplos claros sobre los registros
46	8	Sillas muy incómodas y se requiere más espacio en las mesas.
46	16	Porque se realizó correctamente el corrimiento de los bits deseados para tener una salida por un segundo.
47	16	Porque se comprendió perfectamente el enclavamiento de las salidas
47	18	Deberían agregar una mesa para las cosas o bancos en la zona de trabajo (junto al equipo y PLC)
48	16	Porque se comprendió a la perfección el uso de temporizadores
48	18	Deberían agregar mesas de trabajo o asientos junto al equipo de trabajo (PLC y material neumático)
50	16	Porque se comprendió de manera correcta el uso de registros de corrimiento y su programación en el micro 1
50	18	Deberían agregar mesas de trabajo o asientos junto al equipo de trabajo (PLC y material neumático)
51	16	Porque logre entender que las señales de salida de un PLC pueden utilizarse como señales de control, además de que dichas señales de salida pueden mantenerse energizadas retroalimentandose con su propia señal.  
52	16	Porque entendí tanto el funcionamiento como la aplicación de los temporizadores tanto positivos como negativos
53	16	Porque pude entender el funcionamiento de los contadores, lo cual me permitió utilizarlos para activar una salida del PLC. 
54	16	Porque aprendí la utilidad de los registros de corrimiento y logre aplicar este conocimiento programando en un PLC el seguimiento de artículos.
57	6	Me costó un poco entender la explicación de lo que se debía hacer en la práctica
59	10	Se presenta mucho ruido del taller de manufactura o en ocasiones del otro lado (abajo del puente)
59	16	Porque aprendí a utilizar botones enclavados en un PLC
60	10	Se presentó mucho ruido del taller de manufactura.
60	16	Se aprendió a utilizar los temporizadores positivos y negativos, así como su diferencia.
980	9	No había aire
2	8	No hay espacio suficiente en las mesas y las sillas están incómodas.
2	16	Porque se lográ diseñar un programa capaz de mantener encendida una salida durante 5 segundos cada vez que se activara la señal del sensor de presencia.
545	16	por que se obtuvo lo esperado
973	8	Faltan bancos
3	16	Porque se lográ implementar un contador que al llegar al valor de 10, mandara una señal para encender la banda transportadora.
3	8	No hay suficiente espacio en las mesas para trabajar y las sillas están incómodas.
1	16	 Porque se lográ enclavar la salida con un botón NA y desenclavarla con un botón de paro.
4	16	Porque conocimos el funcionamiento de los PLC, así como el funcionamiento de una salida autoenclavada
8	16	Los objetivos fueron simples y fáciles de cumplir
6	16	Porque conocimos el funcionamiento de un contador, así como su función y programación en un PLC, aplicado a un proceso industrial.
4	18	Excelente estado del equipo y del laboratorio.
5	16	Porque conocimos los tipos de temporización, así como su programación en un PLC, y observamos su funcionamiento.
5	18	Ninguna queja, todo se encuentra en excelentes condiciones.
11	16	Se comprendió el funcionamiento que tienen los registros. Y la forma en la que se puede jugar con su dirección.
6	18	Excelentes condiciones de trabajo.
7	16	Porque aprendimos la operación y programación de corrimiento de un PLC aplicado al seguimiento de artículos en un proceso industrial.
7	18	Todo perfecto.
10	16	Se cumplió el objetivo de sólo dejar entrar 5 autos al estacionamiento, así como contar en forma ascendente y descendente con el contador. 
13	16	La práctica se realizo correctamente
15	16	La practica se llevo a cabo de la manera correcta
17	16	Se logró comprobar el funcionamiento de los temporizadores
12	16	Se pudo realizar la práctica sin problemas
22	18	Comenzar la práctica unos minutos antes.
1	8	Falta espacio en las mesas y las sillas están incómodas
83	16	Se entedió el tema al realizar la práctica 
83	8	faltaban mensas 
84	16	Se entendió el tema llevandolo a la práctica 
85	16	El llevar a la práctica el tema se entiende mejor
86	16	La práctica fue sencilla y se comprendió de manera correcta el tema
90	8	las sillas son incomodas
96	16	Porque aprendí a usar bloques de funciones aritmeticas.
95	16	Se aprendió sobre el programa y sus funciones
98	16	Se comprendió el uso del autoenclavamiento
97	16	Se logró aplicar satisfactoriamente una señal autoenclavada en el funcionamiento del programa.
103	16	Aprendimos lo esencial de salidas autoenclavadas.
213	16	claridad del tema y su aplicación
104	16	Aprendí como usar los temporizadores y me di cuenta que son esenciales para ciertas rutinas.
105	16	Pues porque aprendí a utilizar los contadores, los cuales me facilitan hacer programas complejos.
106	16	Saber usar los registros de corrimiento es muy importante en la programación de PLC's, ya que se puede facilitar la programación de ciertas rutinas.
107	16	Cumplimos el objetivo, y realizamos ejercicios de una complejidad aceptable con funciones aritméticas.
71	18	Deberían colocar una mesa junto al equipo para colocar el material
61	18	Buena práctica
71	16	Porque se comprendió el uso de funciones aritméticas
76	8	Sillas incómodas y espacio para poner mi laptop es insuficiente.
76	16	Porque se logró diseñar un programa contador de chicles y de cajas utilizando diversas funciones aritméticas.
118	18	ninguno, todo bien
118	16	Se vio el funcionamiento, donde encontralas en el simulador, como usarlas y en donde se aplican
61	10	Ahora no hubo tanto ruido.
119	16	Se probaron las funciones algorítmicas de manera adecuada
122	15	Uno de los botones no estaba conectado.
125	16	Se logró poner en practica lo visto en la clase
131	16	Se llego a los resultados previstos
132	18	tapones mas largos, es dificil sacarlos y hace falta herramienta para sacar las mangueras 
135	16	Se logro hacer funcionar un pistón de simple efecto
136	16	Se logró hacer funcionar un pistón de doble efecto
137	16	Se logró controlar el tiempo de funcionamiento de un pistón de doble efecto
145	16	En teoría no comprendí el funcionamiento y al realizar la práctica entendí el funcionamiento 
146	16	Al utilizar el programa para la simulación de la práctica fue de gran ayuda ya que ayuda a visualizar las conexiones 
147	15	el temporizador no funcionaba 
147	16	aprendi a utilizar y saber como conectar el temporizador neumático
148	16	aprendi a ligar movimientos de dos o más pistones
149	16	Porque se pudo accionar el cilindro de simple efecto mediante un botón pulsador.
150	16	Porque se logró accionar y retraer un cilindro de doble efecto mediante un botón pulsador y mediante dos botones pulsadores.
151	16	Porque se logró mantener unos segundos el vástago extendido, para luego retraerse y repetir el ciclo, mediante un botón enclavado.
152	16	Porque se logró secuenciar dos cilindros de doble efecto, para que uno se accionara después del otro, mediante el flanco de subida de un botón pulsador.
153	16	Se comprendió de manera correcta el accionamiento de pistones de simple efecto
154	16	Se comprendió el accionamiento de pistones de doble efecto
155	16	Se comprendió el uso de temporizadores neumáticos
156	16	Se logró correctamente el accionamiento de la secuencia neumática
157	16	Aprendí a programar las salidas enclavadas con un PLC
158	16	Porque aprendí como funciona y como programar un temporizador con el PLC
159	16	Porque aprendí a emplear los contadores de un PLC
160	16	Porque aprendí a implementar una instalación neumática mediante el método de cascada 
161	16	Porque se pudo implementar una instalación neumática sencilla para activar un cilindro de simple efecto
162	4	LAS VÁLVULAS NO FUNCIONABAN DE LA MANERA CORRECTA, ESTABAN INVERTIDAS 
162	15	LAS VÁLVULAS NO HACIAN BIEN SU FUNCIÓN
162	16	SE COMPRENDIÓ EL FUNCIONAMIENTO DE LAS MEMORIAS NEUMÁTICAS, ADEMÁS DE QUE SE APRENDIÓ A USAR LAS VÁLVULAS 5/2 COMO MEMORIAS NEUMÁTICAS
163	4	Las válvulas de la mesa 7 estan con una lógica invertida
163	15	las vávulas 5/2 de la mesa 7 estan invertidas, nos dimos cuenta al ver que no funcionaba la secuencia 
163	16	Se comprendió como utilizar el método de cascada para resolver una secuencia neumática
163	17	Debido a que la mesa 7 no funcionaba correctamente se tuvo que cambiar de mesa 
178	18	Todo se realizó bien
179	18	El concepto quedó claramente entendido con ayuda del equipo
180	8	faltaban mesas, sillas y equipos de computo
181	16	Se aplicó a un problema de la vida real
181	18	La maqueta ayudó a visualizar mejor la práctica
182	8	faltaban mesas, sillas y equipos de computo
183	8	faltaban mesas, sillas y equipos de computo
184	8	faltaban mesas, sillas y equipos de computo
185	18	Todo correcto en la practica
186	8	faltaban mesas, sillas y equipos de computo
187	8	faltaban mesas, sillas y equipos de computo
188	8	faltaban mesas, sillas y equipos de computo
189	16	La práctica fue compleja pero se cumplió el objetivo
193	16	Fue interesante interactuar con equipo neumático por primera vez
546	9	los bancos son muy incomodos
198	16	El método paso a paso es un poco complicado pero funciona bien una vez razonado
197	16	Las secuencias se realizaron como debían
199	16	éste método es más sencillo y rápido, le entendí mejor
200	16	Se realizaron los objetivos correctamente
201	16	Se pudo controlar tiempo del temporizador al gusto del usuario 
202	16	Se puedo contar descendente y acendentemente señales de un sensor. 
203	16	Se pudo implemntar en el plc corriemientos.
204	16	Se pudiern cumplir los objetivos 
205	16	Se acciono un embolo de simple y doble efecto con neumatica
206	16	Se pudo accionar un embolo de doble efecto con neumatica.
207	16	Se uso un temporizador para mover un embolo de simple efecto 
208	16	Se cumplieron los objetivos de implmentar un secuencia neumatica 
209	16	Se pudo implentar el metodo paso a paso para la implentacion de meorias neumaticas. 
210	16	Se implemento el metodo cascada con ayuda de el simulador y en fisico. 
212	9	espacio de mesas y sillas
212	16	porque se cumplió el objetivo de la practica y del tema de manera ejemplificada
214	16	ejemplos bien definidos y palpables
215	16	si y si hay más ejemplos mejor
216	16	porque fue buena la aplicación pero me gustaría más ejemplos
217	16	porque funciono de acuerdo a lo previsto en clase y se implemento extras
218	16	si y más porque se mejoro la aplicación anterior
219	16	porque se aplico el concepto y funciono a la perfección
220	16	porque se vio en la realidad el concepto pero quizá un ejemplo más no estaría mal
221	16	porque se vio la aplicación ejecutándose más quisiera ver más ejemplos
222	16	porque el método funciono bien para la ejecución del sistema
223	15	Al parecer algunas válvulas de las mesa 7 están conectadas al revés a como se indica en su esquema
223	16	Se comprendieron los conceptos de memorias neumáticas
224	16	Se comprendió el método en cascada
225	16	Porque aprendimos la operación y programación de funciones aritméticas en un PLC
225	18	Sin queja alguna.
226	16	Porque aprendimos a construir circuitos neumáticos a partir de un diagrama neumático
226	18	Sin ninguna queja, el material se encuentra en excelentes condiciones.
227	16	Aprendimos a trabajar con cilindros neumáticos de doble efecto
228	16	Porque aprendimos a utilizar un temporizador neumático
228	18	Excelente condición del material
229	16	Se aprendió a enlazar los movimientos de dos o más cilindros neumáticos
229	18	Sin ningún comentario por el momento
230	16	Se aprendió a utilizar e implementar circuitos neumáticos cuando la secuencia de trabajo de los actuadores tiene uno o más estados repetidos
230	18	Ninguna queja o comentario
231	16	Porque se aprendió a trabajar con el método de cascada
231	18	Todo en perfectas condiciones
232	16	Al terminar de ver la teoría pasamos a hacer el debido ejercicio y al"alambrar" se obtuvo el funcionamiento que se esperaba
232	18	Muy buena práctica
233	7	Inclusive siempre estuvo al pendiente dando vueltas para ver si se entendió a la parte del monitoreo
233	16	La práctica fue dinámica y su realización fue entendible y rápida
234	16	Al usar el contador tanto ascendente como descendente venía consigo haber aprendido a utilizar lo contadores que solo son o ascendentes o descendentes  
237	6	Los ejercicios previos se hicieron paso a paso hasta llegar a la parte de la práctica
237	9	tres válvulas 5/2 de la mesa 7, tenían su configuración al revés lo que hizo que nos atrasamos gran cantidad de tiempo
237	15	Las Válvulas biestables estaban con sus conexiones al revés impidiendo terminar rápido la práctica, por otro lado se tuvo que concluir en la mesa 4
237	16	Si, a pesar del contratiempo, nuestra metodología y nuestra simulación utilizando el método de cascada fue la correcta y pudimos hacer nuestro video mostrando el funcionamiento esperado
239	5	Inclusive fue muy buena la explicación del uso de las válvulas 5/2 como 3/2 al igual que como normalmente cerradas o abiertas
239	16	inclusive el tema del método paso a paso también quedó muy bien entendido, cómo se hacen los grupo y que señal hace la transición de un grupo a otro
240	16	Porque se entendió la operación y aplicación de algunas funciones aritméticas para realizar operaciones básicas para el conteo de piezas.
241	16	El objetivo era ver físicamente el movimiento secuencia de un pistón respecto al del otro, se pudo apreciar de buena forma y por lo mismo digo que se cumplió
242	16	Porque aprendí a conectar el equipo neumático, así como a controlar un cilindro de simple efecto y comprendí el funcionamiento de las válvulas 3/2
245	16	Porque entendí el funcionamiento de las válvulas 5/2, aprendí a conectar tanto los cilindros de doble efecto y las válvulas 5/2 y las diferencias entre las válvulas monoestables y las biestables 
247	16	Porque se entendió el funcionamiento y aplicación de los temporizadores neumáticos tanto positivos como negativos 
248	16	Porque se pudo implementar una válvula 5/2 como memoria neumática para trabajar con estados repetidos intermedios.
249	16	Porque se logramos implementar un ciclo de trabajo con más de un cilindro, accionando un cilindro con la señal del otro, es decir, accionandolos mediante eventos 
250	16	Porque se logró conectar el sistema neumático para representar una llenadora de cajas, mediante el método de cascada.
382	16	Sirvió para entender el uso de compuertas AND en el circuito neumático.
253	16	Porque se aprendieron a utilizar las dos funciones basicas del micro uno
254	16	Porque se logró identificar el funcionamiento de los cilindros de simple efecto
255	16	Porque se pudo utilizar un cilindro de doble,  identificando sus diferencias con los de simple efecto
264	15	Una válvula en mal estado
266	16	Porque aprendí a usar válvulas 5/2 y 3/2 para controlar un cilindro de doble efecto
267	16	Se logró tener un funcionamiento correcto según lo visto en clase
268	16	El resultado obtenido correspondió a la programacion vista en clase
269	16	El resultado obtenido correspondió a la programacion vista en clase
270	16	El resultado obtenido correspondió a la programacion vista en clase
271	16	El resultado obtenido correspondió a la programacion vista en clase
272	16	El resultado obtenido correspondió a la simulacion vista en clase
273	16	El resultado obtenido correspondió a la simulacion vista en clase
274	16	El resultado obtenido correspondió a la simulacion vista en clase
275	16	El resultado obtenido correspondió a la simulacion vista en clase
276	16	El resultado obtenido correspondió a la simulacion vista en clase
277	16	El resultado obtenido correspondió a la simulacion vista en clase
278	18	Felicidades por usar recursos didácticos como los pistones y válvulas que se pegan al pizarron
279	18	Buena explicación de los timers y su analogía con los del PLC micro 1
280	18	Me hubiera gustado corroborar con el simulador esta práctica, ya que aveces es dificil seguir el paso de aire a través de las válvulas.
736	16	Se implementaron correctamente los registros de corrimiento.
281	15	Un tapón de las válvulas 5/2 tenía fuga. No hubo mayor problema.
281	16	Fue muy interesante aprender a usar una válvula como elemento de memoria, en este caso una 5/2 como 3/2 de memoria.
282	9	Las mangueras azules, aveces no sellan bien en las válvulas 3/2, o los finales de carrera.
288	9	Al principio no estaba dando la toma de aire 
283	8	Al principio las mesas eran insuficientes
288	15	la toma de aire  no estaba suminisdtrando
288	18	Muy buenas explicaciones del maestro
293	18	Muy buena explicación del maestro
306	16	Porque se pudo observar el funcionamiento del cilindro de doble efecto 
309	16	Porque mediante el diagrama de espacio - fase y el método paso a paso se pudieron usar válvulas de memoria para ejecutar una secuencia de movimientos con los cilindros 
310	8	había que poner los maletines en los bancos
329	16	Se pudo llevar acabo la practica
330	16	Se pudo reconocer el funcionamiento de una memoria 
331	16	Se entendió el funcionamiento del método cascada  
336	16	aprendi como se emplean las salidas enclavadas 
336	17	aprendi como usar el plc 
336	18	falta de mesas para los alumnos 
337	16	comprendi la funcionalidad de los contadores asi como sus usos 
337	18	se cumplieron satisfactoriamente los objetivos 
338	15	boton N/A  con falso contacto
338	16	aprendi la importancia de los registros de corrimiento asi como las banderas 
338	18	revisar brigada 5 
339	16	comprendi como se emplean los contadores 
340	16	aprendimos mas acerca de neumatica 
340	18	excelente estado del equipo neumatico
341	16	aprendimos como funciona el cilindro de doble efecto
342	16	comprendimos como usar los temporizadores asi como las  valvulas de  memorias 
343	16	aprendimos el funcionamiento de las valvulas de memoria  
344	16	en esta practica se utilizo el metodo de cascada que personalmente se me hizo mas facil que el otro 
352	18	me parecio que el funcionamiento y el profesor estuvieron bien
353	18	ninguno, creo que todo funciono adecuadamente
354	18	ninguno todo funciono correctamente
355	18	ninguno todo estuvo bien
356	18	me parecio buena idea el dejar ejercicios de tarea previos para practicar el concepto
357	18	ninguno, todo funciono correctamente y los ejercicios previos ayudaron 
358	18	todo bien, uno de los sensores de los pistones estaba mal colocado pero se soluciono al instante
361	16	Se implementó satisfactoriamente el uso de registros de corrimiento
364	16	Se logró desarrollar un programa funcional mediante el uso del simulador
364	18	Me hubiera gustado que pudiésemos utilizar físicamente los PLCíÂ´s Allen Bradley para la realización de esta práctica
365	16	Se logró aplicar el circuito neumático más sencillo del curso.
366	4	Una válvula de memoria no sostenía bien las mangueras, se zafaba.
366	9	Una válvula de memoria no sostenía bien las mangueras, se zafaba.
366	15	Una válvula de memoria no sostenía bien las mangueras, se zafaba. Y se nos proporciono otra con la que se pudo realizar la practica de forma adecuada.
368	16	Se conoció la aplicación de los temporizadores neumáticos, realizando la analogía con los existentes en los PLCíÂ´s
371	18	Gracias a esta práctica se conoció la manera de implementar el método de cascada, recurso que facilita en gran medida la elaboración de circuitos neumáticos
378	16	El objetivo era muy simple, por lo cual no presentó dificultades.
379	16	Se comprendió el funcionamiento de la válvula que mueven al pistón.
380	16	El temporizador es muy fácil de comprender su funcionamiento, y el conocer que funciona de manera logarítmica resultó muy útil.
381	16	Se logró completar la secuencia neumática esperada.
385	16	El empleo de logixpro es una forma dinámica de comprender mejor el funcionamiento del PLC.
384	16	Se introdujo a los PLC's de buena forma y se realizó todo lo que solicitó
387	16	Mediante el software Logix Pro se pudieron implementar funciones aritméticas
386	16	Se programó de buena forma los registros de corrimientos y se pudieron tener resultados satisfactorios.
385	18	Actualizar el software, para tener la versión más reciente.
388	16	Mediante la programación y la maqueta realizada se pudieron implementar temporizadores y observar su funcionamiento.
389	16	Se implementaron los contadores de buena forma. Se pudo comprobar su funcionamiento gracias a la maqueta realizada y el indicador en el programador
390	9	El compresor no estaba encendido a tiempo.
390	16	Se tuvieron resultados satisfactorios gracias a una buena implementación de los circuitos
393	16	Se llevó a la práctica lo visto en teoría y diseñado mediante el software Fluid Sim
394	16	El maletín de accesorios neumáticos fue indispensable para implementar los circuitos neumáticos diseñados en el software 
391	9	Se tienen algunas fugas con los tapones
391	15	fugas por el mal estado de algunos tapones
391	16	El circuito se implementó de buena manera
392	16	El temporizador funcionó de manera correcta.
402	16	El material y el equipo estaban en buenas condiciones
411	8	Los bancos son incómodos
412	4	Las computadoras están llenas de virus. No se pueden grabar archivos sin terminar con la memoria USB infectada
441	16	Ya se tenían conocimiento de los registros de corrimiento pero no en el micro, se aprendieron las sintaxis para poder utilizar el registro y también poder monitorear el funcionamiento, esto ultimo fue lo que ayudó más
444	16	se cumplió ya que conocieron las válvulas biestables, las cuales son usadas para los pistones de doble efecto, también se hizo uso de los finales de carrera que nos decía en qué posición se ecuentra el pistón
416	8	Los bancos son incómodos
418	8	Los bancos son incómodos
897	7	La disponibilidad del equipo de computo es muy poca, seria mejor un equipo por alumno
443	16	Fue la primera práctica que tuvo que ver con Neumática, si se cumplió el objetivo ya que se revisó el principio de funcionamiento de la neumática y de la válvula, mas específicamente la 5/2
445	15	Aire retenido en las conexiones.
445	16	Porque se implementó una conexión en cascada para visualizar el movimiento repetido del cilindro A al principio del ciclo y a la mitad del ciclo.
446	18	Como lo comentaba en papel, sería interesante tener mangueras distintivas para cada línea de presión que se forma, también pudiera ser tener identificadores para las válvulas AND y OR
447	16	Se realizó el movimiento de 3 pistones 
462	9	Fallan las instalaciones eléctricas
474	16	Pudimos ver como programar un contador en el PLC
462	8	Faltan sillas
463	9	Poco aislamiento al ruido
462	10	poco aislamiento de ruido
462	17	Poco espacio
464	8	Ya hay mas mesas
463	8	Faltan sillas
481	16	Se comprendió el uso de compuertas AND y OR para ciclos con movimiento repetido
463	17	Detalles de espacio
479	16	se movio una secuencia de pistones por e método de cascada
496	8	Hacen falta mesas
514	16	Se pudo observar el registro de corrimiento en el PLC, y logramos realizar la práctica de buena forma
494	8	Los asientos son muy incomodos
495	8	Las sillas son incomodas
506	16	se aprendió a ejecutar una secuencia neumática que incluía el movimiento repetido de un pistón
515	8	Todavía no teníamos las nuevas mesas, no teníamos espacio suficiente
516	16	Empezamos a ver lo básico en cuanto a neumática, y el piston de simple efecto es bueno para este propósito
518	16	Aprendimos los tipos de temporizadores neumáticos, además de ver cómo se realiza la conexión de los mismos.
519	15	Uno de nuestros pistones se quedó atorado en el final de carrera.
521	16	Aprendimos a utilizar el método de cascada para la solución de problemas neumáticos.
523	16	Se pudo llevar acabo la práctica gracias al uso de las compuertas neumáticas y en conjunto con el método de cascada, por lo tanto se aprendió a cómo atacar este tipo de ejercicios
525	4	Excepto por el temporizador con el que contamos en un inicio
525	15	El temporizador neumático no funcionaba, posteriormente se consiguió uno que sí
525	16	Se pudo observar que con la perilla con la que cuenta el temporizador, podemos retrasar un poco más el regreso del pistón y si se desea un tiempo específico se puede discretizar
526	16	Se aprendió a vincular las funciones con el software Logics pro
527	18	se debe disponer de mas valvulas tanto and como or
536	16	por que se obtuvo lo esperado
539	16	por que se obtuvo lo esperado
535	8	los bancos son muy incomodos
535	16	por que se obtuvo lo esperado
542	16	por que se obtuvo lo esperado
537	16	por que se obtuvo lo esperado
538	16	por que se obtuvo lo esperado
540	16	por que se obtuvo lo esperado
541	16	por que se obtuvo lo esperado
543	16	por que se obtuvo lo esperado
592	18	El kit del maletín está en muy buenas condiciones.
561	15	una válvula no funciono 
594	5	No logre entender cómo identificar las terminales del temporizador.
600	15	el sensor no detectaba bien la presencia del pistón. Se encontraba flojo y entre el alumno y el maestro se tuvo que reemplazar dicho sensor
602	16	A pesar de que el método empleado fue improvisado se cumplió con la secuencia solicitada.
604	16	 Porque pudimos comprobar como funciona un autoenclavamiento
615	16	incluimos temporizadores en el programa y todo funcionó correctamente
616	16	pudimos ver como se ingresa un contador en el diagrama y en el programa
617	16	Aprendimos que hace un registro de corrimiento
618	16	Empleamos funciones aritméticas para realizar ciertas acciones en el programa
619	16	Programamos el plc para accionar un cilindro
621	16	comprobamos lo visto teóricamente
622	16	implemementamos un temporizador neumático
623	16	se realizó una secuencia neumática funcionando correctamente
624	16	analizamos el uso de memorias neumáticas
625	16	Coprobamos el funcionamiento del método cascada\\n
626	16	pudimos revisar y comporobar un arreglo neumático
639	16	Porque aprendimos a accionar el cilindro de simple efecto
639	18	Ninguno (a)
640	16	Considero que saber accionar cilindros doble efecto es muy útil para una rutina mas compleja
640	18	Ninguno (a)
641	16	Porque al implementar temporizadores al circuito podremos realizar tareas mas sofisticadas
641	18	Ninguno (a)
642	16	Pues con una secuencia neumática podemos hacer por ejemplo cascadas en un proceso tal
642	18	Ninguno (a)
643	16	Las memorias son indispensables en la automatización, sirven para facilitar el desarrollo de rutinas complejas
643	18	Ninguno (a)
644	16	Aveces hay rutinas que con el método de cascada sale rapidísimo, es de gran utilidad este método
644	18	Ninguno (a)
645	16	Me permite resolver situaciones de automatizado mas fácil, así como aumentar su complejidad
645	18	Ninguno (a)
718	16	Se logró aplicar el método de cascada para la obtención del circuito neumático.
731	16	El circuito neumático funcionó correctamente y el software FluidSim también.
732	16	Se pudieron hacer las conexiones correctamente
732	17	Lo único es que se presentan algunas fugas en los tapones.
733	16	Por medio del PLC y la maqueta de estacionamiento se verificó el funcionamiento de las salidas autoenclavadas
734	16	Los temporizadores funcionaron correctamente y se implementaron en la maqueta de pluma de estacionamiento
735	16	Los contadores del PLC funcionaron correctamente. 
737	16	El Software LogixPro funcionó correctamente para la implementación de las funciones aritméticas
738	16	El equipo neumático funcionó correctamente.
739	16	Los pistones y conexión funcionaron correctamente. Corroboramos el funcionamiento del circuito en el software prácticamente.
740	16	Los temporizadores neumáticos funcionaron correctamente. Se verificaron los diferentes tiempos.
741	16	Se implementó una secuencia neumática de forma satisfactoria. 
743	16	El método se verifica mediante la implementación del circuito.
744	16	Las compuertas OR y AND funcionaron correctamente para poder implementar correctamente el circuito
746	16	Se observó el procedimiento para resolver casos  con movimiento repetido satisfactoriamente
747	16	Se observó físicamente y en simulación el funcionamiento correcto del movimiento repetido
753	16	Porque se aprendió a ejecutar una secuencia neumática que incluía el movimiento repetido de al menos un cilindro
753	18	Al momento de tener problemas con la práctica, el profesor atendió nuestras dudas y problemas de la mejor manera.
754	15	mala conexión al armar la practica 
756	16	Se logró realzar el ciclo propuesto en clase.
757	16	Porque se entendió lo visto en clase y se llevo a la practica satisfactoriamente.
763	16	Aprendí a combinar la neumática  con el plc, es decir comprendi la electroneumática
764	16	se logró controlar por medio de la electroneumática una válvula biestable
765	18	Muy buen manejo de las etiquetas de conexión del equipo
767	16	Porque se logró accionar un cilindro al pulsar un botón utilizando electroválvulas monoestables.
768	16	Porque se logró realizar la secuencia A B A-B- utilizando electroválvulas monoestables y biestables.
771	16	Se comprendió el funcionamiento de la electroválvula monoestable
772	16	Se comprendió el funcionamiento de la electroválvula biestable
777	16	si porque se hizo el primer acercamiento a Electroneumática y porque se pudo hacer a través de una forma fácil el uso del PLC para manipular a los pistones
788	16	Se pudo realizar la práctica
782	16	Logramos ver el funcionamiento de las válvulas biestables aplicadas en la electroneumática.
779	16	Porque se llevo a la practica todo lo visto en clase.
790	18	Se cumplió de manera adecuada el objetivo.
799	16	Porque aprendimos a trabajar con el equipo electroneumatico. 
799	18	El equipo se encuentra en buenas condiciones. 
800	16	Porque aprendimos a utilizar los sensores finales de carrera para circuitos electroneumaticos
800	18	Sin quejas. 
803	16	logramos la secuencia deseada
804	16	se logro la secuencia deseada
809	16	Se entendió como se activa y desactiva la válvula monoestable en el plc
810	16	La válvula biestable es más fácil de usar ya que son dos estados diferentes en diferentes renglones
815	16	se aplico lo conocimientos previamente adquiridos del curso
817	16	Se comprendió el funcionamiento del ciclo neumático completo
820	16	Se lograron conjuntar los conocimientos de PLCÂ´s y neumática para accionar la válvula y controlar el pistón.
826	16	Se pudo hacer mover una valvula con el plc
827	16	Se pudo mover un pisto con las electrovavula biestables
829	16	porque aprendimos a conjuntar el plc y el sistema neumático
830	16	aprendimos a usar otro tipo de válvulas para empalmarlo con el plc y la neumática
831	16	porque nos permitió ver todo lo ya aprendido en un sistema más complejo y completo
832	2	porque a veces no alcanzaban los equipos para hacer nuestras practicas o exámenes individuales
833	16	Porque se logró implementar toda la programación básica de PLC's (incluyendo temporizador, contador, registros) para realizar la configuración deseada en los movimientos de los cilindros de doble efecto.
835	16	Por que se logró desarrollar un sistema electroneumático completo, agrando diversas funciones del PLC
841	16	Por que se aplicaron todos los conocimientos adquiridos durante el curso 
842	14	Excelente laboratorio, disponibilidad del equipo, buen funcionamiento y buenas condiciones del material. 
846	5	Algunos componentes están muy desgastados, por lo que a veces resultaba difícil conectarlos y desconectarlos
853	18	Buena práctica, sin duda se aplicó todo lo visto en el curso
854	14	Excelente laboratorio, sin duda uno de los mejores que he tomado.
858	16	se dieron los conceptos necesarios
857	5	Todo esta casi perfecto, excepto por la mesa 8 que tuvo a lo largo del semestre complicaciones como la baja presión o las conexiones de lo finales de carrera un poco gastadas
857	14	Hubo equipos en cada mesa que nunca se ocuparon, me hubiese gustado haberlos utilizado o haber tenido conocimiento de cuál era su funcionamiento y cómo se ocupaban. 
858	17	huno el material adecuado
859	5	un poco deteriorado 
865	6	no hay suficientes computadoras para los equipos de las mesas por lo tanto no todos podemos usar el software
865	7	hay computadoras que no permiten su uso 
865	8	Un poco complicado encontrar el manual
865	9	los bancos son muy incómodos y a algunos les faltan las gomas asi que se balancean, pero si hay suficientes
865	11	se puede trabajar bien pero sería bueno que hubiera ventanas mas grandes
865	14	Sería muy bueno que sí se sigue con las encuestas en linea, implementen el acceso a internet en las computadoras del laboratorio para tener la posibilidad de contestarlas al terminar las prácticas
866	18	Hacer los cables de los programadores mas largos pues con el tiempo de estar agachado se hace incomodo trabajar 
867	14	alargar cables de programadores, dar pinzas para sacar bananas y los tapones de las valvulas deben ser mas largos
868	15	El PLC no estaba respondiendo de manera adecuada, sin embargo era debido a que sus terminales no estaban haciendo un buen contacto, situación que pudo arreglarse fácilmente.
869	14	Estoy bastante satisfecho con las instalaciones y equipo del laboratorio, que permitieron desarrollar adecuadamente todas las actividades durante el semestre.
898	17	Alguien se llevó el puente de bananas de las válvulas electroneumáticas
904	16	Porque con los conocimientos adquiridos en el curso se logró el control de un ciclo  trabajo
906	14	Consideró que el laboratorio ha mejorado bastante a comparación de como estaba anteriormente, asimismo me gusto mucho que s tuviese tantos equipos industriales, algo que nos permite darnos una idea de la industria
907	16	En esta practica se aplicó todo lo aprendido en el semestre y fue muy visual
907	18	Todo perfecto, talvez el laboratario debería proporcionar más cables para dichas practicas de electroneumatica
908	1	Se tenia el equipo, pero el laboratorio podría proporcionar los cables banana-banana
908	9	Se mejoró todo esto a lo largo del curso, muy bien :)
908	14	Todo muy bien, el laboratorio cumplió mis expectativas y considero que aprendí bastante con el dr octavio 
913	16	Las electro válvula funcionó correctamente
914	16	El circuito funcionó de acuerdo a lo visto en clase
915	16	Funcionó bien y se comprendió la forma de resetearla de ser necesario.
916	16	La implementación del plc simplificó mucho el cableado en las mesas
917	16	El circuito funcionó de acuerdo a lo visto en clase.
918	16	El circuito funcionó de acuerdo a lo visto en clase.
919	6	Las versiones de los programas están desactualizadas.
935	16	Funcionó correctamente la secuencia neumática
936	16	Funcionó correctamente y aprendimos a hacer el programa en escalera adecuado
937	16	Todo funcionó correctamente
938	14	Deberían comprar muchos cables banana-banana para prestárselos a los alumnos, ya que después de ésta materia uno se queda con muchísimos cables que jamás volverá a usar, por lo que es un gasto completamente innecesario.
939	16	se cumplio la secuencia deseada
945	16	Se lograron cumplir los objetivos
966	14	Este curso superó las expectativas que tenía del mismo.
967	16	La conjunción del PLC con los circuitos neumáticos fue satisfactoria.
968	16	La conjunción del PLC con los circuitos neumáticos fue satisfactoria.
969	16	La conjunción del PLC con los circuitos neumáticos fue satisfactoria.
973	5	Explicar un poco más la realización de los diagramas de escalera
994	14	A veces la válvula de mantenimiento tenía agua y eso hacia fallar los pistones \\n
994	5	Válvula de mantenimiento con agua \\n
988	9	Faltan bancos
1005	16	Se comprendió el funcionamiento y forma de utilización de la válvula monoestable.
1036	9	las sillas son muy incomodas 
1012	14	Sin duda un excelente curso, se cumplió con todas las expectativas.
1011	16	Se comprendieron los beneficios que se pueden obtener al implementar la neumática y electrónica en un sistema.
1037	16	Todo funcionó como en la propuesta
1037	18	Hasta ahora todo bien
1038	16	Probamos la teoría que proporcionó el profesor.
1038	18	Todo fue muy rápido y en condiciones óptimas.
1040	14	Fue una excelente mejora el haber expandido el laboratorio, se tiene mayor libertad y comodidad para realizar las prácticas y/o proyectos. 
1041	16	Utilizamos nuestros conocismientos sobre las autoenclavadas
1042	8	Hace falta una superficie para colocar los circuitos y no tengamos que estarlo sosteniendo
1042	16	Pudimos comprobar el concepto de salidas autoenclavadas y de igual manera gracias a la práctica se entendió mejor la manera en como opera este principio y nos quitó de dudas sobre como programar de manera escalera
1042	18	Todo funcionó de manera adecuada.
1047	8	Falta una base para colocar el circuito y no tengamos que tenerlo en la mano
1046	16	comprendimos el uso basico del plc
1043	16	Por que pudimos programar el PLC adecuadamente y obtener las salidas deseadas para el funcionamiento del circuito
1047	16	Porque se realizó de manera correcta la programación y se pudo comprobar mediante el circuito
1048	16	Utilizamos nuestros conocimientos sobre los temporizadores
1049	16	Lo he entendido a la perfección
1049	18	Ejemplos ya programados o de la programación del PLC frente a los alumnos hubieran acelerado todo, pero fue excelente
1050	16	logramos realizar bastante rápido y sin fallas la práctica
1050	18	muy buena esta practica
1051	18	Como comentario quisiera decir que si hubiera más espacio entre los equipos sería mejor, ya que estamos muy apretados, con un pequeño espacio para alambrar y ni siquiera un respaldo para poner artefactos importantes como la fuente de poder.
1052	16	Ya que pudimos ver la aplicación de los diagramas de escalera en un dispositivo como el PLC, el cual es muy usado en la industría
1055	16	si por que al final de conectar el equipo se logro observar lo que se nos pido
1056	16	si se cumplio el objetivo de como funciona el timer para poder regresar el pisto en un determiando tiempo
1059	16	Se aprendio de manera básica lo que es un autoenclave
1059	18	El equipo de laboratorio no presento ningún problema para trabajar
1060	16	El concepto de temporizador se comprobó y se aplico  
1061	16	porque de acuerdo al objetivo planteado se logro realizar la practica satisfactoriamente y hubo aprendizaje gracias a los conocimientos del profesor
1062	16	Se ejemplificó el concepto de salidas autoenclavadas con un problema de aplicación; siendo esta una herramienta meramente de programación además de poder emplear una salida como elemento de control. 
1067	16	porque la realización de la práctica fue concisa y muy clara
1069	7	la asistencia del profesor fue muy satisfactoria para la realización de la práctica
1069	8	las sillas del laboratorio son demasiado incomodas para una clase de 3 horas
1069	9	en nuestro banco de pruebas existe una conexión a banana [salida del PLC me parece el 204] que se encontraba muy suelto 
1069	16	se entendieron completamente los temas de la práctica
1070	7	el profesor aclaró las dudas que se presentaron en la práctica
1070	16	el uso y aplicación de los temporizadores se entendió completamente con ayuda de la práctica
1071	7	el profesor nos explicó de buena forma el uso de los contadores, pero existieron dudas aún cuando la práctica se cumplió correctamente
1071	16	el objetivo de la práctica se cumplió, se realizo la práctica en tiempo y forma, pero quedaron dudas que se generaron al resolver la práctica
1071	18	me gustaría tener otra practica que ayudará a complementar esta, yo tuve dudas en la parte de funciones, realmente hicimos la práctica sólo con contadores [cont 45], pero creemos que se puede complementar con fucniones.
1072	16	aplicamos el uso de temporizadores
1079	16	Si, porque aprendimos como programar y usar salidas auto enclavadas dentro de la lógica del PLC.
1078	5	Las prácticas son interesantes ya que una vez que tenemos la explicación, entramos a la práctica y así quedan mas claros los conceptos.
1077	9	En las mesas los contactos que se encuentran ahí no funcionan.
1080	8	Los contactos que se encuentran en las mesas no funcionan, bueno la que se encuentra atrás de la brigada 5.
1081	16	Si, porque aprendimos a hacer uso de los temporizadores dentro de la programación del PLC, así como ver el avance del tiempo en el display del mismo para verificar su correcto funcionamiento.
1082	16	Si, porque aprendimos a hacer uso de los contadores dentro de la programación del PLC, así como a observar su correcto funcionamiento a través del display.
1082	17	El cable de la display al PLC se encontraba flojo, por lo que varias veces se reiniciaba, también el botón enclavado de paro no servía del todo bien, se desenclavaba solo. Esto fue reportado al profesor.
1084	16	Apliqué mis conocimientos sobre los contadores
1085	16	Porque pude programar los contadores de los PLC y ver su funcionamiento
1195	16	Logramos ocupar los corrimientos sin contratiempos 
1196	16	se verificó con el plc la función de corriemiento con leds
1088	16	Se observo la aplicación de los temporizadores y funcionamiento.
1087	16	Pusimos en practica la teoría y comprobamos que lo que programamos era correcto
1089	16	S pudo observar una aplicación en la industria de los contadores, asi como su funcionamiento.
1098	16	Tolo lo que pedia que reralizaramos, se realizó correctamente y sin imprevistos.
1098	18	Debería de haber un poco más de equipo, ya que somos 3 personas utilizando el material. 
1099	16	Logramos realizar con éxito la practica de contadores  sin ningúna falla. 
1100	16	No hubo problemas al realizar la práctica, se lograron todos los resultados esperados. 
1101	16	El circuito realizado funcionó correctamente
1102	16	Se apreció el uso y funcionamiento de contadores dentro de un sistema con más características.
1103	8	Creo que una pequeña base para colocar el PLC seria muy útil
1103	16	Pudimos ocupar los temporizadores sin problema
1104	18	De igual manera que la práctica anterior considero que sería adecuado contar con una base extra para colocar el PLC
1104	16	Pudimos observar el funcionamiento de los distintos contadores del PLC
1105	8	no se cuenta con superficie para colocar el circuito que se conecta al plc
1106	16	El equipo funcionó adecuadamente y sin contratiempos
1107	16	El equipo funcionó adecuadamente
1108	16	se comprendio correctamente el concepto
1113	16	Porque pudimos ver el funcionamiento de los contadores del PLC y pudimos aplicarlos.
1114	16	Porque pude entender el concepto de salidas autoenclavadas y por lo tanto lo pude utilizar en la práctica
1115	16	Porque entedimos como es que funcionan los temporizadores del PLC y pudimos aplicar el concepto en la práctica
1116	16	he comprendido a la perfección la aplicación
1116	17	Es muy agradable el profesor
1116	18	Dentro de ésta encuesta, sección D pregunta A), es PCL o PLC?
1122	16	Se comprendieron los principios básicos del uso del PLC
1122	18	Sería bueno que cambiaran los asientos del salón, los bancos son un poco incómodos.
1123	16	Se hizo buen uso de los timbres
1129	16	Aprendimos de forma satisfactoria el uso de las salidas autoenclavadas además de aplicar los conocimientos básicos de la implementación del código escalera 
1130	16	Se aprendió satisfactoriamente a programar y monitorear un timer, de tal forma que lo seguiremos aplicando en futuras prácticas para verificar el debido funcionamiento de nuestro programa. 
1132	16	Porque la práctica pudo realizarse correctamente.
1133	16	Porque la práctica se realizó correctamente.
1134	16	Porque los resultados de la práctica fueron correctos.
1135	16	Pudieron realizarse exitosamente todas las actividades solicitadas.
1136	16	Pudieron realizarse exitosamente todas las actividades solicitadas.
1137	16	Pudieron realizarse exitosamente todas las actividades solicitadas.
1140	4	Hubo un detalle en un botón enclavado, se solucionó de manera inmediata.
1141	16	Se logró observar el buen funcionamiento de un contador
1142	16	Logramos identificar el funcionamiento de diversos timers
1143	16	Logramos programar correctamente el PLC para el funcionamiento de una salida autoenclavada
1144	16	Aplicamos nuestros conocimientos sobre registros de corrimiento
1146	16	Se entendió el concepto del empleo de los registros de corrimiento para aplicaciones reales de automatización.
1147	16	Porque pudimos entender el funcionamiento del registro de corrimiento en el PLC y aplicar lo visto en clase en la práctica.
1152	16	Se observó que una salida se puede mantener encendida accionando una sola vez su botón pulsador de encendido
1153	16	Se aprendió a manejar y monitorear los timers, teniendo conocimiento de su estado actual en todo momento
1154	4	Tuvimos falla en un botón enclavado. Un falso contacto.
1154	16	Comprendimos el uso de los contadores, su monitoreo y una aplicación sencilla. Siendo así, que se aprendieron las bases fundamentales para combinarlo con otro tipo de funciones y aplicaciones. 
1162	16	El laboratorio cuenta con el equipo adecuado para la realización de la misma.
1163	16	El equipo del laboratorio funcionó correctamente.
1164	16	Se comprendió el funcionamiento y la utilidad de los registros de corrimiento del plc, aplicando dicho conocimiento al resolver un problema práctico.
1165	18	La práctica se realizó de manera correcta, el material no tuvo ninguna falla.
1169	16	Logramos aplicar los conceptos de contadores fisicamente
1167	18	El material proporcionado fue el adecuado y se realizó de manera correcta.
1168	18	La práctica se desarrolló de manera correcta y el material fue el adecuado.
1166	18	La segunda práctica se realizó correctamente y el equipo fue el adecuado.
1170	16	Aprendimos a manejar los registros de forma directa con el PLC
1171	16	Aprendimos como configurar y utilizar los botones de enclavamiento
1172	16	Pudimos observar como operan los temporizadores del PLC y programarlos
1175	16	Se obtuvieron todos los resultados esperados de la misma sin que hubiese fallas por hardware 
1178	16	Comprobamos el uso de temporalizadores de forma exitosa
1186	16	Pudo llevarse a cabo de forma exitosa la actividad solicitada
1188	16	Por que se pudo programar el contador de manera exitosa, y ver si funcionamiento
1189	16	Se pudo observar como es que se comporta el corrimiento y se programa en el PLC
1190	16	se lograron hacer salidas autoenclavadas
1191	16	hicimos uso de los contadores con los que cunenta el plc
1192	16	hicimos uso de los corrimientos del plc
1193	16	la practica fue terminada en tiempo y forma
1193	17	excelente, con buena atención del profesor
1247	5	Me hubiera gustado ver mÃ¡s ejemplos
1248	7	Me parece que falta atencion por parte del profesor
1249	16	Se aprendiÃ³ a utilizar los registros de corrimiento. Al menos en mi opiniÃ³n personal, fue el primer ejemplo tangible con registros de corrimiento, quedando claro tanto su funcionamiento como sus posibles usos en industria o academia.
1250	16	es muy facil ver las salidas activas en el micro 1
1251	16	los comandos vistos en clase fueron utiles
1252	16	el comando MON es muy util
1255	15	las conexiones del PLC 
383	16	Es un método muy útil por su sencillez de uso, pero en algunas situaciones puede llevar a errores, por activaciones finales de carrera fuera su tiempo. Aunque percatarse de ello fue de ayuda, para comprender mejor el funcionamiento del método.
548	16	Se pudo aplicar un ciclo de movimiento repetido de un circuito neumático. 
558	16	Porque se comprendió el funcionamiento de las válvulas de memoria, utilizándolas para resolver secuencias neumáticas y distinguir el movimiento repetitivo de un cilindro 
778	16	Después de haber visto Válvula monoestable se hizo ahora el ejercicio combinando los dos tipos y se pudo visualizar el difente funcionamiento de ambas, y eso a través del tipo de entradas para cada pistón 
805	16	Porque se aprendió a controlar una válvula monoestable, así como realizar conexiones eléctricas y neumáticas para poder controlar pistones neumáticos mediante PLC 
806	16	Porque aprendimos a utilizar una válvula biestable y con ayuda de los sensores de final de carrera logramos generar una secuencia con los cilindros.
856	16	porque fue el conjunto de muchos temas vistos en el semestre, planteamiento del problema y de las ecuaciones de movimiento de los pistones, diagrama de escalera, código del PLC, y conexiones neumáticas
983	5	Hacer ejercicios del método de cascada antes de realizar la práctica
60	18	Me agradó la práctica, no es tan trivial como las anteriores.
61	16	Porque se aprendió a utilizar los contadores, en un ejemplo práctico.
62	16	Se aprendió a utilizar el corrimiento y la importancia de éste en zonas con poco espacio. 
82	8	El espacio que se tiene para tomar la clase, en cuanto a mesas, es muy reducido
107	18	Quiero felicitarles a los encargados del laboratorio de PLC's por su apoyo en brindarnos mobiliario nuevo y los anaqueles para las mochilas. Nos serán de gran utilidad y nos brindaran comodidad para tomar clases.
195	16	Se visualizo bien el funcionamiento del pistón
251	16	Porque se comprendió el funcionamiento y sobre todo la aplicación de las válvulas de memoria y logramos utilizar una válvula 5/2 como memorias neumáticas, para distinguir estados repetidos.
252	16	Porque se entendió y aplico el método de cascada en una secuencia neumática, utilizando válvulas 5/2 para la generación de las líneas neumáticas 
282	18	Yo recomendaría que deberían hacerse a lo sumo 2 prácticas por semana. En especial esta de método de cascada que es algo compleja. Hacer más es algo pesado pero se entiende, ya que el temario es muy amplio. 
986	15	Conectar mal la fuente, se quemo el fusible
988	8	No se nos indicó que había un manual de prácticas
1010	16	De igual forma que la válvula monoestable, la comprensión e implementación de la válvula biestable fue la mejor. 
1043	8	Solo falto junto al equipo del PLC algun tipo de mesa o repisa, casi a la altura de el PLC para poder apoyar la protoboard y demas equipo que utilizamos
1076	16	Si, pues se aplicó el uso de los temporizadores en un problema de aplicación, además se entendió las características de la temporización positiva y negativa así como ejemplos en los cuales se usarían.
1197	16	Sí ya que realizamos los ejercicios propuestos de manera exitosa y aprendimos los temas.
1198	16	Por que realizamos los ejercicios propuestos de manera exitosa y se aprendieron los temas.
1197	8	Hay un par de sillas que son muy altas y al estar casi a la altura de la mesa es dificil escribir
1199	16	Por que realizamos los ejercicios propuestos de manera exitosa y se aprendieron los temas.
1200	16	Por que realizamos los ejercicios propuestos de manera exitosa y se aprendieron los temas.
1202	16	Se pudo comprender la utilidad de los corrimientos
1205	16	Se logró hacer que un motor funcionara al utilizar una salida autoenclavada
1206	16	Se lograron los objetivos de la práctica ya que logramos obtener una teporización para una aplicación industrial con el plc.
1213	16	Utilizamos registros de corrimiento para desplegar un bit secuencialmente de izquierda a derecha y de regreso de manera cíclica.
1212	16	Aprendimos a utilizar los contadores del Micro1 e implementamos la simulación de una puerta automática que solamente dejaba acceder a 5 personas, admitiendo nuevos ingresos únicamente el numero de personas que desalojaban.
1211	16	Utilizamos temporizadores para simular el funcionamiento de un semáforo estableciendo un tiempo determinado de encendido para cada salida (LEDs rojo, amarillo y verde).
1214	16	ya que se logro realizar la práctica satisfactoriamente y se comprendió ésta misma
1215	16	se cumplió el objetivo ya que la práctica fomento al aprendizaje del tema
1220	16	Porque pudimos observar el funcionamiento del registro de corrimiento y manipularlo para observar como se comporta
1221	18	Un poco mas de espacio para la mesa 4 ya que siento que esta amontonada con la mesa 3
1224	15	Error en un sensor pero el profesor lo arreglo y nos explico la falla 
1224	18	Gracias al profesor que nos ayudo a arreglar un sensor pudimos realizar la practica
1225	16	Con la teoría dada sobre registros de corrimiento, se logró programar en el PLC un secuenciador binario (ciclo de ida y regreso), observando el resultado mediante las saliadas con las que cuenta el PLC del laboratorio.
1233	8	Los bancos del laboratorio no son cómodos.
1234	8	Los bancos son incómodos para dos horas de clase.
1235	8	Los bancos no son cómodos.
1236	16	Porque se realizó correctamente y el equipo funcionó de forma adecuada.
1086	16	Se entendió que el contador sirve para llevar la cuenta de las veces que sucede un evento además se implementó el uso de contadores en un ejemplo de aplicación para una linea de empaquetado por cantidad de producto.
1210	16	Logramos simular un programa de concursos en el cual se autoenclavaba el botón del participante que lo presionara primero, inhabilitando los demás hasta oprimir el botón de reset.
1103	18	Creo que un pequeño soporte extra para el PLC sería muy útil ya que en esta práctica era necesario apreciar claramente las entradas y salidas, y era complicado cargar el plc además de los circuitos
1257	14	Muy bien prueba evaluacion de servico
1259	2	huhu huhu hu huhu
1259	15	hu hu hu hu 
1259	18	hu hu hu hu
1261	18	el cafÃ© me desperto
\.


--
-- Data for Name: encuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY encuestas (idencuesta, npregunta, opcion) FROM stdin;
1	1	10
1	2	10
1	3	10
1	4	10
1	5	10
1	6	10
1	7	10
1	8	8
1	9	10
1	10	10
1	11	0
1	12	0
1	13	0
1	14	0
1	16	0
1	17	10
2	1	10
2	2	10
2	3	10
2	4	10
2	5	10
2	6	10
2	7	10
2	8	8
2	9	10
2	10	10
2	11	0
2	12	0
2	13	0
2	14	0
2	16	0
2	17	10
3	1	10
3	2	10
3	3	10
3	4	10
3	5	10
3	6	10
3	7	10
3	8	8
3	9	10
3	10	10
3	11	0
3	12	0
3	13	0
3	14	0
3	16	0
3	17	10
4	1	10
4	2	10
4	3	10
4	4	10
4	5	10
4	6	10
4	7	10
4	8	10
4	9	10
4	10	10
4	11	0
4	12	0
4	13	0
4	14	0
4	16	0
4	17	10
5	1	10
5	2	10
5	3	10
5	4	10
5	5	10
5	6	10
5	7	10
5	8	10
5	9	10
5	10	10
5	11	0
5	12	0
5	13	0
5	14	0
5	16	0
5	17	10
6	1	10
6	2	10
6	3	10
6	4	10
6	5	10
6	6	10
6	7	10
6	8	10
6	9	10
6	10	10
6	11	0
6	12	0
6	13	0
6	14	0
6	16	0
6	17	10
7	1	10
7	2	10
7	3	10
7	4	10
7	5	10
7	6	10
7	7	10
7	8	10
7	9	10
7	10	10
7	11	0
7	12	0
7	13	0
7	14	0
7	16	0
7	17	10
8	1	10
8	2	10
8	3	10
8	4	10
8	5	10
8	6	10
8	7	10
8	8	10
8	9	10
8	10	10
8	11	0
8	12	0
8	13	0
8	14	0
8	16	0
8	17	10
9	1	10
9	2	10
9	3	10
9	4	10
9	5	10
9	6	10
9	7	10
9	8	10
9	9	10
9	10	10
9	11	0
9	12	0
9	13	0
9	14	0
9	16	0
9	17	10
10	1	10
10	2	10
10	3	10
10	4	10
10	5	10
10	6	10
10	7	10
10	8	10
10	9	10
10	10	10
10	11	0
10	12	0
10	13	0
10	14	0
10	16	0
10	17	10
11	1	10
11	2	10
11	3	10
11	4	10
11	5	10
11	6	10
11	7	10
11	8	10
11	9	10
11	10	10
11	11	0
11	12	0
11	13	0
11	14	0
11	16	0
11	17	10
12	1	10
12	2	10
12	3	10
12	4	10
12	5	10
12	6	10
12	7	10
12	8	10
12	9	10
12	10	10
12	11	0
12	12	0
12	13	0
12	14	0
12	16	0
12	17	10
13	1	10
13	2	10
13	3	10
13	4	10
13	5	10
13	6	10
13	7	10
13	8	10
13	9	10
13	10	10
13	11	0
13	12	0
13	13	0
13	14	0
13	16	0
13	17	10
14	1	10
14	2	10
14	3	10
14	4	10
14	5	10
14	6	10
14	7	10
14	8	10
14	9	10
14	10	10
14	11	0
14	12	0
14	13	0
14	14	0
14	16	0
14	17	10
15	1	10
15	2	10
15	3	10
15	4	10
15	5	10
15	6	10
15	7	10
15	8	10
15	9	10
15	10	10
15	11	0
15	12	0
15	13	0
15	14	0
15	16	0
15	17	10
16	1	10
16	2	10
16	3	10
16	4	10
16	5	10
16	6	10
16	7	10
16	8	10
16	9	10
16	10	10
16	11	0
16	12	0
16	13	0
16	14	0
16	16	0
16	17	10
17	1	10
17	2	10
17	3	10
17	4	10
17	5	10
17	6	10
17	7	10
17	8	10
17	9	10
17	10	10
17	11	0
17	12	0
17	13	0
17	14	0
17	16	0
17	17	10
18	1	10
18	2	10
18	3	10
18	4	10
18	5	10
18	6	10
18	7	10
18	8	10
18	9	10
18	10	10
18	11	0
18	12	0
18	13	0
18	14	0
18	16	0
18	17	10
19	1	10
19	2	10
19	3	10
19	4	10
19	5	10
19	6	10
19	7	10
19	8	10
19	9	10
19	10	10
19	11	0
19	12	0
19	13	0
19	14	0
19	16	0
19	17	10
20	1	10
20	2	10
20	3	10
20	4	10
20	5	10
20	6	10
20	7	10
20	8	10
20	9	10
20	10	10
20	11	0
20	12	0
20	13	0
20	14	0
20	16	0
20	17	10
21	1	10
21	2	10
21	3	10
21	4	10
21	5	8
21	6	10
21	7	10
21	8	10
21	9	10
21	10	10
21	11	0
21	12	0
21	13	0
21	14	0
21	16	0
21	17	10
22	1	10
22	2	10
22	3	10
22	4	10
22	5	10
22	6	10
22	7	10
22	8	10
22	9	10
22	10	10
22	11	0
22	12	0
22	13	0
22	14	0
22	16	0
22	17	10
23	1	10
23	2	10
23	3	10
23	4	10
23	5	10
23	6	10
23	7	10
23	8	10
23	9	10
23	10	10
23	11	0
23	12	0
23	13	0
23	14	0
23	16	0
23	17	10
24	1	10
24	2	10
24	3	10
24	4	10
24	5	10
24	6	10
24	7	10
24	8	8
24	9	10
24	10	10
24	11	0
24	12	0
24	13	0
24	14	0
24	16	0
24	17	10
25	1	10
25	2	10
25	3	10
25	4	10
25	5	10
25	6	10
25	7	10
25	8	10
25	9	10
25	10	10
25	11	0
25	12	0
25	13	0
25	14	0
25	16	0
25	17	10
26	1	10
26	2	10
26	3	10
26	4	10
26	5	10
26	6	10
26	7	10
26	8	10
26	9	10
26	10	10
26	11	0
26	12	0
26	13	0
26	14	0
26	16	0
26	17	10
27	1	10
27	2	10
27	3	10
27	4	10
27	5	10
27	6	10
27	7	10
27	8	10
27	9	10
27	10	10
27	11	0
27	12	0
27	13	0
27	14	0
27	16	0
27	17	10
28	1	10
28	2	10
28	3	10
28	4	10
28	5	10
28	6	10
28	7	10
28	8	10
28	9	10
28	10	10
28	11	0
28	12	0
28	13	0
28	14	0
28	16	0
28	17	10
29	1	10
29	2	10
29	3	10
29	4	10
29	5	10
29	6	10
29	7	10
29	8	10
29	9	10
29	10	10
29	11	0
29	12	0
29	13	0
29	14	0
29	16	0
29	17	10
30	1	10
30	2	10
30	3	10
30	4	10
30	5	10
30	6	10
30	7	10
30	8	10
30	9	10
30	10	10
30	11	0
30	12	0
30	13	0
30	14	0
30	16	0
30	17	10
31	1	10
31	2	10
31	3	10
31	4	10
31	5	10
31	6	10
31	7	10
31	8	10
31	9	10
31	10	10
31	11	0
31	12	0
31	13	0
31	14	0
31	16	0
31	17	10
32	1	10
32	2	10
32	3	10
32	4	10
32	5	10
32	6	10
32	7	10
32	8	10
32	9	10
32	10	10
32	11	0
32	12	0
32	13	0
32	14	0
32	16	0
32	17	10
33	1	10
33	2	10
33	3	10
33	4	10
33	5	10
33	6	10
33	7	10
33	8	10
33	9	10
33	10	10
33	11	0
33	12	0
33	13	0
33	14	0
33	16	0
33	17	10
34	1	10
34	2	10
34	3	10
34	4	10
34	5	10
34	6	10
34	7	10
34	8	10
34	9	10
34	10	10
34	11	0
34	12	0
34	13	0
34	14	0
34	16	0
34	17	10
35	1	10
35	2	10
35	3	10
35	4	10
35	5	10
35	6	10
35	7	10
35	8	10
35	9	10
35	10	10
35	11	0
35	12	0
35	13	0
35	14	0
35	16	0
35	17	10
36	1	10
36	2	10
36	3	10
36	4	10
36	5	10
36	6	10
36	7	10
36	8	10
36	9	10
36	10	10
36	11	0
36	12	0
36	13	0
36	14	0
36	16	0
36	17	10
37	1	10
37	2	10
37	3	10
37	4	10
37	5	10
37	6	10
37	7	10
37	8	10
37	9	10
37	10	10
37	11	0
37	12	0
37	13	0
37	14	0
37	16	0
37	17	10
38	1	10
38	2	10
38	3	10
38	4	10
38	5	10
38	6	10
38	7	10
38	8	10
38	9	10
38	10	10
38	11	0
38	12	0
38	13	0
38	14	0
38	16	0
38	17	10
39	1	10
39	2	10
39	3	10
39	4	10
39	5	10
39	6	10
39	7	10
39	8	10
39	9	10
39	10	10
39	11	0
39	12	0
39	13	0
39	14	0
39	16	0
39	17	10
40	1	10
40	2	10
40	3	10
40	4	10
40	5	10
40	6	10
40	7	10
40	8	10
40	9	10
40	10	10
40	11	0
40	12	0
40	13	0
40	14	0
40	16	0
40	17	10
41	1	10
41	2	10
41	3	10
41	4	10
41	5	10
41	6	10
41	7	10
41	8	10
41	9	10
41	10	10
41	11	0
41	12	0
41	13	0
41	14	0
41	16	0
41	17	10
42	1	10
42	2	10
42	3	10
42	4	10
42	5	10
42	6	10
42	7	10
42	8	10
42	9	10
42	10	10
42	11	0
42	12	0
42	13	0
42	14	0
42	16	0
42	17	10
43	1	10
43	2	10
43	3	10
43	4	10
43	5	10
43	6	10
43	7	10
43	8	10
43	9	10
43	10	10
43	11	0
43	12	0
43	13	0
43	14	0
43	16	0
43	17	10
44	1	10
44	2	10
44	3	10
44	4	10
44	5	10
44	6	10
44	7	10
44	8	10
44	9	10
44	10	10
44	11	0
44	12	0
44	13	0
44	14	0
44	16	0
44	17	10
45	1	10
45	2	10
45	3	10
45	4	10
45	5	10
45	6	10
45	7	10
45	8	10
45	9	10
45	10	10
45	11	0
45	12	0
45	13	0
45	14	0
45	16	0
45	17	10
46	1	10
46	2	10
46	3	10
46	4	10
46	5	10
46	6	10
46	7	10
46	8	8
46	9	10
46	10	10
46	11	0
46	12	0
46	13	0
46	14	0
46	16	0
46	17	10
47	1	10
47	2	10
47	3	10
47	4	10
47	5	10
47	6	10
47	7	10
47	8	10
47	9	10
47	10	10
47	11	0
47	12	0
47	13	0
47	14	0
47	16	0
47	17	10
48	1	10
48	2	10
48	3	10
48	4	10
48	5	10
48	6	10
48	7	10
48	8	10
48	9	10
48	10	10
48	11	0
48	12	0
48	13	0
48	14	0
48	16	0
48	17	10
49	1	10
49	2	10
49	3	10
49	4	10
49	5	10
49	6	10
49	7	10
49	8	10
49	9	10
49	10	10
49	11	0
49	12	0
49	13	0
49	14	0
49	16	0
49	17	10
50	1	10
50	2	10
50	3	10
50	4	10
50	5	10
50	6	10
50	7	10
50	8	10
50	9	10
50	10	10
50	11	0
50	12	0
50	13	0
50	14	0
50	16	0
50	17	10
51	1	10
51	2	10
51	3	10
51	4	10
51	5	10
51	6	10
51	7	10
51	8	10
51	9	10
51	10	10
51	11	0
51	12	0
51	13	0
51	14	0
51	16	0
51	17	10
52	1	10
52	2	10
52	3	10
52	4	10
52	5	10
52	6	10
52	7	10
52	8	10
52	9	10
52	10	10
52	11	0
52	12	0
52	13	0
52	14	0
52	16	0
52	17	10
53	1	10
53	2	10
53	3	10
53	4	10
53	5	10
53	6	10
53	7	10
53	8	10
53	9	10
53	10	10
53	11	0
53	12	0
53	13	0
53	14	0
53	16	0
53	17	10
54	1	10
54	2	10
54	3	10
54	4	10
54	5	10
54	6	10
54	7	10
54	8	10
54	9	10
54	10	10
54	11	0
54	12	0
54	13	0
54	14	0
54	16	0
54	17	10
55	1	10
55	2	10
55	3	10
55	4	10
55	5	10
55	6	10
55	7	10
55	8	10
55	9	10
55	10	10
55	11	0
55	12	0
55	13	0
55	14	0
55	16	0
55	17	10
56	1	10
56	2	10
56	3	10
56	4	10
56	5	10
56	6	10
56	7	10
56	8	10
56	9	10
56	10	10
56	11	0
56	12	0
56	13	0
56	14	0
56	16	0
56	17	10
57	1	10
57	2	10
57	3	10
57	4	10
57	5	10
57	6	8
57	7	10
57	8	10
57	9	10
57	10	10
57	11	0
57	12	0
57	13	0
57	14	0
57	16	0
57	17	10
58	1	10
58	2	10
58	3	10
58	4	10
58	5	10
58	6	10
58	7	10
58	8	10
58	9	10
58	10	10
58	11	0
58	12	0
58	13	0
58	14	0
58	16	0
58	17	10
59	1	10
59	2	10
59	3	10
59	4	10
59	5	10
59	6	10
59	7	10
59	8	10
59	9	10
59	10	8
59	11	0
59	12	0
59	13	0
59	14	0
59	16	0
59	17	10
60	1	10
60	2	10
60	3	10
60	4	10
60	5	10
60	6	10
60	7	10
60	8	10
60	9	10
60	10	8
60	11	0
60	12	0
60	13	0
60	14	0
60	16	0
60	17	10
61	1	10
61	2	10
61	3	10
61	4	10
61	5	10
61	6	10
61	7	10
61	8	10
61	9	10
61	10	10
61	11	0
61	12	0
61	13	0
61	14	0
61	16	0
61	17	10
62	1	10
62	2	10
62	3	10
62	4	10
62	5	10
62	6	10
62	7	10
62	8	10
62	9	10
62	10	10
62	11	0
62	12	0
62	13	0
62	14	0
62	16	0
62	17	10
63	1	10
63	2	10
63	3	10
63	4	10
63	5	10
63	6	10
63	7	10
63	8	10
63	9	10
63	10	10
63	11	0
63	12	0
63	13	0
63	14	0
63	16	0
63	17	10
64	1	10
64	2	10
64	3	10
64	4	10
64	5	10
64	6	10
64	7	10
64	8	10
64	9	10
64	10	10
64	11	0
64	12	0
64	13	0
64	14	0
64	16	0
64	17	10
65	1	10
65	2	10
65	3	10
65	4	10
65	5	10
65	6	10
65	7	10
65	8	10
65	9	10
65	10	10
65	11	0
65	12	0
65	13	0
65	14	0
65	16	0
65	17	10
66	1	10
66	2	10
66	3	10
66	4	10
66	5	10
66	6	10
66	7	10
66	8	10
66	9	10
66	10	10
66	11	0
66	12	0
66	13	0
66	14	0
66	16	0
66	17	10
67	1	10
67	2	10
67	3	10
67	4	10
67	5	10
67	6	10
67	7	10
67	8	10
67	9	10
67	10	10
67	11	0
67	12	0
67	13	0
67	14	0
67	16	0
67	17	10
68	1	10
68	2	10
68	3	10
68	4	10
68	5	10
68	6	10
68	7	10
68	8	10
68	9	10
68	10	10
68	11	0
68	12	0
68	13	0
68	14	0
68	16	0
68	17	10
69	1	10
69	2	10
69	3	10
69	4	10
69	5	10
69	6	10
69	7	10
69	8	10
69	9	10
69	10	10
69	11	0
69	12	0
69	13	0
69	14	0
69	16	0
69	17	10
70	1	10
70	2	10
70	3	10
70	4	10
70	5	10
70	6	10
70	7	10
70	8	10
70	9	10
70	10	10
70	11	0
70	12	0
70	13	0
70	14	0
70	16	0
70	17	10
71	1	10
71	2	10
71	3	10
71	4	10
71	5	10
71	6	10
71	7	10
71	8	10
71	9	10
71	10	10
71	11	0
71	12	0
71	13	0
71	14	0
71	16	0
71	17	10
72	1	10
72	2	10
72	3	10
72	4	10
72	5	10
72	6	10
72	7	10
72	8	10
72	9	10
72	10	10
72	11	0
72	12	0
72	13	0
72	14	0
72	16	0
72	17	10
73	1	10
73	2	10
73	3	10
73	4	10
73	5	10
73	6	10
73	7	10
73	8	10
73	9	10
73	10	10
73	11	0
73	12	0
73	13	0
73	14	0
73	16	0
73	17	10
74	1	10
74	2	10
74	3	10
74	4	10
74	5	10
74	6	10
74	7	10
74	8	10
74	9	10
74	10	10
74	11	0
74	12	0
74	13	0
74	14	0
74	16	0
74	17	10
75	1	10
75	2	10
75	3	10
75	4	10
75	5	10
75	6	10
75	7	10
75	8	10
75	9	10
75	10	10
75	11	0
75	12	0
75	13	0
75	14	0
75	16	0
75	17	10
76	1	10
76	2	10
76	3	10
76	4	10
76	5	10
76	6	10
76	7	10
76	8	8
76	9	10
76	10	10
76	11	0
76	12	0
76	13	0
76	14	0
76	16	0
76	17	10
77	1	10
77	2	10
77	3	10
77	4	10
77	5	10
77	6	10
77	7	10
77	8	10
77	9	10
77	10	10
77	11	0
77	12	0
77	13	0
77	14	0
77	16	0
77	17	10
78	1	10
78	2	10
78	3	10
78	4	10
78	5	10
78	6	10
78	7	10
78	8	10
78	9	10
78	10	10
78	11	0
78	12	0
78	13	0
78	14	0
78	16	0
78	17	10
79	1	10
79	2	10
79	3	10
79	4	10
79	5	10
79	6	10
79	7	10
79	8	10
79	9	10
79	10	10
79	11	0
79	12	0
79	13	0
79	14	0
79	16	0
79	17	10
80	1	10
80	2	10
80	3	10
80	4	10
80	5	10
80	6	10
80	7	10
80	8	10
80	9	10
80	10	10
80	11	0
80	12	0
80	13	0
80	14	0
80	16	0
80	17	10
81	1	10
81	2	10
81	3	10
81	4	10
81	5	10
81	6	10
81	7	10
81	8	10
81	9	10
81	10	10
81	11	0
81	12	0
81	13	0
81	14	0
81	16	0
81	17	10
82	1	10
82	2	10
82	3	10
82	4	10
82	5	10
82	6	10
82	7	10
82	8	6
82	9	10
82	10	10
82	11	0
82	12	0
82	13	0
82	14	0
82	16	0
82	17	10
83	1	10
83	2	10
83	3	10
83	4	10
83	5	10
83	6	10
83	7	10
83	8	8
83	9	10
83	10	10
83	11	0
83	12	0
83	13	0
83	14	0
83	16	0
83	17	10
84	1	10
84	2	10
84	3	10
84	4	10
84	5	10
84	6	10
84	7	10
84	8	10
84	9	10
84	10	10
84	11	0
84	12	0
84	13	0
84	14	0
84	16	0
84	17	10
85	1	10
85	2	10
85	3	10
85	4	10
85	5	10
85	6	10
85	7	10
85	8	10
85	9	10
85	10	10
85	11	0
85	12	0
85	13	0
85	14	0
85	16	0
85	17	10
86	1	10
86	2	10
86	3	10
86	4	10
86	5	10
86	6	10
86	7	10
86	8	10
86	9	10
86	10	10
86	11	0
86	12	0
86	13	0
86	14	0
86	16	0
86	17	10
87	1	10
87	2	10
87	3	10
87	4	10
87	5	10
87	6	10
87	7	10
87	8	10
87	9	10
87	10	10
87	11	0
87	12	0
87	13	0
87	14	0
87	16	0
87	17	10
88	1	10
88	2	10
88	3	10
88	4	10
88	5	10
88	6	10
88	7	10
88	8	10
88	9	10
88	10	10
88	11	0
88	12	0
88	13	0
88	14	0
88	16	0
88	17	10
89	1	10
89	2	10
89	3	10
89	4	10
89	5	10
89	6	10
89	7	10
89	8	10
89	9	10
89	10	10
89	11	0
89	12	0
89	13	0
89	14	0
89	16	0
89	17	10
90	1	10
90	2	10
90	3	10
90	4	10
90	5	10
90	6	10
90	7	10
90	8	6
90	9	10
90	10	10
90	11	0
90	12	0
90	13	0
90	14	0
90	16	0
90	17	10
91	1	10
91	2	10
91	3	10
91	4	10
91	5	10
91	6	10
91	7	10
91	8	10
91	9	10
91	10	10
91	11	0
91	12	0
91	13	0
91	14	0
91	16	0
91	17	10
92	1	10
92	2	10
92	3	10
92	4	10
92	5	10
92	6	10
92	7	10
92	8	10
92	9	10
92	10	10
92	11	0
92	12	0
92	13	0
92	14	0
92	16	0
92	17	10
93	1	10
93	2	10
93	3	10
93	4	10
93	5	10
93	6	10
93	7	10
93	8	10
93	9	10
93	10	10
93	11	0
93	12	0
93	13	0
93	14	0
93	16	0
93	17	10
94	1	10
94	2	10
94	3	10
94	4	10
94	5	10
94	6	10
94	7	10
94	8	10
94	9	10
94	10	10
94	11	0
94	12	0
94	13	0
94	14	0
94	16	0
94	17	10
95	1	10
95	2	10
95	3	10
95	4	10
95	5	10
95	6	10
95	7	10
95	8	10
95	9	10
95	10	10
95	11	0
95	12	0
95	13	0
95	14	0
95	16	0
95	17	10
96	1	10
96	2	10
96	3	10
96	4	10
96	5	10
96	6	10
96	7	10
96	8	10
96	9	10
96	10	10
96	11	0
96	12	0
96	13	0
96	14	0
96	16	0
96	17	10
97	1	10
97	2	10
97	3	10
97	4	10
97	5	10
97	6	10
97	7	10
97	8	10
97	9	10
97	10	10
97	11	0
97	12	0
97	13	0
97	14	0
97	16	0
97	17	10
98	1	10
98	2	10
98	3	10
98	4	10
98	5	10
98	6	10
98	7	10
98	8	10
98	9	10
98	10	10
98	11	0
98	12	0
98	13	0
98	14	0
98	16	0
98	17	10
99	1	10
99	2	10
99	3	10
99	4	10
99	5	10
99	6	10
99	7	10
99	8	10
99	9	10
99	10	10
99	11	0
99	12	0
99	13	0
99	14	0
99	16	0
99	17	10
100	1	10
100	2	10
100	3	10
100	4	10
100	5	10
100	6	10
100	7	10
100	8	10
100	9	10
100	10	10
100	11	0
100	12	0
100	13	0
100	14	0
100	16	0
100	17	10
101	1	10
101	2	10
101	3	10
101	4	10
101	5	10
101	6	10
101	7	10
101	8	10
101	9	10
101	10	10
101	11	0
101	12	0
101	13	0
101	14	0
101	16	0
101	17	10
102	1	10
102	2	10
102	3	10
102	4	10
102	5	10
102	6	10
102	7	10
102	8	10
102	9	10
102	10	10
102	11	0
102	12	0
102	13	0
102	14	0
102	16	0
102	17	10
103	1	10
103	2	10
103	3	10
103	4	10
103	5	10
103	6	10
103	7	10
103	8	10
103	9	10
103	10	10
103	11	0
103	12	0
103	13	0
103	14	0
103	16	0
103	17	10
104	1	10
104	2	10
104	3	10
104	4	10
104	5	10
104	6	10
104	7	10
104	8	10
104	9	10
104	10	10
104	11	0
104	12	0
104	13	0
104	14	0
104	16	0
104	17	10
105	1	10
105	2	10
105	3	10
105	4	10
105	5	10
105	6	10
105	7	10
105	8	10
105	9	10
105	10	10
105	11	0
105	12	0
105	13	0
105	14	0
105	16	0
105	17	10
106	1	10
106	2	10
106	3	10
106	4	10
106	5	10
106	6	10
106	7	10
106	8	10
106	9	10
106	10	10
106	11	0
106	12	0
106	13	0
106	14	0
106	16	0
106	17	10
107	1	10
107	2	10
107	3	10
107	4	10
107	5	10
107	6	10
107	7	10
107	8	10
107	9	10
107	10	10
107	11	0
107	12	0
107	13	0
107	14	0
107	16	0
107	17	10
108	1	10
108	2	10
108	3	10
108	4	10
108	5	10
108	6	10
108	7	10
108	8	10
108	9	10
108	10	10
108	11	0
108	12	0
108	13	0
108	14	0
108	16	0
108	17	10
109	1	10
109	2	10
109	3	10
109	4	10
109	5	10
109	6	10
109	7	10
109	8	10
109	9	10
109	10	10
109	11	0
109	12	0
109	13	0
109	14	0
109	16	0
109	17	10
110	1	10
110	2	10
110	3	10
110	4	10
110	5	10
110	6	10
110	7	10
110	8	10
110	9	10
110	10	10
110	11	0
110	12	0
110	13	0
110	14	0
110	16	0
110	17	10
111	1	10
111	2	10
111	3	10
111	4	10
111	5	10
111	6	10
111	7	10
111	8	10
111	9	10
111	10	10
111	11	0
111	12	0
111	13	0
111	14	0
111	16	0
111	17	10
112	1	10
112	2	10
112	3	10
112	4	10
112	5	10
112	6	10
112	7	10
112	8	10
112	9	10
112	10	10
112	11	0
112	12	0
112	13	0
112	14	0
112	16	0
112	17	10
113	1	10
113	2	10
113	3	10
113	4	10
113	5	10
113	6	10
113	7	10
113	8	10
113	9	10
113	10	10
113	11	0
113	12	0
113	13	0
113	14	0
113	16	0
113	17	10
114	1	10
114	2	10
114	3	10
114	4	10
114	5	10
114	6	10
114	7	10
114	8	10
114	9	10
114	10	10
114	11	0
114	12	0
114	13	0
114	14	0
114	16	0
114	17	10
115	1	10
115	2	10
115	3	10
115	4	10
115	5	10
115	6	10
115	7	10
115	8	10
115	9	10
115	10	10
115	11	0
115	12	0
115	13	0
115	14	0
115	16	0
115	17	10
116	1	10
116	2	10
116	3	10
116	4	10
116	5	10
116	6	10
116	7	10
116	8	10
116	9	10
116	10	10
116	11	0
116	12	0
116	13	0
116	14	0
116	16	0
116	17	10
117	1	10
117	2	10
117	3	10
117	4	10
117	5	10
117	6	10
117	7	10
117	8	10
117	9	10
117	10	10
117	11	0
117	12	0
117	13	0
117	14	0
117	16	0
117	17	10
118	1	10
118	2	10
118	3	10
118	4	10
118	5	10
118	6	10
118	7	10
118	8	10
118	9	10
118	10	10
118	11	0
118	12	0
118	13	0
118	14	0
118	16	0
118	17	10
119	1	10
119	2	10
119	3	10
119	4	10
119	5	10
119	6	10
119	7	10
119	8	10
119	9	10
119	10	10
119	11	0
119	12	0
119	13	0
119	14	0
119	16	0
119	17	10
120	1	10
120	2	10
120	3	10
120	4	10
120	5	10
120	6	10
120	7	10
120	8	10
120	9	10
120	10	10
120	11	0
120	12	0
120	13	0
120	14	0
120	16	0
120	17	10
121	1	10
121	2	10
121	3	10
121	4	10
121	5	10
121	6	10
121	7	10
121	8	10
121	9	10
121	10	10
121	11	0
121	12	0
121	13	0
121	14	0
121	16	0
121	17	10
122	1	10
122	2	10
122	3	10
122	4	10
122	5	10
122	6	10
122	7	10
122	8	10
122	9	10
122	10	10
122	11	1
122	12	0
122	13	0
122	14	0
122	15	1
122	16	0
122	17	10
123	1	10
123	2	10
123	3	10
123	4	10
123	5	10
123	6	10
123	7	10
123	8	10
123	9	10
123	10	10
123	11	0
123	12	0
123	13	0
123	14	0
123	16	0
123	17	10
124	1	10
124	2	10
124	3	10
124	4	10
124	5	10
124	6	10
124	7	10
124	8	10
124	9	10
124	10	10
124	11	0
124	12	0
124	13	0
124	14	0
124	16	0
124	17	10
125	1	10
125	2	10
125	3	10
125	4	10
125	5	10
125	6	10
125	7	10
125	8	10
125	9	10
125	10	10
125	11	0
125	12	0
125	13	0
125	14	0
125	16	0
125	17	10
126	1	10
126	2	10
126	3	10
126	4	10
126	5	10
126	6	10
126	7	10
126	8	10
126	9	10
126	10	10
126	11	0
126	12	0
126	13	0
126	14	0
126	16	0
126	17	10
127	1	10
127	2	10
127	3	10
127	4	10
127	5	10
127	6	10
127	7	10
127	8	10
127	9	10
127	10	10
127	11	0
127	12	0
127	13	0
127	14	0
127	16	0
127	17	10
128	1	10
128	2	10
128	3	10
128	4	10
128	5	10
128	6	10
128	7	10
128	8	10
128	9	10
128	10	10
128	11	0
128	12	0
128	13	0
128	14	0
128	16	0
128	17	10
129	1	10
129	2	10
129	3	10
129	4	10
129	5	10
129	6	10
129	7	10
129	8	10
129	9	10
129	10	10
129	11	0
129	12	0
129	13	0
129	14	0
129	16	0
129	17	10
130	1	10
130	2	10
130	3	10
130	4	10
130	5	10
130	6	10
130	7	10
130	8	10
130	9	10
130	10	10
130	11	0
130	12	0
130	13	0
130	14	0
130	16	0
130	17	10
131	1	10
131	2	10
131	3	10
131	4	10
131	5	10
131	6	10
131	7	10
131	8	10
131	9	10
131	10	10
131	11	0
131	12	0
131	13	0
131	14	0
131	16	0
131	17	10
132	1	10
132	2	10
132	3	10
132	4	10
132	5	10
132	6	10
132	7	10
132	8	10
132	9	10
132	10	10
132	11	0
132	12	0
132	13	0
132	14	0
132	16	0
132	17	10
133	1	10
133	2	10
133	3	10
133	4	10
133	5	10
133	6	10
133	7	10
133	8	10
133	9	10
133	10	10
133	11	0
133	12	0
133	13	0
133	14	0
133	16	0
133	17	10
134	1	10
134	2	10
134	3	10
134	4	10
134	5	10
134	6	10
134	7	10
134	8	10
134	9	10
134	10	10
134	11	0
134	12	0
134	13	0
134	14	0
134	16	0
134	17	10
135	1	10
135	2	10
135	3	10
135	4	10
135	5	10
135	6	10
135	7	10
135	8	10
135	9	10
135	10	10
135	11	0
135	12	0
135	13	0
135	14	0
135	16	0
135	17	10
136	1	10
136	2	10
136	3	10
136	4	10
136	5	10
136	6	10
136	7	10
136	8	10
136	9	10
136	10	10
136	11	0
136	12	0
136	13	0
136	14	0
136	16	0
136	17	10
137	1	10
137	2	10
137	3	10
137	4	10
137	5	10
137	6	10
137	7	10
137	8	10
137	9	10
137	10	10
137	11	0
137	12	0
137	13	0
137	14	0
137	16	0
137	17	10
138	1	10
138	2	10
138	3	10
138	4	10
138	5	10
138	6	10
138	7	10
138	8	10
138	9	10
138	10	10
138	11	0
138	12	0
138	13	0
138	14	0
138	16	0
138	17	10
139	1	10
139	2	10
139	3	10
139	4	10
139	5	10
139	6	10
139	7	10
139	8	10
139	9	10
139	10	10
139	11	0
139	12	0
139	13	0
139	14	0
139	16	0
139	17	10
140	1	10
140	2	10
140	3	10
140	4	10
140	5	10
140	6	10
140	7	10
140	8	10
140	9	10
140	10	10
140	11	0
140	12	0
140	13	0
140	14	0
140	16	0
140	17	10
141	1	10
141	2	10
141	3	10
141	4	10
141	5	10
141	6	10
141	7	10
141	8	10
141	9	10
141	10	10
141	11	0
141	12	0
141	13	0
141	14	0
141	16	0
141	17	10
142	1	10
142	2	10
142	3	10
142	4	10
142	5	10
142	6	10
142	7	10
142	8	10
142	9	10
142	10	10
142	11	0
142	12	0
142	13	0
142	14	0
142	16	0
142	17	10
143	1	10
143	2	10
143	3	10
143	4	10
143	5	10
143	6	10
143	7	10
143	8	10
143	9	10
143	10	10
143	11	0
143	12	0
143	13	0
143	14	0
143	16	0
143	17	10
144	1	10
144	2	10
144	3	10
144	4	10
144	5	10
144	6	10
144	7	10
144	8	10
144	9	10
144	10	10
144	11	0
144	12	0
144	13	0
144	14	0
144	16	0
144	17	10
145	1	10
145	2	10
145	3	10
145	4	10
145	5	10
145	6	10
145	7	10
145	8	10
145	9	10
145	10	10
145	11	0
145	12	0
145	13	0
145	14	0
145	16	0
145	17	10
146	1	10
146	2	10
146	3	10
146	4	10
146	5	10
146	6	10
146	7	10
146	8	10
146	9	10
146	10	10
146	11	0
146	12	0
146	13	0
146	14	0
146	16	0
146	17	10
147	1	10
147	2	10
147	3	10
147	4	10
147	5	10
147	6	10
147	7	10
147	8	10
147	9	10
147	10	10
147	11	0
147	12	1
147	13	0
147	14	0
147	15	1
147	16	0
147	17	10
148	1	10
148	2	10
148	3	10
148	4	10
148	5	10
148	6	10
148	7	10
148	8	10
148	9	10
148	10	10
148	11	0
148	12	0
148	13	0
148	14	0
148	16	0
148	17	10
149	1	10
149	2	10
149	3	10
149	4	10
149	5	10
149	6	10
149	7	10
149	8	10
149	9	10
149	10	10
149	11	0
149	12	0
149	13	0
149	14	0
149	16	0
149	17	10
150	1	10
150	2	10
150	3	10
150	4	10
150	5	10
150	6	10
150	7	10
150	8	10
150	9	10
150	10	10
150	11	0
150	12	0
150	13	0
150	14	0
150	16	0
150	17	10
151	1	10
151	2	10
151	3	10
151	4	10
151	5	10
151	6	10
151	7	10
151	8	10
151	9	10
151	10	10
151	11	0
151	12	0
151	13	0
151	14	0
151	16	0
151	17	10
152	1	10
152	2	10
152	3	10
152	4	10
152	5	10
152	6	10
152	7	10
152	8	10
152	9	10
152	10	10
152	11	0
152	12	0
152	13	0
152	14	0
152	16	0
152	17	10
153	1	10
153	2	10
153	3	10
153	4	10
153	5	10
153	6	10
153	7	10
153	8	10
153	9	10
153	10	10
153	11	0
153	12	0
153	13	0
153	14	0
153	16	0
153	17	10
154	1	10
154	2	10
154	3	10
154	4	10
154	5	10
154	6	10
154	7	10
154	8	10
154	9	10
154	10	10
154	11	0
154	12	0
154	13	0
154	14	0
154	16	0
154	17	10
155	1	10
155	2	10
155	3	10
155	4	10
155	5	10
155	6	10
155	7	10
155	8	10
155	9	10
155	10	10
155	11	0
155	12	0
155	13	0
155	14	0
155	16	0
155	17	10
156	1	10
156	2	10
156	3	10
156	4	10
156	5	10
156	6	10
156	7	10
156	8	10
156	9	10
156	10	10
156	11	0
156	12	0
156	13	0
156	14	0
156	16	0
156	17	10
157	1	10
157	2	10
157	3	10
157	4	10
157	5	10
157	6	10
157	7	10
157	8	10
157	9	10
157	10	10
157	11	0
157	12	0
157	13	0
157	14	0
157	16	0
157	17	10
158	1	10
158	2	10
158	3	10
158	4	10
158	5	10
158	6	10
158	7	10
158	8	10
158	9	10
158	10	10
158	11	0
158	12	0
158	13	0
158	14	0
158	16	0
158	17	10
159	1	10
159	2	10
159	3	10
159	4	10
159	5	10
159	6	10
159	7	10
159	8	10
159	9	10
159	10	10
159	11	0
159	12	0
159	13	0
159	14	0
159	16	0
159	17	10
160	1	10
160	2	10
160	3	10
160	4	10
160	5	10
160	6	10
160	7	10
160	8	10
160	9	10
160	10	10
160	11	0
160	12	0
160	13	0
160	14	0
160	16	0
160	17	10
161	1	10
161	2	10
161	3	10
161	4	10
161	5	10
161	6	10
161	7	10
161	8	10
161	9	10
161	10	10
161	11	0
161	12	0
161	13	0
161	14	0
161	16	0
161	17	10
162	1	10
162	2	10
162	3	10
162	4	8
162	5	10
162	6	10
162	7	10
162	8	10
162	9	10
162	10	10
162	11	0
162	12	1
162	13	0
162	14	0
162	15	1
162	16	0
162	17	10
163	1	10
163	2	10
163	3	10
163	4	8
163	5	10
163	6	10
163	7	10
163	8	10
163	9	10
163	10	10
163	11	0
163	12	1
163	13	0
163	14	0
163	15	1
163	16	0
163	17	8
164	1	10
164	2	10
164	3	10
164	4	10
164	5	10
164	6	10
164	7	10
164	8	10
164	9	10
164	10	10
164	11	0
164	12	0
164	13	0
164	14	0
164	16	0
164	17	10
165	1	10
165	2	10
165	3	10
165	4	10
165	5	10
165	6	10
165	7	10
165	8	10
165	9	10
165	10	10
165	11	0
165	12	0
165	13	0
165	14	0
165	16	0
165	17	10
166	1	10
166	2	10
166	3	10
166	4	10
166	5	10
166	6	10
166	7	10
166	8	10
166	9	10
166	10	10
166	11	0
166	12	0
166	13	0
166	14	0
166	16	0
166	17	10
167	1	10
167	2	10
167	3	10
167	4	10
167	5	10
167	6	10
167	7	10
167	8	10
167	9	10
167	10	10
167	11	0
167	12	0
167	13	0
167	14	0
167	16	0
167	17	10
168	1	10
168	2	10
168	3	10
168	4	10
168	5	10
168	6	10
168	7	10
168	8	10
168	9	10
168	10	10
168	11	0
168	12	0
168	13	0
168	14	0
168	16	0
168	17	10
169	1	10
169	2	10
169	3	10
169	4	10
169	5	10
169	6	10
169	7	10
169	8	10
169	9	10
169	10	10
169	11	0
169	12	0
169	13	0
169	14	0
169	16	0
169	17	10
170	1	10
170	2	10
170	3	10
170	4	10
170	5	10
170	6	10
170	7	10
170	8	10
170	9	10
170	10	10
170	11	0
170	12	0
170	13	0
170	14	0
170	16	0
170	17	10
171	1	10
171	2	10
171	3	10
171	4	10
171	5	10
171	6	10
171	7	10
171	8	10
171	9	10
171	10	10
171	11	0
171	12	0
171	13	0
171	14	0
171	16	0
171	17	10
172	1	10
172	2	10
172	3	10
172	4	10
172	5	10
172	6	10
172	7	10
172	8	10
172	9	10
172	10	10
172	11	0
172	12	0
172	13	0
172	14	0
172	16	0
172	17	10
173	1	10
173	2	10
173	3	10
173	4	10
173	5	10
173	6	10
173	7	10
173	8	10
173	9	10
173	10	10
173	11	0
173	12	0
173	13	0
173	14	0
173	16	0
173	17	10
174	1	10
174	2	10
174	3	10
174	4	10
174	5	10
174	6	10
174	7	10
174	8	10
174	9	10
174	10	10
174	11	0
174	12	0
174	13	0
174	14	0
174	16	0
174	17	10
175	1	10
175	2	10
175	3	10
175	4	10
175	5	10
175	6	10
175	7	10
175	8	10
175	9	10
175	10	10
175	11	0
175	12	0
175	13	0
175	14	0
175	16	0
175	17	10
176	1	10
176	2	10
176	3	10
176	4	10
176	5	10
176	6	10
176	7	10
176	8	10
176	9	10
176	10	10
176	11	0
176	12	0
176	13	0
176	14	0
176	16	0
176	17	10
177	1	10
177	2	10
177	3	10
177	4	10
177	5	10
177	6	10
177	7	10
177	8	10
177	9	10
177	10	10
177	11	0
177	12	0
177	13	0
177	14	0
177	16	0
177	17	10
178	1	10
178	2	10
178	3	10
178	4	10
178	5	10
178	6	10
178	7	10
178	8	10
178	9	10
178	10	10
178	11	0
178	12	0
178	13	0
178	14	0
178	16	0
178	17	10
179	1	10
179	2	10
179	3	10
179	4	10
179	5	10
179	6	10
179	7	10
179	8	10
179	9	10
179	10	10
179	11	0
179	12	0
179	13	0
179	14	0
179	16	0
179	17	10
180	1	10
180	2	10
180	3	10
180	4	10
180	5	10
180	6	10
180	7	10
180	8	8
180	9	10
180	10	10
180	11	0
180	12	0
180	13	0
180	14	0
180	16	0
180	17	10
181	1	10
181	2	10
181	3	10
181	4	10
181	5	10
181	6	10
181	7	10
181	8	10
181	9	10
181	10	10
181	11	0
181	12	0
181	13	0
181	14	0
181	16	0
181	17	10
182	1	10
182	2	10
182	3	10
182	4	10
182	5	10
182	6	10
182	7	10
182	8	8
182	9	10
182	10	10
182	11	0
182	12	0
182	13	0
182	14	0
182	16	0
182	17	10
183	1	10
183	2	10
183	3	10
183	4	10
183	5	10
183	6	10
183	7	10
183	8	8
183	9	10
183	10	10
183	11	0
183	12	0
183	13	0
183	14	0
183	16	0
183	17	10
184	1	10
184	2	10
184	3	10
184	4	10
184	5	10
184	6	10
184	7	10
184	8	8
184	9	10
184	10	10
184	11	0
184	12	0
184	13	0
184	14	0
184	16	0
184	17	10
185	1	10
185	2	10
185	3	10
185	4	10
185	5	10
185	6	10
185	7	10
185	8	10
185	9	10
185	10	10
185	11	0
185	12	0
185	13	0
185	14	0
185	16	0
185	17	10
186	1	10
186	2	10
186	3	10
186	4	10
186	5	10
186	6	10
186	7	10
186	8	8
186	9	10
186	10	10
186	11	0
186	12	0
186	13	0
186	14	0
186	16	0
186	17	10
187	1	10
187	2	10
187	3	10
187	4	10
187	5	10
187	6	10
187	7	10
187	8	8
187	9	10
187	10	10
187	11	0
187	12	0
187	13	0
187	14	0
187	16	0
187	17	10
188	1	10
188	2	10
188	3	10
188	4	10
188	5	10
188	6	10
188	7	10
188	8	8
188	9	10
188	10	10
188	11	0
188	12	0
188	13	0
188	14	0
188	16	0
188	17	10
189	1	10
189	2	10
189	3	10
189	4	10
189	5	10
189	6	10
189	7	10
189	8	10
189	9	10
189	10	10
189	11	0
189	12	0
189	13	0
189	14	0
189	16	0
189	17	10
190	1	10
190	2	10
190	3	10
190	4	10
190	5	10
190	6	10
190	7	10
190	8	10
190	9	10
190	10	10
190	11	0
190	12	0
190	13	0
190	14	0
190	16	0
190	17	10
191	1	10
191	2	10
191	3	10
191	4	10
191	5	10
191	6	10
191	7	10
191	8	10
191	9	10
191	10	10
191	11	0
191	12	0
191	13	0
191	14	0
191	16	0
191	17	10
192	1	10
192	2	10
192	3	10
192	4	10
192	5	10
192	6	10
192	7	10
192	8	10
192	9	10
192	10	10
192	11	0
192	12	0
192	13	0
192	14	0
192	16	0
192	17	10
193	1	10
193	2	10
193	3	10
193	4	10
193	5	10
193	6	10
193	7	10
193	8	10
193	9	10
193	10	10
193	11	0
193	12	0
193	13	0
193	14	0
193	16	0
193	17	10
194	1	10
194	2	10
194	3	10
194	4	10
194	5	10
194	6	10
194	7	10
194	8	10
194	9	10
194	10	10
194	11	0
194	12	0
194	13	0
194	14	0
194	16	0
194	17	10
195	1	10
195	2	10
195	3	10
195	4	10
195	5	10
195	6	10
195	7	10
195	8	10
195	9	10
195	10	10
195	11	0
195	12	0
195	13	0
195	14	0
195	16	0
195	17	10
196	1	10
196	2	10
196	3	10
196	4	10
196	5	10
196	6	10
196	7	10
196	8	10
196	9	10
196	10	10
196	11	0
196	12	0
196	13	0
196	14	0
196	16	0
196	17	10
197	1	10
197	2	10
197	3	10
197	4	10
197	5	10
197	6	10
197	7	10
197	8	10
197	9	10
197	10	10
197	11	0
197	12	0
197	13	0
197	14	0
197	16	0
197	17	10
198	1	10
198	2	10
198	3	10
198	4	10
198	5	10
198	6	10
198	7	10
198	8	10
198	9	10
198	10	10
198	11	0
198	12	0
198	13	0
198	14	0
198	16	0
198	17	10
199	1	10
199	2	10
199	3	10
199	4	10
199	5	10
199	6	10
199	7	10
199	8	10
199	9	10
199	10	10
199	11	0
199	12	0
199	13	0
199	14	0
199	16	0
199	17	10
200	1	10
200	2	10
200	3	10
200	4	10
200	5	10
200	6	10
200	7	10
200	8	10
200	9	10
200	10	10
200	11	0
200	12	0
200	13	0
200	14	0
200	16	0
200	17	10
201	1	10
201	2	10
201	3	10
201	4	10
201	5	10
201	6	10
201	7	10
201	8	10
201	9	10
201	10	10
201	11	0
201	12	0
201	13	0
201	14	0
201	16	0
201	17	10
202	1	10
202	2	10
202	3	10
202	4	10
202	5	10
202	6	10
202	7	10
202	8	10
202	9	10
202	10	10
202	11	0
202	12	0
202	13	0
202	14	0
202	16	0
202	17	10
203	1	10
203	2	10
203	3	10
203	4	10
203	5	10
203	6	10
203	7	10
203	8	10
203	9	10
203	10	10
203	11	0
203	12	0
203	13	0
203	14	0
203	16	0
203	17	10
204	1	10
204	2	10
204	3	10
204	4	10
204	5	10
204	6	10
204	7	10
204	8	10
204	9	10
204	10	10
204	11	0
204	12	0
204	13	0
204	14	0
204	16	0
204	17	10
205	1	10
205	2	10
205	3	10
205	4	10
205	5	10
205	6	10
205	7	10
205	8	10
205	9	10
205	10	10
205	11	0
205	12	0
205	13	0
205	14	0
205	16	0
205	17	10
206	1	10
206	2	10
206	3	10
206	4	10
206	5	10
206	6	10
206	7	10
206	8	10
206	9	10
206	10	10
206	11	0
206	12	0
206	13	0
206	14	0
206	16	0
206	17	10
207	1	10
207	2	10
207	3	10
207	4	10
207	5	10
207	6	10
207	7	10
207	8	10
207	9	10
207	10	10
207	11	0
207	12	0
207	13	0
207	14	0
207	16	0
207	17	10
208	1	10
208	2	10
208	3	10
208	4	10
208	5	10
208	6	10
208	7	10
208	8	10
208	9	10
208	10	10
208	11	0
208	12	0
208	13	0
208	14	0
208	16	0
208	17	10
209	1	10
209	2	10
209	3	10
209	4	10
209	5	10
209	6	10
209	7	10
209	8	10
209	9	10
209	10	10
209	11	0
209	12	0
209	13	0
209	14	0
209	16	0
209	17	10
210	1	10
210	2	10
210	3	10
210	4	10
210	5	10
210	6	10
210	7	10
210	8	10
210	9	10
210	10	10
210	11	0
210	12	0
210	13	0
210	14	0
210	16	0
210	17	10
211	1	10
211	2	10
211	3	10
211	4	10
211	5	10
211	6	10
211	7	10
211	8	10
211	9	10
211	10	10
211	11	0
211	12	0
211	13	0
211	14	0
211	16	0
211	17	10
212	1	10
212	2	10
212	3	10
212	4	10
212	5	10
212	6	10
212	7	10
212	8	10
212	9	8
212	10	10
212	11	0
212	12	0
212	13	0
212	14	0
212	16	0
212	17	10
213	1	10
213	2	10
213	3	10
213	4	10
213	5	10
213	6	10
213	7	10
213	8	10
213	9	10
213	10	10
213	11	0
213	12	0
213	13	0
213	14	0
213	16	0
213	17	10
214	1	10
214	2	10
214	3	10
214	4	10
214	5	10
214	6	10
214	7	10
214	8	10
214	9	10
214	10	10
214	11	0
214	12	0
214	13	0
214	14	0
214	16	0
214	17	10
215	1	10
215	2	10
215	3	10
215	4	10
215	5	10
215	6	10
215	7	10
215	8	10
215	9	10
215	10	10
215	11	0
215	12	0
215	13	0
215	14	0
215	16	0
215	17	10
216	1	10
216	2	10
216	3	10
216	4	10
216	5	10
216	6	10
216	7	10
216	8	10
216	9	10
216	10	10
216	11	0
216	12	0
216	13	0
216	14	0
216	16	0
216	17	10
217	1	10
217	2	10
217	3	10
217	4	10
217	5	10
217	6	10
217	7	10
217	8	10
217	9	10
217	10	10
217	11	0
217	12	0
217	13	0
217	14	0
217	16	0
217	17	10
218	1	10
218	2	10
218	3	10
218	4	10
218	5	10
218	6	10
218	7	10
218	8	10
218	9	10
218	10	10
218	11	0
218	12	0
218	13	0
218	14	0
218	16	0
218	17	10
219	1	10
219	2	10
219	3	10
219	4	10
219	5	10
219	6	10
219	7	10
219	8	10
219	9	10
219	10	10
219	11	0
219	12	0
219	13	0
219	14	0
219	16	0
219	17	10
220	1	10
220	2	10
220	3	10
220	4	10
220	5	10
220	6	10
220	7	10
220	8	10
220	9	10
220	10	10
220	11	0
220	12	0
220	13	0
220	14	0
220	16	0
220	17	10
221	1	10
221	2	10
221	3	10
221	4	10
221	5	10
221	6	10
221	7	10
221	8	10
221	9	10
221	10	10
221	11	0
221	12	0
221	13	0
221	14	0
221	16	0
221	17	10
222	1	10
222	2	10
222	3	10
222	4	10
222	5	10
222	6	10
222	7	10
222	8	10
222	9	10
222	10	10
222	11	0
222	12	0
222	13	0
222	14	0
222	16	0
222	17	10
223	1	10
223	2	10
223	3	10
223	4	10
223	5	10
223	6	10
223	7	10
223	8	10
223	9	10
223	10	10
223	11	0
223	12	1
223	13	0
223	14	0
223	15	1
223	16	0
223	17	10
224	1	10
224	2	10
224	3	10
224	4	10
224	5	10
224	6	10
224	7	10
224	8	10
224	9	10
224	10	10
224	11	0
224	12	0
224	13	0
224	14	0
224	16	0
224	17	10
225	1	10
225	2	10
225	3	10
225	4	10
225	5	10
225	6	10
225	7	10
225	8	10
225	9	10
225	10	10
225	11	0
225	12	0
225	13	0
225	14	0
225	16	0
225	17	10
226	1	10
226	2	10
226	3	10
226	4	10
226	5	10
226	6	10
226	7	10
226	8	10
226	9	10
226	10	10
226	11	0
226	12	0
226	13	0
226	14	0
226	16	0
226	17	10
227	1	10
227	2	10
227	3	10
227	4	10
227	5	10
227	6	10
227	7	10
227	8	10
227	9	10
227	10	10
227	11	0
227	12	0
227	13	0
227	14	0
227	16	0
227	17	10
228	1	10
228	2	10
228	3	10
228	4	10
228	5	10
228	6	10
228	7	10
228	8	10
228	9	10
228	10	10
228	11	0
228	12	0
228	13	0
228	14	0
228	16	0
228	17	10
229	1	10
229	2	10
229	3	10
229	4	10
229	5	10
229	6	10
229	7	10
229	8	10
229	9	10
229	10	10
229	11	0
229	12	0
229	13	0
229	14	0
229	16	0
229	17	10
230	1	10
230	2	10
230	3	10
230	4	10
230	5	10
230	6	10
230	7	10
230	8	10
230	9	10
230	10	10
230	11	0
230	12	0
230	13	0
230	14	0
230	16	0
230	17	10
231	1	10
231	2	10
231	3	10
231	4	10
231	5	10
231	6	10
231	7	10
231	8	10
231	9	10
231	10	10
231	11	0
231	12	0
231	13	0
231	14	0
231	16	0
231	17	10
232	1	10
232	2	10
232	3	10
232	4	10
232	5	10
232	6	10
232	7	10
232	8	10
232	9	10
232	10	10
232	11	0
232	12	0
232	13	0
232	14	0
232	16	0
232	17	10
233	1	10
233	2	10
233	3	10
233	4	10
233	5	10
233	6	10
233	7	10
233	8	10
233	9	10
233	10	10
233	11	0
233	12	0
233	13	0
233	14	0
233	16	0
233	17	10
234	1	10
234	2	10
234	3	10
234	4	10
234	5	10
234	6	10
234	7	10
234	8	10
234	9	10
234	10	10
234	11	0
234	12	0
234	13	0
234	14	0
234	16	0
234	17	10
237	1	10
237	2	10
237	3	10
237	4	10
237	5	10
237	6	10
237	7	10
237	8	10
237	9	8
237	10	10
237	11	0
237	12	1
237	13	0
237	14	0
237	15	1
237	16	0
237	17	10
239	1	10
239	2	10
239	3	10
239	4	10
239	5	10
239	6	10
239	7	10
239	8	10
239	9	10
239	10	10
239	11	0
239	12	0
239	13	0
239	14	0
239	16	0
239	17	10
240	1	10
240	2	10
240	3	10
240	4	10
240	5	10
240	6	10
240	7	10
240	8	10
240	9	10
240	10	10
240	11	0
240	12	0
240	13	0
240	14	0
240	16	0
240	17	10
241	1	10
241	2	10
241	3	10
241	4	10
241	5	10
241	6	10
241	7	10
241	8	10
241	9	10
241	10	10
241	11	0
241	12	1
241	13	0
241	14	0
241	16	0
241	17	10
242	1	10
242	2	10
242	3	10
242	4	10
242	5	10
242	6	10
242	7	10
242	8	10
242	9	10
242	10	10
242	11	0
242	12	0
242	13	0
242	14	0
242	16	0
242	17	10
245	1	10
245	2	10
245	3	10
245	4	10
245	5	10
245	6	10
245	7	10
245	8	10
245	9	10
245	10	10
245	11	0
245	12	0
245	13	0
245	14	0
245	16	0
245	17	10
247	1	10
247	2	10
247	3	10
247	4	10
247	5	10
247	6	10
247	7	10
247	8	10
247	9	10
247	10	10
247	11	0
247	12	0
247	13	0
247	14	0
247	16	0
247	17	10
248	1	10
248	2	10
248	3	10
248	4	10
248	5	10
248	6	10
248	7	10
248	8	10
248	9	10
248	10	10
248	11	0
248	12	0
248	13	0
248	14	0
248	16	0
248	17	10
249	1	10
249	2	10
249	3	10
249	4	10
249	5	10
249	6	10
249	7	10
249	8	10
249	9	10
249	10	10
249	11	0
249	12	0
249	13	0
249	14	0
249	16	0
249	17	10
250	1	10
250	2	10
250	3	10
250	4	10
250	5	10
250	6	10
250	7	10
250	8	10
250	9	10
250	10	10
250	11	0
250	12	0
250	13	0
250	14	0
250	16	0
250	17	10
251	1	10
251	2	10
251	3	10
251	4	10
251	5	10
251	6	10
251	7	10
251	8	10
251	9	10
251	10	10
251	11	0
251	12	0
251	13	0
251	14	0
251	16	0
251	17	10
252	1	10
252	2	10
252	3	10
252	4	10
252	5	10
252	6	10
252	7	10
252	8	10
252	9	10
252	10	10
252	11	0
252	12	0
252	13	0
252	14	0
252	16	0
252	17	10
253	1	10
253	2	10
253	3	10
253	4	10
253	5	10
253	6	10
253	7	10
253	8	10
253	9	10
253	10	10
253	11	0
253	12	0
253	13	0
253	14	0
253	16	0
253	17	10
254	1	10
254	2	10
254	3	10
254	4	10
254	5	10
254	6	10
254	7	10
254	8	10
254	9	10
254	10	10
254	11	0
254	12	0
254	13	0
254	14	0
254	16	0
254	17	10
255	1	10
255	2	10
255	3	10
255	4	10
255	5	10
255	6	10
255	7	10
255	8	10
255	9	10
255	10	10
255	11	0
255	12	0
255	13	0
255	14	0
255	16	0
255	17	10
256	1	10
256	2	10
256	3	10
256	4	10
256	5	10
256	6	10
256	7	10
256	8	10
256	9	10
256	10	10
256	11	0
256	12	0
256	13	0
256	14	0
256	16	0
256	17	10
257	1	10
257	2	10
257	3	10
257	4	10
257	5	10
257	6	10
257	7	10
257	8	10
257	9	10
257	10	10
257	11	0
257	12	0
257	13	0
257	14	0
257	16	0
257	17	10
258	1	10
258	2	10
258	3	10
258	4	10
258	5	10
258	6	10
258	7	10
258	8	10
258	9	10
258	10	10
258	11	0
258	12	0
258	13	0
258	14	0
258	16	0
258	17	10
259	1	10
259	2	10
259	3	10
259	4	10
259	5	10
259	6	10
259	7	10
259	8	10
259	9	10
259	10	10
259	11	0
259	12	0
259	13	0
259	14	0
259	16	0
259	17	10
260	1	10
260	2	10
260	3	10
260	4	10
260	5	10
260	6	10
260	7	10
260	8	10
260	9	10
260	10	10
260	11	0
260	12	0
260	13	0
260	14	0
260	16	0
260	17	10
261	1	10
261	2	10
261	3	10
261	4	10
261	5	10
261	6	10
261	7	10
261	8	10
261	9	10
261	10	10
261	11	0
261	12	0
261	13	0
261	14	0
261	16	0
261	17	10
262	1	10
262	2	10
262	3	10
262	4	10
262	5	10
262	6	10
262	7	10
262	8	10
262	9	10
262	10	10
262	11	0
262	12	0
262	13	0
262	14	0
262	16	0
262	17	10
263	1	10
263	2	10
263	3	10
263	4	10
263	5	10
263	6	10
263	7	10
263	8	10
263	9	10
263	10	10
263	11	0
263	12	0
263	13	0
263	14	0
263	16	0
263	17	10
264	1	10
264	2	10
264	3	10
264	4	10
264	5	10
264	6	10
264	7	10
264	8	10
264	9	10
264	10	10
264	11	0
264	12	1
264	13	0
264	14	0
264	15	1
264	16	0
264	17	10
265	1	10
265	2	10
265	3	10
265	4	10
265	5	10
265	6	10
265	7	10
265	8	10
265	9	10
265	10	10
265	11	0
265	12	0
265	13	0
265	14	0
265	16	0
265	17	10
266	1	10
266	2	10
266	3	10
266	4	10
266	5	10
266	6	10
266	7	10
266	8	10
266	9	10
266	10	10
266	11	0
266	12	0
266	13	0
266	14	0
266	16	0
266	17	10
267	1	10
267	2	10
267	3	10
267	4	10
267	5	10
267	6	10
267	7	10
267	8	10
267	9	10
267	10	10
267	11	0
267	12	0
267	13	0
267	14	0
267	16	0
267	17	10
268	1	10
268	2	10
268	3	10
268	4	10
268	5	10
268	6	10
268	7	10
268	8	10
268	9	10
268	10	10
268	11	0
268	12	0
268	13	0
268	14	0
268	16	0
268	17	10
269	1	10
269	2	10
269	3	10
269	4	10
269	5	10
269	6	10
269	7	10
269	8	10
269	9	10
269	10	10
269	11	0
269	12	0
269	13	0
269	14	0
269	16	0
269	17	10
270	1	10
270	2	10
270	3	10
270	4	10
270	5	10
270	6	10
270	7	10
270	8	10
270	9	10
270	10	10
270	11	0
270	12	0
270	13	0
270	14	0
270	16	0
270	17	10
271	1	10
271	2	10
271	3	10
271	4	10
271	5	10
271	6	10
271	7	10
271	8	10
271	9	10
271	10	10
271	11	0
271	12	0
271	13	0
271	14	0
271	16	0
271	17	10
272	1	10
272	2	10
272	3	10
272	4	10
272	5	10
272	6	10
272	7	10
272	8	10
272	9	10
272	10	10
272	11	0
272	12	0
272	13	0
272	14	0
272	16	0
272	17	10
273	1	10
273	2	10
273	3	10
273	4	10
273	5	10
273	6	10
273	7	10
273	8	10
273	9	10
273	10	10
273	11	0
273	12	0
273	13	0
273	14	0
273	16	0
273	17	10
274	1	10
274	2	10
274	3	10
274	4	10
274	5	10
274	6	10
274	7	10
274	8	10
274	9	10
274	10	10
274	11	0
274	12	0
274	13	0
274	14	0
274	16	0
274	17	10
275	1	10
275	2	10
275	3	10
275	4	10
275	5	10
275	6	10
275	7	10
275	8	10
275	9	10
275	10	10
275	11	0
275	12	0
275	13	0
275	14	0
275	16	0
275	17	10
276	1	10
276	2	10
276	3	10
276	4	10
276	5	10
276	6	10
276	7	10
276	8	10
276	9	10
276	10	10
276	11	0
276	12	0
276	13	0
276	14	0
276	16	0
276	17	10
277	1	10
277	2	10
277	3	10
277	4	10
277	5	10
277	6	10
277	7	10
277	8	10
277	9	10
277	10	10
277	11	0
277	12	0
277	13	0
277	14	0
277	16	0
277	17	10
278	1	10
278	2	10
278	3	10
278	4	10
278	5	10
278	6	10
278	7	10
278	8	10
278	9	10
278	10	10
278	11	0
278	12	0
278	13	0
278	14	0
278	16	0
278	17	10
279	1	10
279	2	10
279	3	10
279	4	10
279	5	10
279	6	10
279	7	10
279	8	10
279	9	10
279	10	10
279	11	0
279	12	0
279	13	0
279	14	0
279	16	0
279	17	10
280	1	10
280	2	10
280	3	10
280	4	10
280	5	10
280	6	10
280	7	10
280	8	10
280	9	10
280	10	10
280	11	0
280	12	0
280	13	0
280	14	0
280	16	0
280	17	10
281	1	10
281	2	10
281	3	10
281	4	10
281	5	10
281	6	10
281	7	10
281	8	10
281	9	10
281	10	10
281	11	0
281	12	1
281	13	0
281	14	0
281	15	1
281	16	0
281	17	10
282	1	10
282	2	10
282	3	10
282	4	10
282	5	10
282	6	10
282	7	10
282	8	10
282	9	10
282	10	10
282	11	0
282	12	0
282	13	0
282	14	0
282	16	0
282	17	10
283	1	10
283	2	10
283	3	10
283	4	10
283	5	10
283	6	10
283	7	10
283	8	8
283	9	10
283	10	10
283	11	0
283	12	0
283	13	0
283	14	0
283	16	0
283	17	10
284	1	10
284	2	10
284	3	10
284	4	10
284	5	10
284	6	10
284	7	10
284	8	10
284	9	10
284	10	10
284	11	0
284	12	0
284	13	0
284	14	0
284	16	0
284	17	10
285	1	10
285	2	10
285	3	10
285	4	10
285	5	10
285	6	10
285	7	10
285	8	10
285	9	10
285	10	10
285	11	0
285	12	0
285	13	0
285	14	0
285	16	0
285	17	10
286	1	10
286	2	10
286	3	10
286	4	10
286	5	10
286	6	10
286	7	10
286	8	10
286	9	10
286	10	10
286	11	0
286	12	0
286	13	0
286	14	0
286	16	0
286	17	10
287	1	10
287	2	10
287	3	10
287	4	10
287	5	10
287	6	10
287	7	10
287	8	10
287	9	10
287	10	10
287	11	0
287	12	0
287	13	0
287	14	0
287	16	0
287	17	10
288	1	10
288	2	10
288	3	10
288	4	10
288	5	10
288	6	10
288	7	10
288	8	10
288	9	8
288	10	10
288	11	0
288	12	1
288	13	0
288	14	0
288	15	1
288	16	0
288	17	10
289	1	10
289	2	10
289	3	10
289	4	10
289	5	10
289	6	10
289	7	10
289	8	10
289	9	10
289	10	10
289	11	0
289	12	0
289	13	0
289	14	0
289	16	0
289	17	10
290	1	10
290	2	10
290	3	10
290	4	10
290	5	10
290	6	10
290	7	10
290	8	10
290	9	10
290	10	10
290	11	0
290	12	0
290	13	0
290	14	0
290	16	0
290	17	10
291	1	10
291	2	10
291	3	10
291	4	10
291	5	10
291	6	10
291	7	10
291	8	10
291	9	10
291	10	10
291	11	0
291	12	0
291	13	0
291	14	0
291	16	0
291	17	10
292	1	10
292	2	10
292	3	10
292	4	10
292	5	10
292	6	10
292	7	10
292	8	10
292	9	10
292	10	10
292	11	0
292	12	0
292	13	0
292	14	0
292	16	0
292	17	10
293	1	10
293	2	10
293	3	10
293	4	10
293	5	10
293	6	10
293	7	10
293	8	10
293	9	10
293	10	10
293	11	0
293	12	0
293	13	0
293	14	0
293	16	0
293	17	10
294	1	10
294	2	10
294	3	10
294	4	10
294	5	10
294	6	10
294	7	10
294	8	10
294	9	10
294	10	10
294	11	0
294	12	0
294	13	0
294	14	0
294	16	0
294	17	10
295	1	10
295	2	10
295	3	10
295	4	10
295	5	10
295	6	10
295	7	10
295	8	10
295	9	10
295	10	10
295	11	0
295	12	0
295	13	0
295	14	0
295	16	0
295	17	10
296	1	10
296	2	10
296	3	10
296	4	10
296	5	10
296	6	10
296	7	10
296	8	10
296	9	10
296	10	10
296	11	0
296	12	0
296	13	0
296	14	0
296	16	0
296	17	10
297	1	10
297	2	10
297	3	10
297	4	10
297	5	10
297	6	10
297	7	10
297	8	10
297	9	10
297	10	10
297	11	0
297	12	0
297	13	0
297	14	0
297	16	0
297	17	10
298	1	10
298	2	10
298	3	10
298	4	10
298	5	10
298	6	10
298	7	10
298	8	10
298	9	10
298	10	10
298	11	0
298	12	0
298	13	0
298	14	0
298	16	0
298	17	10
299	1	10
299	2	10
299	3	10
299	4	10
299	5	10
299	6	10
299	7	10
299	8	10
299	9	10
299	10	10
299	11	0
299	12	0
299	13	0
299	14	0
299	16	0
299	17	10
300	1	10
300	2	10
300	3	10
300	4	10
300	5	10
300	6	10
300	7	10
300	8	10
300	9	10
300	10	10
300	11	0
300	12	0
300	13	0
300	14	0
300	16	0
300	17	10
301	1	10
301	2	10
301	3	10
301	4	10
301	5	10
301	6	10
301	7	10
301	8	10
301	9	10
301	10	10
301	11	0
301	12	0
301	13	0
301	14	0
301	16	0
301	17	10
302	1	10
302	2	10
302	3	10
302	4	10
302	5	10
302	6	10
302	7	10
302	8	10
302	9	10
302	10	10
302	11	0
302	12	0
302	13	0
302	14	0
302	16	0
302	17	10
303	1	10
303	2	10
303	3	10
303	4	10
303	5	10
303	6	10
303	7	10
303	8	10
303	9	10
303	10	10
303	11	0
303	12	0
303	13	0
303	14	0
303	16	0
303	17	10
304	1	10
304	2	10
304	3	10
304	4	10
304	5	10
304	6	10
304	7	10
304	8	10
304	9	10
304	10	10
304	11	0
304	12	0
304	13	0
304	14	0
304	16	0
304	17	10
305	1	10
305	2	10
305	3	10
305	4	10
305	5	10
305	6	10
305	7	10
305	8	10
305	9	10
305	10	10
305	11	0
305	12	0
305	13	0
305	14	0
305	16	0
305	17	10
306	1	10
306	2	10
306	3	10
306	4	10
306	5	10
306	6	10
306	7	10
306	8	10
306	9	10
306	10	10
306	11	0
306	12	0
306	13	0
306	14	0
306	16	0
306	17	10
307	1	10
307	2	10
307	3	10
307	4	10
307	5	10
307	6	10
307	7	10
307	8	10
307	9	10
307	10	10
307	11	0
307	12	0
307	13	0
307	14	0
307	16	0
307	17	10
308	1	10
308	2	10
308	3	10
308	4	10
308	5	10
308	6	10
308	7	10
308	8	10
308	9	10
308	10	10
308	11	0
308	12	0
308	13	0
308	14	0
308	16	0
308	17	10
309	1	10
309	2	10
309	3	10
309	4	10
309	5	10
309	6	10
309	7	10
309	8	10
309	9	10
309	10	10
309	11	0
309	12	0
309	13	0
309	14	0
309	16	0
309	17	10
310	1	10
310	2	10
310	3	10
310	4	10
310	5	10
310	6	10
310	7	10
310	8	8
310	9	10
310	10	10
310	11	0
310	12	0
310	13	0
310	14	0
310	16	0
310	17	10
311	1	10
311	2	10
311	3	10
311	4	10
311	5	10
311	6	10
311	7	10
311	8	10
311	9	10
311	10	10
311	11	0
311	12	0
311	13	0
311	14	0
311	16	0
311	17	10
312	1	10
312	2	10
312	3	10
312	4	10
312	5	10
312	6	10
312	7	10
312	8	10
312	9	10
312	10	10
312	11	0
312	12	0
312	13	0
312	14	0
312	16	0
312	17	10
313	1	10
313	2	10
313	3	10
313	4	10
313	5	10
313	6	10
313	7	10
313	8	10
313	9	10
313	10	10
313	11	0
313	12	0
313	13	0
313	14	0
313	16	0
313	17	10
314	1	10
314	2	10
314	3	10
314	4	10
314	5	10
314	6	10
314	7	10
314	8	10
314	9	10
314	10	10
314	11	0
314	12	0
314	13	0
314	14	0
314	16	0
314	17	10
315	1	10
315	2	10
315	3	10
315	4	10
315	5	10
315	6	10
315	7	10
315	8	10
315	9	10
315	10	10
315	11	0
315	12	0
315	13	0
315	14	0
315	16	0
315	17	10
316	1	10
316	2	10
316	3	10
316	4	10
316	5	10
316	6	10
316	7	10
316	8	10
316	9	10
316	10	10
316	11	0
316	12	0
316	13	0
316	14	0
316	16	0
316	17	10
317	1	10
317	2	10
317	3	10
317	4	10
317	5	10
317	6	10
317	7	10
317	8	10
317	9	10
317	10	10
317	11	0
317	12	0
317	13	0
317	14	0
317	16	0
317	17	10
318	1	10
318	2	10
318	3	10
318	4	10
318	5	10
318	6	10
318	7	10
318	8	10
318	9	10
318	10	10
318	11	0
318	12	0
318	13	0
318	14	0
318	16	0
318	17	10
319	1	10
319	2	10
319	3	10
319	4	10
319	5	10
319	6	10
319	7	10
319	8	10
319	9	10
319	10	10
319	11	0
319	12	0
319	13	0
319	14	0
319	16	0
319	17	10
320	1	10
320	2	10
320	3	10
320	4	10
320	5	10
320	6	10
320	7	10
320	8	10
320	9	10
320	10	10
320	11	0
320	12	0
320	13	0
320	14	0
320	16	0
320	17	10
321	1	10
321	2	10
321	3	10
321	4	10
321	5	10
321	6	10
321	7	10
321	8	10
321	9	10
321	10	10
321	11	0
321	12	0
321	13	0
321	14	0
321	16	0
321	17	10
323	1	10
323	2	10
323	3	10
323	4	10
323	5	10
323	6	10
323	7	10
323	8	10
323	9	10
323	10	10
323	11	0
323	12	0
323	13	0
323	14	0
323	16	0
323	17	10
324	1	10
324	2	10
324	3	10
324	4	10
324	5	10
324	6	10
324	7	10
324	8	10
324	9	10
324	10	10
324	11	0
324	12	0
324	13	0
324	14	0
324	16	0
324	17	10
325	1	10
325	2	10
325	3	10
325	4	10
325	5	10
325	6	10
325	7	10
325	8	10
325	9	10
325	10	10
325	11	0
325	12	0
325	13	0
325	14	0
325	16	0
325	17	10
326	1	10
326	2	10
326	3	10
326	4	10
326	5	10
326	6	10
326	7	10
326	8	10
326	9	10
326	10	10
326	11	0
326	12	0
326	13	0
326	14	0
326	16	0
326	17	10
327	1	10
327	2	10
327	3	10
327	4	10
327	5	10
327	6	10
327	7	10
327	8	10
327	9	10
327	10	10
327	11	0
327	12	0
327	13	0
327	14	0
327	16	0
327	17	10
328	1	10
328	2	10
328	3	10
328	4	10
328	5	10
328	6	10
328	7	10
328	8	10
328	9	10
328	10	10
328	11	0
328	12	0
328	13	0
328	14	0
328	16	0
328	17	10
329	1	10
329	2	10
329	3	10
329	4	10
329	5	10
329	6	10
329	7	10
329	8	10
329	9	10
329	10	10
329	11	0
329	12	0
329	13	0
329	14	0
329	16	0
329	17	10
330	1	10
330	2	10
330	3	10
330	4	10
330	5	10
330	6	10
330	7	10
330	8	10
330	9	10
330	10	10
330	11	0
330	12	0
330	13	0
330	14	0
330	16	0
330	17	10
331	1	10
331	2	10
331	3	10
331	4	10
331	5	10
331	6	10
331	7	10
331	8	10
331	9	10
331	10	10
331	11	0
331	12	0
331	13	0
331	14	0
331	16	0
331	17	10
332	1	10
332	2	10
332	3	10
332	4	10
332	5	10
332	6	10
332	7	10
332	8	10
332	9	10
332	10	10
332	11	0
332	12	0
332	13	0
332	14	0
332	16	0
332	17	10
333	1	10
333	2	10
333	3	10
333	4	10
333	5	10
333	6	10
333	7	10
333	8	10
333	9	10
333	10	10
333	11	0
333	12	0
333	13	0
333	14	0
333	16	0
333	17	10
334	1	10
334	2	10
334	3	10
334	4	10
334	5	10
334	6	10
334	7	10
334	8	10
334	9	10
334	10	10
334	11	0
334	12	0
334	13	0
334	14	0
334	16	0
334	17	10
335	1	10
335	2	10
335	3	10
335	4	10
335	5	10
335	6	10
335	7	10
335	8	10
335	9	10
335	10	10
335	11	0
335	12	0
335	13	0
335	14	0
335	16	0
335	17	10
336	1	10
336	2	10
336	3	10
336	4	10
336	5	10
336	6	10
336	7	10
336	8	10
336	9	10
336	10	10
336	11	0
336	12	0
336	13	0
336	14	0
336	16	0
336	17	10
337	1	10
337	2	10
337	3	10
337	4	10
337	5	10
337	6	10
337	7	10
337	8	10
337	9	10
337	10	10
337	11	0
337	12	0
337	13	0
337	14	0
337	16	0
337	17	10
338	1	10
338	2	10
338	3	10
338	4	10
338	5	10
338	6	10
338	7	10
338	8	10
338	9	10
338	10	10
338	11	1
338	12	0
338	13	0
338	14	0
338	15	1
338	16	0
338	17	10
339	1	10
339	2	10
339	3	10
339	4	10
339	5	10
339	6	10
339	7	10
339	8	10
339	9	10
339	10	10
339	11	0
339	12	0
339	13	0
339	14	0
339	16	0
339	17	10
340	1	10
340	2	10
340	3	10
340	4	10
340	5	10
340	6	10
340	7	10
340	8	10
340	9	10
340	10	10
340	11	0
340	12	0
340	13	0
340	14	0
340	16	0
340	17	10
341	1	10
341	2	10
341	3	10
341	4	10
341	5	10
341	6	10
341	7	10
341	8	10
341	9	10
341	10	10
341	11	0
341	12	0
341	13	0
341	14	0
341	16	0
341	17	10
342	1	10
342	2	10
342	3	10
342	4	10
342	5	10
342	6	10
342	7	10
342	8	10
342	9	10
342	10	10
342	11	0
342	12	0
342	13	0
342	14	0
342	16	0
342	17	10
343	1	10
343	2	10
343	3	10
343	4	10
343	5	10
343	6	10
343	7	10
343	8	10
343	9	10
343	10	10
343	11	0
343	12	0
343	13	0
343	14	0
343	16	0
343	17	10
344	1	10
344	2	10
344	3	10
344	4	10
344	5	10
344	6	10
344	7	10
344	8	10
344	9	10
344	10	10
344	11	0
344	12	0
344	13	0
344	14	0
344	16	0
344	17	10
345	1	10
345	2	10
345	3	10
345	4	10
345	5	10
345	6	10
345	7	10
345	8	10
345	9	10
345	10	10
345	11	0
345	12	0
345	13	0
345	14	0
345	16	0
345	17	10
346	1	10
346	2	10
346	3	10
346	4	10
346	5	10
346	6	10
346	7	10
346	8	10
346	9	10
346	10	10
346	11	0
346	12	0
346	13	0
346	14	0
346	16	0
346	17	10
347	1	10
347	2	10
347	3	10
347	4	10
347	5	10
347	6	10
347	7	10
347	8	10
347	9	10
347	10	10
347	11	0
347	12	0
347	13	0
347	14	0
347	16	0
347	17	10
348	1	10
348	2	10
348	3	10
348	4	10
348	5	10
348	6	10
348	7	10
348	8	10
348	9	10
348	10	10
348	11	0
348	12	0
348	13	0
348	14	0
348	16	0
348	17	10
349	1	10
349	2	10
349	3	10
349	4	10
349	5	10
349	6	10
349	7	10
349	8	10
349	9	10
349	10	10
349	11	0
349	12	0
349	13	0
349	14	0
349	16	0
349	17	10
350	1	10
350	2	10
350	3	10
350	4	10
350	5	10
350	6	10
350	7	10
350	8	10
350	9	10
350	10	10
350	11	0
350	12	0
350	13	0
350	14	0
350	16	0
350	17	10
351	1	10
351	2	10
351	3	10
351	4	10
351	5	10
351	6	10
351	7	10
351	8	10
351	9	10
351	10	10
351	11	0
351	12	0
351	13	0
351	14	0
351	16	0
351	17	10
352	1	10
352	2	10
352	3	10
352	4	10
352	5	10
352	6	10
352	7	10
352	8	10
352	9	10
352	10	10
352	11	0
352	12	0
352	13	0
352	14	0
352	16	0
352	17	10
353	1	10
353	2	10
353	3	10
353	4	10
353	5	10
353	6	10
353	7	10
353	8	10
353	9	10
353	10	10
353	11	0
353	12	0
353	13	0
353	14	0
353	16	0
353	17	10
354	1	10
354	2	10
354	3	10
354	4	10
354	5	10
354	6	10
354	7	10
354	8	10
354	9	10
354	10	10
354	11	0
354	12	0
354	13	0
354	14	0
354	16	0
354	17	10
355	1	10
355	2	10
355	3	10
355	4	10
355	5	10
355	6	10
355	7	10
355	8	10
355	9	10
355	10	10
355	11	0
355	12	0
355	13	0
355	14	0
355	16	0
355	17	10
356	1	10
356	2	10
356	3	10
356	4	10
356	5	10
356	6	10
356	7	10
356	8	10
356	9	10
356	10	10
356	11	0
356	12	0
356	13	0
356	14	0
356	16	0
356	17	10
357	1	10
357	2	10
357	3	10
357	4	10
357	5	10
357	6	10
357	7	10
357	8	10
357	9	10
357	10	10
357	11	0
357	12	0
357	13	0
357	14	0
357	16	0
357	17	10
358	1	10
358	2	10
358	3	10
358	4	10
358	5	10
358	6	10
358	7	10
358	8	10
358	9	10
358	10	10
358	11	0
358	12	0
358	13	0
358	14	0
358	16	0
358	17	10
360	1	10
360	2	10
360	3	10
360	4	10
360	5	10
360	6	10
360	7	10
360	8	10
360	9	10
360	10	10
360	11	0
360	12	0
360	13	0
360	14	0
360	16	0
360	17	10
361	1	10
361	2	10
361	3	10
361	4	10
361	5	10
361	6	10
361	7	10
361	8	10
361	9	10
361	10	10
361	11	0
361	12	0
361	13	0
361	14	0
361	16	0
361	17	10
362	1	10
362	2	10
362	3	10
362	4	10
362	5	10
362	6	10
362	7	10
362	8	10
362	9	10
362	10	10
362	11	0
362	12	0
362	13	0
362	14	0
362	16	0
362	17	10
363	1	10
363	2	10
363	3	10
363	4	10
363	5	10
363	6	10
363	7	10
363	8	10
363	9	10
363	10	10
363	11	0
363	12	0
363	13	0
363	14	0
363	16	0
363	17	10
364	1	10
364	2	10
364	3	10
364	4	10
364	5	10
364	6	10
364	7	10
364	8	10
364	9	10
364	10	10
364	11	0
364	12	0
364	13	0
364	14	0
364	16	0
364	17	10
365	1	10
365	2	10
365	3	10
365	4	10
365	5	10
365	6	10
365	7	10
365	8	10
365	9	10
365	10	10
365	11	0
365	12	0
365	13	0
365	14	0
365	16	0
365	17	10
366	1	10
366	2	10
366	3	10
366	4	8
366	5	10
366	6	10
366	7	10
366	8	10
366	9	8
366	10	10
366	11	0
366	12	1
366	13	0
366	14	0
366	15	1
366	16	0
366	17	10
367	1	10
367	2	10
367	3	10
367	4	10
367	5	10
367	6	10
367	7	10
367	8	10
367	9	10
367	10	10
367	11	0
367	12	0
367	13	0
367	14	0
367	16	0
367	17	10
368	1	10
368	2	10
368	3	10
368	4	10
368	5	10
368	6	10
368	7	10
368	8	10
368	9	10
368	10	10
368	11	0
368	12	0
368	13	0
368	14	0
368	16	0
368	17	10
369	1	10
369	2	10
369	3	10
369	4	10
369	5	10
369	6	10
369	7	10
369	8	10
369	9	10
369	10	10
369	11	0
369	12	0
369	13	0
369	14	0
369	16	0
369	17	10
370	1	10
370	2	10
370	3	10
370	4	10
370	5	10
370	6	10
370	7	10
370	8	10
370	9	10
370	10	10
370	11	0
370	12	0
370	13	0
370	14	0
370	16	0
370	17	10
371	1	10
371	2	10
371	3	10
371	4	10
371	5	10
371	6	10
371	7	10
371	8	10
371	9	10
371	10	10
371	11	0
371	12	0
371	13	0
371	14	0
371	16	0
371	17	10
372	1	10
372	2	10
372	3	10
372	4	10
372	5	10
372	6	10
372	7	10
372	8	10
372	9	10
372	10	10
372	11	0
372	12	0
372	13	0
372	14	0
372	16	0
372	17	10
373	1	10
373	2	10
373	3	10
373	4	10
373	5	10
373	6	10
373	7	10
373	8	10
373	9	10
373	10	10
373	11	0
373	12	0
373	13	0
373	14	0
373	16	0
373	17	10
374	1	10
374	2	10
374	3	10
374	4	10
374	5	10
374	6	10
374	7	10
374	8	10
374	9	10
374	10	10
374	11	0
374	12	0
374	13	0
374	14	0
374	16	0
374	17	10
375	1	10
375	2	10
375	3	10
375	4	10
375	5	10
375	6	10
375	7	10
375	8	10
375	9	10
375	10	10
375	11	0
375	12	0
375	13	0
375	14	0
375	16	0
375	17	10
376	1	10
376	2	10
376	3	10
376	4	10
376	5	10
376	6	10
376	7	10
376	8	10
376	9	10
376	10	10
376	11	0
376	12	0
376	13	0
376	14	0
376	16	0
376	17	10
377	1	10
377	2	10
377	3	10
377	4	10
377	5	10
377	6	10
377	7	10
377	8	10
377	9	10
377	10	10
377	11	0
377	12	0
377	13	0
377	14	0
377	16	0
377	17	10
378	1	10
378	2	10
378	3	10
378	4	10
378	5	10
378	6	10
378	7	10
378	8	10
378	9	10
378	10	10
378	11	0
378	12	0
378	13	0
378	14	0
378	16	0
378	17	10
379	1	10
379	2	10
379	3	10
379	4	10
379	5	10
379	6	10
379	7	10
379	8	10
379	9	10
379	10	10
379	11	0
379	12	0
379	13	0
379	14	0
379	16	0
379	17	10
380	1	10
380	2	10
380	3	10
380	4	10
380	5	10
380	6	10
380	7	10
380	8	10
380	9	10
380	10	10
380	11	0
380	12	0
380	13	0
380	14	0
380	16	0
380	17	10
381	1	10
381	2	10
381	3	10
381	4	10
381	5	10
381	6	10
381	7	10
381	8	10
381	9	10
381	10	10
381	11	0
381	12	0
381	13	0
381	14	0
381	16	0
381	17	10
382	1	10
382	2	10
382	3	10
382	4	10
382	5	10
382	6	10
382	7	10
382	8	10
382	9	10
382	10	10
382	11	0
382	12	0
382	13	0
382	14	0
382	16	0
382	17	10
383	1	10
383	2	10
383	3	10
383	4	10
383	5	10
383	6	10
383	7	10
383	8	10
383	9	10
383	10	10
383	11	0
383	12	0
383	13	0
383	14	0
383	16	0
383	17	10
384	1	10
384	2	10
384	3	10
384	4	10
384	5	10
384	6	10
384	7	10
384	8	10
384	9	10
384	10	10
384	11	0
384	12	0
384	13	0
384	14	0
384	16	0
384	17	10
385	1	10
385	2	10
385	3	10
385	4	10
385	5	10
385	6	10
385	7	10
385	8	10
385	9	10
385	10	10
385	11	0
385	12	0
385	13	0
385	14	0
385	16	0
385	17	10
386	1	10
386	2	10
386	3	10
386	4	10
386	5	10
386	6	10
386	7	10
386	8	10
386	9	10
386	10	10
386	11	0
386	12	0
386	13	0
386	14	0
386	16	0
386	17	10
387	1	10
387	2	10
387	3	10
387	4	10
387	5	10
387	6	10
387	7	10
387	8	10
387	9	10
387	10	10
387	11	0
387	12	0
387	13	0
387	14	0
387	16	0
387	17	10
388	1	10
388	2	10
388	3	10
388	4	10
388	5	10
388	6	10
388	7	10
388	8	10
388	9	10
388	10	10
388	11	0
388	12	0
388	13	0
388	14	0
388	16	0
388	17	10
389	1	10
389	2	10
389	3	10
389	4	10
389	5	10
389	6	10
389	7	10
389	8	10
389	9	10
389	10	10
389	11	0
389	12	0
389	13	0
389	14	0
389	16	0
389	17	10
390	1	10
390	2	10
390	3	10
390	4	10
390	5	10
390	6	10
390	7	10
390	8	10
390	9	8
390	10	10
390	11	0
390	12	0
390	13	0
390	14	0
390	16	0
390	17	10
391	1	10
391	2	10
391	3	10
391	4	10
391	5	10
391	6	10
391	7	10
391	8	10
391	9	8
391	10	10
391	11	0
391	12	1
391	13	0
391	14	0
391	15	1
391	16	0
391	17	10
392	1	10
392	2	10
392	3	10
392	4	10
392	5	10
392	6	10
392	7	10
392	8	10
392	9	10
392	10	10
392	11	0
392	12	0
392	13	0
392	14	0
392	16	0
392	17	10
393	1	10
393	2	10
393	3	10
393	4	10
393	5	10
393	6	10
393	7	10
393	8	10
393	9	10
393	10	10
393	11	0
393	12	0
393	13	0
393	14	0
393	16	0
393	17	10
394	1	10
394	2	10
394	3	10
394	4	10
394	5	10
394	6	10
394	7	10
394	8	10
394	9	10
394	10	10
394	11	0
394	12	0
394	13	0
394	14	0
394	16	0
394	17	10
395	1	10
395	2	10
395	3	10
395	4	10
395	5	10
395	6	10
395	7	10
395	8	10
395	9	10
395	10	10
395	11	0
395	12	0
395	13	0
395	14	0
395	16	0
395	17	10
396	1	10
396	2	10
396	3	10
396	4	10
396	5	10
396	6	10
396	7	10
396	8	10
396	9	10
396	10	10
396	11	0
396	12	0
396	13	0
396	14	0
396	16	0
396	17	10
397	1	10
397	2	10
397	3	10
397	4	10
397	5	10
397	6	10
397	7	10
397	8	10
397	9	10
397	10	10
397	11	0
397	12	0
397	13	0
397	14	0
397	16	0
397	17	10
398	1	10
398	2	10
398	3	10
398	4	10
398	5	10
398	6	10
398	7	10
398	8	10
398	9	10
398	10	10
398	11	0
398	12	0
398	13	0
398	14	0
398	16	0
398	17	10
399	1	10
399	2	10
399	3	10
399	4	10
399	5	10
399	6	10
399	7	10
399	8	10
399	9	10
399	10	10
399	11	0
399	12	0
399	13	0
399	14	0
399	16	0
399	17	10
400	1	10
400	2	10
400	3	10
400	4	10
400	5	10
400	6	10
400	7	10
400	8	10
400	9	10
400	10	10
400	11	0
400	12	0
400	13	0
400	14	0
400	16	0
400	17	10
401	1	10
401	2	10
401	3	10
401	4	10
401	5	10
401	6	10
401	7	10
401	8	10
401	9	10
401	10	10
401	11	0
401	12	0
401	13	0
401	14	0
401	16	0
401	17	10
402	1	10
402	2	10
402	3	10
402	4	10
402	5	10
402	6	10
402	7	10
402	8	10
402	9	10
402	10	10
402	11	0
402	12	0
402	13	0
402	14	0
402	16	0
402	17	10
403	1	10
403	2	10
403	3	10
403	4	10
403	5	10
403	6	10
403	7	10
403	8	10
403	9	10
403	10	10
403	11	0
403	12	0
403	13	0
403	14	0
403	16	0
403	17	10
404	1	10
404	2	10
404	3	10
404	4	10
404	5	10
404	6	10
404	7	10
404	8	10
404	9	10
404	10	10
404	11	0
404	12	0
404	13	0
404	14	0
404	16	0
404	17	10
405	1	10
405	2	10
405	3	10
405	4	10
405	5	10
405	6	10
405	7	10
405	8	10
405	9	10
405	10	10
405	11	0
405	12	0
405	13	0
405	14	0
405	16	0
405	17	10
406	1	10
406	2	10
406	3	10
406	4	10
406	5	10
406	6	10
406	7	10
406	8	10
406	9	10
406	10	10
406	11	0
406	12	0
406	13	0
406	14	0
406	16	0
406	17	10
407	1	10
407	2	10
407	3	10
407	4	10
407	5	10
407	6	10
407	7	10
407	8	10
407	9	10
407	10	10
407	11	0
407	12	0
407	13	0
407	14	0
407	16	0
407	17	10
408	1	10
408	2	10
408	3	10
408	4	10
408	5	10
408	6	10
408	7	10
408	8	10
408	9	10
408	10	10
408	11	0
408	12	0
408	13	0
408	14	0
408	16	0
408	17	10
409	1	10
409	2	10
409	3	10
409	4	10
409	5	10
409	6	10
409	7	10
409	8	10
409	9	10
409	10	10
409	11	0
409	12	0
409	13	0
409	14	0
409	16	0
409	17	10
411	1	10
411	2	10
411	3	10
411	4	10
411	5	10
411	6	10
411	7	10
411	8	8
411	9	10
411	10	10
411	11	0
411	12	0
411	13	0
411	14	0
411	16	0
411	17	10
412	1	10
412	2	10
412	3	10
412	4	8
412	5	10
412	6	10
412	7	10
412	8	10
412	9	10
412	10	10
412	11	0
412	12	0
412	13	0
412	14	0
412	16	0
412	17	10
414	1	10
414	2	10
414	3	10
414	4	10
414	5	10
414	6	10
414	7	10
414	8	10
414	9	10
414	10	10
414	11	0
414	12	0
414	13	0
414	14	0
414	16	0
414	17	10
415	1	10
415	2	10
415	3	10
415	4	10
415	5	10
415	6	10
415	7	10
415	8	10
415	9	10
415	10	10
415	11	0
415	12	0
415	13	0
415	14	0
415	16	0
415	17	10
416	1	10
416	2	10
416	3	10
416	4	10
416	5	10
416	6	10
416	7	10
416	8	8
416	9	10
416	10	10
416	11	0
416	12	0
416	13	0
416	14	0
416	16	0
416	17	10
417	1	10
417	2	10
417	3	10
417	4	10
417	5	10
417	6	10
417	7	10
417	8	10
417	9	10
417	10	10
417	11	0
417	12	0
417	13	0
417	14	0
417	16	0
417	17	10
418	1	10
418	2	10
418	3	10
418	4	10
418	5	10
418	6	10
418	7	10
418	8	8
418	9	10
418	10	10
418	11	0
418	12	0
418	13	0
418	14	0
418	16	0
418	17	10
419	1	10
419	2	10
419	3	10
419	4	10
419	5	10
419	6	10
419	7	10
419	8	10
419	9	10
419	10	10
419	11	0
419	12	0
419	13	0
419	14	0
419	16	0
419	17	10
420	1	10
420	2	10
420	3	10
420	4	10
420	5	10
420	6	10
420	7	10
420	8	10
420	9	10
420	10	10
420	11	0
420	12	0
420	13	0
420	14	0
420	16	0
420	17	10
421	1	10
421	2	10
421	3	10
421	4	10
421	5	10
421	6	10
421	7	10
421	8	10
421	9	10
421	10	10
421	11	0
421	12	0
421	13	0
421	14	0
421	16	0
421	17	10
422	1	10
422	2	10
422	3	10
422	4	10
422	5	10
422	6	10
422	7	10
422	8	10
422	9	10
422	10	10
422	11	0
422	12	0
422	13	0
422	14	0
422	16	0
422	17	10
423	1	10
423	2	10
423	3	10
423	4	10
423	5	10
423	6	10
423	7	10
423	8	10
423	9	10
423	10	10
423	11	0
423	12	0
423	13	0
423	14	0
423	16	0
423	17	10
425	1	10
425	2	10
425	3	10
425	4	10
425	5	10
425	6	10
425	7	10
425	8	10
425	9	10
425	10	10
425	11	0
425	12	0
425	13	0
425	14	0
425	16	0
425	17	10
426	1	10
426	2	10
426	3	10
426	4	10
426	5	10
426	6	10
426	7	10
426	8	10
426	9	10
426	10	10
426	11	0
426	12	0
426	13	0
426	14	0
426	16	0
426	17	10
427	1	10
427	2	10
427	3	10
427	4	10
427	5	10
427	6	10
427	7	10
427	8	10
427	9	10
427	10	10
427	11	0
427	12	0
427	13	0
427	14	0
427	16	0
427	17	10
428	1	10
428	2	10
428	3	10
428	4	10
428	5	10
428	6	10
428	7	10
428	8	10
428	9	10
428	10	10
428	11	0
428	12	0
428	13	0
428	14	0
428	16	0
428	17	10
429	1	10
429	2	10
429	3	10
429	4	10
429	5	10
429	6	10
429	7	10
429	8	10
429	9	10
429	10	10
429	11	0
429	12	0
429	13	0
429	14	0
429	16	0
429	17	10
430	1	10
430	2	10
430	3	10
430	4	10
430	5	10
430	6	10
430	7	10
430	8	10
430	9	10
430	10	10
430	11	0
430	12	0
430	13	0
430	14	0
430	16	0
430	17	10
431	1	10
431	2	10
431	3	10
431	4	10
431	5	10
431	6	10
431	7	10
431	8	10
431	9	10
431	10	10
431	11	0
431	12	0
431	13	0
431	14	0
431	16	0
431	17	10
432	1	10
432	2	10
432	3	10
432	4	10
432	5	10
432	6	10
432	7	10
432	8	10
432	9	10
432	10	10
432	11	0
432	12	0
432	13	0
432	14	0
432	16	0
432	17	10
435	1	10
435	2	10
435	3	10
435	4	10
435	5	10
435	6	10
435	7	10
435	8	10
435	9	10
435	10	10
435	11	0
435	12	0
435	13	0
435	14	0
435	16	0
435	17	10
436	1	10
436	2	10
436	3	10
436	4	10
436	5	10
436	6	10
436	7	10
436	8	10
436	9	10
436	10	10
436	11	0
436	12	0
436	13	0
436	14	0
436	16	0
436	17	10
437	1	10
437	2	10
437	3	10
437	4	10
437	5	10
437	6	10
437	7	10
437	8	10
437	9	10
437	10	10
437	11	0
437	12	0
437	13	0
437	14	0
437	16	0
437	17	10
438	1	10
438	2	10
438	3	10
438	4	10
438	5	10
438	6	10
438	7	10
438	8	10
438	9	10
438	10	10
438	11	0
438	12	0
438	13	0
438	14	0
438	16	0
438	17	10
441	1	10
441	2	10
441	3	10
441	4	10
441	5	10
441	6	10
441	7	10
441	8	10
441	9	10
441	10	10
441	11	0
441	12	0
441	13	0
441	14	0
441	16	0
441	17	10
443	1	10
443	2	10
443	3	10
443	4	10
443	5	10
443	6	10
443	7	10
443	8	10
443	9	10
443	10	10
443	11	0
443	12	0
443	13	0
443	14	0
443	16	0
443	17	10
444	1	10
444	2	10
444	3	10
444	4	10
444	5	10
444	6	10
444	7	10
444	8	10
444	9	10
444	10	10
444	11	0
444	12	0
444	13	0
444	14	0
444	16	0
444	17	10
445	1	10
445	2	10
445	3	10
445	4	10
445	5	10
445	6	10
445	7	10
445	8	10
445	9	10
445	10	10
445	11	0
445	12	1
445	13	0
445	14	0
445	15	1
445	16	0
445	17	10
446	1	10
446	2	10
446	3	10
446	4	10
446	5	10
446	6	10
446	7	10
446	8	10
446	9	10
446	10	10
446	11	0
446	12	0
446	13	0
446	14	0
446	16	0
446	17	10
447	1	10
447	2	10
447	3	10
447	4	10
447	5	10
447	6	10
447	7	10
447	8	10
447	9	10
447	10	10
447	11	0
447	12	0
447	13	0
447	14	0
447	16	0
447	17	10
448	1	10
448	2	10
448	3	10
448	4	10
448	5	10
448	6	10
448	7	10
448	8	10
448	9	10
448	10	10
448	11	0
448	12	0
448	13	0
448	14	0
448	16	0
448	17	10
449	1	10
449	2	10
449	3	10
449	4	10
449	5	10
449	6	10
449	7	10
449	8	10
449	9	10
449	10	10
449	11	0
449	12	0
449	13	0
449	14	0
449	16	0
449	17	10
450	1	10
450	2	10
450	3	10
450	4	10
450	5	10
450	6	10
450	7	10
450	8	10
450	9	10
450	10	10
450	11	0
450	12	0
450	13	0
450	14	0
450	16	0
450	17	10
451	1	10
451	2	10
451	3	10
451	4	10
451	5	10
451	6	10
451	7	10
451	8	10
451	9	10
451	10	10
451	11	0
451	12	0
451	13	0
451	14	0
451	16	0
451	17	10
452	1	10
452	2	10
452	3	10
452	4	10
452	5	10
452	6	10
452	7	10
452	8	10
452	9	10
452	10	10
452	11	0
452	12	0
452	13	0
452	14	0
452	16	0
452	17	10
453	1	10
453	2	10
453	3	10
453	4	10
453	5	10
453	6	10
453	7	10
453	8	10
453	9	10
453	10	10
453	11	0
453	12	0
453	13	0
453	14	0
453	16	0
453	17	10
454	1	10
454	2	10
454	3	10
454	4	10
454	5	10
454	6	10
454	7	10
454	8	10
454	9	10
454	10	10
454	11	0
454	12	0
454	13	0
454	14	0
454	16	0
454	17	10
456	1	10
456	2	10
456	3	10
456	4	10
456	5	10
456	6	10
456	7	10
456	8	10
456	9	10
456	10	10
456	11	0
456	12	0
456	13	0
456	14	0
456	16	0
456	17	10
457	1	10
457	2	10
457	3	10
457	4	10
457	5	10
457	6	10
457	7	10
457	8	10
457	9	10
457	10	10
457	11	0
457	12	0
457	13	0
457	14	0
457	16	0
457	17	10
458	1	10
458	2	10
458	3	10
458	4	10
458	5	10
458	6	10
458	7	10
458	8	10
458	9	10
458	10	10
458	11	0
458	12	0
458	13	0
458	14	0
458	16	0
458	17	10
459	1	10
459	2	10
459	3	10
459	4	10
459	5	10
459	6	10
459	7	10
459	8	10
459	9	10
459	10	10
459	11	0
459	12	0
459	13	0
459	14	0
459	16	0
459	17	10
460	1	10
460	2	10
460	3	10
460	4	10
460	5	10
460	6	10
460	7	10
460	8	10
460	9	10
460	10	10
460	11	0
460	12	0
460	13	0
460	14	0
460	16	0
460	17	10
462	1	10
462	2	10
462	3	10
462	4	10
462	5	10
462	6	10
462	7	10
462	8	6
462	9	8
462	10	8
462	11	0
462	12	0
462	13	0
462	14	0
462	16	0
462	17	8
463	1	10
463	2	10
463	3	10
463	4	10
463	5	10
463	6	10
463	7	10
463	8	8
463	9	8
463	10	10
463	11	0
463	12	0
463	13	0
463	14	0
463	16	0
463	17	8
464	1	10
464	2	10
464	3	10
464	4	10
464	5	10
464	6	10
464	7	10
464	8	10
464	9	10
464	10	10
464	11	0
464	12	0
464	13	0
464	14	0
464	16	0
464	17	10
465	1	10
465	2	10
465	3	10
465	4	10
465	5	10
465	6	10
465	7	10
465	8	10
465	9	10
465	10	10
465	11	0
465	12	0
465	13	0
465	14	0
465	16	0
465	17	10
466	1	10
466	2	10
466	3	10
466	4	10
466	5	10
466	6	10
466	7	10
466	8	10
466	9	10
466	10	10
466	11	0
466	12	0
466	13	0
466	14	0
466	16	0
466	17	10
467	1	10
467	2	10
467	3	10
467	4	10
467	5	10
467	6	10
467	7	10
467	8	10
467	9	10
467	10	10
467	11	0
467	12	0
467	13	0
467	14	0
467	16	0
467	17	10
468	1	10
468	2	10
468	3	10
468	4	10
468	5	10
468	6	10
468	7	10
468	8	10
468	9	10
468	10	10
468	11	0
468	12	0
468	13	0
468	14	0
468	16	0
468	17	10
469	1	10
469	2	10
469	3	10
469	4	10
469	5	10
469	6	10
469	7	10
469	8	10
469	9	10
469	10	10
469	11	0
469	12	0
469	13	0
469	14	0
469	16	0
469	17	10
470	1	10
470	2	10
470	3	10
470	4	10
470	5	10
470	6	10
470	7	10
470	8	10
470	9	10
470	10	10
470	11	0
470	12	0
470	13	0
470	14	0
470	16	0
470	17	10
471	1	10
471	2	10
471	3	10
471	4	10
471	5	10
471	6	10
471	7	10
471	8	10
471	9	10
471	10	10
471	11	0
471	12	0
471	13	0
471	14	0
471	16	0
471	17	10
472	1	10
472	2	10
472	3	10
472	4	10
472	5	10
472	6	10
472	7	10
472	8	10
472	9	10
472	10	10
472	11	0
472	12	0
472	13	0
472	14	0
472	16	0
472	17	10
473	1	10
473	2	10
473	3	10
473	4	10
473	5	10
473	6	10
473	7	10
473	8	10
473	9	10
473	10	10
473	11	0
473	12	0
473	13	0
473	14	0
473	16	0
473	17	10
474	1	10
474	2	10
474	3	10
474	4	10
474	5	10
474	6	10
474	7	10
474	8	10
474	9	10
474	10	10
474	11	0
474	12	0
474	13	0
474	14	0
474	16	0
474	17	10
475	1	10
475	2	10
475	3	10
475	4	10
475	5	10
475	6	10
475	7	10
475	8	10
475	9	10
475	10	10
475	11	0
475	12	0
475	13	0
475	14	0
475	16	0
475	17	10
476	1	10
476	2	10
476	3	10
476	4	10
476	5	10
476	6	10
476	7	10
476	8	10
476	9	10
476	10	10
476	11	0
476	12	0
476	13	0
476	14	0
476	16	0
476	17	10
477	1	10
477	2	10
477	3	10
477	4	10
477	5	10
477	6	10
477	7	10
477	8	10
477	9	10
477	10	10
477	11	0
477	12	0
477	13	0
477	14	0
477	16	0
477	17	10
478	1	10
478	2	10
478	3	10
478	4	10
478	5	10
478	6	10
478	7	10
478	8	10
478	9	10
478	10	10
478	11	0
478	12	0
478	13	0
478	14	0
478	16	0
478	17	10
479	1	10
479	2	10
479	3	10
479	4	10
479	5	10
479	6	10
479	7	10
479	8	10
479	9	10
479	10	10
479	11	0
479	12	0
479	13	0
479	14	0
479	16	0
479	17	10
480	1	10
480	2	10
480	3	10
480	4	10
480	5	10
480	6	10
480	7	10
480	8	10
480	9	10
480	10	10
480	11	0
480	12	0
480	13	0
480	14	0
480	16	0
480	17	10
481	1	10
481	2	10
481	3	10
481	4	10
481	5	10
481	6	10
481	7	10
481	8	10
481	9	10
481	10	10
481	11	0
481	12	0
481	13	0
481	14	0
481	16	0
481	17	10
482	1	10
482	2	10
482	3	10
482	4	10
482	5	10
482	6	10
482	7	10
482	8	10
482	9	10
482	10	10
482	11	0
482	12	0
482	13	0
482	14	0
482	16	0
482	17	10
483	1	10
483	2	10
483	3	10
483	4	10
483	5	10
483	6	10
483	7	10
483	8	10
483	9	10
483	10	10
483	11	0
483	12	0
483	13	0
483	14	0
483	16	0
483	17	10
484	1	10
484	2	10
484	3	10
484	4	10
484	5	10
484	6	10
484	7	10
484	8	10
484	9	10
484	10	10
484	11	0
484	12	0
484	13	0
484	14	0
484	16	0
484	17	10
485	1	10
485	2	10
485	3	10
485	4	10
485	5	10
485	6	10
485	7	10
485	8	10
485	9	10
485	10	10
485	11	0
485	12	0
485	13	0
485	14	0
485	16	0
485	17	10
486	1	10
486	2	10
486	3	10
486	4	10
486	5	10
486	6	10
486	7	10
486	8	10
486	9	10
486	10	10
486	11	0
486	12	0
486	13	0
486	14	0
486	16	0
486	17	10
487	1	10
487	2	10
487	3	10
487	4	10
487	5	10
487	6	10
487	7	10
487	8	10
487	9	10
487	10	10
487	11	0
487	12	0
487	13	0
487	14	0
487	16	0
487	17	10
488	1	10
488	2	10
488	3	10
488	4	10
488	5	10
488	6	10
488	7	10
488	8	10
488	9	10
488	10	10
488	11	0
488	12	0
488	13	0
488	14	0
488	16	0
488	17	10
489	1	10
489	2	10
489	3	10
489	4	10
489	5	10
489	6	10
489	7	10
489	8	10
489	9	10
489	10	10
489	11	0
489	12	0
489	13	0
489	14	0
489	16	0
489	17	10
490	1	10
490	2	10
490	3	10
490	4	10
490	5	10
490	6	10
490	7	10
490	8	10
490	9	10
490	10	10
490	11	0
490	12	0
490	13	0
490	14	0
490	16	0
490	17	10
491	1	10
491	2	10
491	3	10
491	4	10
491	5	10
491	6	10
491	7	10
491	8	10
491	9	10
491	10	10
491	11	0
491	12	0
491	13	0
491	14	0
491	16	0
491	17	10
492	1	10
492	2	10
492	3	10
492	4	10
492	5	10
492	6	10
492	7	10
492	8	10
492	9	10
492	10	10
492	11	0
492	12	0
492	13	0
492	14	0
492	16	0
492	17	10
493	1	10
493	2	10
493	3	10
493	4	10
493	5	10
493	6	10
493	7	10
493	8	10
493	9	10
493	10	10
493	11	0
493	12	0
493	13	0
493	14	0
493	16	0
493	17	10
494	1	10
494	2	10
494	3	10
494	4	10
494	5	10
494	6	10
494	7	10
494	8	8
494	9	10
494	10	10
494	11	0
494	12	0
494	13	0
494	14	0
494	16	0
494	17	10
495	1	10
495	2	10
495	3	10
495	4	10
495	5	10
495	6	10
495	7	10
495	8	8
495	9	10
495	10	10
495	11	0
495	12	0
495	13	0
495	14	0
495	16	0
495	17	10
496	1	10
496	2	10
496	3	10
496	4	10
496	5	10
496	6	10
496	7	10
496	8	8
496	9	10
496	10	10
496	11	0
496	12	0
496	13	0
496	14	0
496	16	0
496	17	10
497	1	10
497	2	10
497	3	10
497	4	10
497	5	10
497	6	10
497	7	10
497	8	10
497	9	10
497	10	10
497	11	0
497	12	0
497	13	0
497	14	0
497	16	0
497	17	10
498	1	10
498	2	10
498	3	10
498	4	10
498	5	10
498	6	10
498	7	10
498	8	10
498	9	10
498	10	10
498	11	0
498	12	0
498	13	0
498	14	0
498	16	0
498	17	10
499	1	10
499	2	10
499	3	10
499	4	10
499	5	10
499	6	10
499	7	10
499	8	10
499	9	10
499	10	10
499	11	0
499	12	0
499	13	0
499	14	0
499	16	0
499	17	10
500	1	10
500	2	10
500	3	10
500	4	10
500	5	10
500	6	10
500	7	10
500	8	10
500	9	10
500	10	10
500	11	0
500	12	0
500	13	0
500	14	0
500	16	0
500	17	10
501	1	10
501	2	10
501	3	10
501	4	10
501	5	10
501	6	10
501	7	10
501	8	10
501	9	10
501	10	10
501	11	0
501	12	0
501	13	0
501	14	0
501	16	0
501	17	10
502	1	10
502	2	10
502	3	10
502	4	10
502	5	10
502	6	10
502	7	10
502	8	10
502	9	10
502	10	10
502	11	0
502	12	0
502	13	0
502	14	0
502	16	0
502	17	10
503	1	10
503	2	10
503	3	10
503	4	10
503	5	10
503	6	10
503	7	10
503	8	10
503	9	10
503	10	10
503	11	0
503	12	0
503	13	0
503	14	0
503	16	0
503	17	10
504	1	10
504	2	10
504	3	10
504	4	10
504	5	10
504	6	10
504	7	10
504	8	10
504	9	10
504	10	10
504	11	0
504	12	0
504	13	0
504	14	0
504	16	0
504	17	10
505	1	10
505	2	10
505	3	10
505	4	10
505	5	10
505	6	10
505	7	10
505	8	10
505	9	10
505	10	10
505	11	0
505	12	0
505	13	0
505	14	0
505	16	0
505	17	10
506	1	10
506	2	10
506	3	10
506	4	10
506	5	10
506	6	10
506	7	10
506	8	10
506	9	10
506	10	10
506	11	0
506	12	0
506	13	0
506	14	0
506	16	0
506	17	10
507	1	10
507	2	10
507	3	10
507	4	10
507	5	10
507	6	10
507	7	10
507	8	10
507	9	10
507	10	10
507	11	0
507	12	0
507	13	0
507	14	0
507	16	0
507	17	10
508	1	10
508	2	10
508	3	10
508	4	10
508	5	10
508	6	10
508	7	10
508	8	10
508	9	10
508	10	10
508	11	0
508	12	0
508	13	0
508	14	0
508	16	0
508	17	10
509	1	10
509	2	10
509	3	10
509	4	10
509	5	10
509	6	10
509	7	10
509	8	10
509	9	10
509	10	10
509	11	0
509	12	0
509	13	0
509	14	0
509	16	0
509	17	10
510	1	10
510	2	10
510	3	10
510	4	10
510	5	10
510	6	10
510	7	10
510	8	10
510	9	10
510	10	10
510	11	0
510	12	0
510	13	0
510	14	0
510	16	0
510	17	10
511	1	10
511	2	10
511	3	10
511	4	10
511	5	10
511	6	10
511	7	10
511	8	10
511	9	10
511	10	10
511	11	0
511	12	0
511	13	0
511	14	0
511	16	0
511	17	10
512	1	10
512	2	10
512	3	10
512	4	10
512	5	10
512	6	10
512	7	10
512	8	10
512	9	10
512	10	10
512	11	0
512	12	0
512	13	0
512	14	0
512	16	0
512	17	10
513	1	10
513	2	10
513	3	10
513	4	10
513	5	10
513	6	10
513	7	10
513	8	10
513	9	10
513	10	10
513	11	0
513	12	0
513	13	0
513	14	0
513	16	0
513	17	10
514	1	10
514	2	10
514	3	10
514	4	10
514	5	10
514	6	10
514	7	10
514	8	10
514	9	10
514	10	10
514	11	0
514	12	0
514	13	0
514	14	0
514	16	0
514	17	10
515	1	10
515	2	10
515	3	10
515	4	10
515	5	10
515	6	10
515	7	10
515	8	8
515	9	10
515	10	10
515	11	0
515	12	0
515	13	0
515	14	0
515	16	0
515	17	10
516	1	10
516	2	10
516	3	10
516	4	10
516	5	10
516	6	10
516	7	10
516	8	10
516	9	10
516	10	10
516	11	0
516	12	0
516	13	0
516	14	0
516	16	0
516	17	10
517	1	10
517	2	10
517	3	10
517	4	10
517	5	10
517	6	10
517	7	10
517	8	10
517	9	10
517	10	10
517	11	0
517	12	0
517	13	0
517	14	0
517	16	0
517	17	10
518	1	10
518	2	10
518	3	10
518	4	10
518	5	10
518	6	10
518	7	10
518	8	10
518	9	10
518	10	10
518	11	0
518	12	0
518	13	0
518	14	0
518	16	0
518	17	10
519	1	10
519	2	10
519	3	10
519	4	10
519	5	10
519	6	10
519	7	10
519	8	10
519	9	10
519	10	10
519	11	0
519	12	1
519	13	0
519	14	0
519	15	1
519	16	0
519	17	10
520	1	10
520	2	10
520	3	10
520	4	10
520	5	10
520	6	10
520	7	10
520	8	10
520	9	10
520	10	10
520	11	0
520	12	0
520	13	0
520	14	0
520	16	0
520	17	10
521	1	10
521	2	10
521	3	10
521	4	10
521	5	10
521	6	10
521	7	10
521	8	10
521	9	10
521	10	10
521	11	0
521	12	0
521	13	0
521	14	0
521	16	0
521	17	10
522	1	10
522	2	10
522	3	10
522	4	10
522	5	10
522	6	10
522	7	10
522	8	10
522	9	10
522	10	10
522	11	0
522	12	0
522	13	0
522	14	0
522	16	0
522	17	10
523	1	10
523	2	10
523	3	10
523	4	10
523	5	10
523	6	10
523	7	10
523	8	10
523	9	10
523	10	10
523	11	0
523	12	0
523	13	0
523	14	0
523	16	0
523	17	10
525	1	10
525	2	10
525	3	10
525	4	10
525	5	10
525	6	10
525	7	10
525	8	10
525	9	10
525	10	10
525	11	0
525	12	1
525	13	0
525	14	0
525	15	1
525	16	0
525	17	10
526	1	10
526	2	10
526	3	10
526	4	10
526	5	10
526	6	10
526	7	10
526	8	10
526	9	10
526	10	10
526	11	0
526	12	0
526	13	0
526	14	0
526	16	0
526	17	10
527	1	10
527	2	10
527	3	10
527	4	10
527	5	10
527	6	10
527	7	10
527	8	10
527	9	10
527	10	10
527	11	0
527	12	0
527	13	0
527	14	0
527	16	0
527	17	10
528	1	10
528	2	10
528	3	10
528	4	10
528	5	10
528	6	10
528	7	10
528	8	10
528	9	10
528	10	10
528	11	0
528	12	0
528	13	0
528	14	0
528	16	0
528	17	10
529	1	10
529	2	10
529	3	10
529	4	10
529	5	10
529	6	10
529	7	10
529	8	10
529	9	10
529	10	10
529	11	0
529	12	0
529	13	0
529	14	0
529	16	0
529	17	10
530	1	10
530	2	10
530	3	10
530	4	10
530	5	10
530	6	10
530	7	10
530	8	10
530	9	10
530	10	10
530	11	0
530	12	0
530	13	0
530	14	0
530	16	0
530	17	10
531	1	10
531	2	10
531	3	10
531	4	10
531	5	10
531	6	10
531	7	10
531	8	10
531	9	10
531	10	10
531	11	0
531	12	0
531	13	0
531	14	0
531	16	0
531	17	10
532	1	10
532	2	10
532	3	10
532	4	10
532	5	10
532	6	10
532	7	10
532	8	10
532	9	10
532	10	10
532	11	0
532	12	0
532	13	0
532	14	0
532	16	0
532	17	10
533	1	10
533	2	10
533	3	10
533	4	10
533	5	10
533	6	10
533	7	10
533	8	10
533	9	10
533	10	10
533	11	0
533	12	0
533	13	0
533	14	0
533	16	0
533	17	10
534	1	10
534	2	10
534	3	10
534	4	10
534	5	10
534	6	10
534	7	10
534	8	10
534	9	10
534	10	10
534	11	0
534	12	0
534	13	0
534	14	0
534	16	0
534	17	10
535	1	10
535	2	10
535	3	10
535	4	10
535	5	10
535	6	10
535	7	10
535	8	8
535	9	10
535	10	10
535	11	0
535	12	0
535	13	0
535	14	0
535	16	0
535	17	10
536	1	10
536	2	10
536	3	10
536	4	10
536	5	10
536	6	10
536	7	10
536	8	10
536	9	10
536	10	10
536	11	0
536	12	0
536	13	0
536	14	0
536	16	0
536	17	10
537	1	10
537	2	10
537	3	10
537	4	10
537	5	10
537	6	10
537	7	10
537	8	10
537	9	10
537	10	10
537	11	0
537	12	0
537	13	0
537	14	0
537	16	0
537	17	10
538	1	10
538	2	10
538	3	10
538	4	10
538	5	10
538	6	10
538	7	10
538	8	10
538	9	10
538	10	10
538	11	0
538	12	0
538	13	0
538	14	0
538	16	0
538	17	10
539	1	10
539	2	10
539	3	10
539	4	10
539	5	10
539	6	10
539	7	10
539	8	10
539	9	10
539	10	10
539	11	0
539	12	0
539	13	0
539	14	0
539	16	0
539	17	10
540	1	10
540	2	10
540	3	10
540	4	10
540	5	10
540	6	10
540	7	10
540	8	10
540	9	10
540	10	10
540	11	0
540	12	0
540	13	0
540	14	0
540	16	0
540	17	10
541	1	10
541	2	10
541	3	10
541	4	10
541	5	10
541	6	10
541	7	10
541	8	10
541	9	10
541	10	10
541	11	0
541	12	0
541	13	0
541	14	0
541	16	0
541	17	10
542	1	10
542	2	10
542	3	10
542	4	10
542	5	10
542	6	10
542	7	10
542	8	10
542	9	10
542	10	10
542	11	0
542	12	0
542	13	0
542	14	0
542	16	0
542	17	10
543	1	10
543	2	10
543	3	10
543	4	10
543	5	10
543	6	10
543	7	10
543	8	10
543	9	10
543	10	10
543	11	0
543	12	0
543	13	0
543	14	0
543	16	0
543	17	10
544	1	10
544	2	10
544	3	10
544	4	10
544	5	10
544	6	10
544	7	10
544	8	10
544	9	10
544	10	10
544	11	0
544	12	0
544	13	0
544	14	0
544	16	0
544	17	10
545	1	10
545	2	10
545	3	10
545	4	10
545	5	10
545	6	10
545	7	10
545	8	10
545	9	10
545	10	10
545	11	0
545	12	0
545	13	0
545	14	0
545	16	0
545	17	10
546	1	10
546	2	10
546	3	10
546	4	10
546	5	10
546	6	10
546	7	10
546	8	10
546	9	8
546	10	10
546	11	0
546	12	0
546	13	0
546	14	0
546	16	0
546	17	10
547	1	10
547	2	10
547	3	10
547	4	10
547	5	10
547	6	10
547	7	10
547	8	10
547	9	10
547	10	10
547	11	0
547	12	0
547	13	0
547	14	0
547	16	0
547	17	10
548	1	10
548	2	10
548	3	10
548	4	10
548	5	10
548	6	10
548	7	10
548	8	10
548	9	10
548	10	10
548	11	0
548	12	0
548	13	0
548	14	0
548	16	0
548	17	10
549	1	10
549	2	10
549	3	10
549	4	10
549	5	10
549	6	10
549	7	10
549	8	10
549	9	10
549	10	10
549	11	0
549	12	0
549	13	0
549	14	0
549	16	0
549	17	10
550	1	10
550	2	10
550	3	10
550	4	10
550	5	10
550	6	10
550	7	10
550	8	10
550	9	10
550	10	10
550	11	0
550	12	0
550	13	0
550	14	0
550	16	0
550	17	10
551	1	10
551	2	10
551	3	10
551	4	10
551	5	10
551	6	10
551	7	10
551	8	10
551	9	10
551	10	10
551	11	0
551	12	0
551	13	0
551	14	0
551	16	0
551	17	10
552	1	10
552	2	10
552	3	10
552	4	10
552	5	10
552	6	10
552	7	10
552	8	10
552	9	10
552	10	10
552	11	0
552	12	0
552	13	0
552	14	0
552	16	0
552	17	10
553	1	10
553	2	10
553	3	10
553	4	10
553	5	10
553	6	10
553	7	10
553	8	10
553	9	10
553	10	10
553	11	0
553	12	0
553	13	0
553	14	0
553	16	0
553	17	10
554	1	10
554	2	10
554	3	10
554	4	10
554	5	10
554	6	10
554	7	10
554	8	10
554	9	10
554	10	10
554	11	0
554	12	0
554	13	0
554	14	0
554	16	0
554	17	10
555	1	10
555	2	10
555	3	10
555	4	10
555	5	10
555	6	10
555	7	10
555	8	10
555	9	10
555	10	10
555	11	0
555	12	0
555	13	0
555	14	0
555	16	0
555	17	10
556	1	10
556	2	10
556	3	10
556	4	10
556	5	10
556	6	10
556	7	10
556	8	10
556	9	10
556	10	10
556	11	0
556	12	0
556	13	0
556	14	0
556	16	0
556	17	10
557	1	10
557	2	10
557	3	10
557	4	10
557	5	10
557	6	10
557	7	10
557	8	10
557	9	10
557	10	10
557	11	0
557	12	0
557	13	0
557	14	0
557	16	0
557	17	10
558	1	10
558	2	10
558	3	10
558	4	10
558	5	10
558	6	10
558	7	10
558	8	10
558	9	10
558	10	10
558	11	0
558	12	0
558	13	0
558	14	0
558	16	0
558	17	10
559	1	10
559	2	10
559	3	10
559	4	10
559	5	10
559	6	10
559	7	10
559	8	10
559	9	10
559	10	10
559	11	0
559	12	0
559	13	0
559	14	0
559	16	0
559	17	10
560	1	10
560	2	10
560	3	10
560	4	10
560	5	10
560	6	10
560	7	10
560	8	10
560	9	10
560	10	10
560	11	0
560	12	0
560	13	0
560	14	0
560	16	0
560	17	10
561	1	10
561	2	10
561	3	10
561	4	10
561	5	10
561	6	10
561	7	10
561	8	10
561	9	10
561	10	10
561	11	0
561	12	2
561	13	0
561	14	0
561	15	1
561	16	0
561	17	10
562	1	10
562	2	10
562	3	10
562	4	10
562	5	10
562	6	10
562	7	10
562	8	10
562	9	10
562	10	10
562	11	0
562	12	0
562	13	0
562	14	0
562	16	0
562	17	10
563	1	10
563	2	10
563	3	10
563	4	10
563	5	10
563	6	10
563	7	10
563	8	10
563	9	10
563	10	10
563	11	0
563	12	0
563	13	0
563	14	0
563	16	0
563	17	10
564	1	10
564	2	10
564	3	10
564	4	10
564	5	10
564	6	10
564	7	10
564	8	10
564	9	10
564	10	10
564	11	0
564	12	0
564	13	0
564	14	0
564	16	0
564	17	10
565	1	10
565	2	10
565	3	10
565	4	10
565	5	10
565	6	10
565	7	10
565	8	10
565	9	10
565	10	10
565	11	0
565	12	0
565	13	0
565	14	0
565	16	0
565	17	10
566	1	10
566	2	10
566	3	10
566	4	10
566	5	10
566	6	10
566	7	10
566	8	10
566	9	10
566	10	10
566	11	0
566	12	0
566	13	0
566	14	0
566	16	0
566	17	10
567	1	10
567	2	10
567	3	10
567	4	10
567	5	10
567	6	10
567	7	10
567	8	10
567	9	10
567	10	10
567	11	0
567	12	0
567	13	0
567	14	0
567	16	0
567	17	10
568	1	10
568	2	10
568	3	10
568	4	10
568	5	10
568	6	10
568	7	10
568	8	10
568	9	10
568	10	10
568	11	0
568	12	0
568	13	0
568	14	0
568	16	0
568	17	10
569	1	10
569	2	10
569	3	10
569	4	10
569	5	10
569	6	10
569	7	10
569	8	10
569	9	10
569	10	10
569	11	0
569	12	0
569	13	0
569	14	0
569	16	0
569	17	10
570	1	10
570	2	10
570	3	10
570	4	10
570	5	10
570	6	10
570	7	10
570	8	10
570	9	10
570	10	10
570	11	0
570	12	0
570	13	0
570	14	0
570	16	0
570	17	10
571	1	10
571	2	10
571	3	10
571	4	10
571	5	10
571	6	10
571	7	10
571	8	10
571	9	10
571	10	10
571	11	0
571	12	0
571	13	0
571	14	0
571	16	0
571	17	10
572	1	10
572	2	10
572	3	10
572	4	10
572	5	10
572	6	10
572	7	10
572	8	10
572	9	10
572	10	10
572	11	0
572	12	0
572	13	0
572	14	0
572	16	0
572	17	10
573	1	10
573	2	10
573	3	10
573	4	10
573	5	10
573	6	10
573	7	10
573	8	10
573	9	10
573	10	10
573	11	0
573	12	0
573	13	0
573	14	0
573	16	0
573	17	10
574	1	10
574	2	10
574	3	10
574	4	10
574	5	10
574	6	10
574	7	10
574	8	10
574	9	10
574	10	10
574	11	0
574	12	0
574	13	0
574	14	0
574	16	0
574	17	10
575	1	10
575	2	10
575	3	10
575	4	10
575	5	10
575	6	10
575	7	10
575	8	10
575	9	10
575	10	10
575	11	0
575	12	0
575	13	0
575	14	0
575	16	0
575	17	10
576	1	10
576	2	10
576	3	10
576	4	10
576	5	10
576	6	10
576	7	10
576	8	10
576	9	10
576	10	10
576	11	0
576	12	0
576	13	0
576	14	0
576	16	0
576	17	10
577	1	10
577	2	10
577	3	10
577	4	10
577	5	10
577	6	10
577	7	10
577	8	10
577	9	10
577	10	10
577	11	0
577	12	0
577	13	0
577	14	0
577	16	0
577	17	10
578	1	10
578	2	10
578	3	10
578	4	10
578	5	10
578	6	10
578	7	10
578	8	10
578	9	10
578	10	10
578	11	0
578	12	0
578	13	0
578	14	0
578	16	0
578	17	10
579	1	10
579	2	10
579	3	10
579	4	10
579	5	10
579	6	10
579	7	10
579	8	10
579	9	10
579	10	10
579	11	0
579	12	0
579	13	0
579	14	0
579	16	0
579	17	10
580	1	10
580	2	10
580	3	10
580	4	10
580	5	10
580	6	10
580	7	10
580	8	10
580	9	10
580	10	10
580	11	0
580	12	0
580	13	0
580	14	0
580	16	0
580	17	10
581	1	10
581	2	10
581	3	10
581	4	10
581	5	10
581	6	10
581	7	10
581	8	10
581	9	10
581	10	10
581	11	0
581	12	0
581	13	0
581	14	0
581	16	0
581	17	10
583	1	10
583	2	10
583	3	10
583	4	10
583	5	10
583	6	10
583	7	10
583	8	10
583	9	10
583	10	10
583	11	0
583	12	0
583	13	0
583	14	0
583	16	0
583	17	10
584	1	10
584	2	10
584	3	10
584	4	10
584	5	10
584	6	10
584	7	10
584	8	10
584	9	10
584	10	10
584	11	0
584	12	0
584	13	0
584	14	0
584	16	0
584	17	10
585	1	10
585	2	10
585	3	10
585	4	10
585	5	10
585	6	10
585	7	10
585	8	10
585	9	10
585	10	10
585	11	0
585	12	0
585	13	0
585	14	0
585	16	0
585	17	10
586	1	10
586	2	10
586	3	10
586	4	10
586	5	10
586	6	10
586	7	10
586	8	10
586	9	10
586	10	10
586	11	0
586	12	0
586	13	0
586	14	0
586	16	0
586	17	10
587	1	10
587	2	10
587	3	10
587	4	10
587	5	10
587	6	10
587	7	10
587	8	10
587	9	10
587	10	10
587	11	0
587	12	0
587	13	0
587	14	0
587	16	0
587	17	10
588	1	10
588	2	10
588	3	10
588	4	10
588	5	10
588	6	10
588	7	10
588	8	10
588	9	10
588	10	10
588	11	0
588	12	0
588	13	0
588	14	0
588	16	0
588	17	10
589	1	10
589	2	10
589	3	10
589	4	10
589	5	10
589	6	10
589	7	10
589	8	10
589	9	10
589	10	10
589	11	0
589	12	0
589	13	0
589	14	0
589	16	0
589	17	10
590	1	10
590	2	10
590	3	10
590	4	10
590	5	10
590	6	10
590	7	10
590	8	10
590	9	10
590	10	10
590	11	0
590	12	0
590	13	0
590	14	0
590	16	0
590	17	10
591	1	10
591	2	10
591	3	10
591	4	10
591	5	10
591	6	10
591	7	10
591	8	10
591	9	10
591	10	10
591	11	0
591	12	0
591	13	0
591	14	0
591	16	0
591	17	10
592	1	10
592	2	10
592	3	10
592	4	10
592	5	10
592	6	10
592	7	10
592	8	10
592	9	10
592	10	10
592	11	0
592	12	0
592	13	0
592	14	0
592	16	0
592	17	10
593	1	10
593	2	10
593	3	10
593	4	10
593	5	10
593	6	10
593	7	10
593	8	10
593	9	10
593	10	10
593	11	0
593	12	0
593	13	0
593	14	0
593	16	0
593	17	10
594	1	10
594	2	10
594	3	10
594	4	10
594	5	8
594	6	10
594	7	10
594	8	10
594	9	10
594	10	10
594	11	0
594	12	0
594	13	0
594	14	0
594	16	0
594	17	10
595	1	10
595	2	10
595	3	10
595	4	10
595	5	10
595	6	10
595	7	10
595	8	10
595	9	10
595	10	10
595	11	0
595	12	0
595	13	0
595	14	0
595	16	0
595	17	10
596	1	10
596	2	10
596	3	10
596	4	10
596	5	10
596	6	10
596	7	10
596	8	10
596	9	10
596	10	10
596	11	0
596	12	0
596	13	0
596	14	0
596	16	0
596	17	10
597	1	10
597	2	10
597	3	10
597	4	10
597	5	10
597	6	10
597	7	10
597	8	10
597	9	10
597	10	10
597	11	0
597	12	0
597	13	0
597	14	0
597	16	0
597	17	10
598	1	10
598	2	10
598	3	10
598	4	10
598	5	10
598	6	10
598	7	10
598	8	10
598	9	10
598	10	10
598	11	0
598	12	0
598	13	0
598	14	0
598	16	0
598	17	10
599	1	10
599	2	10
599	3	10
599	4	10
599	5	10
599	6	10
599	7	10
599	8	10
599	9	10
599	10	10
599	11	0
599	12	0
599	13	0
599	14	0
599	16	0
599	17	10
600	1	10
600	2	10
600	3	10
600	4	10
600	5	10
600	6	10
600	7	10
600	8	10
600	9	10
600	10	10
600	11	0
600	12	1
600	13	0
600	14	0
600	15	1
600	16	0
600	17	10
601	1	10
601	2	10
601	3	10
601	4	10
601	5	10
601	6	10
601	7	10
601	8	10
601	9	10
601	10	10
601	11	0
601	12	0
601	13	0
601	14	0
601	16	0
601	17	10
602	1	10
602	2	10
602	3	10
602	4	10
602	5	10
602	6	10
602	7	10
602	8	10
602	9	10
602	10	10
602	11	0
602	12	0
602	13	0
602	14	0
602	16	0
602	17	10
603	1	10
603	2	10
603	3	10
603	4	10
603	5	10
603	6	10
603	7	10
603	8	10
603	9	10
603	10	10
603	11	0
603	12	0
603	13	0
603	14	0
603	16	0
603	17	10
604	1	10
604	2	10
604	3	10
604	4	10
604	5	10
604	6	10
604	7	10
604	8	10
604	9	10
604	10	10
604	11	0
604	12	0
604	13	0
604	14	0
604	16	0
604	17	10
605	1	10
605	2	10
605	3	10
605	4	10
605	5	10
605	6	10
605	7	10
605	8	10
605	9	10
605	10	10
605	11	0
605	12	0
605	13	0
605	14	0
605	16	0
605	17	10
606	1	10
606	2	10
606	3	10
606	4	10
606	5	10
606	6	10
606	7	10
606	8	10
606	9	10
606	10	10
606	11	0
606	12	0
606	13	0
606	14	0
606	16	0
606	17	10
607	1	10
607	2	10
607	3	10
607	4	10
607	5	10
607	6	10
607	7	10
607	8	10
607	9	10
607	10	10
607	11	0
607	12	0
607	13	0
607	14	0
607	16	0
607	17	10
608	1	10
608	2	10
608	3	10
608	4	10
608	5	10
608	6	10
608	7	10
608	8	10
608	9	10
608	10	10
608	11	0
608	12	0
608	13	0
608	14	0
608	16	0
608	17	10
609	1	10
609	2	10
609	3	10
609	4	10
609	5	10
609	6	10
609	7	10
609	8	10
609	9	10
609	10	10
609	11	0
609	12	0
609	13	0
609	14	0
609	16	0
609	17	10
610	1	10
610	2	10
610	3	10
610	4	10
610	5	10
610	6	10
610	7	10
610	8	10
610	9	10
610	10	10
610	11	0
610	12	0
610	13	0
610	14	0
610	16	0
610	17	10
611	1	10
611	2	10
611	3	10
611	4	10
611	5	10
611	6	10
611	7	10
611	8	10
611	9	10
611	10	10
611	11	0
611	12	0
611	13	0
611	14	0
611	16	0
611	17	10
612	1	10
612	2	10
612	3	10
612	4	10
612	5	10
612	6	10
612	7	10
612	8	10
612	9	10
612	10	10
612	11	0
612	12	0
612	13	0
612	14	0
612	16	0
612	17	10
613	1	10
613	2	10
613	3	10
613	4	10
613	5	10
613	6	10
613	7	10
613	8	10
613	9	10
613	10	10
613	11	0
613	12	0
613	13	0
613	14	0
613	16	0
613	17	10
614	1	10
614	2	10
614	3	10
614	4	10
614	5	10
614	6	10
614	7	10
614	8	10
614	9	10
614	10	10
614	11	0
614	12	0
614	13	0
614	14	0
614	16	0
614	17	10
615	1	10
615	2	10
615	3	10
615	4	10
615	5	10
615	6	10
615	7	10
615	8	10
615	9	10
615	10	10
615	11	0
615	12	0
615	13	0
615	14	0
615	16	0
615	17	10
616	1	10
616	2	10
616	3	10
616	4	10
616	5	10
616	6	10
616	7	10
616	8	10
616	9	10
616	10	10
616	11	0
616	12	0
616	13	0
616	14	0
616	16	0
616	17	10
617	1	10
617	2	10
617	3	10
617	4	10
617	5	10
617	6	10
617	7	10
617	8	10
617	9	10
617	10	10
617	11	0
617	12	0
617	13	0
617	14	0
617	16	0
617	17	10
618	1	10
618	2	10
618	3	10
618	4	10
618	5	10
618	6	10
618	7	10
618	8	10
618	9	10
618	10	10
618	11	0
618	12	0
618	13	0
618	14	0
618	16	0
618	17	10
619	1	10
619	2	10
619	3	10
619	4	10
619	5	10
619	6	10
619	7	10
619	8	10
619	9	10
619	10	10
619	11	0
619	12	0
619	13	0
619	14	0
619	16	0
619	17	10
620	1	10
620	2	10
620	3	10
620	4	10
620	5	10
620	6	10
620	7	10
620	8	10
620	9	10
620	10	10
620	11	0
620	12	0
620	13	0
620	14	0
620	16	0
620	17	10
621	1	10
621	2	10
621	3	10
621	4	10
621	5	10
621	6	10
621	7	10
621	8	10
621	9	10
621	10	10
621	11	0
621	12	0
621	13	0
621	14	0
621	16	0
621	17	10
622	1	10
622	2	10
622	3	10
622	4	10
622	5	10
622	6	10
622	7	10
622	8	10
622	9	10
622	10	10
622	11	0
622	12	0
622	13	0
622	14	0
622	16	0
622	17	10
623	1	10
623	2	10
623	3	10
623	4	10
623	5	10
623	6	10
623	7	10
623	8	10
623	9	10
623	10	10
623	11	0
623	12	0
623	13	0
623	14	0
623	16	0
623	17	10
624	1	10
624	2	10
624	3	10
624	4	10
624	5	10
624	6	10
624	7	10
624	8	10
624	9	10
624	10	10
624	11	0
624	12	0
624	13	0
624	14	0
624	16	0
624	17	10
625	1	10
625	2	10
625	3	10
625	4	10
625	5	10
625	6	10
625	7	10
625	8	10
625	9	10
625	10	10
625	11	0
625	12	0
625	13	0
625	14	0
625	16	0
625	17	10
626	1	10
626	2	10
626	3	10
626	4	10
626	5	10
626	6	10
626	7	10
626	8	10
626	9	10
626	10	10
626	11	0
626	12	0
626	13	0
626	14	0
626	16	0
626	17	10
627	1	10
627	2	10
627	3	10
627	4	10
627	5	10
627	6	10
627	7	10
627	8	10
627	9	10
627	10	10
627	11	0
627	12	0
627	13	0
627	14	0
627	16	0
627	17	10
628	1	10
628	2	10
628	3	10
628	4	10
628	5	10
628	6	10
628	7	10
628	8	10
628	9	10
628	10	10
628	11	0
628	12	0
628	13	0
628	14	0
628	16	0
628	17	8
629	1	10
629	2	10
629	3	10
629	4	10
629	5	10
629	6	10
629	7	10
629	8	10
629	9	10
629	10	10
629	11	0
629	12	0
629	13	0
629	14	0
629	16	0
629	17	10
630	1	10
630	2	10
630	3	10
630	4	10
630	5	10
630	6	10
630	7	10
630	8	10
630	9	10
630	10	10
630	11	0
630	12	0
630	13	0
630	14	0
630	16	0
630	17	10
631	1	10
631	2	10
631	3	10
631	4	10
631	5	10
631	6	10
631	7	10
631	8	10
631	9	10
631	10	10
631	11	0
631	12	0
631	13	0
631	14	0
631	16	0
631	17	10
632	1	10
632	2	10
632	3	10
632	4	10
632	5	10
632	6	10
632	7	10
632	8	10
632	9	10
632	10	10
632	11	0
632	12	0
632	13	0
632	14	0
632	16	0
632	17	10
633	1	10
633	2	10
633	3	10
633	4	10
633	5	10
633	6	10
633	7	10
633	8	10
633	9	10
633	10	10
633	11	0
633	12	0
633	13	0
633	14	0
633	16	0
633	17	10
634	1	10
634	2	10
634	3	10
634	4	10
634	5	10
634	6	10
634	7	10
634	8	10
634	9	10
634	10	10
634	11	0
634	12	0
634	13	0
634	14	0
634	16	0
634	17	10
635	1	10
635	2	10
635	3	10
635	4	10
635	5	10
635	6	10
635	7	10
635	8	10
635	9	10
635	10	10
635	11	0
635	12	0
635	13	0
635	14	0
635	16	0
635	17	10
636	1	10
636	2	10
636	3	10
636	4	10
636	5	10
636	6	10
636	7	10
636	8	10
636	9	10
636	10	10
636	11	0
636	12	0
636	13	0
636	14	0
636	16	0
636	17	10
637	1	10
637	2	10
637	3	10
637	4	10
637	5	10
637	6	10
637	7	10
637	8	10
637	9	10
637	10	10
637	11	0
637	12	0
637	13	0
637	14	0
637	16	0
637	17	10
638	1	10
638	2	10
638	3	10
638	4	10
638	5	10
638	6	10
638	7	10
638	8	10
638	9	10
638	10	10
638	11	0
638	12	0
638	13	0
638	14	0
638	16	0
638	17	10
639	1	10
639	2	10
639	3	10
639	4	10
639	5	10
639	6	10
639	7	10
639	8	10
639	9	10
639	10	10
639	11	0
639	12	0
639	13	0
639	14	0
639	16	0
639	17	10
640	1	10
640	2	10
640	3	10
640	4	10
640	5	10
640	6	10
640	7	10
640	8	10
640	9	10
640	10	10
640	11	0
640	12	0
640	13	0
640	14	0
640	16	0
640	17	10
641	1	10
641	2	10
641	3	10
641	4	10
641	5	10
641	6	10
641	7	10
641	8	10
641	9	10
641	10	10
641	11	0
641	12	0
641	13	0
641	14	0
641	16	0
641	17	10
642	1	10
642	2	10
642	3	10
642	4	10
642	5	10
642	6	10
642	7	10
642	8	10
642	9	10
642	10	10
642	11	0
642	12	0
642	13	0
642	14	0
642	16	0
642	17	10
643	1	10
643	2	10
643	3	10
643	4	10
643	5	10
643	6	10
643	7	10
643	8	10
643	9	10
643	10	10
643	11	0
643	12	0
643	13	0
643	14	0
643	16	0
643	17	10
644	1	10
644	2	10
644	3	10
644	4	10
644	5	10
644	6	10
644	7	10
644	8	10
644	9	10
644	10	10
644	11	0
644	12	0
644	13	0
644	14	0
644	16	0
644	17	10
645	1	10
645	2	10
645	3	10
645	4	10
645	5	10
645	6	10
645	7	10
645	8	10
645	9	10
645	10	10
645	11	0
645	12	0
645	13	0
645	14	0
645	16	0
645	17	10
646	1	10
646	2	10
646	3	10
646	4	10
646	5	10
646	6	10
646	7	10
646	8	10
646	9	10
646	10	10
646	11	0
646	12	0
646	13	0
646	14	0
646	16	0
646	17	10
647	1	10
647	2	10
647	3	10
647	4	10
647	5	10
647	6	10
647	7	10
647	8	10
647	9	10
647	10	10
647	11	0
647	12	0
647	13	0
647	14	0
647	16	0
647	17	10
648	1	10
648	2	10
648	3	10
648	4	10
648	5	10
648	6	10
648	7	10
648	8	10
648	9	10
648	10	10
648	11	0
648	12	0
648	13	0
648	14	0
648	16	0
648	17	10
649	1	10
649	2	10
649	3	10
649	4	10
649	5	10
649	6	10
649	7	10
649	8	10
649	9	10
649	10	10
649	11	0
649	12	0
649	13	0
649	14	0
649	16	0
649	17	10
650	1	10
650	2	10
650	3	10
650	4	10
650	5	10
650	6	10
650	7	10
650	8	10
650	9	10
650	10	10
650	11	0
650	12	0
650	13	0
650	14	0
650	16	0
650	17	10
651	1	10
651	2	10
651	3	10
651	4	10
651	5	10
651	6	10
651	7	10
651	8	10
651	9	10
651	10	10
651	11	0
651	12	0
651	13	0
651	14	0
651	16	0
651	17	10
652	1	10
652	2	10
652	3	10
652	4	10
652	5	10
652	6	10
652	7	10
652	8	10
652	9	10
652	10	10
652	11	0
652	12	0
652	13	0
652	14	0
652	16	0
652	17	10
653	1	10
653	2	10
653	3	10
653	4	10
653	5	10
653	6	10
653	7	10
653	8	10
653	9	10
653	10	10
653	11	0
653	12	0
653	13	0
653	14	0
653	16	0
653	17	10
654	1	10
654	2	10
654	3	10
654	4	10
654	5	10
654	6	10
654	7	10
654	8	10
654	9	10
654	10	10
654	11	0
654	12	0
654	13	0
654	14	0
654	16	0
654	17	10
655	1	10
655	2	10
655	3	10
655	4	10
655	5	10
655	6	10
655	7	10
655	8	10
655	9	10
655	10	10
655	11	0
655	12	0
655	13	0
655	14	0
655	16	0
655	17	10
656	1	10
656	2	10
656	3	10
656	4	10
656	5	10
656	6	10
656	7	10
656	8	10
656	9	10
656	10	10
656	11	0
656	12	0
656	13	0
656	14	0
656	16	0
656	17	10
657	1	10
657	2	10
657	3	10
657	4	10
657	5	10
657	6	10
657	7	10
657	8	10
657	9	10
657	10	10
657	11	0
657	12	0
657	13	0
657	14	0
657	16	0
657	17	10
658	1	10
658	2	10
658	3	10
658	4	10
658	5	10
658	6	10
658	7	10
658	8	10
658	9	10
658	10	10
658	11	0
658	12	0
658	13	0
658	14	0
658	16	0
658	17	10
659	1	10
659	2	10
659	3	10
659	4	10
659	5	10
659	6	10
659	7	10
659	8	10
659	9	10
659	10	10
659	11	0
659	12	0
659	13	0
659	14	0
659	16	0
659	17	10
660	1	10
660	2	10
660	3	10
660	4	10
660	5	10
660	6	10
660	7	10
660	8	10
660	9	10
660	10	10
660	11	0
660	12	0
660	13	0
660	14	0
660	16	0
660	17	10
661	1	10
661	2	10
661	3	10
661	4	10
661	5	10
661	6	10
661	7	10
661	8	10
661	9	10
661	10	10
661	11	0
661	12	0
661	13	0
661	14	0
661	16	0
661	17	10
662	1	10
662	2	10
662	3	10
662	4	10
662	5	10
662	6	10
662	7	10
662	8	10
662	9	10
662	10	10
662	11	0
662	12	0
662	13	0
662	14	0
662	16	0
662	17	10
663	1	10
663	2	10
663	3	10
663	4	10
663	5	10
663	6	10
663	7	10
663	8	10
663	9	10
663	10	10
663	11	0
663	12	0
663	13	0
663	14	0
663	16	0
663	17	10
664	1	10
664	2	10
664	3	10
664	4	10
664	5	10
664	6	10
664	7	10
664	8	10
664	9	10
664	10	10
664	11	0
664	12	0
664	13	0
664	14	0
664	16	0
664	17	10
665	1	10
665	2	10
665	3	10
665	4	10
665	5	10
665	6	10
665	7	10
665	8	10
665	9	10
665	10	10
665	11	0
665	12	0
665	13	0
665	14	0
665	16	0
665	17	10
666	1	10
666	2	10
666	3	10
666	4	10
666	5	10
666	6	10
666	7	10
666	8	10
666	9	10
666	10	10
666	11	0
666	12	0
666	13	0
666	14	0
666	16	0
666	17	10
667	1	10
667	2	10
667	3	10
667	4	10
667	5	10
667	6	10
667	7	10
667	8	10
667	9	10
667	10	10
667	11	0
667	12	0
667	13	0
667	14	0
667	16	0
667	17	10
668	1	10
668	2	10
668	3	10
668	4	10
668	5	10
668	6	10
668	7	10
668	8	10
668	9	10
668	10	10
668	11	0
668	12	0
668	13	0
668	14	0
668	16	0
668	17	10
669	1	10
669	2	10
669	3	10
669	4	10
669	5	10
669	6	10
669	7	10
669	8	10
669	9	10
669	10	10
669	11	0
669	12	0
669	13	0
669	14	0
669	16	0
669	17	10
670	1	10
670	2	10
670	3	10
670	4	10
670	5	10
670	6	10
670	7	10
670	8	10
670	9	10
670	10	10
670	11	0
670	12	0
670	13	0
670	14	0
670	16	0
670	17	10
671	1	10
671	2	10
671	3	10
671	4	10
671	5	10
671	6	10
671	7	10
671	8	10
671	9	10
671	10	10
671	11	0
671	12	0
671	13	0
671	14	0
671	16	0
671	17	10
672	1	10
672	2	10
672	3	10
672	4	10
672	5	10
672	6	10
672	7	10
672	8	10
672	9	10
672	10	10
672	11	0
672	12	0
672	13	0
672	14	0
672	16	0
672	17	10
673	1	10
673	2	10
673	3	10
673	4	10
673	5	10
673	6	10
673	7	10
673	8	10
673	9	10
673	10	10
673	11	0
673	12	0
673	13	0
673	14	0
673	16	0
673	17	10
674	1	10
674	2	10
674	3	10
674	4	10
674	5	10
674	6	10
674	7	10
674	8	10
674	9	10
674	10	10
674	11	0
674	12	0
674	13	0
674	14	0
674	16	0
674	17	10
675	1	10
675	2	10
675	3	10
675	4	10
675	5	10
675	6	10
675	7	10
675	8	10
675	9	10
675	10	10
675	11	0
675	12	0
675	13	0
675	14	0
675	16	0
675	17	10
676	1	10
676	2	10
676	3	10
676	4	10
676	5	10
676	6	10
676	7	10
676	8	10
676	9	10
676	10	10
676	11	0
676	12	0
676	13	0
676	14	0
676	16	0
676	17	10
677	1	10
677	2	10
677	3	10
677	4	10
677	5	10
677	6	10
677	7	10
677	8	10
677	9	10
677	10	10
677	11	0
677	12	0
677	13	0
677	14	0
677	16	0
677	17	10
678	1	10
678	2	10
678	3	10
678	4	10
678	5	10
678	6	10
678	7	10
678	8	10
678	9	10
678	10	10
678	11	0
678	12	0
678	13	0
678	14	0
678	16	0
678	17	10
679	1	10
679	2	10
679	3	10
679	4	10
679	5	10
679	6	10
679	7	10
679	8	10
679	9	10
679	10	10
679	11	0
679	12	0
679	13	0
679	14	0
679	16	0
679	17	10
680	1	10
680	2	10
680	3	10
680	4	10
680	5	10
680	6	10
680	7	10
680	8	10
680	9	10
680	10	10
680	11	0
680	12	0
680	13	0
680	14	0
680	16	0
680	17	10
681	1	10
681	2	10
681	3	10
681	4	10
681	5	10
681	6	10
681	7	10
681	8	10
681	9	10
681	10	10
681	11	0
681	12	0
681	13	0
681	14	0
681	16	0
681	17	10
682	1	10
682	2	10
682	3	10
682	4	10
682	5	10
682	6	10
682	7	10
682	8	10
682	9	10
682	10	10
682	11	0
682	12	0
682	13	0
682	14	0
682	16	0
682	17	10
683	1	10
683	2	10
683	3	10
683	4	10
683	5	10
683	6	10
683	7	10
683	8	10
683	9	10
683	10	10
683	11	0
683	12	0
683	13	0
683	14	0
683	16	0
683	17	10
684	1	10
684	2	10
684	3	10
684	4	10
684	5	10
684	6	10
684	7	10
684	8	10
684	9	10
684	10	10
684	11	0
684	12	0
684	13	0
684	14	0
684	16	0
684	17	10
685	1	10
685	2	10
685	3	10
685	4	10
685	5	10
685	6	10
685	7	10
685	8	10
685	9	10
685	10	10
685	11	0
685	12	0
685	13	0
685	14	0
685	16	0
685	17	10
686	1	10
686	2	10
686	3	10
686	4	10
686	5	10
686	6	10
686	7	10
686	8	10
686	9	10
686	10	10
686	11	0
686	12	0
686	13	0
686	14	0
686	16	0
686	17	10
687	1	10
687	2	10
687	3	10
687	4	10
687	5	10
687	6	10
687	7	10
687	8	10
687	9	10
687	10	10
687	11	0
687	12	0
687	13	0
687	14	0
687	16	0
687	17	10
688	1	10
688	2	10
688	3	10
688	4	10
688	5	10
688	6	10
688	7	10
688	8	10
688	9	10
688	10	10
688	11	0
688	12	0
688	13	0
688	14	0
688	16	0
688	17	10
689	1	10
689	2	10
689	3	10
689	4	10
689	5	10
689	6	10
689	7	10
689	8	10
689	9	10
689	10	10
689	11	0
689	12	0
689	13	0
689	14	0
689	16	0
689	17	10
690	1	10
690	2	10
690	3	10
690	4	10
690	5	10
690	6	10
690	7	10
690	8	10
690	9	10
690	10	10
690	11	0
690	12	0
690	13	0
690	14	0
690	16	0
690	17	10
691	1	10
691	2	10
691	3	10
691	4	10
691	5	10
691	6	10
691	7	10
691	8	10
691	9	10
691	10	10
691	11	0
691	12	0
691	13	0
691	14	0
691	16	0
691	17	10
692	1	10
692	2	10
692	3	10
692	4	10
692	5	10
692	6	10
692	7	10
692	8	10
692	9	10
692	10	10
692	11	0
692	12	0
692	13	0
692	14	0
692	16	0
692	17	10
693	1	10
693	2	10
693	3	10
693	4	10
693	5	10
693	6	10
693	7	10
693	8	10
693	9	10
693	10	10
693	11	0
693	12	0
693	13	0
693	14	0
693	16	0
693	17	10
694	1	10
694	2	10
694	3	10
694	4	10
694	5	10
694	6	10
694	7	10
694	8	10
694	9	10
694	10	10
694	11	0
694	12	0
694	13	0
694	14	0
694	16	0
694	17	10
695	1	10
695	2	10
695	3	10
695	4	10
695	5	10
695	6	10
695	7	10
695	8	10
695	9	10
695	10	10
695	11	0
695	12	0
695	13	0
695	14	0
695	16	0
695	17	10
696	1	10
696	2	10
696	3	10
696	4	10
696	5	10
696	6	10
696	7	10
696	8	10
696	9	10
696	10	10
696	11	0
696	12	0
696	13	0
696	14	0
696	16	0
696	17	10
697	1	10
697	2	10
697	3	10
697	4	10
697	5	10
697	6	10
697	7	10
697	8	10
697	9	10
697	10	10
697	11	0
697	12	0
697	13	0
697	14	0
697	16	0
697	17	10
698	1	10
698	2	10
698	3	10
698	4	10
698	5	10
698	6	10
698	7	10
698	8	10
698	9	10
698	10	10
698	11	0
698	12	0
698	13	0
698	14	0
698	16	0
698	17	10
699	1	10
699	2	10
699	3	10
699	4	10
699	5	10
699	6	10
699	7	10
699	8	10
699	9	10
699	10	10
699	11	0
699	12	0
699	13	0
699	14	0
699	16	0
699	17	10
700	1	10
700	2	10
700	3	10
700	4	10
700	5	10
700	6	10
700	7	10
700	8	10
700	9	10
700	10	10
700	11	0
700	12	0
700	13	0
700	14	0
700	16	0
700	17	10
701	1	10
701	2	10
701	3	10
701	4	10
701	5	10
701	6	10
701	7	10
701	8	10
701	9	10
701	10	10
701	11	0
701	12	0
701	13	0
701	14	0
701	16	0
701	17	10
702	1	10
702	2	10
702	3	10
702	4	10
702	5	10
702	6	10
702	7	10
702	8	10
702	9	10
702	10	10
702	11	0
702	12	0
702	13	0
702	14	0
702	16	0
702	17	10
703	1	10
703	2	10
703	3	10
703	4	10
703	5	10
703	6	10
703	7	10
703	8	10
703	9	10
703	10	10
703	11	0
703	12	0
703	13	0
703	14	0
703	16	0
703	17	10
704	1	10
704	2	10
704	3	10
704	4	10
704	5	10
704	6	10
704	7	10
704	8	10
704	9	10
704	10	10
704	11	0
704	12	0
704	13	0
704	14	0
704	16	0
704	17	10
705	1	10
705	2	10
705	3	10
705	4	10
705	5	10
705	6	10
705	7	10
705	8	10
705	9	10
705	10	10
705	11	0
705	12	0
705	13	0
705	14	0
705	16	0
705	17	10
706	1	10
706	2	10
706	3	10
706	4	10
706	5	10
706	6	10
706	7	10
706	8	10
706	9	10
706	10	10
706	11	0
706	12	0
706	13	0
706	14	0
706	16	0
706	17	10
707	1	10
707	2	10
707	3	10
707	4	10
707	5	10
707	6	10
707	7	10
707	8	10
707	9	10
707	10	10
707	11	0
707	12	0
707	13	0
707	14	0
707	16	0
707	17	10
708	1	10
708	2	10
708	3	10
708	4	10
708	5	10
708	6	10
708	7	10
708	8	10
708	9	10
708	10	10
708	11	0
708	12	0
708	13	0
708	14	0
708	16	0
708	17	10
709	1	10
709	2	10
709	3	10
709	4	10
709	5	10
709	6	10
709	7	10
709	8	10
709	9	10
709	10	10
709	11	0
709	12	0
709	13	0
709	14	0
709	16	0
709	17	10
710	1	10
710	2	10
710	3	10
710	4	10
710	5	10
710	6	10
710	7	10
710	8	10
710	9	10
710	10	10
710	11	0
710	12	0
710	13	0
710	14	0
710	16	0
710	17	10
711	1	10
711	2	10
711	3	10
711	4	10
711	5	10
711	6	10
711	7	10
711	8	10
711	9	10
711	10	10
711	11	0
711	12	0
711	13	0
711	14	0
711	16	0
711	17	10
712	1	10
712	2	10
712	3	10
712	4	10
712	5	10
712	6	10
712	7	10
712	8	10
712	9	10
712	10	10
712	11	0
712	12	0
712	13	0
712	14	0
712	16	0
712	17	10
713	1	10
713	2	10
713	3	10
713	4	10
713	5	10
713	6	10
713	7	10
713	8	10
713	9	10
713	10	10
713	11	0
713	12	0
713	13	0
713	14	0
713	16	0
713	17	10
714	1	10
714	2	10
714	3	10
714	4	10
714	5	10
714	6	10
714	7	10
714	8	10
714	9	10
714	10	10
714	11	0
714	12	0
714	13	0
714	14	0
714	16	0
714	17	10
715	1	10
715	2	10
715	3	10
715	4	10
715	5	10
715	6	10
715	7	10
715	8	10
715	9	10
715	10	10
715	11	0
715	12	0
715	13	0
715	14	0
715	16	0
715	17	10
716	1	10
716	2	10
716	3	10
716	4	10
716	5	10
716	6	10
716	7	10
716	8	10
716	9	10
716	10	10
716	11	0
716	12	0
716	13	0
716	14	0
716	16	0
716	17	10
717	1	10
717	2	10
717	3	10
717	4	10
717	5	10
717	6	10
717	7	10
717	8	10
717	9	10
717	10	10
717	11	0
717	12	0
717	13	0
717	14	0
717	16	0
717	17	10
718	1	10
718	2	10
718	3	10
718	4	10
718	5	10
718	6	10
718	7	10
718	8	10
718	9	10
718	10	10
718	11	0
718	12	0
718	13	0
718	14	0
718	16	0
718	17	10
719	1	10
719	2	10
719	3	10
719	4	10
719	5	10
719	6	10
719	7	10
719	8	10
719	9	10
719	10	10
719	11	0
719	12	0
719	13	0
719	14	0
719	16	0
719	17	10
720	1	10
720	2	10
720	3	10
720	4	10
720	5	10
720	6	10
720	7	10
720	8	10
720	9	10
720	10	10
720	11	0
720	12	0
720	13	0
720	14	0
720	16	0
720	17	10
721	1	10
721	2	10
721	3	10
721	4	10
721	5	10
721	6	10
721	7	10
721	8	10
721	9	10
721	10	10
721	11	0
721	12	0
721	13	0
721	14	0
721	16	0
721	17	10
722	1	10
722	2	10
722	3	10
722	4	10
722	5	10
722	6	10
722	7	10
722	8	10
722	9	10
722	10	10
722	11	0
722	12	0
722	13	0
722	14	0
722	16	0
722	17	10
723	1	10
723	2	10
723	3	10
723	4	10
723	5	10
723	6	10
723	7	10
723	8	10
723	9	10
723	10	10
723	11	0
723	12	0
723	13	0
723	14	0
723	16	0
723	17	10
724	1	10
724	2	10
724	3	10
724	4	10
724	5	10
724	6	10
724	7	10
724	8	10
724	9	10
724	10	10
724	11	0
724	12	0
724	13	0
724	14	0
724	16	0
724	17	10
725	1	10
725	2	10
725	3	10
725	4	10
725	5	10
725	6	10
725	7	10
725	8	10
725	9	10
725	10	10
725	11	0
725	12	0
725	13	0
725	14	0
725	16	0
725	17	10
726	1	10
726	2	10
726	3	10
726	4	10
726	5	10
726	6	10
726	7	10
726	8	10
726	9	10
726	10	10
726	11	0
726	12	0
726	13	0
726	14	0
726	16	0
726	17	10
727	1	10
727	2	10
727	3	10
727	4	10
727	5	10
727	6	10
727	7	10
727	8	10
727	9	10
727	10	10
727	11	0
727	12	0
727	13	0
727	14	0
727	16	0
727	17	10
728	1	10
728	2	10
728	3	10
728	4	10
728	5	10
728	6	10
728	7	10
728	8	10
728	9	10
728	10	10
728	11	0
728	12	0
728	13	0
728	14	0
728	16	0
728	17	10
729	1	10
729	2	10
729	3	10
729	4	10
729	5	10
729	6	10
729	7	10
729	8	10
729	9	10
729	10	10
729	11	0
729	12	0
729	13	0
729	14	0
729	16	0
729	17	10
730	1	10
730	2	10
730	3	10
730	4	10
730	5	10
730	6	10
730	7	10
730	8	10
730	9	10
730	10	10
730	11	0
730	12	0
730	13	0
730	14	0
730	16	0
730	17	10
731	1	10
731	2	10
731	3	10
731	4	10
731	5	10
731	6	10
731	7	10
731	8	10
731	9	10
731	10	10
731	11	0
731	12	0
731	13	0
731	14	0
731	16	0
731	17	10
732	1	10
732	2	10
732	3	10
732	4	10
732	5	10
732	6	10
732	7	10
732	8	10
732	9	10
732	10	10
732	11	0
732	12	0
732	13	0
732	14	0
732	16	0
732	17	10
733	1	10
733	2	10
733	3	10
733	4	10
733	5	10
733	6	10
733	7	10
733	8	10
733	9	10
733	10	10
733	11	0
733	12	0
733	13	0
733	14	0
733	16	0
733	17	10
734	1	10
734	2	10
734	3	10
734	4	10
734	5	10
734	6	10
734	7	10
734	8	10
734	9	10
734	10	10
734	11	0
734	12	0
734	13	0
734	14	0
734	16	0
734	17	10
735	1	10
735	2	10
735	3	10
735	4	10
735	5	10
735	6	10
735	7	10
735	8	10
735	9	10
735	10	10
735	11	0
735	12	0
735	13	0
735	14	0
735	16	0
735	17	10
736	1	10
736	2	10
736	3	10
736	4	10
736	5	10
736	6	10
736	7	10
736	8	10
736	9	10
736	10	10
736	11	0
736	12	0
736	13	0
736	14	0
736	16	0
736	17	10
737	1	10
737	2	10
737	3	10
737	4	10
737	5	10
737	6	10
737	7	10
737	8	10
737	9	10
737	10	10
737	11	0
737	12	0
737	13	0
737	14	0
737	16	0
737	17	10
738	1	10
738	2	10
738	3	10
738	4	10
738	5	10
738	6	10
738	7	10
738	8	10
738	9	10
738	10	10
738	11	0
738	12	0
738	13	0
738	14	0
738	16	0
738	17	10
739	1	10
739	2	10
739	3	10
739	4	10
739	5	10
739	6	10
739	7	10
739	8	10
739	9	10
739	10	10
739	11	0
739	12	0
739	13	0
739	14	0
739	16	0
739	17	10
740	1	10
740	2	10
740	3	10
740	4	10
740	5	10
740	6	10
740	7	10
740	8	10
740	9	10
740	10	10
740	11	0
740	12	0
740	13	0
740	14	0
740	16	0
740	17	10
741	1	10
741	2	10
741	3	10
741	4	10
741	5	10
741	6	10
741	7	10
741	8	10
741	9	10
741	10	10
741	11	0
741	12	0
741	13	0
741	14	0
741	16	0
741	17	10
742	1	10
742	2	10
742	3	10
742	4	10
742	5	10
742	6	10
742	7	10
742	8	10
742	9	10
742	10	10
742	11	0
742	12	0
742	13	0
742	14	0
742	16	0
742	17	10
743	1	10
743	2	10
743	3	10
743	4	10
743	5	10
743	6	10
743	7	10
743	8	10
743	9	10
743	10	10
743	11	0
743	12	0
743	13	0
743	14	0
743	16	0
743	17	10
744	1	10
744	2	10
744	3	10
744	4	10
744	5	10
744	6	10
744	7	10
744	8	10
744	9	10
744	10	10
744	11	0
744	12	0
744	13	0
744	14	0
744	16	0
744	17	10
745	1	10
745	2	10
745	3	10
745	4	10
745	5	10
745	6	10
745	7	10
745	8	10
745	9	10
745	10	10
745	11	0
745	12	0
745	13	0
745	14	0
745	16	0
745	17	10
746	1	10
746	2	10
746	3	10
746	4	10
746	5	10
746	6	10
746	7	10
746	8	10
746	9	10
746	10	10
746	11	0
746	12	0
746	13	0
746	14	0
746	16	0
746	17	10
747	1	10
747	2	10
747	3	10
747	4	10
747	5	10
747	6	10
747	7	10
747	8	10
747	9	10
747	10	10
747	11	0
747	12	0
747	13	0
747	14	0
747	16	0
747	17	10
748	1	10
748	2	10
748	3	10
748	4	10
748	5	10
748	6	10
748	7	10
748	8	10
748	9	10
748	10	10
748	11	0
748	12	0
748	13	0
748	14	0
748	16	0
748	17	10
749	1	10
749	2	10
749	3	10
749	4	10
749	5	10
749	6	10
749	7	10
749	8	10
749	9	10
749	10	10
749	11	0
749	12	0
749	13	0
749	14	0
749	16	0
749	17	10
750	1	10
750	2	10
750	3	10
750	4	10
750	5	10
750	6	10
750	7	10
750	8	10
750	9	10
750	10	10
750	11	0
750	12	0
750	13	0
750	14	0
750	16	0
750	17	10
751	1	10
751	2	10
751	3	10
751	4	10
751	5	10
751	6	10
751	7	10
751	8	10
751	9	10
751	10	10
751	11	0
751	12	0
751	13	0
751	14	0
751	16	0
751	17	10
752	1	10
752	2	10
752	3	10
752	4	10
752	5	10
752	6	10
752	7	10
752	8	10
752	9	10
752	10	10
752	11	0
752	12	0
752	13	0
752	14	0
752	16	0
752	17	10
753	1	10
753	2	10
753	3	10
753	4	10
753	5	10
753	6	10
753	7	10
753	8	10
753	9	10
753	10	10
753	11	0
753	12	0
753	13	0
753	14	0
753	16	0
753	17	10
754	1	10
754	2	10
754	3	10
754	4	10
754	5	10
754	6	10
754	7	10
754	8	10
754	9	10
754	10	10
754	11	0
754	12	1
754	13	0
754	14	0
754	15	0
754	16	0
754	17	10
755	1	10
755	2	10
755	3	10
755	4	10
755	5	10
755	6	10
755	7	10
755	8	10
755	9	10
755	10	10
755	11	0
755	12	0
755	13	0
755	14	0
755	16	0
755	17	10
756	1	10
756	2	10
756	3	10
756	4	10
756	5	10
756	6	10
756	7	10
756	8	10
756	9	10
756	10	10
756	11	0
756	12	0
756	13	0
756	14	0
756	16	0
756	17	10
757	1	10
757	2	10
757	3	10
757	4	10
757	5	10
757	6	10
757	7	10
757	8	10
757	9	10
757	10	10
757	11	0
757	12	0
757	13	0
757	14	0
757	16	0
757	17	10
758	1	10
758	2	10
758	3	10
758	4	10
758	5	10
758	6	10
758	7	10
758	8	10
758	9	10
758	10	10
758	11	0
758	12	0
758	13	0
758	14	0
758	16	0
758	17	10
759	1	10
759	2	10
759	3	10
759	4	10
759	5	10
759	6	10
759	7	10
759	8	10
759	9	10
759	10	10
759	11	0
759	12	0
759	13	0
759	14	0
759	16	0
759	17	10
760	1	10
760	2	10
760	3	10
760	4	10
760	5	10
760	6	10
760	7	10
760	8	10
760	9	10
760	10	10
760	11	0
760	12	0
760	13	0
760	14	0
760	16	0
760	17	10
761	1	10
761	2	10
761	3	10
761	4	10
761	5	10
761	6	10
761	7	10
761	8	10
761	9	10
761	10	10
761	11	0
761	12	0
761	13	0
761	14	0
761	16	0
761	17	10
762	1	10
762	2	10
762	3	10
762	4	10
762	5	10
762	6	10
762	7	10
762	8	10
762	9	10
762	10	10
762	11	0
762	12	0
762	13	0
762	14	0
762	16	0
762	17	10
763	1	10
763	2	10
763	3	10
763	4	10
763	5	10
763	6	10
763	7	10
763	8	10
763	9	10
763	10	10
763	11	0
763	12	0
763	13	0
763	14	0
763	16	0
763	17	10
764	1	10
764	2	10
764	3	10
764	4	10
764	5	10
764	6	10
764	7	10
764	8	10
764	9	10
764	10	10
764	11	0
764	12	0
764	13	0
764	14	0
764	16	0
764	17	10
765	1	10
765	2	10
765	3	10
765	4	10
765	5	10
765	6	10
765	7	10
765	8	10
765	9	10
765	10	10
765	11	0
765	12	0
765	13	0
765	14	0
765	16	0
765	17	10
766	1	10
766	2	10
766	3	10
766	4	10
766	5	10
766	6	10
766	7	10
766	8	10
766	9	10
766	10	10
766	11	0
766	12	0
766	13	0
766	14	0
766	16	0
766	17	10
767	1	10
767	2	10
767	3	10
767	4	10
767	5	10
767	6	10
767	7	10
767	8	10
767	9	10
767	10	10
767	11	0
767	12	0
767	13	0
767	14	0
767	16	0
767	17	10
768	1	10
768	2	10
768	3	10
768	4	10
768	5	10
768	6	10
768	7	10
768	8	10
768	9	10
768	10	10
768	11	0
768	12	0
768	13	0
768	14	0
768	16	0
768	17	10
769	1	10
769	2	10
769	3	10
769	4	10
769	5	10
769	6	10
769	7	10
769	8	10
769	9	10
769	10	10
769	11	0
769	12	0
769	13	0
769	14	0
769	16	0
769	17	10
770	1	10
770	2	10
770	3	10
770	4	10
770	5	10
770	6	10
770	7	10
770	8	10
770	9	10
770	10	10
770	11	0
770	12	0
770	13	0
770	14	0
770	16	0
770	17	10
771	1	10
771	2	10
771	3	10
771	4	10
771	5	10
771	6	10
771	7	10
771	8	10
771	9	10
771	10	10
771	11	0
771	12	0
771	13	0
771	14	0
771	16	0
771	17	10
772	1	10
772	2	10
772	3	10
772	4	10
772	5	10
772	6	10
772	7	10
772	8	10
772	9	10
772	10	10
772	11	0
772	12	0
772	13	0
772	14	0
772	16	0
772	17	10
773	1	10
773	2	10
773	3	10
773	4	10
773	5	10
773	6	10
773	7	10
773	8	10
773	9	10
773	10	10
773	11	0
773	12	0
773	13	0
773	14	0
773	16	0
773	17	10
774	1	10
774	2	10
774	3	10
774	4	10
774	5	10
774	6	10
774	7	10
774	8	10
774	9	10
774	10	10
774	11	0
774	12	0
774	13	0
774	14	0
774	16	0
774	17	10
775	1	10
775	2	10
775	3	10
775	4	10
775	5	10
775	6	10
775	7	10
775	8	10
775	9	10
775	10	10
775	11	0
775	12	0
775	13	0
775	14	0
775	16	0
775	17	10
776	1	10
776	2	10
776	3	10
776	4	10
776	5	10
776	6	10
776	7	10
776	8	10
776	9	10
776	10	10
776	11	0
776	12	0
776	13	0
776	14	0
776	16	0
776	17	10
777	1	10
777	2	10
777	3	10
777	4	10
777	5	10
777	6	10
777	7	10
777	8	10
777	9	10
777	10	10
777	11	0
777	12	0
777	13	0
777	14	0
777	16	0
777	17	10
778	1	10
778	2	10
778	3	10
778	4	10
778	5	10
778	6	10
778	7	10
778	8	10
778	9	10
778	10	10
778	11	0
778	12	0
778	13	0
778	14	0
778	16	0
778	17	10
779	1	10
779	2	10
779	3	10
779	4	10
779	5	10
779	6	10
779	7	10
779	8	10
779	9	10
779	10	10
779	11	0
779	12	0
779	13	0
779	14	0
779	16	0
779	17	10
780	1	10
780	2	10
780	3	10
780	4	10
780	5	10
780	6	10
780	7	10
780	8	10
780	9	10
780	10	10
780	11	0
780	12	0
780	13	0
780	14	0
780	16	0
780	17	10
781	1	10
781	2	10
781	3	10
781	4	10
781	5	10
781	6	10
781	7	10
781	8	10
781	9	10
781	10	10
781	11	0
781	12	0
781	13	0
781	14	0
781	16	0
781	17	10
782	1	10
782	2	10
782	3	10
782	4	10
782	5	10
782	6	10
782	7	10
782	8	10
782	9	10
782	10	10
782	11	0
782	12	0
782	13	0
782	14	0
782	16	0
782	17	10
783	1	10
783	2	10
783	3	10
783	4	10
783	5	10
783	6	10
783	7	10
783	8	10
783	9	10
783	10	10
783	11	0
783	12	0
783	13	0
783	14	0
783	16	0
783	17	10
784	1	10
784	2	10
784	3	10
784	4	10
784	5	10
784	6	10
784	7	10
784	8	10
784	9	10
784	10	10
784	11	0
784	12	0
784	13	0
784	14	0
784	16	0
784	17	10
785	1	10
785	2	10
785	3	10
785	4	10
785	5	10
785	6	10
785	7	10
785	8	10
785	9	10
785	10	10
785	11	0
785	12	0
785	13	0
785	14	0
785	16	0
785	17	10
786	1	10
786	2	10
786	3	10
786	4	10
786	5	10
786	6	10
786	7	10
786	8	10
786	9	10
786	10	10
786	11	0
786	12	0
786	13	0
786	14	0
786	16	0
786	17	10
787	1	10
787	2	10
787	3	10
787	4	10
787	5	10
787	6	10
787	7	10
787	8	10
787	9	10
787	10	10
787	11	0
787	12	0
787	13	0
787	14	0
787	16	0
787	17	10
788	1	10
788	2	10
788	3	10
788	4	10
788	5	10
788	6	10
788	7	10
788	8	10
788	9	10
788	10	10
788	11	0
788	12	0
788	13	0
788	14	0
788	16	0
788	17	10
789	1	10
789	2	10
789	3	10
789	4	10
789	5	10
789	6	10
789	7	10
789	8	10
789	9	10
789	10	10
789	11	0
789	12	0
789	13	0
789	14	0
789	16	0
789	17	10
790	1	10
790	2	10
790	3	10
790	4	10
790	5	10
790	6	10
790	7	10
790	8	10
790	9	10
790	10	10
790	11	0
790	12	0
790	13	0
790	14	0
790	16	0
790	17	10
791	1	10
791	2	10
791	3	10
791	4	10
791	5	10
791	6	10
791	7	10
791	8	10
791	9	10
791	10	10
791	11	0
791	12	0
791	13	0
791	14	0
791	16	0
791	17	10
792	1	10
792	2	10
792	3	10
792	4	10
792	5	10
792	6	10
792	7	10
792	8	10
792	9	10
792	10	10
792	11	0
792	12	0
792	13	0
792	14	0
792	16	0
792	17	10
793	1	10
793	2	10
793	3	10
793	4	10
793	5	10
793	6	10
793	7	10
793	8	10
793	9	10
793	10	10
793	11	0
793	12	0
793	13	0
793	14	0
793	16	0
793	17	10
794	1	10
794	2	10
794	3	10
794	4	10
794	5	10
794	6	10
794	7	10
794	8	10
794	9	10
794	10	10
794	11	0
794	12	0
794	13	0
794	14	0
794	16	0
794	17	10
795	1	10
795	2	10
795	3	10
795	4	10
795	5	10
795	6	10
795	7	10
795	8	10
795	9	10
795	10	10
795	11	0
795	12	0
795	13	0
795	14	0
795	16	0
795	17	10
796	1	10
796	2	10
796	3	10
796	4	10
796	5	10
796	6	10
796	7	10
796	8	10
796	9	10
796	10	10
796	11	0
796	12	0
796	13	0
796	14	0
796	16	0
796	17	10
797	1	10
797	2	10
797	3	10
797	4	10
797	5	10
797	6	10
797	7	10
797	8	10
797	9	10
797	10	10
797	11	0
797	12	0
797	13	0
797	14	0
797	16	0
797	17	10
798	1	10
798	2	10
798	3	10
798	4	10
798	5	10
798	6	10
798	7	10
798	8	10
798	9	10
798	10	10
798	11	0
798	12	0
798	13	0
798	14	0
798	16	0
798	17	10
799	1	10
799	2	10
799	3	10
799	4	10
799	5	10
799	6	10
799	7	10
799	8	10
799	9	10
799	10	10
799	11	0
799	12	0
799	13	0
799	14	0
799	16	0
799	17	10
800	1	10
800	2	10
800	3	10
800	4	10
800	5	10
800	6	10
800	7	10
800	8	10
800	9	10
800	10	10
800	11	0
800	12	0
800	13	0
800	14	0
800	16	0
800	17	10
801	1	10
801	2	10
801	3	10
801	4	10
801	5	10
801	6	10
801	7	10
801	8	10
801	9	10
801	10	10
801	11	0
801	12	0
801	13	0
801	14	0
801	16	0
801	17	10
802	1	10
802	2	10
802	3	10
802	4	10
802	5	10
802	6	10
802	7	10
802	8	10
802	9	10
802	10	10
802	11	0
802	12	0
802	13	0
802	14	0
802	16	0
802	17	10
803	1	10
803	2	10
803	3	10
803	4	10
803	5	10
803	6	10
803	7	10
803	8	10
803	9	10
803	10	10
803	11	0
803	12	0
803	13	0
803	14	0
803	16	0
803	17	10
804	1	10
804	2	10
804	3	10
804	4	10
804	5	10
804	6	10
804	7	10
804	8	10
804	9	10
804	10	10
804	11	0
804	12	0
804	13	0
804	14	0
804	16	0
804	17	10
805	1	10
805	2	10
805	3	10
805	4	10
805	5	10
805	6	10
805	7	10
805	8	10
805	9	10
805	10	10
805	11	0
805	12	0
805	13	0
805	14	0
805	16	0
805	17	10
806	1	10
806	2	10
806	3	10
806	4	10
806	5	10
806	6	10
806	7	10
806	8	10
806	9	10
806	10	10
806	11	0
806	12	0
806	13	0
806	14	0
806	16	0
806	17	10
807	1	10
807	2	10
807	3	10
807	4	10
807	5	10
807	6	10
807	7	10
807	8	10
807	9	10
807	10	10
807	11	0
807	12	0
807	13	0
807	14	0
807	16	0
807	17	10
808	1	10
808	2	10
808	3	10
808	4	10
808	5	10
808	6	10
808	7	10
808	8	10
808	9	10
808	10	10
808	11	0
808	12	0
808	13	0
808	14	0
808	16	0
808	17	10
809	1	10
809	2	10
809	3	10
809	4	10
809	5	10
809	6	10
809	7	10
809	8	10
809	9	10
809	10	10
809	11	0
809	12	0
809	13	0
809	14	0
809	16	0
809	17	10
810	1	10
810	2	10
810	3	10
810	4	10
810	5	10
810	6	10
810	7	10
810	8	10
810	9	10
810	10	10
810	11	0
810	12	0
810	13	0
810	14	0
810	16	0
810	17	10
811	1	10
811	2	10
811	3	10
811	4	10
811	5	10
811	6	10
811	7	10
811	8	10
811	9	10
811	10	10
811	11	0
811	12	0
811	13	0
811	14	0
811	16	0
811	17	10
812	1	10
812	2	10
812	3	10
812	4	10
812	5	10
812	6	10
812	7	10
812	8	10
812	9	10
812	10	10
812	11	0
812	12	0
812	13	0
812	14	0
812	16	0
812	17	10
813	1	10
813	2	10
813	3	10
813	4	10
813	5	10
813	6	10
813	7	10
813	8	10
813	9	10
813	10	10
813	11	0
813	12	0
813	13	0
813	14	0
813	16	0
813	17	10
814	1	10
814	2	10
814	3	10
814	4	10
814	5	10
814	6	10
814	7	10
814	8	10
814	9	10
814	10	10
814	11	0
814	12	0
814	13	0
814	14	0
814	16	0
814	17	10
815	1	10
815	2	10
815	3	10
815	4	10
815	5	10
815	6	10
815	7	10
815	8	10
815	9	10
815	10	10
815	11	0
815	12	0
815	13	0
815	14	0
815	16	0
815	17	10
816	1	10
816	2	10
816	3	10
816	4	10
816	5	10
816	6	10
816	7	10
816	8	10
816	9	10
816	10	10
816	11	10
816	12	10
816	13	10
817	1	10
817	2	10
817	3	10
817	4	10
817	5	10
817	6	10
817	7	10
817	8	10
817	9	10
817	10	10
817	11	0
817	12	0
817	13	0
817	14	0
817	16	0
817	17	10
819	1	10
819	2	10
819	3	10
819	4	10
819	5	10
819	6	10
819	7	10
819	8	10
819	9	10
819	10	10
819	11	10
819	12	10
819	13	10
820	1	10
820	2	10
820	3	10
820	4	10
820	5	10
820	6	10
820	7	10
820	8	10
820	9	10
820	10	10
820	11	0
820	12	0
820	13	0
820	14	0
820	16	0
820	17	10
821	1	10
821	2	10
821	3	10
821	4	10
821	5	10
821	6	10
821	7	10
821	8	10
821	9	10
821	10	10
821	11	0
821	12	0
821	13	0
821	14	0
821	16	0
821	17	10
822	1	10
822	2	10
822	3	10
822	4	10
822	5	10
822	6	10
822	7	10
822	8	10
822	9	10
822	10	10
822	11	0
822	12	0
822	13	0
822	14	0
822	16	0
822	17	10
823	1	10
823	2	10
823	3	10
823	4	10
823	5	10
823	6	10
823	7	10
823	8	10
823	9	10
823	10	10
823	11	0
823	12	0
823	13	0
823	14	0
823	16	0
823	17	10
824	1	10
824	2	10
824	3	10
824	4	10
824	5	10
824	6	10
824	7	10
824	8	10
824	9	10
824	10	10
824	11	0
824	12	0
824	13	0
824	14	0
824	16	0
824	17	10
825	1	10
825	2	10
825	3	10
825	4	10
825	5	10
825	6	10
825	7	10
825	8	10
825	9	10
825	10	10
825	11	10
825	12	10
825	13	10
826	1	10
826	2	10
826	3	10
826	4	10
826	5	10
826	6	10
826	7	10
826	8	10
826	9	10
826	10	10
826	11	0
826	12	0
826	13	0
826	14	0
826	16	0
826	17	10
827	1	10
827	2	10
827	3	10
827	4	10
827	5	10
827	6	10
827	7	10
827	8	10
827	9	10
827	10	10
827	11	0
827	12	0
827	13	0
827	14	0
827	16	0
827	17	10
828	1	10
828	2	10
828	3	10
828	4	10
828	5	10
828	6	10
828	7	10
828	8	10
828	9	10
828	10	10
828	11	10
828	12	10
828	13	10
829	1	10
829	2	10
829	3	10
829	4	10
829	5	10
829	6	10
829	7	10
829	8	10
829	9	10
829	10	10
829	11	0
829	12	0
829	13	0
829	14	0
829	16	0
829	17	10
830	1	10
830	2	10
830	3	10
830	4	10
830	5	10
830	6	10
830	7	10
830	8	10
830	9	10
830	10	10
830	11	0
830	12	0
830	13	0
830	14	0
830	16	0
830	17	10
831	1	10
831	2	10
831	3	10
831	4	10
831	5	10
831	6	10
831	7	10
831	8	10
831	9	10
831	10	10
831	11	0
831	12	0
831	13	0
831	14	0
831	16	0
831	17	10
832	1	10
832	2	8
832	3	10
832	4	10
832	5	10
832	6	10
832	7	10
832	8	10
832	9	10
832	10	10
832	11	10
832	12	10
832	13	10
833	1	10
833	2	10
833	3	10
833	4	10
833	5	10
833	6	10
833	7	10
833	8	10
833	9	10
833	10	10
833	11	0
833	12	0
833	13	0
833	14	0
833	16	0
833	17	10
834	1	10
834	2	10
834	3	10
834	4	10
834	5	10
834	6	10
834	7	10
834	8	10
834	9	10
834	10	10
834	11	10
834	12	10
834	13	10
835	1	10
835	2	10
835	3	10
835	4	10
835	5	10
835	6	10
835	7	10
835	8	10
835	9	10
835	10	10
835	11	0
835	12	0
835	13	0
835	14	0
835	16	0
835	17	10
836	1	10
836	2	10
836	3	10
836	4	10
836	5	10
836	6	10
836	7	10
836	8	10
836	9	10
836	10	10
836	11	0
836	12	0
836	13	0
836	14	0
836	16	0
836	17	10
839	1	10
839	2	10
839	3	10
839	4	10
839	5	10
839	6	10
839	7	10
839	8	10
839	9	10
839	10	10
839	11	0
839	12	0
839	13	0
839	14	0
839	16	0
839	17	10
840	1	10
840	2	10
840	3	10
840	4	10
840	5	10
840	6	10
840	7	10
840	8	10
840	9	10
840	10	10
840	11	10
840	12	10
840	13	10
841	1	10
841	2	10
841	3	10
841	4	10
841	5	10
841	6	10
841	7	10
841	8	10
841	9	10
841	10	10
841	11	0
841	12	0
841	13	0
841	14	0
841	16	0
841	17	10
842	1	10
842	2	10
842	3	10
842	4	10
842	5	10
842	6	10
842	7	10
842	8	10
842	9	10
842	10	10
842	11	10
842	12	10
842	13	10
843	1	10
843	2	10
843	3	10
843	4	10
843	5	10
843	6	10
843	7	10
843	8	10
843	9	10
843	10	10
843	11	0
843	12	0
843	13	0
843	14	0
843	16	0
843	17	10
844	1	10
844	2	10
844	3	10
844	4	10
844	5	10
844	6	10
844	7	10
844	8	10
844	9	10
844	10	10
844	11	0
844	12	0
844	13	0
844	14	0
844	16	0
844	17	10
845	1	10
845	2	10
845	3	10
845	4	10
845	5	10
845	6	10
845	7	10
845	8	10
845	9	10
845	10	10
845	11	0
845	12	0
845	13	0
845	14	0
845	16	0
845	17	10
846	1	10
846	2	10
846	3	10
846	4	10
846	5	8
846	6	10
846	7	10
846	8	10
846	9	10
846	10	10
846	11	10
846	12	10
846	13	10
847	1	10
847	2	10
847	3	10
847	4	10
847	5	10
847	6	10
847	7	10
847	8	10
847	9	10
847	10	10
847	11	0
847	12	0
847	13	0
847	14	0
847	16	0
847	17	10
848	1	10
848	2	10
848	3	10
848	4	10
848	5	10
848	6	10
848	7	10
848	8	10
848	9	10
848	10	10
848	11	10
848	12	10
848	13	10
849	1	10
849	2	10
849	3	10
849	4	10
849	5	10
849	6	10
849	7	10
849	8	10
849	9	10
849	10	10
849	11	0
849	12	0
849	13	0
849	14	0
849	16	0
849	17	10
850	1	10
850	2	10
850	3	10
850	4	10
850	5	10
850	6	10
850	7	10
850	8	10
850	9	10
850	10	10
850	11	10
850	12	10
850	13	10
851	1	10
851	2	10
851	3	10
851	4	10
851	5	10
851	6	10
851	7	10
851	8	10
851	9	10
851	10	10
851	11	10
851	12	10
851	13	10
852	1	10
852	2	10
852	3	10
852	4	10
852	5	10
852	6	10
852	7	10
852	8	10
852	9	10
852	10	10
852	11	0
852	12	0
852	13	0
852	14	0
852	16	0
852	17	10
853	1	10
853	2	10
853	3	10
853	4	10
853	5	10
853	6	10
853	7	10
853	8	10
853	9	10
853	10	10
853	11	0
853	12	0
853	13	0
853	14	0
853	16	0
853	17	10
854	1	10
854	2	10
854	3	10
854	4	10
854	5	10
854	6	10
854	7	10
854	8	10
854	9	10
854	10	10
854	11	10
854	12	10
854	13	10
856	1	10
856	2	10
856	3	10
856	4	10
856	5	10
856	6	10
856	7	10
856	8	10
856	9	10
856	10	10
856	11	0
856	12	0
856	13	0
856	14	0
856	16	0
856	17	10
857	1	10
857	2	10
857	3	10
857	4	10
857	5	8
857	6	10
857	7	10
857	8	10
857	9	10
857	10	10
857	11	10
857	12	10
857	13	10
858	1	10
858	2	10
858	3	10
858	4	10
858	5	10
858	6	10
858	7	10
858	8	10
858	9	10
858	10	10
858	11	0
858	12	0
858	13	0
858	14	0
858	16	0
858	17	10
859	1	10
859	2	10
859	3	10
859	4	10
859	5	8
859	6	10
859	7	10
859	8	10
859	9	10
859	10	10
859	11	10
859	12	10
859	13	10
860	1	10
860	2	10
860	3	10
860	4	10
860	5	10
860	6	10
860	7	10
860	8	10
860	9	10
860	10	10
860	11	0
860	12	0
860	13	0
860	14	0
860	16	0
860	17	10
861	1	10
861	2	10
861	3	10
861	4	10
861	5	10
861	6	10
861	7	10
861	8	10
861	9	10
861	10	10
861	11	10
861	12	10
861	13	10
862	1	10
862	2	10
862	3	10
862	4	10
862	5	10
862	6	10
862	7	10
862	8	10
862	9	10
862	10	10
862	11	0
862	12	0
862	13	0
862	14	0
862	16	0
862	17	10
863	1	10
863	2	10
863	3	10
863	4	10
863	5	10
863	6	10
863	7	10
863	8	10
863	9	10
863	10	10
863	11	0
863	12	0
863	13	0
863	14	0
863	16	0
863	17	10
864	1	10
864	2	10
864	3	10
864	4	10
864	5	10
864	6	10
864	7	10
864	8	10
864	9	10
864	10	10
864	11	0
864	12	0
864	13	0
864	14	0
864	16	0
864	17	10
865	1	10
865	2	10
865	3	10
865	4	10
865	5	10
865	6	6
865	7	6
865	8	8
865	9	6
865	10	10
865	11	8
865	12	10
865	13	10
866	1	10
866	2	10
866	3	10
866	4	10
866	5	10
866	6	10
866	7	10
866	8	10
866	9	10
866	10	10
866	11	0
866	12	0
866	13	0
866	14	0
866	16	0
866	17	10
867	1	10
867	2	10
867	3	10
867	4	10
867	5	10
867	6	10
867	7	10
867	8	10
867	9	10
867	10	10
867	11	10
867	12	10
867	13	10
868	1	10
868	2	10
868	3	10
868	4	10
868	5	10
868	6	10
868	7	10
868	8	10
868	9	10
868	10	10
868	11	1
868	12	0
868	13	0
868	14	0
868	15	1
868	16	0
868	17	10
869	1	10
869	2	10
869	3	10
869	4	10
869	5	10
869	6	10
869	7	10
869	8	10
869	9	10
869	10	10
869	11	10
869	12	10
869	13	10
870	1	10
870	2	10
870	3	10
870	4	10
870	5	10
870	6	10
870	7	10
870	8	10
870	9	10
870	10	10
870	11	0
870	12	0
870	13	0
870	14	0
870	16	0
870	17	10
871	1	10
871	2	10
871	3	10
871	4	10
871	5	10
871	6	10
871	7	10
871	8	10
871	9	10
871	10	10
871	11	0
871	12	0
871	13	0
871	14	0
871	16	0
871	17	10
872	1	10
872	2	10
872	3	10
872	4	10
872	5	10
872	6	10
872	7	10
872	8	10
872	9	10
872	10	10
872	11	0
872	12	0
872	13	0
872	14	0
872	16	0
872	17	10
873	1	10
873	2	10
873	3	10
873	4	10
873	5	10
873	6	10
873	7	10
873	8	10
873	9	10
873	10	10
873	11	10
873	12	10
873	13	10
874	1	10
874	2	10
874	3	10
874	4	10
874	5	10
874	6	10
874	7	10
874	8	10
874	9	10
874	10	10
874	11	0
874	12	0
874	13	0
874	14	0
874	16	0
874	17	10
875	1	10
875	2	10
875	3	10
875	4	10
875	5	10
875	6	10
875	7	10
875	8	10
875	9	10
875	10	10
875	11	0
875	12	0
875	13	0
875	14	0
875	16	0
875	17	10
876	1	10
876	2	10
876	3	10
876	4	10
876	5	10
876	6	10
876	7	10
876	8	10
876	9	10
876	10	10
876	11	0
876	12	0
876	13	0
876	14	0
876	16	0
876	17	10
877	1	10
877	2	10
877	3	10
877	4	10
877	5	10
877	6	10
877	7	10
877	8	10
877	9	10
877	10	10
877	11	10
877	12	10
877	13	10
878	1	10
878	2	10
878	3	10
878	4	10
878	5	10
878	6	10
878	7	10
878	8	10
878	9	10
878	10	10
878	11	0
878	12	0
878	13	0
878	14	0
878	16	0
878	17	10
879	1	10
879	2	10
879	3	10
879	4	10
879	5	10
879	6	10
879	7	10
879	8	10
879	9	10
879	10	10
879	11	0
879	12	0
879	13	0
879	14	0
879	16	0
879	17	10
880	1	10
880	2	10
880	3	10
880	4	10
880	5	10
880	6	10
880	7	10
880	8	10
880	9	10
880	10	10
880	11	0
880	12	0
880	13	0
880	14	0
880	16	0
880	17	10
881	1	10
881	2	10
881	3	10
881	4	10
881	5	10
881	6	10
881	7	10
881	8	10
881	9	10
881	10	10
881	11	10
881	12	10
881	13	10
882	1	10
882	2	10
882	3	10
882	4	10
882	5	10
882	6	10
882	7	10
882	8	10
882	9	10
882	10	10
882	11	0
882	12	0
882	13	0
882	14	0
882	16	0
882	17	10
883	1	10
883	2	10
883	3	10
883	4	10
883	5	10
883	6	10
883	7	10
883	8	10
883	9	10
883	10	10
883	11	0
883	12	0
883	13	0
883	14	0
883	16	0
883	17	10
884	1	10
884	2	10
884	3	10
884	4	10
884	5	10
884	6	10
884	7	10
884	8	10
884	9	10
884	10	10
884	11	0
884	12	0
884	13	0
884	14	0
884	16	0
884	17	10
885	1	10
885	2	10
885	3	10
885	4	10
885	5	10
885	6	10
885	7	10
885	8	10
885	9	10
885	10	10
885	11	0
885	12	0
885	13	0
885	14	0
885	16	0
885	17	10
886	1	10
886	2	10
886	3	10
886	4	10
886	5	10
886	6	10
886	7	10
886	8	10
886	9	10
886	10	10
886	11	0
886	12	0
886	13	0
886	14	0
886	16	0
886	17	10
887	1	10
887	2	10
887	3	10
887	4	10
887	5	10
887	6	10
887	7	10
887	8	10
887	9	10
887	10	10
887	11	0
887	12	0
887	13	0
887	14	0
887	16	0
887	17	10
888	1	10
888	2	10
888	3	10
888	4	10
888	5	10
888	6	10
888	7	10
888	8	10
888	9	10
888	10	10
888	11	0
888	12	0
888	13	0
888	14	0
888	16	0
888	17	10
889	1	10
889	2	10
889	3	10
889	4	10
889	5	10
889	6	10
889	7	10
889	8	10
889	9	10
889	10	10
889	11	0
889	12	0
889	13	0
889	14	0
889	16	0
889	17	10
890	1	10
890	2	10
890	3	10
890	4	10
890	5	10
890	6	10
890	7	10
890	8	10
890	9	10
890	10	10
890	11	0
890	12	0
890	13	0
890	14	0
890	16	0
890	17	10
891	1	10
891	2	10
891	3	10
891	4	10
891	5	10
891	6	10
891	7	10
891	8	10
891	9	10
891	10	10
891	11	0
891	12	0
891	13	0
891	14	0
891	16	0
891	17	10
892	1	10
892	2	10
892	3	10
892	4	10
892	5	10
892	6	10
892	7	10
892	8	10
892	9	10
892	10	10
892	11	0
892	12	0
892	13	0
892	14	0
892	16	0
892	17	10
893	1	10
893	2	10
893	3	10
893	4	10
893	5	10
893	6	10
893	7	10
893	8	10
893	9	10
893	10	10
893	11	0
893	12	0
893	13	0
893	14	0
893	16	0
893	17	10
894	1	10
894	2	10
894	3	10
894	4	10
894	5	10
894	6	10
894	7	10
894	8	10
894	9	10
894	10	10
894	11	0
894	12	0
894	13	0
894	14	0
894	16	0
894	17	10
895	1	10
895	2	10
895	3	10
895	4	10
895	5	10
895	6	10
895	7	10
895	8	10
895	9	10
895	10	10
895	11	0
895	12	0
895	13	0
895	14	0
895	16	0
895	17	10
896	1	10
896	2	10
896	3	10
896	4	10
896	5	10
896	6	10
896	7	10
896	8	10
896	9	10
896	10	10
896	11	0
896	12	0
896	13	0
896	14	0
896	16	0
896	17	10
897	1	10
897	2	10
897	3	10
897	4	10
897	5	10
897	6	10
897	7	8
897	8	10
897	9	10
897	10	10
897	11	10
897	12	10
897	13	10
898	1	10
898	2	10
898	3	10
898	4	10
898	5	10
898	6	10
898	7	10
898	8	10
898	9	10
898	10	10
898	11	0
898	12	0
898	13	0
898	14	0
898	16	0
898	17	8
899	1	10
899	2	10
899	3	10
899	4	10
899	5	10
899	6	10
899	7	10
899	8	10
899	9	10
899	10	10
899	11	10
899	12	10
899	13	10
900	1	10
900	2	10
900	3	10
900	4	10
900	5	10
900	6	10
900	7	10
900	8	10
900	9	10
900	10	10
900	11	0
900	12	0
900	13	0
900	14	0
900	16	0
900	17	10
901	1	10
901	2	10
901	3	10
901	4	10
901	5	10
901	6	10
901	7	10
901	8	10
901	9	10
901	10	10
901	11	0
901	12	0
901	13	0
901	14	0
901	16	0
901	17	10
902	1	10
902	2	10
902	3	10
902	4	10
902	5	10
902	6	10
902	7	10
902	8	10
902	9	10
902	10	10
902	11	0
902	12	0
902	13	0
902	14	0
902	16	0
902	17	10
903	1	10
903	2	10
903	3	10
903	4	10
903	5	10
903	6	10
903	7	10
903	8	10
903	9	10
903	10	10
903	11	10
903	12	10
903	13	10
904	1	10
904	2	10
904	3	10
904	4	10
904	5	10
904	6	10
904	7	10
904	8	10
904	9	10
904	10	10
904	11	0
904	12	0
904	13	0
904	14	0
904	16	0
904	17	10
905	1	10
905	2	10
905	3	10
905	4	10
905	5	10
905	6	10
905	7	10
905	8	10
905	9	10
905	10	10
905	11	10
905	12	10
905	13	10
906	1	10
906	2	10
906	3	10
906	4	10
906	5	10
906	6	10
906	7	10
906	8	10
906	9	10
906	10	10
906	11	10
906	12	10
906	13	10
907	1	10
907	2	10
907	3	10
907	4	10
907	5	10
907	6	10
907	7	10
907	8	10
907	9	10
907	10	10
907	11	0
907	12	0
907	13	0
907	14	0
907	16	0
907	17	10
908	1	10
908	2	10
908	3	10
908	4	10
908	5	10
908	6	10
908	7	10
908	8	10
908	9	10
908	10	10
908	11	10
908	12	10
908	13	10
909	1	10
909	2	10
909	3	10
909	4	10
909	5	10
909	6	10
909	7	10
909	8	10
909	9	10
909	10	10
909	11	0
909	12	0
909	13	0
909	14	0
909	16	0
909	17	10
910	1	10
910	2	10
910	3	10
910	4	10
910	5	10
910	6	10
910	7	10
910	8	10
910	9	10
910	10	10
910	11	0
910	12	0
910	13	0
910	14	0
910	16	0
910	17	10
911	1	10
911	2	10
911	3	10
911	4	10
911	5	10
911	6	10
911	7	10
911	8	10
911	9	10
911	10	10
911	11	0
911	12	0
911	13	0
911	14	0
911	16	0
911	17	10
912	1	10
912	2	10
912	3	10
912	4	10
912	5	10
912	6	10
912	7	10
912	8	10
912	9	10
912	10	10
912	11	10
912	12	10
912	13	10
913	1	10
913	2	10
913	3	10
913	4	10
913	5	10
913	6	10
913	7	10
913	8	10
913	9	10
913	10	10
913	11	0
913	12	0
913	13	0
913	14	0
913	16	0
913	17	10
914	1	10
914	2	10
914	3	10
914	4	10
914	5	10
914	6	10
914	7	10
914	8	10
914	9	10
914	10	10
914	11	0
914	12	0
914	13	0
914	14	0
914	16	0
914	17	10
915	1	10
915	2	10
915	3	10
915	4	10
915	5	10
915	6	10
915	7	10
915	8	10
915	9	10
915	10	10
915	11	0
915	12	0
915	13	0
915	14	0
915	16	0
915	17	10
916	1	10
916	2	10
916	3	10
916	4	10
916	5	10
916	6	10
916	7	10
916	8	10
916	9	10
916	10	10
916	11	0
916	12	0
916	13	0
916	14	0
916	16	0
916	17	10
917	1	10
917	2	10
917	3	10
917	4	10
917	5	10
917	6	10
917	7	10
917	8	10
917	9	10
917	10	10
917	11	0
917	12	0
917	13	0
917	14	0
917	16	0
917	17	10
918	1	10
918	2	10
918	3	10
918	4	10
918	5	10
918	6	10
918	7	10
918	8	10
918	9	10
918	10	10
918	11	0
918	12	0
918	13	0
918	14	0
918	16	0
918	17	10
919	1	10
919	2	10
919	3	10
919	4	10
919	5	10
919	6	6
919	7	10
919	8	10
919	9	10
919	10	10
919	11	10
919	12	10
919	13	10
920	1	10
920	2	10
920	3	10
920	4	10
920	5	10
920	6	10
920	7	10
920	8	10
920	9	10
920	10	10
920	11	10
920	12	10
920	13	10
921	1	10
921	2	10
921	3	10
921	4	10
921	5	10
921	6	10
921	7	10
921	8	10
921	9	10
921	10	10
921	11	0
921	12	0
921	13	0
921	14	0
921	16	0
921	17	10
922	1	10
922	2	10
922	3	10
922	4	10
922	5	10
922	6	10
922	7	10
922	8	10
922	9	10
922	10	10
922	11	10
922	12	10
922	13	10
923	1	10
923	2	10
923	3	10
923	4	10
923	5	10
923	6	10
923	7	10
923	8	10
923	9	10
923	10	10
923	11	0
923	12	0
923	13	0
923	14	0
923	16	0
923	17	10
924	1	10
924	2	10
924	3	10
924	4	10
924	5	10
924	6	10
924	7	10
924	8	10
924	9	10
924	10	10
924	11	10
924	12	10
924	13	10
925	1	10
925	2	10
925	3	10
925	4	10
925	5	10
925	6	10
925	7	10
925	8	10
925	9	10
925	10	10
925	11	0
925	12	0
925	13	0
925	14	0
925	16	0
925	17	10
926	1	10
926	2	10
926	3	10
926	4	10
926	5	10
926	6	10
926	7	10
926	8	10
926	9	10
926	10	10
926	11	0
926	12	0
926	13	0
926	14	0
926	16	0
926	17	10
927	1	10
927	2	10
927	3	10
927	4	10
927	5	10
927	6	10
927	7	10
927	8	10
927	9	10
927	10	10
927	11	0
927	12	0
927	13	0
927	14	0
927	16	0
927	17	10
928	1	10
928	2	10
928	3	10
928	4	10
928	5	10
928	6	10
928	7	10
928	8	10
928	9	10
928	10	10
928	11	0
928	12	0
928	13	0
928	14	0
928	16	0
928	17	10
929	1	10
929	2	10
929	3	10
929	4	10
929	5	10
929	6	10
929	7	10
929	8	10
929	9	10
929	10	10
929	11	0
929	12	0
929	13	0
929	14	0
929	16	0
929	17	10
930	1	10
930	2	10
930	3	10
930	4	10
930	5	10
930	6	10
930	7	10
930	8	10
930	9	10
930	10	10
930	11	10
930	12	10
930	13	10
931	1	10
931	2	10
931	3	10
931	4	10
931	5	10
931	6	10
931	7	10
931	8	10
931	9	10
931	10	10
931	11	0
931	12	0
931	13	0
931	14	0
931	16	0
931	17	10
932	1	10
932	2	10
932	3	10
932	4	10
932	5	10
932	6	10
932	7	10
932	8	10
932	9	10
932	10	10
932	11	0
932	12	0
932	13	0
932	14	0
932	16	0
932	17	10
933	1	10
933	2	10
933	3	10
933	4	10
933	5	10
933	6	10
933	7	10
933	8	10
933	9	10
933	10	10
933	11	0
933	12	0
933	13	0
933	14	0
933	16	0
933	17	10
934	1	10
934	2	10
934	3	10
934	4	10
934	5	10
934	6	10
934	7	10
934	8	10
934	9	10
934	10	10
934	11	10
934	12	10
934	13	10
935	1	10
935	2	10
935	3	10
935	4	10
935	5	10
935	6	10
935	7	10
935	8	10
935	9	10
935	10	10
935	11	0
935	12	0
935	13	0
935	14	0
935	16	0
935	17	10
936	1	10
936	2	10
936	3	10
936	4	10
936	5	10
936	6	10
936	7	10
936	8	10
936	9	10
936	10	10
936	11	0
936	12	0
936	13	0
936	14	0
936	16	0
936	17	10
937	1	10
937	2	10
937	3	10
937	4	10
937	5	10
937	6	10
937	7	10
937	8	10
937	9	10
937	10	10
937	11	0
937	12	0
937	13	0
937	14	0
937	16	0
937	17	10
938	1	10
938	2	10
938	3	10
938	4	10
938	5	10
938	6	10
938	7	10
938	8	10
938	9	10
938	10	10
938	11	10
938	12	10
938	13	10
939	1	10
939	2	10
939	3	10
939	4	10
939	5	10
939	6	10
939	7	10
939	8	10
939	9	10
939	10	10
939	11	0
939	12	0
939	13	0
939	14	0
939	16	0
939	17	10
940	1	10
940	2	10
940	3	10
940	4	10
940	5	10
940	6	10
940	7	10
940	8	10
940	9	10
940	10	10
940	11	10
940	12	10
940	13	10
941	1	10
941	2	10
941	3	10
941	4	10
941	5	10
941	6	10
941	7	10
941	8	10
941	9	10
941	10	10
941	11	0
941	12	0
941	13	0
941	14	0
941	16	0
941	17	10
942	1	10
942	2	10
942	3	10
942	4	10
942	5	10
942	6	10
942	7	10
942	8	10
942	9	10
942	10	10
942	11	0
942	12	0
942	13	0
942	14	0
942	16	0
942	17	10
943	1	10
943	2	10
943	3	10
943	4	10
943	5	10
943	6	10
943	7	10
943	8	10
943	9	10
943	10	10
943	11	0
943	12	0
943	13	0
943	14	0
943	16	0
943	17	10
944	1	10
944	2	10
944	3	10
944	4	10
944	5	10
944	6	10
944	7	10
944	8	10
944	9	10
944	10	10
944	11	10
944	12	10
944	13	10
945	1	10
945	2	10
945	3	10
945	4	10
945	5	10
945	6	10
945	7	10
945	8	10
945	9	10
945	10	10
945	11	0
945	12	0
945	13	0
945	14	0
945	16	0
945	17	10
946	1	10
946	2	10
946	3	10
946	4	10
946	5	10
946	6	10
946	7	10
946	8	10
946	9	10
946	10	10
946	11	0
946	12	0
946	13	0
946	14	0
946	16	0
946	17	10
947	1	10
947	2	10
947	3	10
947	4	10
947	5	10
947	6	10
947	7	10
947	8	10
947	9	10
947	10	10
947	11	0
947	12	0
947	13	0
947	14	0
947	16	0
947	17	10
948	1	10
948	2	10
948	3	10
948	4	10
948	5	10
948	6	10
948	7	10
948	8	10
948	9	10
948	10	10
948	11	0
948	12	0
948	13	0
948	14	0
948	16	0
948	17	10
949	1	10
949	2	10
949	3	10
949	4	10
949	5	10
949	6	10
949	7	10
949	8	10
949	9	10
949	10	10
949	11	10
949	12	10
949	13	10
950	1	10
950	2	10
950	3	10
950	4	10
950	5	10
950	6	10
950	7	10
950	8	10
950	9	10
950	10	10
950	11	0
950	12	0
950	13	0
950	14	0
950	16	0
950	17	10
951	1	10
951	2	10
951	3	10
951	4	10
951	5	10
951	6	10
951	7	10
951	8	10
951	9	10
951	10	10
951	11	0
951	12	0
951	13	0
951	14	0
951	16	0
951	17	10
952	1	10
952	2	10
952	3	10
952	4	10
952	5	10
952	6	10
952	7	10
952	8	10
952	9	10
952	10	10
952	11	0
952	12	0
952	13	0
952	14	0
952	16	0
952	17	10
953	1	10
953	2	10
953	3	10
953	4	10
953	5	10
953	6	10
953	7	10
953	8	10
953	9	10
953	10	10
953	11	10
953	12	10
953	13	10
954	1	10
954	2	10
954	3	10
954	4	10
954	5	10
954	6	10
954	7	10
954	8	10
954	9	10
954	10	10
954	11	10
954	12	10
954	13	10
955	1	10
955	2	10
955	3	10
955	4	10
955	5	10
955	6	10
955	7	10
955	8	10
955	9	10
955	10	10
955	11	0
955	12	0
955	13	0
955	14	0
955	16	0
955	17	10
956	1	10
956	2	10
956	3	10
956	4	10
956	5	10
956	6	10
956	7	10
956	8	10
956	9	10
956	10	10
956	11	0
956	12	0
956	13	0
956	14	0
956	16	0
956	17	10
957	1	10
957	2	10
957	3	10
957	4	10
957	5	10
957	6	10
957	7	10
957	8	10
957	9	10
957	10	10
957	11	0
957	12	0
957	13	0
957	14	0
957	16	0
957	17	10
958	1	10
958	2	10
958	3	10
958	4	10
958	5	10
958	6	10
958	7	10
958	8	10
958	9	10
958	10	10
958	11	10
958	12	10
958	13	10
959	1	10
959	2	10
959	3	10
959	4	10
959	5	10
959	6	10
959	7	10
959	8	10
959	9	10
959	10	10
959	11	0
959	12	0
959	13	0
959	14	0
959	16	0
959	17	10
960	1	10
960	2	10
960	3	10
960	4	10
960	5	10
960	6	10
960	7	10
960	8	10
960	9	10
960	10	10
960	11	0
960	12	0
960	13	0
960	14	0
960	16	0
960	17	10
961	1	10
961	2	10
961	3	10
961	4	10
961	5	10
961	6	10
961	7	10
961	8	10
961	9	10
961	10	10
961	11	0
961	12	0
961	13	0
961	14	0
961	16	0
961	17	10
962	1	10
962	2	10
962	3	10
962	4	10
962	5	10
962	6	10
962	7	10
962	8	10
962	9	10
962	10	10
962	11	10
962	12	10
962	13	10
963	1	10
963	2	10
963	3	10
963	4	10
963	5	10
963	6	10
963	7	10
963	8	10
963	9	10
963	10	10
963	11	0
963	12	0
963	13	0
963	14	0
963	16	0
963	17	10
964	1	10
964	2	10
964	3	10
964	4	10
964	5	10
964	6	10
964	7	10
964	8	10
964	9	10
964	10	10
964	11	0
964	12	0
964	13	0
964	14	0
964	16	0
964	17	10
965	1	10
965	2	10
965	3	10
965	4	10
965	5	10
965	6	10
965	7	10
965	8	10
965	9	10
965	10	10
965	11	0
965	12	0
965	13	0
965	14	0
965	16	0
965	17	10
966	1	10
966	2	10
966	3	10
966	4	10
966	5	10
966	6	10
966	7	10
966	8	10
966	9	10
966	10	10
966	11	10
966	12	10
966	13	10
967	1	10
967	2	10
967	3	10
967	4	10
967	5	10
967	6	10
967	7	10
967	8	10
967	9	10
967	10	10
967	11	0
967	12	0
967	13	0
967	14	0
967	16	0
967	17	10
968	1	10
968	2	10
968	3	10
968	4	10
968	5	10
968	6	10
968	7	10
968	8	10
968	9	10
968	10	10
968	11	0
968	12	0
968	13	0
968	14	0
968	16	0
968	17	10
969	1	10
969	2	10
969	3	10
969	4	10
969	5	10
969	6	10
969	7	10
969	8	10
969	9	10
969	10	10
969	11	0
969	12	0
969	13	0
969	14	0
969	16	0
969	17	10
971	1	10
971	2	10
971	3	10
971	4	10
971	5	10
971	6	10
971	7	10
971	8	10
971	9	10
971	10	10
971	11	10
971	12	10
971	13	10
972	1	10
972	2	10
972	3	10
972	4	10
972	5	10
972	6	10
972	7	10
972	8	10
972	9	10
972	10	10
972	11	0
972	12	0
972	13	0
972	14	0
972	16	0
972	17	10
973	1	10
973	2	10
973	3	10
973	4	10
973	5	8
973	6	10
973	7	10
973	8	8
973	9	10
973	10	10
973	11	0
973	12	0
973	13	0
973	14	0
973	16	0
973	17	10
974	1	10
974	2	10
974	3	10
974	4	10
974	5	10
974	6	10
974	7	10
974	8	10
974	9	10
974	10	10
974	11	0
974	12	0
974	13	0
974	14	0
974	16	0
974	17	10
975	1	10
975	2	10
975	3	10
975	4	10
975	5	10
975	6	10
975	7	10
975	8	10
975	9	10
975	10	10
975	11	0
975	12	0
975	13	0
975	14	0
975	16	0
975	17	10
976	1	10
976	2	10
976	3	10
976	4	10
976	5	10
976	6	10
976	7	10
976	8	10
976	9	10
976	10	10
976	11	0
976	12	0
976	13	0
976	14	0
976	16	0
976	17	10
977	1	10
977	2	10
977	3	10
977	4	10
977	5	10
977	6	10
977	7	10
977	8	10
977	9	10
977	10	10
977	11	0
977	12	0
977	13	0
977	14	0
977	16	0
977	17	10
978	1	10
978	2	10
978	3	10
978	4	10
978	5	10
978	6	10
978	7	10
978	8	10
978	9	10
978	10	10
978	11	0
978	12	0
978	13	0
978	14	0
978	16	0
978	17	10
979	1	10
979	2	10
979	3	10
979	4	10
979	5	10
979	6	10
979	7	10
979	8	10
979	9	10
979	10	10
979	11	0
979	12	0
979	13	0
979	14	0
979	16	0
979	17	10
980	1	10
980	2	10
980	3	10
980	4	10
980	5	10
980	6	10
980	7	10
980	8	10
980	9	6
980	10	10
980	11	0
980	12	0
980	13	0
980	14	0
980	16	0
980	17	10
981	1	10
981	2	10
981	3	10
981	4	10
981	5	10
981	6	10
981	7	10
981	8	10
981	9	10
981	10	10
981	11	0
981	12	0
981	13	0
981	14	0
981	16	0
981	17	10
982	1	10
982	2	10
982	3	10
982	4	10
982	5	10
982	6	10
982	7	10
982	8	10
982	9	10
982	10	10
982	11	0
982	12	0
982	13	0
982	14	0
982	16	0
982	17	10
983	1	10
983	2	10
983	3	10
983	4	10
983	5	8
983	6	10
983	7	10
983	8	10
983	9	10
983	10	10
983	11	0
983	12	0
983	13	0
983	14	0
983	16	0
983	17	10
984	1	10
984	2	10
984	3	10
984	4	10
984	5	10
984	6	10
984	7	10
984	8	10
984	9	10
984	10	10
984	11	0
984	12	0
984	13	0
984	14	0
984	16	0
984	17	10
985	1	10
985	2	10
985	3	10
985	4	10
985	5	10
985	6	10
985	7	10
985	8	10
985	9	10
985	10	10
985	11	0
985	12	0
985	13	0
985	14	0
985	16	0
985	17	10
986	1	10
986	2	10
986	3	10
986	4	10
986	5	10
986	6	10
986	7	10
986	8	10
986	9	10
986	10	10
986	11	0
986	12	1
986	13	0
986	14	0
986	15	0
986	16	0
986	17	10
987	1	10
987	2	10
987	3	10
987	4	10
987	5	10
987	6	10
987	7	10
987	8	10
987	9	10
987	10	10
987	11	0
987	12	0
987	13	0
987	14	0
987	16	0
987	17	10
988	1	10
988	2	10
988	3	10
988	4	10
988	5	10
988	6	10
988	7	10
988	8	6
988	9	8
988	10	10
988	11	10
988	12	10
988	13	10
989	1	10
989	2	10
989	3	10
989	4	10
989	5	10
989	6	10
989	7	10
989	8	10
989	9	10
989	10	10
989	11	0
989	12	0
989	13	0
989	14	0
989	16	0
989	17	10
990	1	10
990	2	10
990	3	10
990	4	10
990	5	10
990	6	10
990	7	10
990	8	10
990	9	10
990	10	10
990	11	10
990	12	10
990	13	10
991	1	10
991	2	10
991	3	10
991	4	10
991	5	10
991	6	10
991	7	10
991	8	10
991	9	10
991	10	10
991	11	0
991	12	0
991	13	0
991	14	0
991	16	0
991	17	10
992	1	10
992	2	10
992	3	10
992	4	10
992	5	10
992	6	10
992	7	10
992	8	10
992	9	10
992	10	10
992	11	0
992	12	0
992	13	0
992	14	0
992	16	0
992	17	10
993	1	10
993	2	10
993	3	10
993	4	10
993	5	10
993	6	10
993	7	10
993	8	10
993	9	10
993	10	10
993	11	0
993	12	0
993	13	0
993	14	0
993	16	0
993	17	10
994	1	10
994	2	10
994	3	10
994	4	10
994	5	6
994	6	10
994	7	10
994	8	10
994	9	10
994	10	10
994	11	10
994	12	10
994	13	10
995	1	10
995	2	10
995	3	10
995	4	10
995	5	10
995	6	10
995	7	10
995	8	10
995	9	10
995	10	10
995	11	0
995	12	0
995	13	0
995	14	0
995	16	0
995	17	10
996	1	10
996	2	10
996	3	10
996	4	10
996	5	10
996	6	10
996	7	10
996	8	10
996	9	10
996	10	10
996	11	0
996	12	0
996	13	0
996	14	0
996	16	0
996	17	10
997	1	10
997	2	10
997	3	10
997	4	10
997	5	10
997	6	10
997	7	10
997	8	10
997	9	10
997	10	10
997	11	0
997	12	0
997	13	0
997	14	0
997	16	0
997	17	10
998	1	10
998	2	10
998	3	10
998	4	10
998	5	10
998	6	10
998	7	10
998	8	10
998	9	10
998	10	10
998	11	10
998	12	10
998	13	10
999	1	10
999	2	10
999	3	10
999	4	10
999	5	10
999	6	10
999	7	10
999	8	10
999	9	10
999	10	10
999	11	0
999	12	0
999	13	0
999	14	0
999	16	0
999	17	10
1000	1	10
1000	2	10
1000	3	10
1000	4	10
1000	5	10
1000	6	10
1000	7	10
1000	8	10
1000	9	10
1000	10	10
1000	11	10
1000	12	10
1000	13	10
1001	1	10
1001	2	10
1001	3	10
1001	4	10
1001	5	10
1001	6	10
1001	7	10
1001	8	10
1001	9	10
1001	10	10
1001	11	0
1001	12	0
1001	13	0
1001	14	0
1001	16	0
1001	17	10
1002	1	10
1002	2	10
1002	3	10
1002	4	10
1002	5	10
1002	6	10
1002	7	10
1002	8	10
1002	9	10
1002	10	10
1002	11	0
1002	12	0
1002	13	0
1002	14	0
1002	16	0
1002	17	10
1003	1	10
1003	2	10
1003	3	10
1003	4	10
1003	5	10
1003	6	10
1003	7	10
1003	8	10
1003	9	10
1003	10	10
1003	11	0
1003	12	0
1003	13	0
1003	14	0
1003	16	0
1003	17	10
1004	1	10
1004	2	10
1004	3	10
1004	4	10
1004	5	10
1004	6	10
1004	7	10
1004	8	10
1004	9	10
1004	10	10
1004	11	10
1004	12	10
1004	13	10
1005	1	10
1005	2	10
1005	3	10
1005	4	10
1005	5	10
1005	6	10
1005	7	10
1005	8	10
1005	9	10
1005	10	10
1005	11	0
1005	12	0
1005	13	0
1005	14	0
1005	16	0
1005	17	10
1006	1	10
1006	2	10
1006	3	10
1006	4	10
1006	5	10
1006	6	10
1006	7	10
1006	8	10
1006	9	10
1006	10	10
1006	11	0
1006	12	0
1006	13	0
1006	14	0
1006	16	0
1006	17	10
1007	1	10
1007	2	10
1007	3	10
1007	4	10
1007	5	10
1007	6	10
1007	7	10
1007	8	10
1007	9	10
1007	10	10
1007	11	0
1007	12	0
1007	13	0
1007	14	0
1007	16	0
1007	17	10
1008	1	10
1008	2	10
1008	3	10
1008	4	10
1008	5	10
1008	6	10
1008	7	10
1008	8	10
1008	9	10
1008	10	10
1008	11	0
1008	12	0
1008	13	0
1008	14	0
1008	16	0
1008	17	10
1009	1	10
1009	2	10
1009	3	10
1009	4	10
1009	5	10
1009	6	10
1009	7	10
1009	8	10
1009	9	10
1009	10	10
1009	11	10
1009	12	10
1009	13	10
1010	1	10
1010	2	10
1010	3	10
1010	4	10
1010	5	10
1010	6	10
1010	7	10
1010	8	10
1010	9	10
1010	10	10
1010	11	0
1010	12	0
1010	13	0
1010	14	0
1010	16	0
1010	17	10
1011	1	10
1011	2	10
1011	3	10
1011	4	10
1011	5	10
1011	6	10
1011	7	10
1011	8	10
1011	9	10
1011	10	10
1011	11	0
1011	12	0
1011	13	0
1011	14	0
1011	16	0
1011	17	10
1012	1	10
1012	2	10
1012	3	10
1012	4	10
1012	5	10
1012	6	10
1012	7	10
1012	8	10
1012	9	10
1012	10	10
1012	11	10
1012	12	10
1012	13	10
1013	1	10
1013	2	10
1013	3	10
1013	4	10
1013	5	10
1013	6	10
1013	7	10
1013	8	10
1013	9	10
1013	10	10
1013	11	0
1013	12	0
1013	13	0
1013	14	0
1013	16	0
1013	17	10
1014	1	10
1014	2	10
1014	3	10
1014	4	10
1014	5	10
1014	6	10
1014	7	10
1014	8	10
1014	9	10
1014	10	10
1014	11	0
1014	12	0
1014	13	0
1014	14	0
1014	16	0
1014	17	10
1015	1	10
1015	2	10
1015	3	10
1015	4	10
1015	5	10
1015	6	10
1015	7	10
1015	8	10
1015	9	10
1015	10	10
1015	11	0
1015	12	0
1015	13	0
1015	14	0
1015	16	0
1015	17	10
1016	1	10
1016	2	10
1016	3	10
1016	4	10
1016	5	10
1016	6	10
1016	7	10
1016	8	10
1016	9	10
1016	10	10
1016	11	10
1016	12	10
1016	13	10
1017	1	10
1017	2	10
1017	3	10
1017	4	10
1017	5	10
1017	6	10
1017	7	10
1017	8	10
1017	9	10
1017	10	10
1017	11	0
1017	12	0
1017	13	0
1017	14	0
1017	16	0
1017	17	10
1018	1	10
1018	2	10
1018	3	10
1018	4	10
1018	5	10
1018	6	10
1018	7	10
1018	8	10
1018	9	10
1018	10	10
1018	11	10
1018	12	10
1018	13	10
1019	1	10
1019	2	10
1019	3	10
1019	4	10
1019	5	10
1019	6	10
1019	7	10
1019	8	10
1019	9	10
1019	10	10
1019	11	0
1019	12	0
1019	13	0
1019	14	0
1019	16	0
1019	17	10
1020	1	10
1020	2	10
1020	3	10
1020	4	10
1020	5	10
1020	6	10
1020	7	10
1020	8	10
1020	9	10
1020	10	10
1020	11	0
1020	12	0
1020	13	0
1020	14	0
1020	16	0
1020	17	10
1021	1	10
1021	2	10
1021	3	10
1021	4	10
1021	5	10
1021	6	10
1021	7	10
1021	8	10
1021	9	10
1021	10	10
1021	11	10
1021	12	10
1021	13	10
1022	1	10
1022	2	10
1022	3	10
1022	4	10
1022	5	10
1022	6	10
1022	7	10
1022	8	10
1022	9	10
1022	10	10
1022	11	0
1022	12	0
1022	13	0
1022	14	0
1022	16	0
1022	17	10
1023	1	10
1023	2	10
1023	3	10
1023	4	10
1023	5	10
1023	6	10
1023	7	10
1023	8	10
1023	9	10
1023	10	10
1023	11	0
1023	12	0
1023	13	0
1023	14	0
1023	16	0
1023	17	10
1024	1	10
1024	2	10
1024	3	10
1024	4	10
1024	5	10
1024	6	10
1024	7	10
1024	8	10
1024	9	10
1024	10	10
1024	11	0
1024	12	0
1024	13	0
1024	14	0
1024	16	0
1024	17	10
1025	1	10
1025	2	10
1025	3	10
1025	4	10
1025	5	10
1025	6	10
1025	7	10
1025	8	10
1025	9	10
1025	10	10
1025	11	0
1025	12	0
1025	13	0
1025	14	0
1025	16	0
1025	17	10
1026	1	10
1026	2	10
1026	3	10
1026	4	10
1026	5	10
1026	6	10
1026	7	10
1026	8	10
1026	9	10
1026	10	10
1026	11	0
1026	12	0
1026	13	0
1026	14	0
1026	16	0
1026	17	10
1027	1	10
1027	2	10
1027	3	10
1027	4	10
1027	5	10
1027	6	10
1027	7	10
1027	8	10
1027	9	10
1027	10	10
1027	11	0
1027	12	0
1027	13	0
1027	14	0
1027	16	0
1027	17	10
1028	1	10
1028	2	10
1028	3	10
1028	4	10
1028	5	10
1028	6	10
1028	7	10
1028	8	10
1028	9	10
1028	10	10
1028	11	10
1028	12	10
1028	13	10
1029	1	10
1029	2	10
1029	3	10
1029	4	10
1029	5	10
1029	6	10
1029	7	10
1029	8	10
1029	9	10
1029	10	10
1029	11	0
1029	12	0
1029	13	0
1029	14	0
1029	16	0
1029	17	10
1030	1	10
1030	2	10
1030	3	10
1030	4	10
1030	5	10
1030	6	10
1030	7	10
1030	8	10
1030	9	10
1030	10	10
1030	11	0
1030	12	0
1030	13	0
1030	14	0
1030	16	0
1030	17	10
1031	1	10
1031	2	10
1031	3	10
1031	4	10
1031	5	10
1031	6	10
1031	7	10
1031	8	10
1031	9	10
1031	10	10
1031	11	0
1031	12	0
1031	13	0
1031	14	0
1031	16	0
1031	17	10
1032	1	10
1032	2	10
1032	3	10
1032	4	10
1032	5	10
1032	6	10
1032	7	10
1032	8	10
1032	9	10
1032	10	10
1032	11	10
1032	12	10
1032	13	10
1033	1	10
1033	2	10
1033	3	10
1033	4	10
1033	5	10
1033	6	10
1033	7	10
1033	8	10
1033	9	10
1033	10	10
1033	11	0
1033	12	0
1033	13	0
1033	14	0
1033	16	0
1033	17	10
1034	1	10
1034	2	10
1034	3	10
1034	4	10
1034	5	10
1034	6	10
1034	7	10
1034	8	10
1034	9	10
1034	10	10
1034	11	0
1034	12	0
1034	13	0
1034	14	0
1034	16	0
1034	17	10
1035	1	10
1035	2	10
1035	3	10
1035	4	10
1035	5	10
1035	6	10
1035	7	10
1035	8	10
1035	9	10
1035	10	10
1035	11	0
1035	12	0
1035	13	0
1035	14	0
1035	16	0
1035	17	10
1036	1	10
1036	2	10
1036	3	10
1036	4	10
1036	5	10
1036	6	10
1036	7	10
1036	8	10
1036	9	6
1036	10	10
1036	11	10
1036	12	10
1036	13	10
1037	1	10
1037	2	10
1037	3	10
1037	4	10
1037	5	10
1037	6	10
1037	7	10
1037	8	10
1037	9	10
1037	10	10
1037	11	0
1037	12	0
1037	13	0
1037	14	0
1037	16	0
1037	17	10
1038	1	10
1038	2	10
1038	3	10
1038	4	10
1038	5	10
1038	6	10
1038	7	10
1038	8	10
1038	9	10
1038	10	10
1038	11	0
1038	12	0
1038	13	0
1038	14	0
1038	16	0
1038	17	10
1039	1	10
1039	2	10
1039	3	10
1039	4	10
1039	5	10
1039	6	10
1039	7	10
1039	8	10
1039	9	10
1039	10	10
1039	11	0
1039	12	0
1039	13	0
1039	14	0
1039	16	0
1039	17	10
1040	1	10
1040	2	10
1040	3	10
1040	4	10
1040	5	10
1040	6	10
1040	7	10
1040	8	10
1040	9	10
1040	10	10
1040	11	10
1040	12	10
1040	13	10
1041	1	10
1041	2	10
1041	3	10
1041	4	10
1041	5	10
1041	6	10
1041	7	10
1041	8	10
1041	9	10
1041	10	10
1041	11	0
1041	12	0
1041	13	0
1041	14	0
1041	16	0
1041	17	10
1042	1	10
1042	2	10
1042	3	10
1042	4	10
1042	5	10
1042	6	10
1042	7	10
1042	8	6
1042	9	10
1042	10	10
1042	11	0
1042	12	0
1042	13	0
1042	14	0
1042	16	0
1042	17	10
1043	1	10
1043	2	10
1043	3	10
1043	4	10
1043	5	10
1043	6	10
1043	7	10
1043	8	8
1043	9	10
1043	10	10
1043	11	0
1043	12	0
1043	13	0
1043	14	0
1043	16	0
1043	17	10
1044	1	10
1044	2	10
1044	3	10
1044	4	10
1044	5	10
1044	6	10
1044	7	10
1044	8	10
1044	9	10
1044	10	10
1044	11	0
1044	12	0
1044	13	0
1044	14	0
1044	16	0
1044	17	10
1045	1	10
1045	2	10
1045	3	10
1045	4	10
1045	5	10
1045	6	10
1045	7	10
1045	8	10
1045	9	10
1045	10	10
1045	11	0
1045	12	0
1045	13	0
1045	14	0
1045	16	0
1045	17	10
1046	1	10
1046	2	10
1046	3	10
1046	4	10
1046	5	10
1046	6	10
1046	7	10
1046	8	10
1046	9	10
1046	10	10
1046	11	0
1046	12	0
1046	13	0
1046	14	0
1046	16	0
1046	17	10
1047	1	10
1047	2	10
1047	3	10
1047	4	10
1047	5	10
1047	6	10
1047	7	10
1047	8	8
1047	9	10
1047	10	10
1047	11	0
1047	12	0
1047	13	0
1047	14	0
1047	16	0
1047	17	10
1048	1	10
1048	2	10
1048	3	10
1048	4	10
1048	5	10
1048	6	10
1048	7	10
1048	8	10
1048	9	10
1048	10	10
1048	11	0
1048	12	0
1048	13	0
1048	14	0
1048	16	0
1048	17	10
1049	1	10
1049	2	10
1049	3	10
1049	4	10
1049	5	10
1049	6	10
1049	7	10
1049	8	10
1049	9	10
1049	10	10
1049	11	0
1049	12	0
1049	13	0
1049	14	0
1049	16	0
1049	17	10
1050	1	10
1050	2	10
1050	3	10
1050	4	10
1050	5	10
1050	6	10
1050	7	10
1050	8	10
1050	9	10
1050	10	10
1050	11	0
1050	12	0
1050	13	0
1050	14	0
1050	16	0
1050	17	10
1051	1	10
1051	2	10
1051	3	10
1051	4	10
1051	5	10
1051	6	10
1051	7	10
1051	8	10
1051	9	10
1051	10	10
1051	11	0
1051	12	0
1051	13	0
1051	14	0
1051	16	0
1051	17	10
1052	1	10
1052	2	10
1052	3	10
1052	4	10
1052	5	10
1052	6	10
1052	7	10
1052	8	10
1052	9	10
1052	10	10
1052	11	0
1052	12	0
1052	13	0
1052	14	0
1052	16	0
1052	17	10
1053	1	10
1053	2	10
1053	3	10
1053	4	10
1053	5	10
1053	6	10
1053	7	10
1053	8	10
1053	9	10
1053	10	10
1053	11	0
1053	12	0
1053	13	0
1053	14	0
1053	16	0
1053	17	10
1054	1	10
1054	2	10
1054	3	10
1054	4	10
1054	5	10
1054	6	10
1054	7	10
1054	8	10
1054	9	10
1054	10	10
1054	11	0
1054	12	0
1054	13	0
1054	14	0
1054	16	0
1054	17	10
1055	1	10
1055	2	10
1055	3	10
1055	4	10
1055	5	10
1055	6	10
1055	7	10
1055	8	10
1055	9	10
1055	10	10
1055	11	0
1055	12	0
1055	13	0
1055	14	0
1055	16	0
1055	17	10
1056	1	10
1056	2	10
1056	3	10
1056	4	10
1056	5	10
1056	6	10
1056	7	10
1056	8	10
1056	9	10
1056	10	10
1056	11	0
1056	12	0
1056	13	0
1056	14	0
1056	16	0
1056	17	10
1057	1	10
1057	2	10
1057	3	10
1057	4	10
1057	5	10
1057	6	10
1057	7	10
1057	8	10
1057	9	10
1057	10	10
1057	11	0
1057	12	0
1057	13	0
1057	14	0
1057	16	0
1057	17	10
1058	1	10
1058	2	10
1058	3	10
1058	4	10
1058	5	10
1058	6	10
1058	7	10
1058	8	10
1058	9	10
1058	10	10
1058	11	0
1058	12	0
1058	13	0
1058	14	0
1058	16	0
1058	17	10
1059	1	10
1059	2	10
1059	3	10
1059	4	10
1059	5	10
1059	6	10
1059	7	10
1059	8	10
1059	9	10
1059	10	10
1059	11	0
1059	12	0
1059	13	0
1059	14	0
1059	16	0
1059	17	10
1060	1	10
1060	2	10
1060	3	10
1060	4	10
1060	5	10
1060	6	10
1060	7	10
1060	8	10
1060	9	10
1060	10	10
1060	11	0
1060	12	0
1060	13	0
1060	14	0
1060	16	0
1060	17	10
1061	1	10
1061	2	10
1061	3	10
1061	4	10
1061	5	10
1061	6	10
1061	7	10
1061	8	10
1061	9	10
1061	10	10
1061	11	0
1061	12	0
1061	13	0
1061	14	0
1061	16	0
1061	17	10
1062	1	10
1062	2	10
1062	3	10
1062	4	10
1062	5	10
1062	6	10
1062	7	10
1062	8	10
1062	9	10
1062	10	10
1062	11	0
1062	12	0
1062	13	0
1062	14	0
1062	16	0
1062	17	10
1063	1	10
1063	2	10
1063	3	10
1063	4	10
1063	5	10
1063	6	10
1063	7	10
1063	8	10
1063	9	10
1063	10	10
1063	11	0
1063	12	0
1063	13	0
1063	14	0
1063	16	0
1063	17	10
1064	1	10
1064	2	10
1064	3	10
1064	4	10
1064	5	10
1064	6	10
1064	7	10
1064	8	10
1064	9	10
1064	10	10
1064	11	0
1064	12	0
1064	13	0
1064	14	0
1064	16	0
1064	17	10
1065	1	10
1065	2	10
1065	3	10
1065	4	10
1065	5	10
1065	6	10
1065	7	10
1065	8	10
1065	9	10
1065	10	10
1065	11	0
1065	12	0
1065	13	0
1065	14	0
1065	16	0
1065	17	10
1066	1	10
1066	2	10
1066	3	10
1066	4	10
1066	5	10
1066	6	10
1066	7	10
1066	8	10
1066	9	10
1066	10	10
1066	11	0
1066	12	0
1066	13	0
1066	14	0
1066	16	0
1066	17	10
1067	1	10
1067	2	10
1067	3	10
1067	4	10
1067	5	10
1067	6	10
1067	7	10
1067	8	10
1067	9	10
1067	10	10
1067	11	0
1067	12	0
1067	13	0
1067	14	0
1067	16	0
1067	17	10
1068	1	10
1068	2	10
1068	3	10
1068	4	10
1068	5	10
1068	6	10
1068	7	10
1068	8	10
1068	9	10
1068	10	10
1068	11	0
1068	12	0
1068	13	0
1068	14	0
1068	16	0
1068	17	10
1069	1	10
1069	2	10
1069	3	10
1069	4	10
1069	5	10
1069	6	10
1069	7	10
1069	8	8
1069	9	8
1069	10	10
1069	11	0
1069	12	0
1069	13	0
1069	14	0
1069	16	0
1069	17	10
1070	1	10
1070	2	10
1070	3	10
1070	4	10
1070	5	10
1070	6	10
1070	7	10
1070	8	10
1070	9	10
1070	10	10
1070	11	0
1070	12	0
1070	13	0
1070	14	0
1070	16	0
1070	17	10
1071	1	10
1071	2	10
1071	3	10
1071	4	10
1071	5	10
1071	6	10
1071	7	8
1071	8	10
1071	9	10
1071	10	10
1071	11	0
1071	12	0
1071	13	0
1071	14	0
1071	16	0
1071	17	10
1072	1	10
1072	2	10
1072	3	10
1072	4	10
1072	5	10
1072	6	10
1072	7	10
1072	8	10
1072	9	10
1072	10	10
1072	11	0
1072	12	0
1072	13	0
1072	14	0
1072	16	0
1072	17	10
1073	1	10
1073	2	10
1073	3	10
1073	4	10
1073	5	10
1073	6	10
1073	7	10
1073	8	10
1073	9	10
1073	10	10
1073	11	0
1073	12	0
1073	13	0
1073	14	0
1073	16	0
1073	17	10
1074	1	10
1074	2	10
1074	3	10
1074	4	10
1074	5	10
1074	6	10
1074	7	10
1074	8	10
1074	9	10
1074	10	10
1074	11	0
1074	12	0
1074	13	0
1074	14	0
1074	16	0
1074	17	10
1075	1	10
1075	2	10
1075	3	10
1075	4	10
1075	5	10
1075	6	10
1075	7	10
1075	8	10
1075	9	10
1075	10	10
1075	11	0
1075	12	0
1075	13	0
1075	14	0
1075	16	0
1075	17	10
1076	1	10
1076	2	10
1076	3	10
1076	4	10
1076	5	10
1076	6	10
1076	7	10
1076	8	10
1076	9	10
1076	10	10
1076	11	0
1076	12	0
1076	13	0
1076	14	0
1076	16	0
1076	17	10
1077	1	10
1077	2	10
1077	3	10
1077	4	10
1077	5	10
1077	6	10
1077	7	10
1077	8	10
1077	9	8
1077	10	10
1077	11	0
1077	12	0
1077	13	0
1077	14	0
1077	16	0
1077	17	10
1078	1	10
1078	2	10
1078	3	10
1078	4	10
1078	5	10
1078	6	10
1078	7	10
1078	8	10
1078	9	10
1078	10	10
1078	11	0
1078	12	0
1078	13	0
1078	14	0
1078	16	0
1078	17	10
1079	1	10
1079	2	10
1079	3	10
1079	4	10
1079	5	10
1079	6	10
1079	7	10
1079	8	10
1079	9	10
1079	10	10
1079	11	0
1079	12	0
1079	13	0
1079	14	0
1079	16	0
1079	17	10
1080	1	10
1080	2	10
1080	3	10
1080	4	10
1080	5	10
1080	6	10
1080	7	10
1080	8	8
1080	9	10
1080	10	10
1080	11	0
1080	12	0
1080	13	0
1080	14	0
1080	16	0
1080	17	10
1081	1	10
1081	2	10
1081	3	10
1081	4	10
1081	5	10
1081	6	10
1081	7	10
1081	8	10
1081	9	10
1081	10	10
1081	11	0
1081	12	0
1081	13	0
1081	14	0
1081	16	0
1081	17	10
1082	1	10
1082	2	10
1082	3	10
1082	4	10
1082	5	10
1082	6	10
1082	7	10
1082	8	10
1082	9	10
1082	10	10
1082	11	0
1082	12	0
1082	13	0
1082	14	0
1082	16	0
1082	17	8
1083	1	10
1083	2	10
1083	3	10
1083	4	10
1083	5	10
1083	6	10
1083	7	10
1083	8	10
1083	9	10
1083	10	10
1083	11	0
1083	12	0
1083	13	0
1083	14	0
1083	16	0
1083	17	10
1084	1	10
1084	2	10
1084	3	10
1084	4	10
1084	5	10
1084	6	10
1084	7	10
1084	8	10
1084	9	10
1084	10	10
1084	11	0
1084	12	0
1084	13	0
1084	14	0
1084	16	0
1084	17	10
1085	1	10
1085	2	10
1085	3	10
1085	4	10
1085	5	10
1085	6	10
1085	7	10
1085	8	10
1085	9	10
1085	10	10
1085	11	0
1085	12	0
1085	13	0
1085	14	0
1085	16	0
1085	17	10
1086	1	10
1086	2	10
1086	3	10
1086	4	10
1086	5	10
1086	6	10
1086	7	10
1086	8	10
1086	9	10
1086	10	10
1086	11	0
1086	12	0
1086	13	0
1086	14	0
1086	16	0
1086	17	10
1087	1	10
1087	2	10
1087	3	10
1087	4	10
1087	5	10
1087	6	10
1087	7	10
1087	8	10
1087	9	10
1087	10	10
1087	11	0
1087	12	0
1087	13	0
1087	14	0
1087	16	0
1087	17	10
1088	1	10
1088	2	10
1088	3	10
1088	4	10
1088	5	10
1088	6	10
1088	7	10
1088	8	10
1088	9	10
1088	10	10
1088	11	0
1088	12	0
1088	13	0
1088	14	0
1088	16	0
1088	17	10
1089	1	10
1089	2	10
1089	3	10
1089	4	10
1089	5	10
1089	6	10
1089	7	10
1089	8	10
1089	9	10
1089	10	10
1089	11	0
1089	12	0
1089	13	0
1089	14	0
1089	16	0
1089	17	10
1090	1	10
1090	2	10
1090	3	10
1090	4	10
1090	5	10
1090	6	10
1090	7	10
1090	8	10
1090	9	10
1090	10	10
1090	11	0
1090	12	0
1090	13	0
1090	14	0
1090	16	0
1090	17	10
1091	1	10
1091	2	10
1091	3	10
1091	4	10
1091	5	10
1091	6	10
1091	7	10
1091	8	10
1091	9	10
1091	10	10
1091	11	0
1091	12	0
1091	13	0
1091	14	0
1091	16	0
1091	17	10
1092	1	10
1092	2	10
1092	3	10
1092	4	10
1092	5	10
1092	6	10
1092	7	10
1092	8	10
1092	9	10
1092	10	10
1092	11	0
1092	12	0
1092	13	0
1092	14	0
1092	16	0
1092	17	10
1093	1	10
1093	2	10
1093	3	10
1093	4	10
1093	5	10
1093	6	10
1093	7	10
1093	8	10
1093	9	10
1093	10	10
1093	11	0
1093	12	0
1093	13	0
1093	14	0
1093	16	0
1093	17	10
1094	1	10
1094	2	10
1094	3	10
1094	4	10
1094	5	10
1094	6	10
1094	7	10
1094	8	10
1094	9	10
1094	10	10
1094	11	0
1094	12	0
1094	13	0
1094	14	0
1094	16	0
1094	17	10
1095	1	10
1095	2	10
1095	3	10
1095	4	10
1095	5	10
1095	6	10
1095	7	10
1095	8	10
1095	9	10
1095	10	10
1095	11	0
1095	12	0
1095	13	0
1095	14	0
1095	16	0
1095	17	10
1096	1	10
1096	2	10
1096	3	10
1096	4	10
1096	5	10
1096	6	10
1096	7	10
1096	8	10
1096	9	10
1096	10	10
1096	11	0
1096	12	0
1096	13	0
1096	14	0
1096	16	0
1096	17	10
1098	1	10
1098	2	10
1098	3	10
1098	4	10
1098	5	10
1098	6	10
1098	7	10
1098	8	10
1098	9	10
1098	10	10
1098	11	0
1098	12	0
1098	13	0
1098	14	0
1098	16	0
1098	17	10
1099	1	10
1099	2	10
1099	3	10
1099	4	10
1099	5	10
1099	6	10
1099	7	10
1099	8	10
1099	9	10
1099	10	10
1099	11	0
1099	12	0
1099	13	0
1099	14	0
1099	16	0
1099	17	10
1100	1	10
1100	2	10
1100	3	10
1100	4	10
1100	5	10
1100	6	10
1100	7	10
1100	8	10
1100	9	10
1100	10	10
1100	11	0
1100	12	0
1100	13	0
1100	14	0
1100	16	0
1100	17	10
1101	1	10
1101	2	10
1101	3	10
1101	4	10
1101	5	10
1101	6	10
1101	7	10
1101	8	10
1101	9	10
1101	10	10
1101	11	0
1101	12	0
1101	13	0
1101	14	0
1101	16	0
1101	17	10
1102	1	10
1102	2	10
1102	3	10
1102	4	10
1102	5	10
1102	6	10
1102	7	10
1102	8	10
1102	9	10
1102	10	10
1102	11	0
1102	12	0
1102	13	0
1102	14	0
1102	16	0
1102	17	10
1103	1	10
1103	2	10
1103	3	10
1103	4	10
1103	5	10
1103	6	10
1103	7	10
1103	8	8
1103	9	10
1103	10	10
1103	11	0
1103	12	0
1103	13	0
1103	14	0
1103	16	0
1103	17	10
1104	1	10
1104	2	10
1104	3	10
1104	4	10
1104	5	10
1104	6	10
1104	7	10
1104	8	10
1104	9	10
1104	10	10
1104	11	0
1104	12	0
1104	13	0
1104	14	0
1104	16	0
1104	17	10
1105	1	10
1105	2	10
1105	3	10
1105	4	10
1105	5	10
1105	6	10
1105	7	10
1105	8	8
1105	9	10
1105	10	10
1105	11	0
1105	12	0
1105	13	0
1105	14	0
1105	16	0
1105	17	10
1106	1	10
1106	2	10
1106	3	10
1106	4	10
1106	5	10
1106	6	10
1106	7	10
1106	8	10
1106	9	10
1106	10	10
1106	11	0
1106	12	0
1106	13	0
1106	14	0
1106	16	0
1106	17	10
1107	1	10
1107	2	10
1107	3	10
1107	4	10
1107	5	10
1107	6	10
1107	7	10
1107	8	10
1107	9	10
1107	10	10
1107	11	0
1107	12	0
1107	13	0
1107	14	0
1107	16	0
1107	17	10
1108	1	10
1108	2	10
1108	3	10
1108	4	10
1108	5	10
1108	6	10
1108	7	10
1108	8	10
1108	9	10
1108	10	10
1108	11	0
1108	12	0
1108	13	0
1108	14	0
1108	16	0
1108	17	10
1109	1	10
1109	2	10
1109	3	10
1109	4	10
1109	5	10
1109	6	10
1109	7	10
1109	8	10
1109	9	10
1109	10	10
1109	11	0
1109	12	0
1109	13	0
1109	14	0
1109	16	0
1109	17	10
1110	1	10
1110	2	10
1110	3	10
1110	4	10
1110	5	10
1110	6	10
1110	7	10
1110	8	10
1110	9	10
1110	10	10
1110	11	0
1110	12	0
1110	13	0
1110	14	0
1110	16	0
1110	17	10
1111	1	10
1111	2	10
1111	3	10
1111	4	10
1111	5	10
1111	6	10
1111	7	10
1111	8	10
1111	9	10
1111	10	10
1111	11	0
1111	12	0
1111	13	0
1111	14	0
1111	16	0
1111	17	10
1112	1	10
1112	2	10
1112	3	10
1112	4	10
1112	5	10
1112	6	10
1112	7	10
1112	8	10
1112	9	10
1112	10	10
1112	11	0
1112	12	0
1112	13	0
1112	14	0
1112	16	0
1112	17	10
1113	1	10
1113	2	10
1113	3	10
1113	4	10
1113	5	10
1113	6	10
1113	7	10
1113	8	10
1113	9	10
1113	10	10
1113	11	0
1113	12	0
1113	13	0
1113	14	0
1113	16	0
1113	17	10
1114	1	10
1114	2	10
1114	3	10
1114	4	10
1114	5	10
1114	6	10
1114	7	10
1114	8	10
1114	9	10
1114	10	10
1114	11	0
1114	12	0
1114	13	0
1114	14	0
1114	16	0
1114	17	10
1115	1	10
1115	2	10
1115	3	10
1115	4	10
1115	5	10
1115	6	10
1115	7	10
1115	8	10
1115	9	10
1115	10	10
1115	11	0
1115	12	0
1115	13	0
1115	14	0
1115	16	0
1115	17	10
1116	1	10
1116	2	10
1116	3	10
1116	4	10
1116	5	10
1116	6	10
1116	7	10
1116	8	10
1116	9	10
1116	10	10
1116	11	0
1116	12	0
1116	13	0
1116	14	0
1116	16	0
1116	17	10
1117	1	10
1117	2	10
1117	3	10
1117	4	10
1117	5	10
1117	6	10
1117	7	10
1117	8	10
1117	9	10
1117	10	10
1117	11	0
1117	12	0
1117	13	0
1117	14	0
1117	16	0
1117	17	10
1118	1	10
1118	2	10
1118	3	10
1118	4	10
1118	5	10
1118	6	10
1118	7	10
1118	8	10
1118	9	10
1118	10	10
1118	11	0
1118	12	0
1118	13	0
1118	14	0
1118	16	0
1118	17	10
1119	1	10
1119	2	10
1119	3	10
1119	4	10
1119	5	10
1119	6	10
1119	7	10
1119	8	10
1119	9	10
1119	10	10
1119	11	0
1119	12	0
1119	13	0
1119	14	0
1119	16	0
1119	17	10
1120	1	10
1120	2	10
1120	3	8
1120	4	10
1120	5	8
1120	6	10
1120	7	10
1120	8	10
1120	9	10
1120	10	10
1120	11	0
1120	12	0
1120	13	0
1120	14	0
1120	16	0
1120	17	10
1121	1	10
1121	2	10
1121	3	10
1121	4	10
1121	5	10
1121	6	10
1121	7	10
1121	8	10
1121	9	10
1121	10	10
1121	11	0
1121	12	0
1121	13	0
1121	14	0
1121	16	0
1121	17	10
1122	1	10
1122	2	10
1122	3	10
1122	4	10
1122	5	10
1122	6	10
1122	7	10
1122	8	10
1122	9	10
1122	10	10
1122	11	0
1122	12	0
1122	13	0
1122	14	0
1122	16	0
1122	17	10
1123	1	10
1123	2	10
1123	3	10
1123	4	10
1123	5	10
1123	6	10
1123	7	10
1123	8	10
1123	9	10
1123	10	10
1123	11	0
1123	12	0
1123	13	0
1123	14	0
1123	16	0
1123	17	10
1124	1	10
1124	2	10
1124	3	10
1124	4	10
1124	5	10
1124	6	10
1124	7	10
1124	8	10
1124	9	10
1124	10	10
1124	11	0
1124	12	0
1124	13	0
1124	14	0
1124	16	0
1124	17	10
1125	1	10
1125	2	10
1125	3	10
1125	4	10
1125	5	10
1125	6	10
1125	7	10
1125	8	10
1125	9	10
1125	10	10
1125	11	0
1125	12	0
1125	13	0
1125	14	0
1125	16	0
1125	17	10
1126	1	10
1126	2	10
1126	3	10
1126	4	10
1126	5	10
1126	6	10
1126	7	10
1126	8	10
1126	9	10
1126	10	10
1126	11	0
1126	12	0
1126	13	0
1126	14	0
1126	16	0
1126	17	10
1127	1	10
1127	2	10
1127	3	10
1127	4	10
1127	5	10
1127	6	10
1127	7	10
1127	8	10
1127	9	10
1127	10	10
1127	11	0
1127	12	0
1127	13	0
1127	14	0
1127	16	0
1127	17	10
1128	1	10
1128	2	10
1128	3	10
1128	4	10
1128	5	10
1128	6	10
1128	7	10
1128	8	10
1128	9	10
1128	10	10
1128	11	0
1128	12	0
1128	13	0
1128	14	0
1128	16	0
1128	17	10
1129	1	10
1129	2	10
1129	3	10
1129	4	10
1129	5	10
1129	6	10
1129	7	10
1129	8	10
1129	9	10
1129	10	10
1129	11	0
1129	12	0
1129	13	0
1129	14	0
1129	16	0
1129	17	10
1130	1	10
1130	2	10
1130	3	10
1130	4	10
1130	5	10
1130	6	10
1130	7	10
1130	8	10
1130	9	10
1130	10	10
1130	11	0
1130	12	0
1130	13	0
1130	14	0
1130	16	0
1130	17	10
1132	1	10
1132	2	10
1132	3	10
1132	4	10
1132	5	10
1132	6	10
1132	7	10
1132	8	10
1132	9	10
1132	10	10
1132	11	0
1132	12	0
1132	13	0
1132	14	0
1132	16	0
1132	17	10
1133	1	10
1133	2	10
1133	3	10
1133	4	10
1133	5	10
1133	6	10
1133	7	10
1133	8	10
1133	9	10
1133	10	10
1133	11	0
1133	12	0
1133	13	0
1133	14	0
1133	16	0
1133	17	10
1134	1	10
1134	2	10
1134	3	10
1134	4	10
1134	5	10
1134	6	10
1134	7	10
1134	8	10
1134	9	10
1134	10	10
1134	11	0
1134	12	0
1134	13	0
1134	14	0
1134	16	0
1134	17	10
1135	1	10
1135	2	10
1135	3	10
1135	4	10
1135	5	10
1135	6	10
1135	7	10
1135	8	10
1135	9	10
1135	10	10
1135	11	0
1135	12	0
1135	13	0
1135	14	0
1135	16	0
1135	17	10
1136	1	10
1136	2	10
1136	3	10
1136	4	10
1136	5	10
1136	6	10
1136	7	10
1136	8	10
1136	9	10
1136	10	10
1136	11	0
1136	12	0
1136	13	0
1136	14	0
1136	16	0
1136	17	10
1137	1	10
1137	2	10
1137	3	10
1137	4	10
1137	5	10
1137	6	10
1137	7	10
1137	8	10
1137	9	10
1137	10	10
1137	11	0
1137	12	0
1137	13	0
1137	14	0
1137	16	0
1137	17	10
1138	1	10
1138	2	10
1138	3	10
1138	4	10
1138	5	10
1138	6	10
1138	7	10
1138	8	10
1138	9	10
1138	10	10
1138	11	0
1138	12	0
1138	13	0
1138	14	0
1138	16	0
1138	17	10
1139	1	10
1139	2	10
1139	3	10
1139	4	10
1139	5	10
1139	6	10
1139	7	10
1139	8	10
1139	9	10
1139	10	10
1139	11	0
1139	12	0
1139	13	0
1139	14	0
1139	16	0
1139	17	10
1140	1	10
1140	2	10
1140	3	10
1140	4	8
1140	5	10
1140	6	10
1140	7	10
1140	8	10
1140	9	10
1140	10	10
1140	11	0
1140	12	0
1140	13	0
1140	14	0
1140	16	0
1140	17	10
1141	1	10
1141	2	10
1141	3	10
1141	4	10
1141	5	10
1141	6	10
1141	7	10
1141	8	10
1141	9	10
1141	10	10
1141	11	0
1141	12	0
1141	13	0
1141	14	0
1141	16	0
1141	17	10
1142	1	10
1142	2	10
1142	3	10
1142	4	10
1142	5	10
1142	6	10
1142	7	10
1142	8	10
1142	9	10
1142	10	10
1142	11	0
1142	12	0
1142	13	0
1142	14	0
1142	16	0
1142	17	10
1143	1	10
1143	2	10
1143	3	10
1143	4	10
1143	5	10
1143	6	10
1143	7	10
1143	8	10
1143	9	10
1143	10	10
1143	11	0
1143	12	0
1143	13	0
1143	14	0
1143	16	0
1143	17	10
1144	1	10
1144	2	10
1144	3	10
1144	4	10
1144	5	10
1144	6	10
1144	7	10
1144	8	10
1144	9	10
1144	10	10
1144	11	0
1144	12	0
1144	13	0
1144	14	0
1144	16	0
1144	17	10
1145	1	10
1145	2	10
1145	3	10
1145	4	10
1145	5	10
1145	6	10
1145	7	10
1145	8	10
1145	9	10
1145	10	10
1145	11	0
1145	12	0
1145	13	0
1145	14	0
1145	16	0
1145	17	10
1146	1	10
1146	2	10
1146	3	10
1146	4	10
1146	5	10
1146	6	10
1146	7	10
1146	8	10
1146	9	10
1146	10	10
1146	11	0
1146	12	0
1146	13	0
1146	14	0
1146	16	0
1146	17	10
1147	1	10
1147	2	10
1147	3	10
1147	4	10
1147	5	10
1147	6	10
1147	7	10
1147	8	10
1147	9	10
1147	10	10
1147	11	0
1147	12	0
1147	13	0
1147	14	0
1147	16	0
1147	17	10
1148	1	10
1148	2	10
1148	3	10
1148	4	10
1148	5	10
1148	6	10
1148	7	10
1148	8	10
1148	9	10
1148	10	10
1148	11	0
1148	12	0
1148	13	0
1148	14	0
1148	16	0
1148	17	10
1149	1	10
1149	2	10
1149	3	10
1149	4	10
1149	5	10
1149	6	10
1149	7	10
1149	8	10
1149	9	10
1149	10	10
1149	11	0
1149	12	0
1149	13	0
1149	14	0
1149	16	0
1149	17	10
1150	1	10
1150	2	10
1150	3	10
1150	4	10
1150	5	10
1150	6	10
1150	7	10
1150	8	10
1150	9	10
1150	10	10
1150	11	0
1150	12	0
1150	13	0
1150	14	0
1150	16	0
1150	17	10
1151	1	10
1151	2	10
1151	3	10
1151	4	10
1151	5	10
1151	6	10
1151	7	10
1151	8	10
1151	9	10
1151	10	10
1151	11	0
1151	12	0
1151	13	0
1151	14	0
1151	16	0
1151	17	10
1152	1	10
1152	2	10
1152	3	10
1152	4	10
1152	5	10
1152	6	10
1152	7	10
1152	8	10
1152	9	10
1152	10	10
1152	11	0
1152	12	0
1152	13	0
1152	14	0
1152	16	0
1152	17	10
1153	1	10
1153	2	10
1153	3	10
1153	4	10
1153	5	10
1153	6	10
1153	7	10
1153	8	10
1153	9	10
1153	10	10
1153	11	0
1153	12	0
1153	13	0
1153	14	0
1153	16	0
1153	17	10
1154	1	10
1154	2	10
1154	3	10
1154	4	8
1154	5	10
1154	6	10
1154	7	10
1154	8	10
1154	9	10
1154	10	10
1154	11	0
1154	12	0
1154	13	0
1154	14	0
1154	16	0
1154	17	10
1155	1	10
1155	2	10
1155	3	10
1155	4	10
1155	5	10
1155	6	10
1155	7	10
1155	8	10
1155	9	10
1155	10	10
1155	11	0
1155	12	0
1155	13	0
1155	14	0
1155	16	0
1155	17	10
1156	1	10
1156	2	10
1156	3	10
1156	4	10
1156	5	10
1156	6	10
1156	7	10
1156	8	10
1156	9	10
1156	10	10
1156	11	0
1156	12	0
1156	13	0
1156	14	0
1156	16	0
1156	17	10
1157	1	10
1157	2	10
1157	3	10
1157	4	10
1157	5	10
1157	6	10
1157	7	10
1157	8	10
1157	9	10
1157	10	10
1157	11	0
1157	12	0
1157	13	0
1157	14	0
1157	16	0
1157	17	10
1158	1	10
1158	2	10
1158	3	10
1158	4	10
1158	5	10
1158	6	10
1158	7	10
1158	8	10
1158	9	10
1158	10	10
1158	11	0
1158	12	0
1158	13	0
1158	14	0
1158	16	0
1158	17	10
1159	1	10
1159	2	10
1159	3	10
1159	4	10
1159	5	10
1159	6	10
1159	7	10
1159	8	10
1159	9	10
1159	10	10
1159	11	0
1159	12	0
1159	13	0
1159	14	0
1159	16	0
1159	17	10
1160	1	10
1160	2	10
1160	3	10
1160	4	10
1160	5	10
1160	6	10
1160	7	10
1160	8	10
1160	9	10
1160	10	10
1160	11	0
1160	12	0
1160	13	0
1160	14	0
1160	16	0
1160	17	10
1161	1	10
1161	2	10
1161	3	10
1161	4	10
1161	5	10
1161	6	10
1161	7	10
1161	8	10
1161	9	10
1161	10	10
1161	11	0
1161	12	0
1161	13	0
1161	14	0
1161	16	0
1161	17	10
1162	1	10
1162	2	10
1162	3	10
1162	4	10
1162	5	10
1162	6	10
1162	7	10
1162	8	10
1162	9	10
1162	10	10
1162	11	0
1162	12	0
1162	13	0
1162	14	0
1162	16	0
1162	17	10
1163	1	10
1163	2	10
1163	3	10
1163	4	10
1163	5	10
1163	6	10
1163	7	10
1163	8	10
1163	9	10
1163	10	10
1163	11	0
1163	12	0
1163	13	0
1163	14	0
1163	16	0
1163	17	10
1164	1	10
1164	2	10
1164	3	10
1164	4	10
1164	5	10
1164	6	10
1164	7	10
1164	8	10
1164	9	10
1164	10	10
1164	11	0
1164	12	0
1164	13	0
1164	14	0
1164	16	0
1164	17	10
1165	1	10
1165	2	10
1165	3	10
1165	4	10
1165	5	10
1165	6	10
1165	7	10
1165	8	10
1165	9	10
1165	10	10
1165	11	0
1165	12	0
1165	13	0
1165	14	0
1165	16	0
1165	17	10
1166	1	10
1166	2	10
1166	3	10
1166	4	10
1166	5	10
1166	6	10
1166	7	10
1166	8	10
1166	9	10
1166	10	10
1166	11	0
1166	12	0
1166	13	0
1166	14	0
1166	16	0
1166	17	10
1167	1	10
1167	2	10
1167	3	10
1167	4	10
1167	5	10
1167	6	10
1167	7	10
1167	8	10
1167	9	10
1167	10	10
1167	11	0
1167	12	0
1167	13	0
1167	14	0
1167	16	0
1167	17	10
1168	1	10
1168	2	10
1168	3	10
1168	4	10
1168	5	10
1168	6	10
1168	7	10
1168	8	10
1168	9	10
1168	10	10
1168	11	0
1168	12	0
1168	13	0
1168	14	0
1168	16	0
1168	17	10
1169	1	10
1169	2	10
1169	3	10
1169	4	10
1169	5	10
1169	6	10
1169	7	10
1169	8	10
1169	9	10
1169	10	10
1169	11	0
1169	12	0
1169	13	0
1169	14	0
1169	16	0
1169	17	10
1170	1	10
1170	2	10
1170	3	10
1170	4	10
1170	5	10
1170	6	10
1170	7	10
1170	8	10
1170	9	10
1170	10	10
1170	11	0
1170	12	0
1170	13	0
1170	14	0
1170	16	0
1170	17	10
1171	1	10
1171	2	10
1171	3	10
1171	4	10
1171	5	10
1171	6	10
1171	7	10
1171	8	10
1171	9	10
1171	10	10
1171	11	0
1171	12	0
1171	13	0
1171	14	0
1171	16	0
1171	17	10
1172	1	10
1172	2	10
1172	3	10
1172	4	10
1172	5	10
1172	6	10
1172	7	10
1172	8	10
1172	9	10
1172	10	10
1172	11	0
1172	12	0
1172	13	0
1172	14	0
1172	16	0
1172	17	10
1173	1	10
1173	2	10
1173	3	10
1173	4	10
1173	5	10
1173	6	10
1173	7	10
1173	8	10
1173	9	10
1173	10	10
1173	11	0
1173	12	0
1173	13	0
1173	14	0
1173	16	0
1173	17	10
1174	1	10
1174	2	10
1174	3	10
1174	4	10
1174	5	10
1174	6	10
1174	7	10
1174	8	10
1174	9	10
1174	10	10
1174	11	0
1174	12	0
1174	13	0
1174	14	0
1174	16	0
1174	17	10
1175	1	10
1175	2	10
1175	3	10
1175	4	10
1175	5	10
1175	6	10
1175	7	10
1175	8	10
1175	9	10
1175	10	10
1175	11	0
1175	12	0
1175	13	0
1175	14	0
1175	16	0
1175	17	10
1176	1	10
1176	2	10
1176	3	10
1176	4	10
1176	5	10
1176	6	10
1176	7	10
1176	8	10
1176	9	10
1176	10	10
1176	11	0
1176	12	0
1176	13	0
1176	14	0
1176	16	0
1176	17	10
1177	1	10
1177	2	10
1177	3	10
1177	4	10
1177	5	10
1177	6	10
1177	7	10
1177	8	10
1177	9	10
1177	10	10
1177	11	0
1177	12	0
1177	13	0
1177	14	0
1177	16	0
1177	17	10
1178	1	10
1178	2	10
1178	3	10
1178	4	10
1178	5	10
1178	6	10
1178	7	10
1178	8	10
1178	9	10
1178	10	10
1178	11	0
1178	12	0
1178	13	0
1178	14	0
1178	16	0
1178	17	10
1179	1	10
1179	2	10
1179	3	10
1179	4	10
1179	5	10
1179	6	10
1179	7	10
1179	8	10
1179	9	10
1179	10	10
1179	11	0
1179	12	0
1179	13	0
1179	14	0
1179	16	0
1179	17	10
1180	1	10
1180	2	10
1180	3	10
1180	4	10
1180	5	10
1180	6	10
1180	7	10
1180	8	10
1180	9	10
1180	10	10
1180	11	0
1180	12	0
1180	13	0
1180	14	0
1180	16	0
1180	17	10
1181	1	10
1181	2	10
1181	3	10
1181	4	10
1181	5	10
1181	6	10
1181	7	10
1181	8	10
1181	9	10
1181	10	10
1181	11	0
1181	12	0
1181	13	0
1181	14	0
1181	16	0
1181	17	10
1182	1	10
1182	2	10
1182	3	10
1182	4	10
1182	5	10
1182	6	10
1182	7	10
1182	8	10
1182	9	10
1182	10	10
1182	11	0
1182	12	0
1182	13	0
1182	14	0
1182	16	0
1182	17	10
1183	1	10
1183	2	10
1183	3	10
1183	4	10
1183	5	10
1183	6	10
1183	7	10
1183	8	10
1183	9	10
1183	10	10
1183	11	0
1183	12	0
1183	13	0
1183	14	0
1183	16	0
1183	17	10
1184	1	10
1184	2	10
1184	3	10
1184	4	10
1184	5	10
1184	6	10
1184	7	10
1184	8	10
1184	9	10
1184	10	10
1184	11	0
1184	12	0
1184	13	0
1184	14	0
1184	16	0
1184	17	10
1185	1	10
1185	2	10
1185	3	10
1185	4	10
1185	5	10
1185	6	10
1185	7	10
1185	8	10
1185	9	10
1185	10	10
1185	11	0
1185	12	0
1185	13	0
1185	14	0
1185	16	0
1185	17	10
1186	1	10
1186	2	10
1186	3	10
1186	4	10
1186	5	10
1186	6	10
1186	7	10
1186	8	10
1186	9	10
1186	10	10
1186	11	0
1186	12	0
1186	13	0
1186	14	0
1186	16	0
1186	17	10
1187	1	10
1187	2	10
1187	3	10
1187	4	10
1187	5	10
1187	6	10
1187	7	10
1187	8	10
1187	9	10
1187	10	10
1187	11	0
1187	12	0
1187	13	0
1187	14	0
1187	16	0
1187	17	10
1188	1	10
1188	2	10
1188	3	10
1188	4	10
1188	5	10
1188	6	10
1188	7	10
1188	8	10
1188	9	10
1188	10	10
1188	11	0
1188	12	0
1188	13	0
1188	14	0
1188	16	0
1188	17	10
1189	1	10
1189	2	10
1189	3	10
1189	4	10
1189	5	10
1189	6	10
1189	7	10
1189	8	10
1189	9	10
1189	10	10
1189	11	0
1189	12	0
1189	13	0
1189	14	0
1189	16	0
1189	17	10
1190	1	10
1190	2	10
1190	3	10
1190	4	10
1190	5	10
1190	6	10
1190	7	10
1190	8	10
1190	9	10
1190	10	10
1190	11	0
1190	12	0
1190	13	0
1190	14	0
1190	16	0
1190	17	10
1191	1	10
1191	2	10
1191	3	10
1191	4	10
1191	5	10
1191	6	10
1191	7	10
1191	8	10
1191	9	10
1191	10	10
1191	11	0
1191	12	0
1191	13	0
1191	14	0
1191	16	0
1191	17	10
1192	1	10
1192	2	10
1192	3	10
1192	4	10
1192	5	10
1192	6	10
1192	7	10
1192	8	10
1192	9	10
1192	10	10
1192	11	0
1192	12	0
1192	13	0
1192	14	0
1192	16	0
1192	17	10
1193	1	10
1193	2	10
1193	3	10
1193	4	10
1193	5	10
1193	6	10
1193	7	10
1193	8	10
1193	9	10
1193	10	10
1193	11	0
1193	12	0
1193	13	0
1193	14	0
1193	16	0
1193	17	10
1194	1	10
1194	2	10
1194	3	10
1194	4	10
1194	5	10
1194	6	10
1194	7	10
1194	8	10
1194	9	10
1194	10	10
1194	11	0
1194	12	0
1194	13	0
1194	14	0
1194	16	0
1194	17	10
1195	1	10
1195	2	10
1195	3	10
1195	4	10
1195	5	10
1195	6	10
1195	7	10
1195	8	10
1195	9	10
1195	10	10
1195	11	0
1195	12	0
1195	13	0
1195	14	0
1195	16	0
1195	17	10
1196	1	10
1196	2	10
1196	3	10
1196	4	10
1196	5	10
1196	6	10
1196	7	10
1196	8	10
1196	9	10
1196	10	10
1196	11	0
1196	12	0
1196	13	0
1196	14	0
1196	16	0
1196	17	10
1197	1	10
1197	2	10
1197	3	10
1197	4	10
1197	5	10
1197	6	10
1197	7	10
1197	8	8
1197	9	10
1197	10	10
1197	11	0
1197	12	0
1197	13	0
1197	14	0
1197	16	0
1197	17	10
1198	1	10
1198	2	10
1198	3	10
1198	4	10
1198	5	10
1198	6	10
1198	7	10
1198	8	10
1198	9	10
1198	10	10
1198	11	0
1198	12	0
1198	13	0
1198	14	0
1198	16	0
1198	17	10
1199	1	10
1199	2	10
1199	3	10
1199	4	10
1199	5	10
1199	6	10
1199	7	10
1199	8	10
1199	9	10
1199	10	10
1199	11	0
1199	12	0
1199	13	0
1199	14	0
1199	16	0
1199	17	10
1200	1	10
1200	2	10
1200	3	10
1200	4	10
1200	5	10
1200	6	10
1200	7	10
1200	8	10
1200	9	10
1200	10	10
1200	11	0
1200	12	0
1200	13	0
1200	14	0
1200	16	0
1200	17	10
1201	1	10
1201	2	10
1201	3	10
1201	4	10
1201	5	10
1201	6	10
1201	7	10
1201	8	10
1201	9	10
1201	10	10
1201	11	0
1201	12	0
1201	13	0
1201	14	0
1201	16	0
1201	17	10
1202	1	10
1202	2	10
1202	3	10
1202	4	10
1202	5	10
1202	6	10
1202	7	10
1202	8	10
1202	9	10
1202	10	10
1202	11	0
1202	12	0
1202	13	0
1202	14	0
1202	16	0
1202	17	10
1203	1	10
1203	2	10
1203	3	10
1203	4	10
1203	5	10
1203	6	10
1203	7	10
1203	8	10
1203	9	10
1203	10	10
1203	11	0
1203	12	0
1203	13	0
1203	14	0
1203	16	0
1203	17	10
1204	1	10
1204	2	10
1204	3	10
1204	4	10
1204	5	10
1204	6	10
1204	7	10
1204	8	10
1204	9	10
1204	10	10
1204	11	0
1204	12	0
1204	13	0
1204	14	0
1204	16	0
1204	17	10
1205	1	10
1205	2	10
1205	3	10
1205	4	10
1205	5	10
1205	6	10
1205	7	10
1205	8	10
1205	9	10
1205	10	10
1205	11	0
1205	12	0
1205	13	0
1205	14	0
1205	16	0
1205	17	10
1206	1	10
1206	2	10
1206	3	10
1206	4	10
1206	5	10
1206	6	10
1206	7	10
1206	8	10
1206	9	10
1206	10	10
1206	11	0
1206	12	0
1206	13	0
1206	14	0
1206	16	0
1206	17	10
1207	1	10
1207	2	10
1207	3	10
1207	4	10
1207	5	10
1207	6	10
1207	7	10
1207	8	10
1207	9	10
1207	10	10
1207	11	0
1207	12	0
1207	13	0
1207	14	0
1207	16	0
1207	17	10
1208	1	10
1208	2	10
1208	3	10
1208	4	10
1208	5	10
1208	6	10
1208	7	10
1208	8	10
1208	9	10
1208	10	10
1208	11	0
1208	12	0
1208	13	0
1208	14	0
1208	16	0
1208	17	10
1209	1	10
1209	2	10
1209	3	10
1209	4	10
1209	5	10
1209	6	10
1209	7	10
1209	8	10
1209	9	10
1209	10	10
1209	11	0
1209	12	0
1209	13	0
1209	14	0
1209	16	0
1209	17	10
1210	1	10
1210	2	10
1210	3	10
1210	4	10
1210	5	10
1210	6	10
1210	7	10
1210	8	10
1210	9	10
1210	10	10
1210	11	0
1210	12	0
1210	13	0
1210	14	0
1210	16	0
1210	17	10
1211	1	10
1211	2	10
1211	3	10
1211	4	10
1211	5	10
1211	6	10
1211	7	10
1211	8	10
1211	9	10
1211	10	10
1211	11	0
1211	12	0
1211	13	0
1211	14	0
1211	16	0
1211	17	10
1212	1	10
1212	2	10
1212	3	10
1212	4	10
1212	5	10
1212	6	10
1212	7	10
1212	8	10
1212	9	10
1212	10	10
1212	11	0
1212	12	0
1212	13	0
1212	14	0
1212	16	0
1212	17	10
1213	1	10
1213	2	10
1213	3	10
1213	4	10
1213	5	10
1213	6	10
1213	7	10
1213	8	10
1213	9	10
1213	10	10
1213	11	0
1213	12	0
1213	13	0
1213	14	0
1213	16	0
1213	17	10
1214	1	10
1214	2	10
1214	3	10
1214	4	10
1214	5	10
1214	6	10
1214	7	10
1214	8	10
1214	9	10
1214	10	10
1214	11	0
1214	12	0
1214	13	0
1214	14	0
1214	16	0
1214	17	10
1215	1	10
1215	2	10
1215	3	10
1215	4	10
1215	5	10
1215	6	10
1215	7	10
1215	8	10
1215	9	10
1215	10	10
1215	11	0
1215	12	0
1215	13	0
1215	14	0
1215	16	0
1215	17	10
1216	1	10
1216	2	10
1216	3	10
1216	4	10
1216	5	10
1216	6	10
1216	7	10
1216	8	10
1216	9	10
1216	10	10
1216	11	0
1216	12	0
1216	13	0
1216	14	0
1216	16	0
1216	17	10
1217	1	10
1217	2	10
1217	3	10
1217	4	10
1217	5	10
1217	6	10
1217	7	10
1217	8	10
1217	9	10
1217	10	10
1217	11	0
1217	12	0
1217	13	0
1217	14	0
1217	16	0
1217	17	10
1218	1	10
1218	2	10
1218	3	10
1218	4	10
1218	5	10
1218	6	10
1218	7	10
1218	8	10
1218	9	10
1218	10	10
1218	11	0
1218	12	0
1218	13	0
1218	14	0
1218	16	0
1218	17	10
1219	1	10
1219	2	10
1219	3	10
1219	4	10
1219	5	10
1219	6	10
1219	7	10
1219	8	10
1219	9	10
1219	10	10
1219	11	0
1219	12	0
1219	13	0
1219	14	0
1219	16	0
1219	17	10
1220	1	10
1220	2	10
1220	3	10
1220	4	10
1220	5	10
1220	6	10
1220	7	10
1220	8	10
1220	9	10
1220	10	10
1220	11	0
1220	12	0
1220	13	0
1220	14	0
1220	16	0
1220	17	10
1221	1	10
1221	2	10
1221	3	10
1221	4	10
1221	5	10
1221	6	10
1221	7	10
1221	8	10
1221	9	10
1221	10	10
1221	11	0
1221	12	0
1221	13	0
1221	14	0
1221	16	0
1221	17	10
1222	1	10
1222	2	10
1222	3	10
1222	4	10
1222	5	10
1222	6	10
1222	7	10
1222	8	10
1222	9	10
1222	10	10
1222	11	0
1222	12	0
1222	13	0
1222	14	0
1222	16	0
1222	17	10
1223	1	10
1223	2	10
1223	3	10
1223	4	10
1223	5	10
1223	6	10
1223	7	10
1223	8	10
1223	9	10
1223	10	10
1223	11	0
1223	12	0
1223	13	0
1223	14	0
1223	16	0
1223	17	10
1224	1	10
1224	2	10
1224	3	10
1224	4	10
1224	5	10
1224	6	10
1224	7	10
1224	8	10
1224	9	10
1224	10	10
1224	11	1
1224	12	0
1224	13	0
1224	14	0
1224	15	1
1224	16	0
1224	17	10
1225	1	10
1225	2	10
1225	3	10
1225	4	10
1225	5	10
1225	6	10
1225	7	10
1225	8	10
1225	9	10
1225	10	10
1225	11	0
1225	12	0
1225	13	0
1225	14	0
1225	16	0
1225	17	10
1226	1	10
1226	2	10
1226	3	10
1226	4	10
1226	5	10
1226	6	10
1226	7	10
1226	8	10
1226	9	10
1226	10	10
1226	11	0
1226	12	0
1226	13	0
1226	14	0
1226	16	0
1226	17	10
1227	1	10
1227	2	10
1227	3	10
1227	4	10
1227	5	10
1227	6	10
1227	7	10
1227	8	10
1227	9	10
1227	10	10
1227	11	0
1227	12	0
1227	13	0
1227	14	0
1227	16	0
1227	17	10
1228	1	10
1228	2	10
1228	3	10
1228	4	10
1228	5	10
1228	6	10
1228	7	10
1228	8	10
1228	9	10
1228	10	10
1228	11	0
1228	12	0
1228	13	0
1228	14	0
1228	16	0
1228	17	10
1229	1	10
1229	2	10
1229	3	10
1229	4	10
1229	5	10
1229	6	10
1229	7	10
1229	8	10
1229	9	10
1229	10	10
1229	11	0
1229	12	0
1229	13	0
1229	14	0
1229	16	0
1229	17	10
1230	1	10
1230	2	10
1230	3	10
1230	4	10
1230	5	10
1230	6	10
1230	7	10
1230	8	10
1230	9	10
1230	10	10
1230	11	0
1230	12	0
1230	13	0
1230	14	0
1230	16	0
1230	17	10
1231	1	10
1231	2	10
1231	3	10
1231	4	10
1231	5	10
1231	6	10
1231	7	10
1231	8	10
1231	9	10
1231	10	10
1231	11	0
1231	12	0
1231	13	0
1231	14	0
1231	16	0
1231	17	10
1232	1	10
1232	2	10
1232	3	10
1232	4	10
1232	5	10
1232	6	10
1232	7	10
1232	8	10
1232	9	10
1232	10	10
1232	11	0
1232	12	0
1232	13	0
1232	14	0
1232	16	0
1232	17	10
1233	1	10
1233	2	10
1233	3	10
1233	4	10
1233	5	10
1233	6	10
1233	7	10
1233	8	6
1233	9	10
1233	10	10
1233	11	0
1233	12	0
1233	13	0
1233	14	0
1233	16	0
1233	17	10
1234	1	10
1234	2	10
1234	3	10
1234	4	10
1234	5	10
1234	6	10
1234	7	10
1234	8	6
1234	9	10
1234	10	10
1234	11	0
1234	12	0
1234	13	0
1234	14	0
1234	16	0
1234	17	10
1235	1	10
1235	2	10
1235	3	10
1235	4	10
1235	5	10
1235	6	10
1235	7	10
1235	8	6
1235	9	10
1235	10	10
1235	11	0
1235	12	0
1235	13	0
1235	14	0
1235	16	0
1235	17	10
1236	1	10
1236	2	10
1236	3	10
1236	4	10
1236	5	10
1236	6	10
1236	7	10
1236	8	10
1236	9	10
1236	10	10
1236	11	0
1236	12	0
1236	13	0
1236	14	0
1236	16	0
1236	17	10
1237	1	10
1237	2	10
1237	3	10
1237	4	10
1237	5	10
1237	6	10
1237	7	10
1237	8	10
1237	9	10
1237	10	10
1237	11	0
1237	12	0
1237	13	0
1237	14	0
1237	16	0
1237	17	10
1238	1	10
1238	2	10
1238	3	10
1238	4	10
1238	5	10
1238	6	10
1238	7	10
1238	8	10
1238	9	10
1238	10	10
1238	11	0
1238	12	0
1238	13	0
1238	14	0
1238	16	0
1238	17	10
1239	1	10
1239	2	10
1239	3	10
1239	4	10
1239	5	10
1239	6	10
1239	7	10
1239	8	10
1239	9	10
1239	10	10
1239	11	0
1239	12	0
1239	13	0
1239	14	0
1239	16	0
1239	17	10
1240	1	10
1240	2	10
1240	3	10
1240	4	10
1240	5	10
1240	6	10
1240	7	10
1240	8	10
1240	9	10
1240	10	10
1240	11	0
1240	12	0
1240	13	0
1240	14	0
1240	16	0
1240	17	10
1241	1	10
1241	2	10
1241	3	10
1241	4	10
1241	5	10
1241	6	10
1241	7	10
1241	8	10
1241	9	10
1241	10	10
1241	11	0
1241	12	0
1241	13	0
1241	14	0
1241	16	0
1241	17	10
1242	1	10
1242	2	10
1242	3	10
1242	4	10
1242	5	10
1242	6	10
1242	7	10
1242	8	10
1242	9	10
1242	10	10
1242	11	0
1242	12	0
1242	13	0
1242	14	0
1242	16	0
1242	17	10
1243	1	10
1243	2	10
1243	3	10
1243	4	10
1243	5	10
1243	6	10
1243	7	10
1243	8	10
1243	9	10
1243	10	10
1243	11	0
1243	12	0
1243	13	0
1243	14	0
1243	16	0
1243	17	10
1244	1	10
1244	2	10
1244	3	10
1244	4	10
1244	5	10
1244	6	10
1244	7	10
1244	8	10
1244	9	10
1244	10	10
1244	11	0
1244	12	0
1244	13	0
1244	14	0
1244	16	0
1244	17	10
1245	1	10
1245	2	10
1245	3	10
1245	4	10
1245	5	10
1245	6	10
1245	7	10
1245	8	10
1245	9	10
1245	10	10
1245	11	0
1245	12	0
1245	13	0
1245	14	0
1245	16	0
1245	17	10
1246	1	10
1246	2	10
1246	3	10
1246	4	10
1246	5	10
1246	6	10
1246	7	10
1246	8	10
1246	9	10
1246	10	10
1246	11	0
1246	12	0
1246	13	0
1246	14	0
1246	16	0
1246	17	10
1247	1	10
1247	2	10
1247	3	10
1247	4	10
1247	5	8
1247	6	10
1247	7	10
1247	8	10
1247	9	10
1247	10	10
1247	11	0
1247	12	0
1247	13	0
1247	14	0
1247	16	0
1247	17	10
1248	1	10
1248	2	10
1248	3	10
1248	4	10
1248	5	10
1248	6	10
1248	7	8
1248	8	10
1248	9	10
1248	10	10
1248	11	0
1248	12	0
1248	13	0
1248	14	0
1248	16	0
1248	17	10
1249	1	10
1249	2	10
1249	3	10
1249	4	10
1249	5	10
1249	6	10
1249	7	10
1249	8	10
1249	9	10
1249	10	10
1249	11	0
1249	12	0
1249	13	0
1249	14	0
1249	16	0
1249	17	10
1250	1	10
1250	2	10
1250	3	10
1250	4	10
1250	5	10
1250	6	10
1250	7	10
1250	8	10
1250	9	10
1250	10	10
1250	11	0
1250	12	0
1250	13	0
1250	14	0
1250	16	0
1250	17	10
1251	1	10
1251	2	10
1251	3	10
1251	4	10
1251	5	10
1251	6	10
1251	7	10
1251	8	10
1251	9	10
1251	10	10
1251	11	0
1251	12	0
1251	13	0
1251	14	0
1251	16	0
1251	17	10
1252	1	10
1252	2	10
1252	3	10
1252	4	10
1252	5	10
1252	6	10
1252	7	10
1252	8	10
1252	9	10
1252	10	10
1252	11	0
1252	12	0
1252	13	0
1252	14	0
1252	16	0
1252	17	10
1253	1	10
1253	2	10
1253	3	10
1253	4	10
1253	5	10
1253	6	10
1253	7	10
1253	8	10
1253	9	10
1253	10	10
1253	11	0
1253	12	0
1253	13	0
1253	14	0
1253	16	0
1253	17	10
1254	1	10
1254	2	10
1254	3	10
1254	4	10
1254	5	10
1254	6	10
1254	7	10
1254	8	10
1254	9	10
1254	10	10
1254	11	0
1254	12	0
1254	13	0
1254	14	0
1254	16	0
1254	17	10
1255	1	10
1255	2	10
1255	3	10
1255	4	10
1255	5	10
1255	6	10
1255	7	10
1255	8	10
1255	9	10
1255	10	10
1255	11	1
1255	12	0
1255	13	0
1255	14	0
1255	15	1
1255	16	0
1255	17	10
1256	1	10
1256	2	10
1256	3	10
1256	4	10
1256	5	10
1256	6	10
1256	7	10
1256	8	10
1256	9	10
1256	10	10
1256	11	0
1256	12	0
1256	13	0
1256	14	0
1256	16	0
1256	17	10
1257	1	10
1257	2	10
1257	3	10
1257	4	10
1257	5	10
1257	6	10
1257	7	10
1257	8	10
1257	9	10
1257	10	10
1257	11	10
1257	12	10
1257	13	10
1258	1	10
1258	2	10
1258	3	10
1258	4	10
1258	5	10
1258	6	10
1258	7	10
1258	8	10
1258	9	10
1258	10	10
1258	11	0
1258	12	0
1258	13	0
1258	14	0
1258	16	0
1258	17	10
1259	1	10
1259	2	8
1259	3	10
1259	4	10
1259	5	10
1259	6	10
1259	7	10
1259	8	10
1259	9	10
1259	10	10
1259	11	0
1259	12	1
1259	13	1
1259	14	1
1259	15	0
1259	16	0
1259	17	10
1260	1	10
1260	2	10
1260	3	10
1260	4	10
1260	5	10
1260	6	10
1260	7	10
1260	8	10
1260	9	10
1260	10	10
1260	11	10
1260	12	10
1260	13	10
1261	1	10
1261	2	10
1261	3	10
1261	4	10
1261	5	10
1261	6	10
1261	7	10
1261	8	10
1261	9	10
1261	10	10
1261	11	0
1261	12	0
1261	13	0
1261	14	0
1261	16	0
1261	17	10
\.


--
-- Data for Name: grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY grupo (idgrupo, grupo, idcal, profesor) FROM stdin;
5	2	5	HUCG750316
6	4	5	HUCG750316
7	3	6	SOCR680401
8	1	5	DIHO791022
9	3	8	SOCR680401
10	1	8	DIHO791022
11	4	7	HUCG750316
12	2	7	HUCG750316
13	1	10	DIHO791022
14	2	9	HUCG750316
15	3	9	HUCG750316
16	4	10	SOCR680401
17	1	12	DIHO791022
18	2	11	HUCG750316
21	3	11	HUCG750316
22	4	12	SOCR680401
\.


--
-- Data for Name: horarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY horarios (id, descripcion) FROM stdin;
2	Martes y Jueves
1	Lunes Mircoles y Viernes
\.


--
-- Data for Name: i_encuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY i_encuestas (idencuesta, ncuenta, idcxp, fecha) FROM stdin;
1	308626807	2	2014-09-03
2	308626807	4	2014-09-03
3	308626807	6	2014-09-03
4	308056646	2	2014-09-06
5	308056646	4	2014-09-06
6	308056646	6	2014-09-06
7	308056646	8	2014-09-06
8	308072826	2	2014-09-06
9	308072826	4	2014-09-06
10	308072826	6	2014-09-06
11	308072826	8	2014-09-06
12	308107638	2	2014-09-06
13	308107638	4	2014-09-06
14	308107638	6	2014-09-06
15	308107638	8	2014-09-06
16	308105445	2	2014-09-07
17	308105445	4	2014-09-07
18	308105445	6	2014-09-07
19	308105445	8	2014-09-07
20	308045653	2	2014-09-07
21	308045653	4	2014-09-07
22	308045653	6	2014-09-07
23	308045653	8	2014-09-07
24	308220034	2	2014-09-07
25	308220034	4	2014-09-07
26	308042999	2	2014-09-07
27	308042999	4	2014-09-07
28	308042999	6	2014-09-07
29	308042999	8	2014-09-07
30	308029631	2	2014-09-08
31	308029631	4	2014-09-08
32	308029631	6	2014-09-08
33	308029631	8	2014-09-08
34	308162291	2	2014-09-08
35	308162291	4	2014-09-08
36	308162291	6	2014-09-08
37	308162291	8	2014-09-08
38	306306282	5	2014-09-09
39	306306282	1	2014-09-09
40	306306282	3	2014-09-09
41	306306282	7	2014-09-09
42	410054040	2	2014-09-10
43	410054040	8	2014-09-10
44	410054040	4	2014-09-10
45	410054040	6	2014-09-10
46	308626807	8	2014-09-10
47	308071915	2	2014-09-11
48	308071915	4	2014-09-11
49	308071915	6	2014-09-11
50	308071915	8	2014-09-11
51	308313606	2	2014-09-11
52	308313606	4	2014-09-11
53	308313606	6	2014-09-11
54	308313606	8	2014-09-11
55	411004983	2	2014-09-11
56	411004983	4	2014-09-11
57	411004983	6	2014-09-11
58	411004983	8	2014-09-11
59	308192472	2	2014-09-11
60	308192472	4	2014-09-11
61	308192472	6	2014-09-11
62	308192472	8	2014-09-11
63	308041947	4	2014-09-11
64	308041947	2	2014-09-11
65	308041947	6	2014-09-11
66	308041947	8	2014-09-11
67	105001933	2	2014-09-12
68	105001933	4	2014-09-12
69	105001933	6	2014-09-12
70	105001933	8	2014-09-12
71	308071915	10	2014-09-13
72	308334582	2	2014-09-13
73	308334582	4	2014-09-13
74	308334582	6	2014-09-13
75	308334582	8	2014-09-13
76	308626807	10	2014-09-13
77	308240308	2	2014-09-15
78	308240308	4	2014-09-15
79	308240308	6	2014-09-15
80	308240308	8	2014-09-15
81	308240308	10	2014-09-15
82	307239123	9	2014-09-15
83	308151246	2	2014-09-17
84	308151246	4	2014-09-17
85	308151246	6	2014-09-17
86	308151246	8	2014-09-17
87	308151246	10	2014-09-17
88	308086937	10	2014-09-18
89	306306282	9	2014-09-18
90	307109677	2	2014-09-18
91	307109677	6	2014-09-18
92	307109677	4	2014-09-18
93	307109677	8	2014-09-18
94	307109677	10	2014-09-18
95	308029631	10	2014-09-19
96	308045653	10	2014-09-19
97	308249284	2	2014-09-19
98	303843258	2	2014-09-19
99	303843258	4	2014-09-19
100	303843258	6	2014-09-19
101	303843258	8	2014-09-19
102	303843258	10	2014-09-19
103	411036395	1	2014-09-21
104	411036395	3	2014-09-21
105	411036395	5	2014-09-21
106	411036395	7	2014-09-21
107	411036395	9	2014-09-21
108	308324912	2	2014-09-21
109	308324912	4	2014-09-21
110	308324912	6	2014-09-21
111	308324912	8	2014-09-21
112	308324912	10	2014-09-21
113	308253072	2	2014-09-23
114	308253072	4	2014-09-23
115	308253072	6	2014-09-23
116	308253072	8	2014-09-23
117	308253072	10	2014-09-23
118	410054040	10	2014-09-23
119	308107638	10	2014-09-26
120	308012392	2	2014-09-26
121	308012392	4	2014-09-26
122	308012392	6	2014-09-26
123	308012392	8	2014-09-26
124	308012392	10	2014-09-26
125	308105445	10	2014-09-26
126	308162291	10	2014-09-27
127	308162291	12	2014-09-27
128	308162291	14	2014-09-27
129	308162291	16	2014-09-27
130	308041947	10	2014-09-27
131	308041947	12	2014-09-27
132	307109677	12	2014-09-27
133	307109677	14	2014-09-27
134	307109677	16	2014-09-27
135	308107638	12	2014-09-28
136	308107638	14	2014-09-28
137	308107638	16	2014-09-28
138	308105445	12	2014-09-28
139	308105445	16	2014-09-28
140	308042999	10	2014-09-28
141	308042999	12	2014-09-28
142	308042999	14	2014-09-28
143	308042999	16	2014-09-28
144	308249284	4	2014-09-29
145	308151246	12	2014-09-29
146	308151246	14	2014-09-29
147	308151246	16	2014-09-29
148	308151246	18	2014-09-29
149	308626807	12	2014-09-29
150	308626807	14	2014-09-29
151	308626807	16	2014-09-29
152	308626807	18	2014-09-29
153	308071915	12	2014-09-29
154	308071915	14	2014-09-29
155	308071915	16	2014-09-30
156	308071915	18	2014-09-30
157	308268063	2	2014-10-04
158	308268063	4	2014-10-04
159	308268063	6	2014-10-04
160	308268063	22	2014-10-04
161	308268063	12	2014-10-04
162	308151246	20	2014-10-05
163	308151246	22	2014-10-05
164	307097855	2	2014-10-05
165	307097855	4	2014-10-05
166	307097855	6	2014-10-05
167	307097855	8	2014-10-05
168	307097855	10	2014-10-05
169	307097855	12	2014-10-05
170	307097855	14	2014-10-05
171	307097855	16	2014-10-05
172	307097855	18	2014-10-05
173	307097855	20	2014-10-05
174	307097855	22	2014-10-05
175	307109677	18	2014-10-05
176	307109677	20	2014-10-05
177	307109677	22	2014-10-05
178	308304806	2	2014-10-06
179	308304806	4	2014-10-06
180	307604426	2	2014-10-06
181	308304806	6	2014-10-06
182	307604426	4	2014-10-06
183	307604426	6	2014-10-06
184	307604426	8	2014-10-06
185	308304806	8	2014-10-06
186	307604426	10	2014-10-06
187	307604426	12	2014-10-06
188	307604426	14	2014-10-06
189	308304806	10	2014-10-06
190	307604426	16	2014-10-06
191	307604426	18	2014-10-06
192	307604426	20	2014-10-06
193	308304806	12	2014-10-06
194	307604426	22	2014-10-06
195	308304806	14	2014-10-06
196	308304806	16	2014-10-06
197	308304806	18	2014-10-06
198	308304806	20	2014-10-06
199	308304806	22	2014-10-06
200	307616052	2	2014-10-06
201	307616052	4	2014-10-06
202	307616052	6	2014-10-06
203	307616052	8	2014-10-06
204	307616052	10	2014-10-06
205	307616052	12	2014-10-06
206	307616052	14	2014-10-06
207	307616052	16	2014-10-06
208	307616052	18	2014-10-06
209	307616052	20	2014-10-06
210	307616052	22	2014-10-06
211	303843258	12	2014-10-06
212	105000194	2	2014-10-06
213	105000194	4	2014-10-06
214	105000194	6	2014-10-06
215	105000194	8	2014-10-06
216	105000194	10	2014-10-06
217	105000194	12	2014-10-06
218	105000194	14	2014-10-06
219	105000194	16	2014-10-06
220	105000194	18	2014-10-06
221	105000194	20	2014-10-06
222	105000194	22	2014-10-06
223	308071915	20	2014-10-06
224	308071915	22	2014-10-06
225	308056646	10	2014-10-06
226	308056646	12	2014-10-06
227	308056646	14	2014-10-06
228	308056646	16	2014-10-06
229	308056646	18	2014-10-06
230	308056646	20	2014-10-06
231	308056646	22	2014-10-06
232	308023189	2	2014-10-06
233	308023189	4	2014-10-06
234	308023189	6	2014-10-06
237	308023189	22	2014-10-06
239	308023189	20	2014-10-06
240	308313606	10	2014-10-06
241	308023189	18	2014-10-06
242	308313606	12	2014-10-06
245	308313606	14	2014-10-06
247	308313606	16	2014-10-06
248	308626807	20	2014-10-06
249	308313606	18	2014-10-06
250	308626807	22	2014-10-06
251	308313606	20	2014-10-06
252	308313606	22	2014-10-06
253	308192472	10	2014-10-06
254	308192472	12	2014-10-06
255	308192472	14	2014-10-06
256	308192472	16	2014-10-06
257	308192472	18	2014-10-06
258	308192472	20	2014-10-06
259	308192472	22	2014-10-06
260	308029631	12	2014-10-06
261	308029631	14	2014-10-06
262	308029631	16	2014-10-06
263	308029631	18	2014-10-06
264	308029631	20	2014-10-06
265	308029631	22	2014-10-06
266	308045653	12	2014-10-06
267	306055904	2	2014-10-06
268	306055904	4	2014-10-06
269	306055904	6	2014-10-06
270	306055904	8	2014-10-06
271	306055904	10	2014-10-06
272	306055904	12	2014-10-06
273	306055904	14	2014-10-06
274	306055904	16	2014-10-06
275	306055904	18	2014-10-06
276	306055904	20	2014-10-06
277	306055904	22	2014-10-06
278	308045653	14	2014-10-06
279	308045653	16	2014-10-06
280	308045653	18	2014-10-06
281	308045653	20	2014-10-06
282	308045653	22	2014-10-06
283	308078419	2	2014-10-06
284	308078419	4	2014-10-06
285	308078419	6	2014-10-06
286	308078419	8	2014-10-06
287	308078419	10	2014-10-06
288	308078419	12	2014-10-06
289	308078419	14	2014-10-06
290	308078419	16	2014-10-06
291	308078419	18	2014-10-06
292	308078419	20	2014-10-06
293	308078419	22	2014-10-06
294	308106411	2	2014-10-06
295	308106411	4	2014-10-06
296	308106411	6	2014-10-06
297	308106411	8	2014-10-06
298	308106411	10	2014-10-06
299	308106411	12	2014-10-06
300	308106411	14	2014-10-06
301	308106411	16	2014-10-06
302	308106411	18	2014-10-06
303	308106411	20	2014-10-06
304	308106411	22	2014-10-06
305	308268063	8	2014-10-07
306	308268063	14	2014-10-07
307	308268063	16	2014-10-07
308	308268063	10	2014-10-07
309	308268063	20	2014-10-07
310	306005459	2	2014-10-07
311	306005459	6	2014-10-07
312	306005459	4	2014-10-07
313	306005459	8	2014-10-07
314	306005459	10	2014-10-07
315	306005459	12	2014-10-07
316	306005459	14	2014-10-07
317	306005459	16	2014-10-07
318	306005459	18	2014-10-07
319	306005459	20	2014-10-07
320	306005459	22	2014-10-07
321	306005459	24	2014-10-07
323	308240308	12	2014-10-07
324	308240308	14	2014-10-07
325	308240308	16	2014-10-07
326	308240308	18	2014-10-07
327	308240308	20	2014-10-07
328	308240308	22	2014-10-07
329	308107638	18	2014-10-07
330	308107638	20	2014-10-07
331	308107638	22	2014-10-07
332	308105445	14	2014-10-07
333	308105445	18	2014-10-07
334	308105445	20	2014-10-07
335	308105445	22	2014-10-07
336	307127545	2	2014-10-07
337	307127545	6	2014-10-07
338	307127545	8	2014-10-07
339	307127545	4	2014-10-07
340	307127545	12	2014-10-07
341	307127545	14	2014-10-07
342	307127545	16	2014-10-07
343	307127545	20	2014-10-07
344	307127545	22	2014-10-07
345	307168702	2	2014-10-07
346	307168702	6	2014-10-07
347	307168702	10	2014-10-07
348	307168702	14	2014-10-07
349	307168702	18	2014-10-07
350	307168702	22	2014-10-07
351	307168702	24	2014-10-07
352	410054040	12	2014-10-07
353	410054040	14	2014-10-07
354	410054040	16	2014-10-07
355	410054040	18	2014-10-07
356	410054040	20	2014-10-07
357	410054040	22	2014-10-07
358	410054040	24	2014-10-07
360	308249284	6	2014-10-07
361	308249284	8	2014-10-07
362	308162291	18	2014-10-07
363	308162291	20	2014-10-07
364	308249284	10	2014-10-07
365	308249284	12	2014-10-07
366	308162291	22	2014-10-07
367	308249284	14	2014-10-07
368	308249284	16	2014-10-07
369	308249284	18	2014-10-07
370	308249284	20	2014-10-07
371	308249284	22	2014-10-07
372	308253072	14	2014-10-07
373	308253072	12	2014-10-07
374	308253072	16	2014-10-07
375	308253072	18	2014-10-07
376	308253072	20	2014-10-07
377	308253072	22	2014-10-07
378	308072826	12	2014-10-07
379	308072826	14	2014-10-07
380	308072826	16	2014-10-07
381	308072826	18	2014-10-07
382	308072826	20	2014-10-07
383	308072826	22	2014-10-07
384	308051926	2	2014-10-07
385	308072826	10	2014-10-07
386	308051926	8	2014-10-07
387	308051926	10	2014-10-07
388	308051926	4	2014-10-07
389	308051926	6	2014-10-07
390	308051926	12	2014-10-07
391	308051926	14	2014-10-07
392	308051926	16	2014-10-07
393	308051926	18	2014-10-07
394	308051926	20	2014-10-07
395	411004983	10	2014-10-07
396	411004983	12	2014-10-07
397	411004983	14	2014-10-07
398	411004983	16	2014-10-07
399	411004983	18	2014-10-07
400	411004983	20	2014-10-07
401	411004983	22	2014-10-07
402	308334582	10	2014-10-08
403	308334582	12	2014-10-08
404	308334582	14	2014-10-08
405	308334582	16	2014-10-08
406	308334582	18	2014-10-08
407	308334582	20	2014-10-08
408	308334582	22	2014-10-08
409	308334582	24	2014-10-08
411	411003254	24	2014-10-08
412	411003254	22	2014-10-08
414	411003254	18	2014-10-08
415	411003254	16	2014-10-08
416	411003254	14	2014-10-08
417	411003254	12	2014-10-08
418	411003254	10	2014-10-08
419	411003254	8	2014-10-08
420	411003254	2	2014-10-08
421	411003254	4	2014-10-08
422	411003254	6	2014-10-08
423	411003254	20	2014-10-08
425	105001933	10	2014-10-08
426	105001933	12	2014-10-08
427	105001933	14	2014-10-08
428	105001933	16	2014-10-08
429	105001933	18	2014-10-08
430	105001933	20	2014-10-08
431	105001933	22	2014-10-08
432	105001933	24	2014-10-08
435	308042999	18	2014-10-08
436	308042999	20	2014-10-08
437	308042999	22	2014-10-08
438	308042999	24	2014-10-08
441	308023189	8	2014-10-08
443	308023189	12	2014-10-08
444	308023189	14	2014-10-08
445	308626807	24	2014-10-10
446	308045653	24	2014-10-10
447	308107638	24	2014-10-10
448	303843258	14	2014-10-10
449	303843258	16	2014-10-10
450	303843258	18	2014-10-10
451	303843258	20	2014-10-10
452	303843258	22	2014-10-10
453	303843258	24	2014-10-10
454	308012392	12	2014-10-10
456	308012392	14	2014-10-10
457	308012392	16	2014-10-10
458	308012392	18	2014-10-10
459	308012392	20	2014-10-10
460	308012392	22	2014-10-10
462	306240168	1	2014-10-10
463	306240168	3	2014-10-10
464	306240168	5	2014-10-10
465	306240168	7	2014-10-10
466	306240168	9	2014-10-10
467	306240168	11	2014-10-10
468	306240168	13	2014-10-10
469	306240168	15	2014-10-10
470	306240168	17	2014-10-10
471	306240168	19	2014-10-10
472	306240168	21	2014-10-10
473	306240168	23	2014-10-10
474	308220034	6	2014-10-11
475	308041947	14	2014-10-11
476	308041947	16	2014-10-11
477	308041947	18	2014-10-11
478	308041947	20	2014-10-11
479	308041947	22	2014-10-11
480	308041947	24	2014-10-11
481	308071915	24	2014-10-11
482	308033498	1	2014-10-13
483	308033498	3	2014-10-13
484	308033498	5	2014-10-13
485	308033498	7	2014-10-13
486	308033498	9	2014-10-13
487	308033498	11	2014-10-13
488	308033498	13	2014-10-13
489	308033498	15	2014-10-13
490	308033498	17	2014-10-13
491	308033498	19	2014-10-13
492	308033498	21	2014-10-13
493	308033498	23	2014-10-13
494	308086937	2	2014-10-13
495	308086937	4	2014-10-13
496	308086937	6	2014-10-13
497	308086937	8	2014-10-13
498	308086937	12	2014-10-13
499	308086937	14	2014-10-13
500	308086937	16	2014-10-13
501	308086937	18	2014-10-13
502	308086937	20	2014-10-13
503	308086937	22	2014-10-13
504	308086937	24	2014-10-13
505	307168702	4	2014-10-13
506	308151246	24	2014-10-13
507	308324912	12	2014-10-13
508	308324912	14	2014-10-13
509	308324912	16	2014-10-13
510	308324912	18	2014-10-13
511	308324912	20	2014-10-13
512	308324912	22	2014-10-13
513	308324912	24	2014-10-13
514	308220034	8	2014-10-13
515	308220034	10	2014-10-13
516	308220034	12	2014-10-13
517	308220034	14	2014-10-13
518	308220034	16	2014-10-13
519	308220034	18	2014-10-13
520	308220034	20	2014-10-13
521	308220034	22	2014-10-13
522	308220034	24	2014-10-13
523	308023189	24	2014-10-13
525	308023189	16	2014-10-13
526	308023189	10	2014-10-13
527	307109677	24	2014-10-13
528	306306282	11	2014-10-14
529	306306282	13	2014-10-14
530	306306282	15	2014-10-14
531	306306282	17	2014-10-14
532	306306282	19	2014-10-14
533	306306282	21	2014-10-14
534	306306282	23	2014-10-14
535	308203792	1	2014-10-15
536	308203792	3	2014-10-15
537	308203792	5	2014-10-15
538	308203792	7	2014-10-15
539	308203792	9	2014-10-15
540	308203792	11	2014-10-15
541	308203792	13	2014-10-15
542	308203792	15	2014-10-15
543	308203792	17	2014-10-15
544	308203792	19	2014-10-15
545	308203792	21	2014-10-15
546	308203792	23	2014-10-15
547	308268063	18	2014-10-15
548	307616052	24	2014-10-15
549	307048455	1	2014-10-15
550	307048455	3	2014-10-15
551	307048455	5	2014-10-15
552	307048455	7	2014-10-15
553	307048455	9	2014-10-15
554	307048455	11	2014-10-15
555	307048455	13	2014-10-15
556	307048455	15	2014-10-15
557	307048455	17	2014-10-15
558	308313606	24	2014-10-15
559	307048455	19	2014-10-15
560	307048455	21	2014-10-15
561	307048455	23	2014-10-15
562	307214201	21	2014-10-15
563	307214201	19	2014-10-15
564	307214201	17	2014-10-15
565	307214201	15	2014-10-15
566	307214201	13	2014-10-15
567	307214201	11	2014-10-15
568	307214201	23	2014-10-15
569	307214201	9	2014-10-15
570	307214201	7	2014-10-15
571	307214201	5	2014-10-15
572	307214201	3	2014-10-15
573	307214201	1	2014-10-15
574	307239123	21	2014-10-15
575	307239123	19	2014-10-15
576	307239123	17	2014-10-15
577	307239123	15	2014-10-15
578	307239123	13	2014-10-15
579	307239123	11	2014-10-15
580	307239123	23	2014-10-15
581	307239123	7	2014-10-15
583	307239123	5	2014-10-15
584	307239123	3	2014-10-15
585	307239123	1	2014-10-15
586	308268063	24	2014-10-15
587	306069204	2	2014-10-15
588	306069204	4	2014-10-15
589	306069204	6	2014-10-15
590	306069204	8	2014-10-15
591	306069204	10	2014-10-15
592	306069204	12	2014-10-15
593	306069204	14	2014-10-15
594	306069204	16	2014-10-15
595	306069204	18	2014-10-15
596	306069204	20	2014-10-15
597	306069204	22	2014-10-15
598	306069204	24	2014-10-15
599	308240308	24	2014-10-15
600	308253072	24	2014-10-15
601	308192472	24	2014-10-15
602	308072826	24	2014-10-15
603	307068743	1	2014-10-15
604	308222722	1	2014-10-15
605	307068743	7	2014-10-15
606	307068743	3	2014-10-15
607	307068743	5	2014-10-15
608	307068743	9	2014-10-15
609	307068743	11	2014-10-15
610	307068743	13	2014-10-15
611	307068743	15	2014-10-15
612	307068743	17	2014-10-15
613	307068743	19	2014-10-15
614	307068743	21	2014-10-15
615	308222722	3	2014-10-15
616	308222722	5	2014-10-15
617	308222722	7	2014-10-15
618	308222722	9	2014-10-15
619	308222722	13	2014-10-15
620	308029631	24	2014-10-15
621	308222722	11	2014-10-15
622	308222722	15	2014-10-15
623	308222722	17	2014-10-15
624	308222722	19	2014-10-15
625	308222722	21	2014-10-15
626	308222722	23	2014-10-15
627	307093077	1	2014-10-16
628	307093077	3	2014-10-16
629	307093077	5	2014-10-16
630	307093077	7	2014-10-16
631	307093077	9	2014-10-16
632	307093077	11	2014-10-16
633	307093077	13	2014-10-16
634	307093077	15	2014-10-16
635	307093077	17	2014-10-16
636	307093077	19	2014-10-16
637	307093077	21	2014-10-16
638	307093077	23	2014-10-16
639	411036395	11	2014-10-16
640	411036395	13	2014-10-16
641	411036395	15	2014-10-16
642	411036395	17	2014-10-16
643	411036395	19	2014-10-16
644	411036395	21	2014-10-16
645	411036395	23	2014-10-16
646	620151031	1	2014-10-16
647	620151031	3	2014-10-16
648	620151031	5	2014-10-16
649	620151031	7	2014-10-16
650	620151031	9	2014-10-16
651	620151031	11	2014-10-16
652	620151031	13	2014-10-16
653	620151031	15	2014-10-16
654	620151031	17	2014-10-16
655	620151031	19	2014-10-16
656	620151031	21	2014-10-16
657	620151031	23	2014-10-16
658	306146620	1	2014-10-16
659	306146620	3	2014-10-16
660	306146620	5	2014-10-16
661	306146620	7	2014-10-16
662	306146620	9	2014-10-16
663	306146620	11	2014-10-16
664	410085912	1	2014-10-16
665	306146620	13	2014-10-16
666	410085912	3	2014-10-16
667	306146620	15	2014-10-16
668	410085912	5	2014-10-16
669	410085912	7	2014-10-16
670	306146620	17	2014-10-16
671	410085912	9	2014-10-16
672	306146620	19	2014-10-16
673	410085912	11	2014-10-16
674	410085912	23	2014-10-16
675	306146620	21	2014-10-16
676	307292335	1	2014-10-16
677	410085912	21	2014-10-16
678	306146620	23	2014-10-16
679	410085912	19	2014-10-16
680	307292335	3	2014-10-16
681	410085912	17	2014-10-16
682	307292335	5	2014-10-16
683	410085912	15	2014-10-16
684	307292335	7	2014-10-16
685	410085912	13	2014-10-16
686	307292335	9	2014-10-16
687	307292335	11	2014-10-16
688	307292335	13	2014-10-16
689	307292335	15	2014-10-16
690	308124437	1	2014-10-16
691	307292335	17	2014-10-16
692	307292335	19	2014-10-16
693	307292335	21	2014-10-16
694	308124437	3	2014-10-16
695	307292335	23	2014-10-16
696	308124437	5	2014-10-16
697	308124437	7	2014-10-16
698	308124437	9	2014-10-16
699	308124437	11	2014-10-16
700	308124437	13	2014-10-16
701	308124437	15	2014-10-16
702	308124437	17	2014-10-16
703	308124437	19	2014-10-16
704	308124437	21	2014-10-16
705	308124437	23	2014-10-16
706	307129013	1	2014-10-16
707	307129013	5	2014-10-16
708	307129013	9	2014-10-16
709	307129013	3	2014-10-16
710	307129013	7	2014-10-16
711	307129013	11	2014-10-16
712	307129013	13	2014-10-16
713	307129013	15	2014-10-16
714	307129013	17	2014-10-16
715	307129013	23	2014-10-16
716	307129013	19	2014-10-16
717	307129013	21	2014-10-16
718	308249284	24	2014-10-16
719	307594017	2	2014-10-16
720	307594017	4	2014-10-16
721	307594017	6	2014-10-16
722	307594017	24	2014-10-16
723	307594017	8	2014-10-16
724	307594017	10	2014-10-16
725	307594017	12	2014-10-16
726	307594017	14	2014-10-16
727	307594017	16	2014-10-16
728	307594017	18	2014-10-16
729	307594017	20	2014-10-16
730	307594017	22	2014-10-16
731	308051926	22	2014-10-16
732	308051926	24	2014-10-16
733	308102585	2	2014-10-16
734	308102585	4	2014-10-16
735	308102585	6	2014-10-16
736	308102585	8	2014-10-16
737	308102585	10	2014-10-16
738	308102585	12	2014-10-16
739	308102585	14	2014-10-16
740	308102585	16	2014-10-16
741	308102585	18	2014-10-16
742	308102585	20	2014-10-16
743	308102585	22	2014-10-16
744	308102585	24	2014-10-16
745	308162291	24	2014-10-17
746	308304806	24	2014-10-17
747	307604426	24	2014-10-17
748	411004983	24	2014-10-19
749	307127545	10	2014-10-19
750	307127545	18	2014-10-19
751	307127545	24	2014-10-19
752	308078419	24	2014-10-19
753	308056646	24	2014-10-20
754	307097855	24	2014-10-20
755	105000194	24	2014-10-21
756	306055904	24	2014-10-25
757	308106411	24	2014-10-25
758	307168702	8	2014-10-27
759	307168702	12	2014-10-27
760	307168702	16	2014-10-27
761	307168702	20	2014-10-27
762	307068743	23	2014-10-27
763	308151246	26	2014-10-28
764	308151246	28	2014-10-28
765	308045653	26	2014-10-28
766	308045653	28	2014-10-28
767	308626807	26	2014-10-28
768	308626807	28	2014-10-28
769	308029631	26	2014-10-28
770	308029631	28	2014-10-28
771	308071915	26	2014-10-28
772	308071915	28	2014-10-28
773	308162291	26	2014-10-28
774	308162291	28	2014-10-28
775	308324912	26	2014-10-28
776	308324912	28	2014-10-28
777	308023189	26	2014-10-28
778	308023189	28	2014-10-28
779	308106411	26	2014-10-28
780	308106411	28	2014-10-28
781	308220034	26	2014-10-28
782	308220034	28	2014-10-28
783	308334582	26	2014-10-29
784	308334582	28	2014-10-29
785	308012392	24	2014-10-29
786	308012392	26	2014-10-29
787	308012392	28	2014-10-29
788	308107638	26	2014-10-30
789	308107638	28	2014-10-30
790	308105445	24	2014-10-31
791	308105445	26	2014-10-31
792	308105445	28	2014-10-31
793	411036395	25	2014-11-01
794	411036395	27	2014-11-01
795	308268063	26	2014-11-01
796	308268063	28	2014-11-01
797	308192472	26	2014-11-01
798	308192472	28	2014-11-01
799	308056646	26	2014-11-02
800	308056646	28	2014-11-02
801	307109677	26	2014-11-02
802	307109677	28	2014-11-02
803	308041947	26	2014-11-02
804	308041947	28	2014-11-02
805	308313606	26	2014-11-03
806	308313606	28	2014-11-03
807	307097855	26	2014-11-03
808	307097855	28	2014-11-03
809	308304806	26	2014-11-03
810	308304806	28	2014-11-03
811	306306282	25	2014-11-03
812	306306282	27	2014-11-03
813	620151031	25	2014-11-04
814	620151031	27	2014-11-04
815	308151246	30	2014-11-04
816	308151246	32	2014-11-04
817	308071915	30	2014-11-04
819	308071915	32	2014-11-04
820	308249284	26	2014-11-04
821	308249284	28	2014-11-04
822	410085912	25	2014-11-05
823	410085912	27	2014-11-05
824	410085912	29	2014-11-05
825	410085912	31	2014-11-05
826	307616052	26	2014-11-07
827	307616052	28	2014-11-07
828	307616052	32	2014-11-07
829	105000194	26	2014-11-07
830	105000194	28	2014-11-07
831	105000194	30	2014-11-07
832	105000194	32	2014-11-07
833	308626807	30	2014-11-09
834	308626807	32	2014-11-09
835	308192472	30	2014-11-09
836	308162291	30	2014-11-09
839	308029631	30	2014-11-09
840	308029631	32	2014-11-09
841	308056646	30	2014-11-09
842	308056646	32	2014-11-09
843	411004983	26	2014-11-09
844	411004983	28	2014-11-09
845	411004983	30	2014-11-09
846	411004983	32	2014-11-09
847	308107638	30	2014-11-10
848	308107638	32	2014-11-10
849	308012392	30	2014-11-10
850	308012392	32	2014-11-10
851	308268063	32	2014-11-10
852	308268063	30	2014-11-10
853	308045653	30	2014-11-11
854	308045653	32	2014-11-11
856	308023189	30	2014-11-11
857	308023189	32	2014-11-11
858	308334582	30	2014-11-11
859	308334582	32	2014-11-11
860	308105445	30	2014-11-12
861	308105445	32	2014-11-12
862	307068743	25	2014-11-12
863	307068743	27	2014-11-12
864	307068743	29	2014-11-12
865	307068743	31	2014-11-12
866	307109677	30	2014-11-13
867	307109677	32	2014-11-13
868	308249284	30	2014-11-13
869	308249284	32	2014-11-13
870	303843258	26	2014-11-13
871	303843258	28	2014-11-13
872	303843258	30	2014-11-13
873	303843258	32	2014-11-13
874	308033498	25	2014-11-13
875	308033498	27	2014-11-13
876	308033498	29	2014-11-13
877	308033498	31	2014-11-13
878	410054040	26	2014-11-13
879	410054040	28	2014-11-13
880	410054040	30	2014-11-13
881	410054040	32	2014-11-13
882	306160909	1	2014-11-13
883	306160909	3	2014-11-13
884	306160909	5	2014-11-13
885	306160909	7	2014-11-13
886	306160909	9	2014-11-13
887	306160909	11	2014-11-13
888	306160909	13	2014-11-13
889	306160909	15	2014-11-13
890	306160909	17	2014-11-13
891	306160909	19	2014-11-13
892	306160909	21	2014-11-13
893	306160909	23	2014-11-13
894	306160909	25	2014-11-13
895	306160909	27	2014-11-13
896	306160909	29	2014-11-13
897	306160909	31	2014-11-13
898	308220034	30	2014-11-13
899	308220034	32	2014-11-13
900	308253072	28	2014-11-13
901	308253072	30	2014-11-13
902	308253072	26	2014-11-13
903	308253072	32	2014-11-13
904	308313606	30	2014-11-13
905	308313606	32	2014-11-13
906	308192472	32	2014-11-13
907	308304806	30	2014-11-13
908	308304806	32	2014-11-13
909	307048455	25	2014-11-13
910	307048455	27	2014-11-13
911	307048455	29	2014-11-13
912	307048455	31	2014-11-13
913	308072826	26	2014-11-13
914	306055904	26	2014-11-13
915	308072826	28	2014-11-13
916	308072826	30	2014-11-13
917	306055904	28	2014-11-13
918	306055904	30	2014-11-13
919	308072826	32	2014-11-13
920	306055904	32	2014-11-13
921	308324912	30	2014-11-13
922	308324912	32	2014-11-13
923	307594017	26	2014-11-13
924	307594017	32	2014-11-13
925	307594017	28	2014-11-13
926	307594017	30	2014-11-13
927	308078419	26	2014-11-14
928	308078419	28	2014-11-14
929	308078419	30	2014-11-14
930	308078419	32	2014-11-14
931	306005459	28	2014-11-14
932	306005459	30	2014-11-14
933	306005459	26	2014-11-14
934	306005459	32	2014-11-14
935	307604426	26	2014-11-14
936	307604426	28	2014-11-14
937	307604426	30	2014-11-14
938	307604426	32	2014-11-14
939	308041947	30	2014-11-14
940	308041947	32	2014-11-14
941	307168702	26	2014-11-14
942	307168702	28	2014-11-14
943	307168702	30	2014-11-14
944	307168702	32	2014-11-14
945	307616052	30	2014-11-14
946	308042999	26	2014-11-14
947	308042999	28	2014-11-14
948	308042999	30	2014-11-14
949	308042999	32	2014-11-14
950	308240308	26	2014-11-14
951	308240308	28	2014-11-14
952	308240308	30	2014-11-14
953	308240308	32	2014-11-14
954	308162291	32	2014-11-14
955	308086937	26	2014-11-14
956	308086937	28	2014-11-14
957	308086937	30	2014-11-14
958	308086937	32	2014-11-14
959	411003254	26	2014-11-14
960	411003254	28	2014-11-14
961	411003254	30	2014-11-14
962	411003254	32	2014-11-14
963	306069204	26	2014-11-14
964	306069204	28	2014-11-14
965	306069204	30	2014-11-14
966	306069204	32	2014-11-14
967	308051926	26	2014-11-14
968	308051926	28	2014-11-14
969	308051926	30	2014-11-14
971	620151031	31	2014-11-21
972	620151031	29	2014-11-21
973	307132615	1	2014-11-22
974	307132615	3	2014-11-22
975	307132615	5	2014-11-22
976	307132615	7	2014-11-22
977	307132615	9	2014-11-22
978	307132615	11	2014-11-22
979	307132615	13	2014-11-22
980	307132615	15	2014-11-22
981	307132615	17	2014-11-22
982	307132615	19	2014-11-22
983	307132615	21	2014-11-22
984	307132615	23	2014-11-22
985	307132615	25	2014-11-22
986	307132615	27	2014-11-22
987	307132615	29	2014-11-22
988	307132615	31	2014-11-22
989	308106411	30	2014-11-22
990	308106411	32	2014-11-22
991	307127545	26	2014-11-23
992	307127545	28	2014-11-23
993	307127545	30	2014-11-23
994	307127545	32	2014-11-23
995	105001933	26	2014-11-24
996	105001933	28	2014-11-24
997	105001933	30	2014-11-24
998	105001933	32	2014-11-24
999	307093077	27	2014-11-25
1000	307093077	31	2014-11-25
1001	307093077	25	2014-11-25
1002	307093077	29	2014-11-25
1003	306306282	29	2014-11-25
1004	306306282	31	2014-11-25
1005	308102585	26	2014-11-25
1006	307239123	25	2014-11-25
1007	307239123	27	2014-11-25
1008	307239123	29	2014-11-25
1009	307239123	31	2014-11-25
1010	308102585	28	2014-11-25
1011	308102585	30	2014-11-25
1012	308102585	32	2014-11-25
1013	307292335	25	2014-11-25
1014	307292335	27	2014-11-25
1015	307292335	29	2014-11-25
1016	307292335	31	2014-11-25
1017	307129013	25	2014-11-25
1018	307129013	31	2014-11-25
1019	307129013	29	2014-11-25
1020	307129013	27	2014-11-25
1021	307214201	31	2014-11-25
1022	307214201	29	2014-11-25
1023	307214201	27	2014-11-25
1024	307214201	25	2014-11-25
1025	308124437	25	2014-11-25
1026	308124437	27	2014-11-25
1027	308124437	29	2014-11-25
1028	308124437	31	2014-11-25
1029	308222722	25	2014-11-26
1030	308222722	27	2014-11-26
1031	308222722	29	2014-11-26
1032	308222722	31	2014-11-26
1033	308203792	25	2014-11-26
1034	308203792	27	2014-11-26
1035	308203792	29	2014-11-26
1036	308203792	31	2014-11-26
1037	306240168	25	2014-12-01
1038	306240168	27	2014-12-01
1039	306240168	29	2014-12-01
1040	306240168	31	2014-12-01
1041	412005361	51	2015-02-11
1042	309014124	51	2015-02-11
1043	309238610	51	2015-02-11
1044	308279647	51	2015-02-12
1045	308279647	52	2015-02-12
1046	307176969	51	2015-02-12
1047	309014124	52	2015-02-12
1048	412005361	52	2015-02-12
1049	308205435	51	2015-02-12
1050	308205435	52	2015-02-12
1051	308328532	51	2015-02-12
1052	308328532	52	2015-02-12
1053	305670698	51	2015-02-12
1054	305670698	52	2015-02-12
1055	308090622	51	2015-02-12
1056	308090622	52	2015-02-12
1057	306099887	52	2015-02-12
1058	306099887	51	2015-02-12
1059	309292386	51	2015-02-12
1060	309292386	52	2015-02-12
1061	308211289	51	2015-02-13
1062	309292599	34	2015-02-13
1063	412009730	37	2015-02-22
1064	308307962	37	2015-02-22
1065	308307962	36	2015-02-22
1066	308307962	34	2015-02-22
1067	308211289	52	2015-02-22
1068	309239143	37	2015-02-22
1069	308020652	51	2015-02-22
1070	308020652	52	2015-02-22
1071	308020652	53	2015-02-22
1072	309104630	36	2015-02-22
1073	309692724	36	2015-02-22
1074	309692724	34	2015-02-22
1075	309692724	37	2015-02-22
1076	309292599	36	2015-02-22
1077	307105844	52	2015-02-22
1078	307105844	53	2015-02-22
1079	309138424	34	2015-02-22
1080	307105844	51	2015-02-22
1081	309138424	36	2015-02-22
1082	309138424	37	2015-02-22
1083	308328532	53	2015-02-22
1084	412005361	53	2015-02-22
1085	309238610	52	2015-02-22
1086	309292599	37	2015-02-22
1087	309028716	34	2015-02-22
1088	309028716	36	2015-02-22
1089	309028716	37	2015-02-22
1090	307542898	34	2015-02-23
1091	307542898	36	2015-02-23
1092	308044687	37	2015-02-23
1093	308044687	36	2015-02-23
1094	308044687	34	2015-02-23
1095	307003908	52	2015-02-23
1096	307003908	53	2015-02-23
1098	411035659	52	2015-02-23
1099	411035659	53	2015-02-23
1100	411035659	51	2015-02-23
1101	308247125	51	2015-02-23
1102	308178234	37	2015-02-23
1103	308247125	52	2015-02-23
1104	308247125	53	2015-02-23
1105	309014124	53	2015-02-23
1106	308240559	52	2015-02-23
1107	308240559	51	2015-02-23
1108	307176969	52	2015-02-23
1109	308080629	52	2015-02-23
1110	307176969	53	2015-02-23
1111	308080629	53	2015-02-23
1112	308080629	51	2015-02-23
1113	308192386	53	2015-02-23
1114	308192386	51	2015-02-23
1115	308192386	52	2015-02-23
1116	308205435	53	2015-02-23
1117	308102767	53	2015-02-23
1118	309292386	53	2015-02-23
1119	308230202	52	2015-02-23
1120	308230202	53	2015-02-23
1121	308230202	51	2015-02-23
1122	308188378	51	2015-02-24
1123	308188378	52	2015-02-24
1124	308188378	53	2015-02-24
1125	308279647	53	2015-02-24
1126	308227318	34	2015-02-24
1127	308227318	36	2015-02-24
1128	308227318	37	2015-02-24
1129	308253632	34	2015-02-24
1130	308253632	36	2015-02-24
1132	308194548	37	2015-02-25
1133	308194548	34	2015-02-25
1134	308194548	36	2015-02-25
1135	308187072	34	2015-02-25
1136	308187072	36	2015-02-25
1137	308187072	37	2015-02-25
1138	411000576	34	2015-02-25
1139	411000576	36	2015-02-25
1140	411000576	37	2015-02-25
1141	411080996	53	2015-02-25
1142	411080996	52	2015-02-25
1143	411080996	51	2015-02-25
1144	412005361	54	2015-02-25
1145	412009730	38	2015-02-25
1146	308178234	38	2015-02-25
1147	308192386	54	2015-02-25
1148	106003600	34	2015-02-26
1149	106003600	36	2015-02-26
1150	106003600	37	2015-02-26
1151	106003600	38	2015-02-26
1152	308178234	34	2015-02-26
1153	308178234	36	2015-02-26
1154	308253632	37	2015-02-26
1155	305670698	53	2015-02-26
1156	305670698	54	2015-02-26
1157	308044687	38	2015-02-26
1158	308048812	51	2015-02-26
1159	308048812	52	2015-02-26
1160	308048812	53	2015-02-26
1161	308048812	54	2015-02-26
1162	308240559	53	2015-02-26
1163	308240559	54	2015-02-26
1164	309292599	38	2015-02-26
1165	307331801	51	2015-02-26
1166	307331801	52	2015-02-26
1167	307331801	53	2015-02-26
1168	307331801	54	2015-02-26
1169	309299749	37	2015-02-27
1170	309299749	38	2015-02-27
1171	309299749	34	2015-02-27
1172	309299749	36	2015-02-27
1173	307542898	37	2015-02-27
1174	307542898	38	2015-02-27
1175	309126245	34	2015-02-27
1176	309011532	36	2015-02-27
1177	309692724	38	2015-02-27
1178	309126245	36	2015-02-27
1179	309126245	37	2015-02-27
1180	309126245	38	2015-02-27
1181	308090622	53	2015-02-28
1182	309528955	34	2015-02-28
1183	309528955	36	2015-02-28
1184	309528955	37	2015-02-28
1185	309528955	38	2015-02-28
1186	308187072	38	2015-03-01
1187	411000576	38	2015-03-01
1188	309238610	53	2015-03-01
1189	309238610	54	2015-03-01
1190	309104630	34	2015-03-01
1191	309104630	37	2015-03-01
1192	309104630	38	2015-03-01
1193	308205435	54	2015-03-01
1194	309292386	54	2015-03-01
1195	308247125	54	2015-03-01
1196	308260775	54	2015-03-01
1197	309014588	34	2015-03-02
1198	309014588	36	2015-03-02
1199	309014588	37	2015-03-02
1200	309014588	38	2015-03-02
1201	307105844	54	2015-03-02
1202	309028716	38	2015-03-02
1203	307003908	51	2015-03-02
1204	307003908	54	2015-03-02
1205	308227617	34	2015-03-02
1206	308227617	36	2015-03-02
1207	308227318	38	2015-03-02
1208	308227617	37	2015-03-02
1209	308227617	38	2015-03-02
1210	308315198	51	2015-03-02
1211	308315198	52	2015-03-02
1212	308315198	53	2015-03-02
1213	308315198	54	2015-03-02
1214	308211289	53	2015-03-02
1215	308211289	54	2015-03-02
1216	309239143	38	2015-03-02
1217	309239143	36	2015-03-02
1218	309239143	34	2015-03-02
1219	411035659	54	2015-03-02
1220	309014124	54	2015-03-02
1221	307039387	51	2015-03-02
1222	307039387	52	2015-03-02
1223	307039387	53	2015-03-02
1224	307039387	54	2015-03-02
1225	308230202	54	2015-03-03
1226	306099887	53	2015-03-04
1227	306099887	54	2015-03-04
1228	306099887	55	2015-03-04
1229	412001112	34	2015-03-04
1230	412001112	36	2015-03-04
1231	412001112	37	2015-03-04
1232	412001112	38	2015-03-04
1233	308323551	34	2015-03-04
1234	308323551	36	2015-03-04
1235	308323551	37	2015-03-04
1236	308194548	38	2015-03-05
1237	309011532	34	2015-03-05
1238	309011532	37	2015-03-05
1239	309011532	38	2015-03-05
1240	309011532	39	2015-03-05
1241	308328532	54	2015-03-05
1242	308328532	55	2015-03-05
1243	412009730	34	2015-03-05
1244	412009730	36	2015-03-05
1245	309262026	34	2015-03-05
1246	309262026	36	2015-03-05
1247	309262026	37	2015-03-05
1248	309262026	38	2015-03-05
1249	308253632	38	2015-03-05
1250	309125736	34	2015-03-05
1251	309125736	36	2015-03-05
1252	309125736	37	2015-03-05
1253	309125736	38	2015-03-05
1254	309125736	39	2015-03-05
1255	307176969	54	2015-03-06
1256	307176969	55	2015-03-06
1257	412054345	35	2015-05-14
1258	412009730	39	2015-08-21
1259	309028709	67	2015-11-07
1260	412009730	35	2015-11-18
1261	309041524	115	2016-02-19
\.


--
-- Data for Name: practicas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY practicas (idpractica, nombre, tipo) FROM stdin;
1	Salidas Autoenclavadas	A
2	Temporizadores	A
3	Contadores	A
4	Registros de corrimiento	A
5	Funciones Aritméticas	A
6	Accionamiento de cilindro simple efecto	A
7	Accionamiento de cilindro de doble efecto	A
8	Temporizador neumático	A
9	Secuencia Neumática	A
10	Memorias Neumáticas	A
11	Método Cascada	A
12	Ciclo con movimiento repetido	A
13	Electroválvula Monoestable	A
14	Electroválvula Biestable	A
15	Sistema electroneumático completo	A
16	Evaluación de servicio 1	B
\.


--
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profesor (id, titulo, nombre, apellidop, apellidom, correo_e, habilitado) FROM stdin;
DIHO791022	Mtr	Octavio	Diaz	Hernandez	zidh@hotmail.com	t
SOCR680401	M.Ing.	Rafael Eduardo	Combe	Sousa	\N	t
REYE001010	M.I.	Caudia	Cruz	Reyes	cgomezca89@gmail.com	t
HUCG750316	M.F.	Gabriel	Chong	Hurtado	gahucho@yahoo.com	t
\.


--
-- Name: s_buzon; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_buzon', 3, true);


--
-- Name: s_cal; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_cal', 12, true);


--
-- Name: s_cxp; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_cxp', 131, true);


--
-- Name: s_encuesta; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_encuesta', 1261, true);


--
-- Name: s_grupo; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_grupo', 22, true);


--
-- Name: s_horario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_horario', 3, true);


--
-- Name: s_idreportebimestral; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_idreportebimestral', 1, false);


--
-- Name: s_idreportesemestral; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_idreportesemestral', 1, false);


--
-- Name: s_practica; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_practica', 16, true);


--
-- Name: s_user; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('s_user', 2189, true);


--
-- Data for Name: semestres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY semestres (id, inicio, fin) FROM stdin;
2015-1 	2014-08-04	2014-12-05
2015-2 	2015-01-26	2015-06-06
2016-1 	2015-08-10	2015-12-31
2016-2 	2016-01-04	2016-08-05
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarios (iduser, nameuser, passwd, tipo) FROM stdin;
4	308072826	CHco__11	1
5	308626807	sde_1892	1
1	gabriel	03	3
3	HUCG750316	nibe1ung0	3
13	308056646	pink.floyd	1
14	308107638	roma92	1
15	308105445	pamela28	1
16	308045653	1604papr...	1
17	308220034	Oscar@21_.,	1
18	308042999	12fa92pj	1
19	308029631	gr0ss_1p!	1
20	308162291	cacecead	1
43	306306282	BEba**11	1
53	307616052	santiago10	1
68	303843258	clase2	1
69	410054040	lamlp-640	1
70	308071915	cafe920102	1
182	308313606	earthquake	1
183	411004983	betabi	1
184	308192472	JoseAngel1	1
185	308041947	13ARra,.	1
186	308151246	lema666	1
187	105001933	55gusano	1
209	308334582	jorge1234	1
210	308240308	patokuak	1
211	307239123	307239123	1
212	308086937	Mistermi	1
213	307109677	8888elgato	1
214	308324912	vero.umx	1
215	308249284	joES92..	1
295	411036395	1957	1
296	308253072	automati	1
297	308012392	jahola	1
298	308268063	0459_ld*LD	1
313	307097855	luzadavid7	1
345	308304806	Casaroja1	1
366	307604426	cope2012	1
367	105000194	101010	1
431	308023189	bryanbryan	1
432	306055904	excalibur	1
433	308078419	nicolai1990	1
434	308106411	e2v2o1992	1
439	306005459	bigbang	1
440	307127545	159951	1
441	307168702	r55343355	1
442	308051926	308051926	1
476	308102585	308102585	1
525	411003254	Laiencuestas	1
526	306240168	ma241210	1
527	308033498	Gilberto16	1
528	308203792	LUlu..16	1
529	307048455	carmina123	1
549	307214201	Setram.1207	1
550	306069204	lai1250	1
593	308222722	zanahoria1	1
594	307068743	clauauto	1
618	307093077	n3v3rm0r3(8)	1
641	620151031	arreolag	1
642	306146620	123456	1
643	410085912	arshavin2008	1
718	307292335	307292335	1
743	306160909	1189	1
744	308124437	@@mayte12	1
759	307129013	alexis123	1
760	307594017	blink-182	1
2084	309126245	Marigate12	1
2102	308315198	IsMorales92-	1
762	307132615	7418880	1
2103	307039387	chiquipapi10	1
763	DIHO791022	homeroso	2
761	MAGN810129	labai	3
765	308240559	fjcglodvg	1
766	411080996	7777791	1
767	308260775	lilimon	1
768	309014124	siempre1	1
769	308230202	encuestaai	1
770	308102767	MUbfr92dk)"	1
771	307003908	agata1991	1
772	307105844	ESTEyY@	1
773	308020652	308020652	1
774	411035659	nimbusynala	1
775	308328532	sion1405	1
781	308103630	308103630Aa	1
782	308080629	INGENIERO201	1
783	308090622	308090622	1
937	411000576	-1a-2456-43	1
938	412005361	monene678	1
1046	309528955	309528955	1
1047	309238610	nesco31ir	1
1048	309028716	campeche	1
1049	106003600	matenalemo	1
1050	309138424	mppaai863	1
1051	308178234	#05091992#	1
1091	309292386	hernandez	1
1113	309104630	kenworth	1
1114	308194548	anarquia	1
1118	308187072	poseidon92	1
1120	412054345	pcja.030893	1
1238	308279647	rayito	1
1239	307176969	autoautoauto	1
1243	306099887	miercoles	1
1244	308044687	ballhaus0009	1
1245	412009730	i012060	1
1288	308307962	Hola	1
1386	307312383	silmarillion	1
1394	308205435	todopor3	1
1395	308227318	308227318	1
1396	308211289	27pepe12	1
1397	305670698	r56810735	1
1398	309692724	Sidney123	1
1399	308253632	lamisma	1
1400	308318326	PandiXD1080	1
1401	412001112	00001156g	1
1406	309262026	andy_peter	1
1407	309125736	karabiner98k	1
1408	309239143	dark93luna	1
1486	308227617	308227617	1
1560	309292599	prepa3unam13	1
1561	309014588	*Shakura*	1
1719	308192386	DianitA22##	1
1720	309299749	Te@mo93	1
1721	308247125	308247	1
1732	307542898	mecatronico1	1
1905	308188378	emma12k.	1
2041	308048812	308048812	1
2070	307331801	is-Einstein2	1
2076	SOCR680401	edison01	2
2083	309011532	12meses	1
2185	308323551	ombranera	1
2186	309028709	123	1
2187	309041524	123	1
2188	309527752	123	1
2189	FONB781101	123	2
\.


--
-- Name: calendarizacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY calendarizacion
    ADD CONSTRAINT calendarizacion_pkey PRIMARY KEY (idcal);


--
-- Name: horarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY horarios
    ADD CONSTRAINT horarios_pkey PRIMARY KEY (id);


--
-- Name: pk_alumno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY alumno
    ADD CONSTRAINT pk_alumno PRIMARY KEY (id);


--
-- Name: pk_buzon; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY buzon
    ADD CONSTRAINT pk_buzon PRIMARY KEY (usuario, idbuzon);


--
-- Name: pk_calxpractica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY calxpractica
    ADD CONSTRAINT pk_calxpractica PRIMARY KEY (idcxp);


--
-- Name: pk_enc_comens; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT pk_enc_comens PRIMARY KEY (idencuesta, idpregunta);


--
-- Name: pk_encuesta_preg; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY encuestas
    ADD CONSTRAINT pk_encuesta_preg PRIMARY KEY (idencuesta, npregunta);


--
-- Name: pk_grupo; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY grupo
    ADD CONSTRAINT pk_grupo PRIMARY KEY (idgrupo);


--
-- Name: pk_idencuestas; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY i_encuestas
    ADD CONSTRAINT pk_idencuestas PRIMARY KEY (idencuesta);


--
-- Name: pk_practicas; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY practicas
    ADD CONSTRAINT pk_practicas PRIMARY KEY (idpractica);


--
-- Name: pk_profesor; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT pk_profesor PRIMARY KEY (id);


--
-- Name: pk_semestres; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY semestres
    ADD CONSTRAINT pk_semestres PRIMARY KEY (id);


--
-- Name: pk_usuarios; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (iduser);


--
-- Name: u_cal_grupo; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY calendarizacion
    ADD CONSTRAINT u_cal_grupo UNIQUE (horario, semestre);


--
-- Name: u_calxpractica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY calxpractica
    ADD CONSTRAINT u_calxpractica UNIQUE (idcal, practica);


--
-- Name: u_grupo_cal; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY grupo
    ADD CONSTRAINT u_grupo_cal UNIQUE (grupo, idcal);


--
-- Name: u_ncuenata_cal; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY i_encuestas
    ADD CONSTRAINT u_ncuenata_cal UNIQUE (ncuenta, idcxp);


--
-- Name: usuarios_nameuser_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_nameuser_key UNIQUE (nameuser);


--
-- Name: alumno_grupo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alumno
    ADD CONSTRAINT alumno_grupo_fkey FOREIGN KEY (grupo) REFERENCES grupo(idgrupo);


--
-- Name: calendarizacion_horario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calendarizacion
    ADD CONSTRAINT calendarizacion_horario_fkey FOREIGN KEY (horario) REFERENCES horarios(id);


--
-- Name: calendarizacion_semestre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calendarizacion
    ADD CONSTRAINT calendarizacion_semestre_fkey FOREIGN KEY (semestre) REFERENCES semestres(id);


--
-- Name: calxpractica_idcal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calxpractica
    ADD CONSTRAINT calxpractica_idcal_fkey FOREIGN KEY (idcal) REFERENCES calendarizacion(idcal);


--
-- Name: calxpractica_practica_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calxpractica
    ADD CONSTRAINT calxpractica_practica_fkey FOREIGN KEY (practica) REFERENCES practicas(idpractica);


--
-- Name: comentarios_idencuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comentarios
    ADD CONSTRAINT comentarios_idencuesta_fkey FOREIGN KEY (idencuesta) REFERENCES i_encuestas(idencuesta);


--
-- Name: encuestas_idencuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY encuestas
    ADD CONSTRAINT encuestas_idencuesta_fkey FOREIGN KEY (idencuesta) REFERENCES i_encuestas(idencuesta);


--
-- Name: fk_usuario_buzon; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY buzon
    ADD CONSTRAINT fk_usuario_buzon FOREIGN KEY (usuario) REFERENCES usuarios(nameuser);


--
-- Name: grupo_idcal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grupo
    ADD CONSTRAINT grupo_idcal_fkey FOREIGN KEY (idcal) REFERENCES calendarizacion(idcal);


--
-- Name: grupo_profesor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grupo
    ADD CONSTRAINT grupo_profesor_fkey FOREIGN KEY (profesor) REFERENCES profesor(id);


--
-- Name: i_encuestas_idcxp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY i_encuestas
    ADD CONSTRAINT i_encuestas_idcxp_fkey FOREIGN KEY (idcxp) REFERENCES calxpractica(idcxp);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

