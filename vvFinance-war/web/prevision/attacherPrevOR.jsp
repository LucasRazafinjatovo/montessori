<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<script type="text/javascript">
function checkBoxer(obj,taille)
{
     if(obj.checked==true)
     {
         for(var i=0;i<taille;i++)
         {
          document.getElementById("identifiant"+i).checked = true;
         }
     }
     else
     {
       for(var i=0;i<taille;i++)
         {
          document.getElementById("identifiant"+i).checked = false;
         }
     }
}
</script>
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
OrdonnerPayement p = new OrdonnerPayement();
String etat = "ORDONNERRECETTELIBELLE";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0) etat = request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[] = {"daty"};
String listeInt[] = {"daty"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
String idprev =  request.getParameter("radio");
session.setAttribute("idprevision",idprev);
pr.setApres("prevision/attacherPrevOR.jsp&etat="+etat);
pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
String libEntete[]={"id","ded_id","daty","remarque","montant"};
String[]colSomme = {"montant"};
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste prevision depense</h1>
<form action="<%=pr.getLien()%>?but=prevision/attacherPrevOR.jsp" method="post" name="listeOrdonnerPayement" id="listeOrdonnerPayement">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : 	<select name="etat" class="champ" id="etat" >
            <option value="ORDONNERRECETTELIBELLE"  <%if(etat.compareTo("ORDONNERRECETTELIBELLE")==0) out.println("selected");%>>Tous</option>
            <option value="ORDONNERRECETTELIBELLEATC"  <%if(etat.compareTo("ORDONNERRECETTELIBELLEATC")==0) out.println("selected");%>> Attache</option>
            <option value="ORDONNERRECETTELIBELLENATC"  <%if(etat.compareTo("ORDONNERRECETTELIBELLENATC")==0) out.println("selected");%>> Non attache</option>
		</select>
	</form>
<%
String lienTableau[]={pr.getLien()+"?but=prevision/OrdonnerPayement.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=prevision/liaisonPrevOR.jsp" method="post">
<%
if(etat.compareTo("ORDONNERRECETTELIBELLENATC")==0){
	out.println(pr.getTableau().getHtmlWithCheckbox());
}else{
	out.println(pr.getTableau().getHtml());
}
%>
   <input type="hidden" name="type" value="prevop" class="submit">
   <input type="submit" name="Submit" value="Valider" class="submit">
</form>
<% 
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

