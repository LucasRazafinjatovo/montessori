<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%

EtudiantPromo e=new EtudiantPromo();
e.setNomTable("ETUDIANTPROMOLIB2");
String listeCrt[]={"nom","prenom","datenaissance","pere","proffpere","mere","profmere","adresse","contact","mail","chemin","sexe","ecole","nature","niveau","pays","promotion","daty"};
String listeInt[]={"datenaissance"};
String libEntete[]={"id","nom","prenom","datenaissance","ecole","promotion","niveau"};
//PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3);
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("etudiant/listeEtudiant.jsp");
affichage.Champ[] liste=new affichage.Champ[7];
TypeObjet prof1=new TypeObjet();
prof1.setNomTable("TYPEPROF");
liste[0]=new Liste("proffpere",prof1,"val","val");
TypeObjet prof2=new TypeObjet();
prof2.setNomTable("TYPEPROF");
liste[1]=new Liste("profmere",prof2,"val","val");
TypeObjet sexe=new TypeObjet();
sexe.setNomTable("SEXE");
liste[2]=new Liste("sexe",sexe,"val","val");
Ecole ecole=new Ecole();
//ecole.setNomTable("ECOLE");
liste[3]=new Liste("ecole",ecole,"nom","nom");
TypeObjet nature=new TypeObjet();
nature.setNomTable("nature");
liste[4]=new Liste("nature",nature,"val","val");
TypeObjet pays=new TypeObjet();
pays.setNomTable("pays");
liste[5]=new Liste("pays",pays,"val","val");
Promotion promo=new Promotion();
liste[6]=new Liste("promotion",promo,"nom","nom");
pr.getFormu().changerEnChamp(liste);


pr.getFormu().getChamp("proffpere").setLibelleAffiche("Profession du père");
pr.getFormu().getChamp("profmere").setLibelleAffiche("Profession de la mère");

//String colSomme[]={"montantVal"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des &eacute;tudiants</h1>
<form action="<%=pr.getLien()%>?but=etudiant/listeEtudiant.jsp" method="post" name="listeetudiant" id="listeetudiant">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=etudiant/ficheEtudiant.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
