<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
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

PrevDepenseAVise e=new PrevDepenseAVise();
String etat="PrevDepenseAVise";
e.setNomTable(etat);
String listeCrt[]={"id","daty","montant","description"};
String listeInt[]={"daty"};
String libEntete[]={"id","daty","montant","description"};

PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/listePrevisionDepAViser.jsp");
String[]colSomme = null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des pr&eacute;visions d&eacute;pense &agrave; viser</h1>
<form action="<%=pr.getLien()%>?but=prevision/listePrevisionDepAViser.jsp" method="post" name="listePrevisionDepAViser" id="listePrevisionDepAViser">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=prevision/fichePrevisionDepenseAViser.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=prevision/apresFichePrevision.jsp" method="post" name="listePub" id="listePub">
	<input name="nature" type="hidden" id="nature" value="PrevisionDepense">
	<input type="submit" value="viser">
	<input name="acte" type="hidden" id="acte" value="VISERMULTIPLE">
<%
out.println(pr.getTableau().getHtmlWithCheckbox());
out.println(pr.getBasPage());
%>
</form>