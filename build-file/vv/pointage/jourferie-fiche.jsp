<%-- 
    Document   : jourferie-fiche
    Created on : 11 déc. 2015, 10:14:35
    Author     : Jetta
--%>
<%@page import="affichage.PageConsulte"%>
<%@page import="pointage.PointJourferie"%>
<%!
    PointJourferie pointage; 
%>
<%
    pointage = new PointJourferie();
  //  pointage.setNomTable("POINT_POINTAGE_LIBELLE");
    String[] libellePointageFiche = {"Id", "Date", "Type", "Designation","Remarque", "Heure debut","Heure fin"};
    PageConsulte pc = new PageConsulte(pointage, request, (user.UserEJB) session.getValue("u"));
    pc.setLibAffichage(libellePointageFiche);
    pc.setTitre("Fiche jour ferié");
%>
<html>
                        <h1><a href="<%=(String) session.getValue("lien")%>?but=paie/pointage/jourferie/jourferie-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                     
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                   
                        <a    href="<%=(String) session.getValue("lien") + "?but=pointage/jourferie-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                        <a   href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=pointage/jourferie-liste.jsp&classe=pointage.PointJourferie" style="margin-right: 10px">Supprimer</a>
                 
    <%out.println(pc.getBasPage());%>
</html>
