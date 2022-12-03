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
try{
Rib p = new Rib();
String etat = "RibTous";
p.setNomTable("RIBNONRAPPROCHE_LIBELLE");
String listeCrt[]={"designation","debit","credit","daty","caisse","numcheque"};
String listeInt[]={"daty","debit","credit"};
String libEntete[]={"id","daty","designation","numcheque","caisse","debit","credit"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listeribnonr.jsp&etat="+etat);
affichage.Champ[] liste=new affichage.Champ[1];
Caisse to2 = new Caisse();
to2.setNomTable("caisse");
liste[0]=new Liste("caisse",to2,"desccaisse","desccaisse");

pr.getFormu().changerEnChamp(liste);


String colSomme[]={"debit","credit"};
pr.creerObjetPageMultiple(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Lister RIB non rapproch&eacute;</h1>
	<form action="<%=pr.getLien()%>?but=ded/rib-multiple.jsp" method="post" name="listePub" id="listePub">
	<%
	out.println(pr.getFormu().getHtmlEnsemble());%>
	<br/>
	</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/ficheRibnonr.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>

<form action="<%=pr.getLien()%>?but=ded/creerOPRibMultiple.jsp" method="post" name="listePub" id="listePub">
<br>
<%
out.println(pr.getTableau().getHtmlWithCheckbox());
%>
<br />
<input class="submit" type="submit" value="Créer OP"/>
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
