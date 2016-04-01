<%-- 
    Document   : p_c2
    Created on : 20/09/2013, 01:33:00 PM
    Author     : Cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <jsp:useBean id="indice" scope="page" class="entity.Indicadores" />
        
         <% int ind = Integer.parseInt(request.getParameter("param"));
         
         switch(ind){
             case 1:     
         %>    
         
        <H1> Indicador 1 </H1> 
        promedio: <%=indice.iprac_calidad(1)%> 
         
             
         <%break;
         case 2: 
         %> 
        
         <H1> Indicador 2 </H1> 
        promedio: <%=indice.iprac_calidad(2)%> 
        
         <%break;
         case 4: 
         %> 
        
         <H1> Indicador 4 </H1> 
        promedio: <%=indice.iprac_calidad(4)%> 
         
        <%break;
         case 6: 
         %> 
        
         <H1> Indicador 6 </H1> 
        promedio: <%=indice.iprac_calidad(6)%> 
         
        
        <%
         break;
         default:
         %> 
        
         <H1> Indicador no encontrado </h1>
             
         <%break;}%>
         
          <div><span>Dato: </span><span id="info2">Nothing</span></div>
            <div id="chart2" style="margin-top:20px; margin-left:20px; width:300px; height:300px;"></div>
    </body>
</html>
