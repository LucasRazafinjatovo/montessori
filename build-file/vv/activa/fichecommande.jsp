<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%!
CommandeLibelle a;
%>
<%
a=new CommandeLibelle();
a.setNomTable("commandelibelle");
PageConsulte pc=new PageConsulte(a,request,(user.UserEJB)session.getValue("u"));
CommandeLibelle e=(CommandeLibelle)pc.getBase();
%>
<html>
<h1>Consultation d'une fiche Commande</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=activa/modifcommande.jsp&id="+request.getParameter("idcmd")%>">Modifier</a>&nbsp;
<a href='javascript:Popup("apercuCommande.jsp?idCommande=<%=request.getParameter("idcmd")%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Aperçu commande</a>
&nbsp;<a href="<%=(String)session.getValue("lien")+"?but=activa/saisiproductionfille.jsp&id="+request.getParameter("idcmd")%>" target="_blank">Saisir Production</a>
&nbsp;<a href="<%=(String)session.getValue("lien")+"?but=formLiaisonCommande.jsp&idcmd="+request.getParameter("idcmd")+"&daty="+e.getDatecmd()+"&datylivraison="+e.getDateLivraisonCmd()%>">Lier avec Facture</a>

</html>