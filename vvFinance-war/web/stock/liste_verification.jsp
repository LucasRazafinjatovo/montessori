<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="stock.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet dev[] = null;
MvtStock mvt[]= null;
MvtStock mvt1= null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;

String id = null;
 Verification[] verif=  null;
String dateDebut= null;
String dateFin= null;
String compte= null;
String controleur = null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     id = request.getParameter("id");
     controleur = request.getParameter("controleur");
     dateDebut= request.getParameter("dateDebut");
dateFin= request.getParameter("dateFin");
compte= request.getParameter("compte");
  if ((dateDebut == null)|| dateDebut.compareTo("")==0) dateDebut="";
    if ((dateFin == null)|| dateFin.compareTo("")==0) dateFin="";
      if ((compte == null)|| compte.compareTo("")==0) compte="%";
       if ((controleur == null)|| controleur.compareTo("")==0) controleur="%";
verif=u.findVerification("%",dateDebut,dateFin, compte,controleur);


     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/

%>
<%
  try{

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
<h1>V&eacute;rification</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les restes th&eacute;oriques)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
	   <tr>
            <td class="left">Controleur :</td>
            <td align="center"><input name="controleur" type="text"   id="controleur" value="<%=controleur%>"size="10" maxlength="10" /> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
            <td class="left">Magasin</td>
            <td align="center"><input name="compte" type="text"   id="compte" value="<%=compte%>"size="10" maxlength="10" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
          </tr>
          <tr>
            <td class="left">Date début :</td>
            <td align="center"><input name="dateDebut" type="text"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
            </td>
            <td class="left">Date fin:</td>
            <td align="center"><input name="dateFin" type="text"   id="dateFin" value="<%=dateFin%>" size="10" />
              &nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
            </td>
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
<form action="retour_emprunt_reglement.html" method="post" name="frmselect">

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td>
      <br>
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
         <tr class="head">

          <td align="center" valign="top">id</td>
		   <td align="right" valign="top"><div align="center">Controleur</div></td>
          <td align="right" valign="top"><div align="center">Magasin</div></td>
          <td align="right" valign="top"><div align="center"><strong>Date</strong></div></td>
		  <td align="right" valign="top"><div align="center"><strong>Reste</strong></div></td>
        </tr>
<%

                for(int i=0;i<verif.length;i++){

        %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">

          <td align="center"><a href="<%=lien%>?but=stock/confirmation_verification.jsp&id=<%=verif[i].getId()%>"><%=verif[i].getId()%></a></td>
          <td align="center"><%=verif[i].getControleur()%></td>
           <td align="right"><%=verif[i].getc%></td>
         <td align="center"><%=Utilitaire.formatterDaty(verif[i].getDaty())%></td>
        <td align="right"><%=verif[i].getReste()%></td>

        </tr>
        <%
                }
        %>
      </table>

	  </td>
</tr>
</table>
</form>
<br>



<script language="javascript">
  function getChoix(){
setTimeout("document.frmselect.submit()",800);
}
</script>
