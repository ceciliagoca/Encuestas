<%-- 
    Document   : inicioSesion
    Created on : 3/12/2013, 09:04:12 AM
    Author     : Cecilia
--%>
<jsp:useBean id="ialumno" scope="page" class="ABC.ABCAlumnos" />}
<jsp:useBean id="alumno" scope="page" class="entity.Alumno" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />
<jsp:useBean id="iprofe" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="iusuario" scope="page" class="ABC.ABCUsuarios" />
   
<%
    String salida= "";
     int ban = Integer.parseInt(request.getParameter("bandera"));
   
    switch(ban){
    case 1:
   
     
        String cuenta = request.getParameter("cuenta");
        alumno.setBrigada(Integer.parseInt(request.getParameter("brigada")));
        alumno.setCorreo(request.getParameter("mail"));
        alumno.setCuenta(cuenta);
        salida = iusuario.addUsuario(alumno, request.getParameter("passwd"), request.getParameter("passwd1"));
        
    
         %>
        
        
        <%=salida%>
        <%

        break;
        
        
         case 2:
             
       String rfc = request.getParameter("profesor");
       profesor.setRfc(rfc);
       profesor.setCorreo(request.getParameter("mail"));
       salida = iusuario.addUsuario(profesor, request.getParameter("passwd"), request.getParameter("passwd1"));
         %> 
         <%=salida%>
         <%  
         break;
             //recuperar contraseÑa
         case 3:
        
      
       
         %>
       
      
         <%=iusuario.recuperaraContrasenia(request.getParameter("cuenta"))%>;
        <%
             
        break;
        
   }     

%>


