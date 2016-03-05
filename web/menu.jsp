
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>

<!--
Menu de exploración del sistema basado en tipos de usuario:

Administrador:
    -- administracion de catalogos(alumnos, grupos, calendarizació)
    -- visuailización de grupos (alumnos, encuestas por grupos, resumen de encuestas de practicas, *indicadores de encuestas de servicio)
    -- visualización de buzon
    -- navegacion para consulta de semestres anteriores

Profesor:
    -- visuailización de sus grupos actuales (alumnos, encuestas por grupos, resumen de encuestas de practicas, *indicadores de encuestas de servicio)


Alumno: 
        acceo a las encuestas
        acceso al buzon




*las encuenstas de servicio son contestadas al final del semestre, por lo que esta opción aparece cuando se ha finalizado el semestre
--->


<%@ page session="true" %>
<%@page import="java.util.Iterator"%>
<%@page import="entity.Encuesta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />
<jsp:useBean id="semestre" scope="session" class="ABC.ABCSemestre" />
<jsp:useBean id="practica" scope="page" class="entity.Encuesta" />

<!DOCTYPE html>
    <%char tipo = cuesUs.getTipo();%>
    
<div id='cssmenu'>

    
    <!-- USUARIO TIPO ADMINISTRADOR-->
    
    <% if(tipo=='3'){ %>
       <!--  SEMESTRE ACTUAL
         Si hay semestre pone actual, si no pone general

       -->
        
        <% if(request.getParameter("sem")!=null){
           
            semestre.setCurrent(request.getParameter("sem"));
            semestre.setInicio(false);
            
        }else{
                semestre.getCurrentSemester();
                semestre.setInicio(true);
            } %>
        
        
            <%if(semestre.getCurrent().equals("") ){  //menu general (semestres y catalogos)%>
      
         
              <ul>
                    <li><a href='#'> <center> <b> GENERAL </b> </center>  </a> </li>

              <li class='has-sub'><a href='#'>Elegir semestre</a>
               <ul>
                   <%if(!semestre.consultarSemestreActual().equals("")){%>
                       <li><a href='#' onclick="cargarSemestre('<%=semestre.consultarSemestreActual()%>')"> Actual </a></li>
                   <%}%>        
                  <%= semestre.listarSemestresMenu().toString() %>
                  <li><a href='#' onclick="contenido('contenido','catalogos/semestres/elegirSemestre.jsp');">Otro semestre...</a> </li>
               </ul>
              </li>
              
               
            <li class='has-sub'><a href='#'>Catálogos</a>
      <ul>
          
         <li  class='has-sub' > <a href='#'>Semestres</a> 
         
         <ul>
                <li><a href='#'  onclick="contenido('contenido','catalogos/semestres/catSemestre.jsp')">Ver semestres</a> </li>
                
                <% if (semestre.getCurrent().equals(""))  { %>
                <li><a href='#' onclick="contenido('contenido','catalogos/semestres/agregarSemestre.jsp')">Nuevo semestre</a> </li> <!--TODO: verificar que sea tiempo de agregar nuevo semestre-->
               
                    <%}%>
                         
                         
                
         </ul>
         
         </li>
         <li><a href='#' onclick="contenido('contenido','catalogos/profesores/catProfesores.jsp')">Profesores</a> </li>
         <li><a href='#' onclick="contenido('contenido','catalogos/horarios/catHorarios.jsp')">Horarios</a> </li>
         <li><a href='#' onclick="contenido('contenido','catalogos/practicas/catPracticas.jsp')">Practicas</a> </li>
         <li><a href='#' onclick="contenido('contenido','catalogos/usuarios/catUsuarios.jsp')">Usuarios</a> </li>
       
      </ul></li>
              </ul>
      <!--li class='has-sub'><a href='#'>Catálogos</a> </li-- mostrar el historial de indices acumulados>
      
      
      <%}else if(semestre.getCurrent().equals(semestre.consultarSemestreActual())){ %>      <! menu de semestre actual-->
            
            
      
      
              <ul>
                    <li><a href='#'> <center> <b> Actual <br> <%=semestre.consultarSemestreActual()%> </b> </center>  </a> </li>

              <li class='has-sub'><a href='#'>Elegir semestre</a>
               <ul>
                  <%= semestre.listarSemestresMenu().toString() %>
                  <li><a href='#' onclick="cargarSemestre('')">General</a> </li>
                  <li><a href='#' onclick="contenido('contenido','catalogos/semestres/elegirSemestre.jsp');">Otro semestre...</a> </li>
               </ul>
              </li>
              
               
          <li class='has-sub'><a href='#'>Grupos</a>

                   <ul>
                      <%=semestre.listarGruposMenu()%>  
                      
                  </ul>
               </li>
              
               
               <li class="has-sub"><a href="#"> ENCUESTAS </a>
<ul>
                   
            
            <li> <a href="#" onclick="contenido('contenido','consultas/encuestas/listar.jsp');">   Listar encuestas </a>  </li>
            <li> <a href="#" onclick="vistaResumenPracticas('<%=semestre.getCurrent()%>')">   Ver resumen de encuestas de practicas </a>  </li>
            <li> <a href="#" onclick="vistaComentarios('1','<%=semestre.getCurrent()%>')">   Ver comentarios de practicas </a>  </li>
             
       
     </ul>
              
     
     
                       </li>
               <li><a href='#'  onclick="contenidoP('contenido', 'consultas/buzon/3/buzon.jsp','<%=semestre.getCurrent()%>');">Buzon</a></li>
               
              </ul>

        <%}else{%>  <!-- menu de semestre anteriro -->
            
            
              <ul>
                    <li><a href='#'> <center> <b>  <%=semestre.getCurrent() %> </b> </center>  </a> </li>

              <li class='has-sub'><a href='#'>Elegir semestre</a>
               <ul>
                  <%= semestre.listarSemestresMenu().toString() %>
                  <li><a href='#' onclick="cargarSemestre('')">General</a> </li>
                  <li><a href='#' onclick="contenido('contenido','catalogos/semestres/elegirSemestre.jsp');">Otro semestre...</a> </li>
               </ul>
              </li>
              
               
               <li class='has-sub'><a href='#'>Grupos</a>

                   <ul>
                      <%=semestre.listarGruposMenu()%>  
                       <!--li><a href='#' onclick="">ver grupos</a> </li-->
                  </ul>
               </li>
              
               
               
               <li class='has-sub'><a href='#'>Encuestas</a>

                   <ul>
                       <li><a href='#' onclick="contenido('contenido','indicadores/general/servicio.jsp')"> Indices de servicio</a> </li>
                       <li> <a href="#" onclick="vistaResumenPracticas('<%=semestre.getCurrent()%>')">   Ver resumen de encuestas de practicas </a>  </li>
                       <li><a href='#' onclick="vistaComentarios('1','<%=semestre.getCurrent()%>')">Comentarios</a> </li>
                       <li><a href='#' onclick="contenidoP('contenido','consultas/encuestas/listar_1.jsp','<%=semestre.getCurrent()%>');">Explorar encuestas</a> </li>
                  </ul>
               </li>
               

               <li><a href='#'  onclick="contenidoP('contenido', 'consultas/buzon/3/buzon.jsp','<%=semestre.getCurrent()%>');">Buzon</a></li>
               
              </ul>
           
       <%}%> 
        
        
        
        <!-- SEMESTRE NO ACTIVO -->
 
        
        
        
        
        
        <!-- ELEJIR SEMESTRe -->
    <%}%>
    
    <!-- los profesores pueden ver su semestre actual %-->
    
    
       <%if(tipo=='2'){
       semestre.getCurrentSemester();
       %>
         
           <%if(semestre.getCurrent().equals("") ){  //menu general (semestres y catalogos)%>
      
         
              <ul>
                    <li><a href='#'> <center> <b> NO HAY SEMESTRE ACTIVO </b> </center>  </a> </li>
              </ul>
             <%} else{ %>
               <ul>
                     <li><a href='#'> <center> <b> <%=semestre.getCurrent() %> </b> </center>  </a> </li>
                    <li class='has-sub'><a href='#'> <center> <b> GRUPOS  </b> </center>  </a> 
                        <ul>
                            <%= semestre.listarGruposMenu(cuesUs.getUser(),semestre.getCurrent()) %>  
                        </ul>
                    
                    </li>
                    
                    
                    
                    
                    
                    <li><a href='#'> <center> <b> BUZON </b> </center>  </a>  </li>
                   
                    
              
        </ul>      
        	
                  
       
    
        <%}}%>
    
    
    
    
    <% if(tipo=='1'){ %>
    
    <jsp:useBean id="alumno" scope="page" class="ABC.ABCAlumnos" />
     <%
         alumno.getAlumno(cuesUs.getUser());
         List<Encuesta> l_pra = alumno.listarEncuestas();
     
     %>
    
    
    <ul>
                    <li><a href='#'> <center> <b> ENCUESTAS </b> </center>  </a> </li>
        <%if(!l_pra.isEmpty()){
        
        
        Iterator<Encuesta> iter= l_pra.iterator();
        while(iter.hasNext()){
        practica = (Encuesta)iter.next();
        
         %>
                    <li> <a href='#' <%=practica.getId()+ "."%>   onclick=" mostrarForm('<%=practica.getCal()%>&prac=<%=practica.getId()%>','<%=practica.getTipo()%>');"><%=practica.getNombre()%></a>    </li>    
                    
         <%}
        }else{%>
              <li><a href='#'>Sin encuestas pendientes</a></li>
             
         <% } %>
         
          <li><a href="#"  onclick="contenido('contenido','forma3.jsp');"> <span><img src="buzon.jpg" width="20" height="20" title="buzon"> </span><span>Buz&oacute;n</span></a></li>

    </ul>                
    
    
       
    <table>    
           
    
  
    
    <%}%>

    
</div>      