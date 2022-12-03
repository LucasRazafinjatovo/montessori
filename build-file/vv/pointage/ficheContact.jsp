<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pointage.*" %>
<%!
ContactList rl;
%>
<%
rl=new ContactList();
rl.setNomTable("contact_libelle");
PageConsulte pc=new PageConsulte(rl,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
String enteteLibelle[]={"Identifiant","Nom","Prenom","Type contact","Description","Téléphone-1","Téléphone-2","Mail","Adresse","Date de naissance"};
//rl=(RubriqueLibelle)pc.getBase();
pc.setLibAffichage(enteteLibelle);
pc.getListeChamp()[9].setValeur(Utilitaire.formatterDaty(pc.getListeChamp()[9].getValeur()));
%>
<html>
<h1>Consultation d'un contact</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresPub.jsp&id=<%=request.getParameter("id")%>" method="post" name="ficheContact" id="ficheContact">
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=pointage/listContact.jsp&classe=pointage.ContactList">Supprimer</a>

</form>
</html>
