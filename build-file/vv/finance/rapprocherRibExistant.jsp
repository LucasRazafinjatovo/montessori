<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<script language="JavaScript">
  $(document).ready(function() {
      $('#cocheTout').click(function() {

          var cases = $("#divchck").find(':checkbox');
          if(this.checked){
              cases.attr('checked', true);
              $('#cocheText').html('Tout decocher');
          }else{
              cases.attr('checked', false);
              $('#cocheText').html('Tout cocher');
          }

      });

});
</script>
<%
	String idrib = null;
	String debit = null;
	String credit = null;
	String caisse = null;
MvtCaisseTous p;
%>
<%
try{
p = new MvtCaisseTous();
p.setNomTable("MVTNONRAPPRO");
String listeCrt[]={"designation","idordre","debit","credit","iddevise","id","daty","idmode","idcaisse","agence","tiers","numpiece","typemvt"};
String listeInt[]={"daty","debit","credit"};
String libEntete[]={"id","daty","designation","agence","idCaisse","debit","credit"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/rapprocherRibExistant.jsp&idrib="+request.getParameter("idrib"));
affichage.Champ[] liste=new affichage.Champ[4];
TypeObjet to=new TypeObjet();
to.setNomTable("devise");
liste[0]=new Liste("iddevise",to,"val","val", true);
TypeObjet to1=new TypeObjet();
to1.setNomTable("modepaiement");
liste[1]=new Liste("idmode",to1,"val","val", true);
Caisse to2=new Caisse();
to2.setNomTable("caisse");
liste[2]=new Liste("idcaisse",to2,"desccaisse","desccaisse", true);
TypeObjet to3=new TypeObjet();
to3.setNomTable("typemvt");
liste[3]=new Liste("typemvt",to3,"val","val", true);

pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("idMvt",7);


String colSomme[]={"debit","credit"};
UserEJB u = (user.UserEJB)session.getValue("u");
Rib rib = u.findDetailRib(request.getParameter("idrib"));
pr.creerObjetPageMultiple(libEntete,colSomme);
//pr.preparerDataFormu();
%>
</br>
VOTRE CHOIX
<table width="100%"  border="0" class="monographe">
  <tr>
    <td width="27%" class="left">Num <%=request.getParameter("idrib")%></td>
    <td width="73%"><div align="center"><%=rib.getDesignation()%></div></td>
  </tr>
  <tr>
    <td class="left">Num Cheque</td>
    <td><div align="center"><%=rib.getNumcheque()%></div></td>
  </tr>
  <tr>
    <td class="left">Montant</td>
    <td><div align="center"><% if(rib.getDebit() > 0) out.println(Utilitaire.formaterAr(rib.getDebit())); else out.println(Utilitaire.formaterAr(rib.getCredit()));%> Ar </div></td>
  </tr>
</table><br>
<h1>Lister les Mouvements de caisse non raprochée</h1>
<form action="<%=pr.getLien()%>?but=finance/rapprocherRibExistant.jsp" method="post" name="listePub" id="listePub">
<input type="hidden" name="idrib" value="<%=request.getParameter("idrib")%>">
<%out.println(pr.getFormu().getHtmlEnsemble());%>

</form>


<%
String lienTableau[]={pr.getLien()+"?but=finance/ficheMvtCaisssenonr.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=finance/apresRib.jsp" method="post" name="listePub" id="listePub">
 <div align="center">
	    <input type="submit" value="selectionner">
        <input type="hidden" name="idrib" value="<%=request.getParameter("idrib")%>">
		<input name="acte" type="hidden" id="nature" value="rib">
		<input name="bute" type="hidden" id="bute" value="finance/listeribnonr.jsp">
		<input name="classe" type="hidden" id="classe" value="finance.RapprochementBancaire">
     </div>
<%
out.println(pr.getTableau().getHtmlWithCheckbox());
out.println(pr.getBasPage());
%>
</form>
<%
}
catch(Exception e){
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}
%>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>