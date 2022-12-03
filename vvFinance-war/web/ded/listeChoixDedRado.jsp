<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ded.Ded" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!


  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;
String action = null;
 Utilitaire utilitR=new Utilitaire();

   String idDED,designation, dateDebut, dateFin,fournisseur;
  Ded[] ded = null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");

     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/

%>
<%
  try{

                  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
                  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
                   action = request.getParameter("action");if ((action==null)||action.compareTo("")==0) action="listeFactureChoix.jsp";

					    designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
                        fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
                        idDED=request.getParameter("idDED");if ((idDED==null)||idDED.compareTo("")==0) idDED="%";

                         ded = u.findDed(idDED,designation, dateDebut, dateFin,"%","%","%",fournisseur);



  // sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les Demandes d&eacute;penses </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les demandes de d&eacute;pense)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
&nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
        </tr>
        <tr>
          <td class="left">Fournisseur :</td>
          <td align="center"><input name="fournisseur" type="text" class="champ"   id="fournisseur" value="<%=fournisseur%>"size="10" maxlength="10" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          <td class="left">Designation</td>
          <td align="center"><input name="designation" type="text" class="champ"   id="designation" value="<%=designation%>" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
        </tr>
        <tr>
          <td class="left">id DED </td>
          <td align="center">
<input name="idDED" type="text" class="champ"   id="idDED" value="<%=idDED%>"size="10" maxlength="10" /> </td>
          <td class="left"></td>
          <td align="center"></td>
        </tr>
      </table></td>
    </tr>

        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">            </td>
            <td align="center"> <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">            </td>
          </tr>
        </table></td>
    </tr>
  </table>


</form>


<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>


      <br>
      <p align="center"><strong><u>LISTE</u></strong></p><form action="<%=lien%>?but=<%=action%>" method="post">

     <input name="typeObjet" type="hidden" value="<%=Constante.getObjetFactureF()%>"> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">

          <td width="66" align="center" valign="top">Date</td>
                   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Tiers</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant TTC</strong></div></td>
  <td width="102" align="center" valign="top">Montant Tva</td>
                            <td width="102" align="center" valign="top">Choix</td>

        </tr>
        <%
  for(int i=0;i<ded.length;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">

          <td align="center"><%=utilitR.formatterDaty(ded[i].getDaty())%></td>
          <td align="right"><div align="center"><%=ded[i].getDesignation()%></div></td>
                  <td align="center"><%=ded[i].getTiers()%></td>
          <td align="right"><%=utilitR.formaterAr((double)ded[i].getMttc())%>>Ar</td>
          <td align="center"><%=utilitR.formaterAr(ded[i].getTaxe()) %>Ar</td>
    <input type="hidden" name="nombre">
                  <td align="center">

<input name="indice" type="radio" id="numObjet" value=<%=i%> onClick=nombre.value=<%=i%>>
<input type="hidden" name="numObjet<%=i%>" value="<%=ded[i].getId()%>">
<input type="hidden" name="montantObjet<%=i%>" value="<%=ded[i].getMttc()%>">
</td>



        <%
    }
  %>
      </table>
     <div align="center">
       <input name="bouton" type="submit" value="choix">
     </div>
      </form></td>
</tr>
</table>
<br>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>
