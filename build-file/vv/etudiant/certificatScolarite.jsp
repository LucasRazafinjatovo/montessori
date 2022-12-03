<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%@ page import="utilitaire.*" %>
<%
Etudiant et=new Etudiant();
String id=request.getParameter("id");
UserEJB u=null;
String lien=null;
et.setId(id);
Etudiant[]listeEt=(Etudiant[])CGenUtil.rechercher(et,null,null,"");
AvancementComplet av=new AvancementComplet();
av.setNomTable("AVANCEMENTCOMPLETID");
av.setEtudiant(id);
AvancementComplet[]listeAv=(AvancementComplet[])CGenUtil.rechercher(av,null,null,"");
if(listeAv.length==0) throw new Exception("AUCUN AVANCEMENT");
try{

  u=(user.UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");

}catch(Exception e){
 %>
<script language="JavaScript"> document.location.replace("../erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>
<table align=center>
<tr><td><img src="images/bateau.jpg" width="351" height="150"></td></tr>
<tr><td><h1>Certificat de scolarit&eacute;</h1></td></tr>
<tr><td><h1 align=center><%
String an1=Utilitaire.getAnnee(Utilitaire.dateDuJour());
int anneeplus=Integer.parseInt(an1);
//out.print(anneeplus);
int an2=anneeplus+1;;
out.print(an1+"-"+an2);
%>
</h1></td></tr></table><br/><br/><br/>
<table align=center><tr>Je soussign&eacute;, Dr Olivier Robinson, recteur de l'IT UNIVERSITY certifie que :</tr></table>
<br/><br/><table align=center cellpadding=3 cellspacing=3>
 <tr>
    <td>Nom : </td>
    <td><%=listeEt[0].getNom()%></td>
 </tr>
 <tr>
    <td>Pr&eacute;nom : </td>
    <td><%=listeEt[0].getPrenom()%></td>
 </tr>
 <tr>
    <td><% String sexe=listeEt[0].getSexe();
        if(sexe.compareToIgnoreCase("SEX1")==0){out.println("N&eacute; le :");}
        else{out.println("N&eacute;e le :");} %>
    </td>
    <%
String daty=Utilitaire.formatterDatySql(listeEt[0].getDateNaissance());
String jour=Utilitaire.getJour(daty);
String mois=Utilitaire.getMois(daty);
int m=Utilitaire.getMois(listeEt[0].getDateNaissance());
//int m=Integer.valueOf(mois);
String moisLettre=Utilitaire.nbToMois(m);
String annee=Utilitaire.getAnnee(daty);
//System.out.println(" DATE : "+jour+" "+moisLettre+" "+annee);
%>
    <td><% out.println(jour+" "+moisLettre+" "+annee);%><br></td>
 </tr>
 <tr>
    <td>N° matricule : </td>
    <td></td>
 </tr>
</table><br/>
<table align=center cellpadding=3 cellspacing=3>
<tr>Est inscrit r&eacute;guli&egrave;rement sur le registre de l'&eacute;tablissement en L2-Informatique</tr>
<br/><tr><p style='margin-left:7.0cm'>
Fait &agrave; Antananarivo ce <%
String j=Utilitaire.getJour(Utilitaire.dateDuJour());
int mon=Utilitaire.getMoisEnCours();
String monLettre=Utilitaire.nbToMois(mon+1);
//String mois=Utilitaire.getMoisEnCours();
String an=Utilitaire.getAnnee(Utilitaire.dateDuJour());
out.println(j+" "+monLettre+" "+an);
%></p></tr></table>

<br/><br/><br/>
<table align=center cellpadding=3 cellspacing=3>
<tr><p style='margin-left:7.0cm'>Le Recteur
<br/><br/><br/><br/><br/><br/>
Dr Olivier ROBINSON</p></tr>
</table>
</div>
</body>
</html>
