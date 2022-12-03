<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%!
Vendeur p;
%>
<%
p=new Vendeur();
p.setNomTable("VendeurLib");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
Vendeur[] vend=(Vendeur[])CGenUtil.rechercher(p,null,null," and id='"+request.getParameter("id")+"'");
//String dat=Utilitaire.datetostring(vend[0].getDateembauche());
//String daty=Utilitaire.datetostring(vend[0].getDatesortie());
%>
<html>
<h1>Consultation d'un vendeur</h1>
<%
out.println(pc.getHtml());
String dateembauche="";
if(vend[0].getDateembauche()==null){
  dateembauche="";
}
else{
  dateembauche=Utilitaire.datetostring(vend[0].getDateembauche());
}
%>
<!--<a href="<%=(String)session.getValue("lien")+"?but=ventegazety/updateVendeur.jsp&id="+request.getParameter("id")%>&dateembauche=<%=dateembauche%>">Modifier</a>-->
<!--<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=ventegazety/listeVendeur.jsp&classe=ventegazety.Vendeur">Supprimer</a>-->
</html>
