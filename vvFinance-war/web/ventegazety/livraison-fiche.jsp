<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%!
LivraisonFait p;
Prisejournallib[] listePrise;
%>
<%
p=new LivraisonFait();
Prisejournallib pp = new Prisejournallib();
pp.setNomTable("PRISEJOURNALLIVRAISON");
listePrise = (Prisejournallib[])CGenUtil.rechercher(pp, null, null, " AND IDPLACE = '"+request.getParameter("id")+"'");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
%>
<html>
<h1>Consultation d'une livraison</h1>
<%
out.println(pc.getHtml());
%>
<br/>
<table class="monographe" width="60%">
     <tr class="head">
        <td>Journal</td><td>Num parution</td><td>Nombre prise</td>
     </tr>
      <%for(int i=0 ; i<listePrise.length ; i++){%>
     <tr>

             <td><%=listePrise[i].getJournal()%></td>
             <td><%=listePrise[i].getNumparution()%></td>
             <td><%=listePrise[i].getNbreprise()%></td>

     </tr>
      <%}%>
</table>
</html>
