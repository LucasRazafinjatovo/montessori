<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Publication p=new Publication();
p.setNomTable("publication");
PageInsert pc=new PageInsert(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet to=new TypeObjet();
to.setNomTable("journal");
liste[0]=new Liste("journal",to);
((Liste)liste[0]).setDefaultSelected("j0");
TypeObjet j=new TypeObjet();
j.setNomTable("jour");
liste[1]=new Liste("jour",j,"val","val");
Rubrique r=new Rubrique();
r.setNomTable("rubrique");
liste[2]=new Liste("rubrique",r,"libelle","libelle");
pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
pc.getFormu().getChamp("parametre").setPageAppel("pub/listeParametreChoix.jsp");
pc.getFormu().getChamp("daty").setValeur(Utilitaire.dateDuJour());
pc.getFormu().getChamp("datyParution").setValeur(Utilitaire.dateDuJour());
%>
<SCRIPT language="JavaScript" src="script.js">
</script>
<script language="javascript">
var cal1 = new calendar1(document.forms['pub'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['pub'].elements['date']);
cal2.year_scroll = false;
cal2.time_comp = false;
var cal3 = new calendar1(document.forms['pub'].elements['date']);
cal3.year_scroll = false;
cal3.time_comp = false;
</script>
<SCRIPT language="JavaScript">
$(function() {
          $("#rubrique").html("");
});
function checkPublication()
  {
    obj = $("#journal").val()
    $.ajax({
      url:'ajaxRubrique.jsp?IdEditor='+obj,
      success:function(data)
      {
        $("#rubrique").html(data);
      }
    });
}
</script>
<h1>Publication d'un journal</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresPub.jsp" method="post" name="publication" id="publication">
<%
pc.getFormu().getChamp("journal").setAutre("onchange='checkPublication()'");
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="valider" class="submit">
  <input name="acte" type="hidden" id="nature" value="insertPublication">
</form>
