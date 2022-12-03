<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%!
ProductionLibelle a;
%>
<%
a=new ProductionLibelle();
a.setNomTable("ProductionLibelle");
PageConsulte pc=new PageConsulte(a,request,(user.UserEJB)session.getValue("u"));
Production e=(Production)pc.getBase();
%>
<html>
<h1>Consultation d'une fiche Production</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=activa/modifproduction.jsp&idProduction="+request.getParameter("idProduction")%>">Modifier</a>
<a href="<%=(String)session.getValue("lien")+"?but=activa/saisilivraisonfille.jsp&id="+request.getParameter("idProduction")%>" target="_blank">Saisir Livraison</a>
<br/><br/><br/><br/><br/>
<h1>Etat livraison</h1>
<%
 EtatLivraisonProduction ex=new EtatLivraisonProduction();
ex.setNomTable("etatLivraisonProduction");
String t=request.getParameter("idProduction");
ex.setIdProduction(t);
EtatLivraisonProduction[] ee=(EtatLivraisonProduction[])CGenUtil.rechercher(ex,null,null,"");
if(ee.length!=0){
%>
<br/>
<p><strong>Nom client : </strong><%= ee[0].getNomclient()%></p>
<p><strong>Article : </strong><%=ee[0].getArticle()%></p>
<p><strong>Nombre Impression : </strong><%=ee[0].getNombreimpression()%></p>
<p><strong>Quantite livre : </strong><%=ee[0].getQuantiteLivre()%></p>
<p><strong>Quantite restant : </strong><%=ee[0].getQuantiteRestant()%></p>
<%}
else{
%>
<p>AUCUN<p>
<%}%>

</html>