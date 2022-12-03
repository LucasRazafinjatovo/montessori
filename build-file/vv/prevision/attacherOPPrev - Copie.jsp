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
p.setNomTable("OrdonnerRecette");
String listeCrt[] = {"daty"};
String listeInt[] = {"daty"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
String idprev =  request.getParameter("radio");
session.setAttribute("idprevision",idprev);
pr.setApres("prevision/attacherORPrev.jsp");
pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
String libEntete[]={"id","ded_id","daty","remarque","montant"};
String[]colSomme = {"montant"};
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste ordre recette</h1>
<form action="<%=pr.getLien()%>?but=prevision/attacherORPrev.jsp" method="post" name="listeOrdonnerPayement" id="listeOrdonnerPayement">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=prevision/OrdonnerPayement.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=prevision/liaisonPrevOP.jsp" method="post">
<%
out.println(pr.getTableau().getHtmlWithRadio());
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

