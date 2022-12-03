<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="pointage.*" %>

<%
ContactList cl=new ContactList();
//cl.setNomTable("contact_libelle");
String listeCrt[]={"nom","prenom","tel1","tel2","mail","adresse","val"};
String listeInt[]={"naissance"};
PageRecherche pr=new PageRecherche(cl,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pointage/listContact.jsp");
TypeObjet to=new TypeObjet();
to.setNomTable("typecontact");
affichage.Champ[] liste=new affichage.Champ[1];
liste[0]=new Liste("val",to,"val","val");
pr.getFormu().changerEnChamp(liste);
String libEntete[]={"id","nom","prenom","tel1","tel2","mail","adresse","val","naissance"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);

%>
<h1>Liste des contacts</h1>
<form action="<%=pr.getLien()%>?but=pointage/listContact.jsp" method="post" name="listecontact" id="listecontact">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pointage/ficheContact.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());

  %>
