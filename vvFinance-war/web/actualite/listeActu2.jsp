<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>

<%
UserEJB u = null;
try{
u = (user.UserEJB)session.getValue("u");
Actualite p=new Actualite();
p.setNomTable("ACTUALITELIB");
String listeCrt[]={"direction","typeActu","daty","heure","actualite","entite"};
String listeInt[]={"daty","heure"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("actualite/listeActu.jsp");
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet act=new TypeObjet();
act.setNomTable("TYPEACTU");
liste[0]=new Liste("typeActu",act,"val","val");
Direction to2=new Direction();
to2.setNomTable("direction");
liste[1]=new Liste("direction",to2,"libelledir","libelledir");
TypeObjet ent=new TypeObjet();
ent.setNomTable("beneficiaire");
liste[2]=new Liste("entite",ent,"val","val");

pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
//pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
String libEntete[]={"id","direction","typeActus","actualite","daty","heure","entite"};
//String colSomme[]={"montantVal"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des actualites</h1>
<form action="<%=pr.getLien()%>?but=actualite/listeActu.jsp" method="post" name="listeactualite" id="listeactualite">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=actualite/ficheActu.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e){
	u.saveException(e.getMessage(),"test");
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}
%>
