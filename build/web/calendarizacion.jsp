<%-- 
    Document   : calendarizacion
    Created on : Jan 10, 2014, 3:09:45 PM
    Author     : cecilia
--%>

<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="practica" scope="page" class="ABC.ABCPracticas" />
           
<div class="ui-widget">
    <table class="üi-widget ui-widget-content" style="width: 40%">
        <thead>
            <tr class="ui-widget-header">
                <th colspan="3"> Calendarizacion grupo:</th>
                </tr>
                          <tr class="ui-widget-header">
                              <th >Practica</th> <th >Fecha inicio</th> <th >Fecha fin</th>
                </tr>
                
        </thead>
        <tbody>
           <%Iterator iter =  practica.listarPracticas().iterator(); 
           String from = "from";
            String to = "to";
            int n = 0;
           
   
           while(iter.hasNext()){%>
            <tr>
                <td><%=(String)iter.next()%></td> <td><input type="text" id="<%=from+n%>" name="<%=from+n%>" onclick="f_menu(<%=n%>)"/></td><td><input type="text" id="<%=to+n%>" name="<%=to+n%>"/></td>
                </tr>
               
                <% n++; }%>
        </tbody>
        </table>
            </div>