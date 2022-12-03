<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%
try{
UserEJB u;
Publicite p = new Publicite();
p.setNomTable("publicite");
u=(user.UserEJB)session.getValue("u");
PageUpdate pc=new PageUpdate(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
affichage.Champ[] liste=new affichage.Champ[3];
Montant m=new Montant();
m.setNomTable("MontantVue");
liste[0]=new Liste("idMont",m);
TypeObjet to=new TypeObjet();
to.setNomTable("categoriePub");
liste[1]=new Liste("idCat",to);
TypeObjet too=new TypeObjet();
too.setNomTable("Agence");
liste[2]=new Liste("idAgence",too,"val");
pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
pc.getFormu().getChamp("idClient").setPageAppel("ded/choix_tiers.jsp");
pc.getFormu().getChamp("pagemisyazy").setAutre("readonly='true'");
pc.getFormu().getChamp("id").setAutre("readonly='true'");
pc.getFormu().getChamp("idClient").setAutre("readonly='true'");
pc.getFormu().getChamp("idparution").setAutre("readonly='true'");
pc.getFormu().getChamp("remis").setAutre("onblur='controler()'");
if(u.isSuperUser()==false) pc.getFormu().getChamp("montant").setAutre("readonly='true'");
Publicite pub = (Publicite)pc.getBase();
Parution[] par = (Parution[])CGenUtil.rechercher(new Parution(), null, null, " AND ID = '" + pub.getIdParution() + "'");

if( Utilitaire.compareDaty(Utilitaire.dateDuJourSql(), par[0].getDatyParution()) > 0 && u.getUser().getIdrole().compareTo("dg") != 0){

%>
<h1>Erreur de droit!</h1>
<%
}else{
%>

<SCRIPT language="JavaScript" src="script.js"></script>
<script type="text/javascript">

 function controler()
{
  if(isNaN(listePub.remis.value) == true)
  {
  listePub.remis.value="";
  listePub.remis.focus();
  alert("remise invalide");
  }
}
</script>
<h1>Modification d'une pubicite</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresPub.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="valider" class="submit">
  <input name="acte" type="hidden" id="nature" value="update">
</form>
<%
}
}catch(Exception ex){
	ex.printStackTrace();
}
%>