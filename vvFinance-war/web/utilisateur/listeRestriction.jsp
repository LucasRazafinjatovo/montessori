<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="restriction.*" %>
<%@ page import="historique.*" %>


<%
try{
Restriction e=new Restriction();

e.setNomTable("restriction_lib");

String listeCrt[]={"id","profil","tablerestrict","action","remarque","login"};
String listeInt[]=null;
String libEntete[]={"id","login","profil","tablerestrict","action"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,5);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("utilisateur/listeRestriction.jsp");

affichage.Champ[] liste=new affichage.Champ[2];

MapRoles rl=new MapRoles();
rl.setNomTable("roles");
liste[0]=new Liste("profil",rl,"idRole","idRole");
TypeObjet action=new TypeObjet();
action.setNomTable("action");
liste[1]=new Liste("action",action,"val","val");
pr.getFormu().changerEnChamp(liste);
pr.creerObjetPage(libEntete);
%>
<h1>Liste des restrictions</h1>
<form action="<%=pr.getLien()%>?but=utilisateur/listeRestriction.jsp" method="post" name="restriction" id="restriction">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=utilisateur/ficheRestriction.jsp"};
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
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}
%>

