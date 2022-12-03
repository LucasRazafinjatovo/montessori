<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%
EtudiantPromo e=new EtudiantPromo();
e.setNomTable("ETUDIANTPROMO");
String listeCrt[]={"nom","prenom","datenaissance","pere","proffpere","mere","profmere","adresse","contact","mail","chemin","sexe","ecole","nature","niveau","pays","promotion","daty"};
String listeInt[]={"datenaissance"};
String libEntete[]={"id","nom","prenom","datenaissance","ecole","promotion","niveau"};
//PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3);
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("listeEtudiantChoix.jsp");
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

  pr.getFormu().getChamp("proffpere").setLibelleAffiche("Profession du p�re");
  pr.getFormu().getChamp("profmere").setLibelleAffiche("Profession de la m�re");
//String colSomme[]={"montantVal"};
  String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
EtudiantPromo []listeP=(EtudiantPromo [])pr.getRs().getResultat();//liste listeEtudiant
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des &eacute;tudiants</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeEtudiantChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
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
<form action="<%=pr.getLien() %>?but=apresEtudiantChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top">id</td>
<td width=9% align="center" valign="top">id</td>
<td width=16% align=center valign=top>nom</td>
<td width=14% align=center valign=top>prenom</td>
<td width=14% align=center valign=top>datenaissance</td>
<td width=14% align=center valign=top>ecole</td>
<td width=7% align=center valign=top>nature</td>
<td width=14% align=center valign=top>promotion</td>
<td width=7% align=center valign=top>niveau</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getNom() %></td>
<td align=center><%=listeP[i].getPrenom() %></td>
<td align=center><%=listeP[i].getDateNaissance() %></td>
<td align=center><%=listeP[i].getEcole()%></td>
<td align=center><%=listeP[i].getNature()%></td>
<td align=center><%=listeP[i].getPromotion()%></td>
<td align=center><%=listeP[i].getNiveau()%></td>
</tr>
<!--<input type="hidden" name="id<%=i%>" value="<%=listeP[i].getId()%>">-->
<%}%>
</table>
<!--<input type="hidden" name="nb" value="<%=listeP.length%>">-->
<!--<input type="hidden" name="crt" value="<%=pr.getFormu().getListeCritereString()%>&numPage=<%=pr.getNumPage()%>">-->
<!--<input type="submit" value="valider">-->
</form>


<%
//out.println(pr.getBasPage());
%>
