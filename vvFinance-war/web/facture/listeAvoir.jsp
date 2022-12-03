<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/listeAvoir.jsp";
	String lien= null;
	facture.Avoir autoAnnul[] = null;
    bean.TypeObjet to[] = null;
	UserEJB u = null;
    String idFactureMere = null;
	String daty1 = null;
	String daty2 = null;
	String idTypeObjet = null;
	String numObj = null;
	String responsable = null;
	String avoir=null;
	historique.MapUtilisateur ut=null;
    int pazy=0;
    int nbParPazy=Parametre.getNbParPage();
%>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
daty1 = request.getParameter("daty1");
daty2 = request.getParameter("daty2");
idTypeObjet = request.getParameter("idTypeObjet");
numObj = request.getParameter("numObj");
responsable = request.getParameter("responsable");
avoir = request.getParameter("avoir");
if ((idTypeObjet == null)|| idTypeObjet.compareTo("")==0) idTypeObjet="%";
if (daty1==null || daty1.compareTo("")==0) daty1="";
if (daty2==null || daty2.compareTo("")==0) daty2="";
if ((responsable==null)|| responsable.compareTo("")==0) responsable="%";
if ((numObj==null)|| numObj.compareTo("")==0) numObj="%";
if ((avoir==null)|| avoir.compareTo("")==0) avoir="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
              //String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot,String typ
autoAnnul = u.findAvoirValide(avoir,numObj,responsable,daty1,daty2,"%",idTypeObjet);
to = u.findTypeObjet("TypeObjet","%","%");
ut=u.getUser();
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<h1>Liste des Avoirs</h1>
<table width="360" border="0" align="center" cellpadding="3" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td width="354" height="30" valign="top" class="remarque">Choisir les crit&egrave;res
      de recherche pour la liste des autorisations d'annulation enregistr&eacute;es.</td>
    </tr>
</table>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeAuto" id="listeAuto">
  <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td width="19%" height="20" bgcolor="#C300FF"><strong>Date début :</strong></td>
            <td width="34%"><div align="center">
                <input name="daty1" type="text" class="champ" id="daty1" value="<%=daty1%>" size="10" maxlength="10">
                &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></div></td>
            <td width="16%" bgcolor="#C300FF"><strong>Date fin:</strong></td>
            <td width="31%"><div align="center">
                <input name="daty2" type="text" class="champ" id="daty22" value="<%=daty2%>" size="10" maxlength="10">
                &nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></div></td>
          </tr>
          <tr>
            <td bgcolor="#C300FF" height="20"><strong>Type:</strong></td>
            <td><div align="center">
                <select name="idTypeObjet" class="champ" id="select">
					<option value="%">Tous</option>
                  <option value="interne" <%if(idTypeObjet.compareTo("interne")==0)out.println("selected");%>>interne</option>
                  <option value="externe" <%if(idTypeObjet.compareTo("externe")==0)out.println("selected");%>>externe</option>
                </select>
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
            <td bgcolor="#C300FF"><strong>Num&eacute;ro Fact:</strong></td>
            <td><div align="center">
                <input name="numObj" type="text" class="champ" id="numObj2" <%=numObj%>>
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
          <tr>
            <td bgcolor="#C300FF" height="20"><strong>Autoris&eacute; par :</strong></td>
            <td><div align="center">
                <input name="responsable" type="text" class="champ" id="responsable2" value="<%=responsable%>">
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
            <td height="20" bgcolor="#C300FF"><strong>Num&eacute;ro Av :</strong></td>
            <td><div align="center">
                <input name="avoir" type="text" class="champ" id="responsable2">
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
        </table></td>
        </tr>
        <tr>
          <td height="30"><table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr>

            <td align="center">
<input type="submit" name="Submit" value="Afficher" class="submit">
            </td>

            <td align="center">
<input name="Annuler" type="reset" class="submit">
            </td>
              </tr>
            </table></td>
        </tr>
      </table>


</form>

<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"> <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="14%" height="20"><div align="center"><strong>Num Avoir</strong></div></td>
          <td width="12%"><div align="center"><strong>Type</strong></div></td>
          <td width="13%"><div align="center">Date</div></td>
          <td width="30%"><div align="center">Montant</div></td>
          <td width="14%"><div align="center">N&deg; Facture</div></td>
		     <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
		{
   %>
          <td width="17%">&nbsp;</td>
		  <%
		  }
		  %>
        </tr>
<%
int pejy=0;
if(pazy==0){
        pejy=0;
        pazy=1;
}else{
        pejy=pazy-1;
}
int pazy1=nbParPazy*pejy;
int pazy2=pazy*nbParPazy;
if(pazy2>autoAnnul.length){
  pazy2=autoAnnul.length;
}
%>
   <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr>
          <td height="20"><div align="center"><a href="<%=lien%>?but=facture/detailAvoir.jsp&idAvoir=<%=autoAnnul[i].getIdAvoir()%>"><%=autoAnnul[i].getIdAvoir()%></a></div></td>
          <td><div align="center"><%=autoAnnul[i].getType()%></div></td>
          <td><div align="center"><%=Utilitaire.formatterDaty(autoAnnul[i].getDaty())%></div></td>
          <td><div align="center"><%=Utilitaire.formaterAr((double)autoAnnul[i].getMontant())%></div></td>
          <td><div align="center"><%=autoAnnul[i].getIdFactureMere()%></div></td>
   <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
		{
   %>
          <td><div align="center">
<a href="javascript:decision('Vous voulez vraiment annuler cet avoir?\n\nCette opération supprimera définitivement cet avoir du système.','<%=lien%>?idAvoir=<%=autoAnnul[i].getIdAvoir()%>&but=facture/apresAvoir.jsp&acte=ANNULE')">
Annuler</a></div></td>
<%
}
%>
        </tr>
        <%
  }
  %>
      </table></td>
  </tr>
</table>
<script>
var cal1 = new calendar1(document.forms['listeAuto'].elements['daty1']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeAuto'].elements['daty2']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
<%
if ((idTypeObjet == null)|| idTypeObjet.compareTo("%")==0) idTypeObjet="";
if ((responsable==null)|| responsable.compareTo("%")==0) responsable="";
if ((numObj==null)|| numObj.compareTo("%")==0) numObj="";
if ((avoir==null)|| avoir.compareTo("%")==0) avoir="";
%>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=autoAnnul.length%></td><td align="right"><%if(autoAnnul.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%if(autoAnnul.length%nbParPazy==0)out.println(autoAnnul.length/nbParPazy);else out.println(autoAnnul.length/nbParPazy+1);}%></td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=facture/listeAvoir.jsp&pazy=<%=pazy-1%>&daty1=<%=daty1%>&daty2=<%=daty2%>&idTypeObjet=<%=idTypeObjet%>&numObj=<%=numObj%>&responsable=<%=responsable%>&avoir=<%=avoir%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right" valign="top">
      <%
      if(autoAnnul.length>pazy2){
      %>
      <a href="<%=lien%>?but=facture/listeAvoir.jsp&pazy=<%=pazy%>&daty1=<%=daty1%>&daty2=<%=daty2%>&idTypeObjet=<%=idTypeObjet%>&numObj=<%=numObj%>&responsable=<%=responsable%>&avoir=<%=avoir%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>