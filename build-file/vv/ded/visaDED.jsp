<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.DedLc" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresvisaDED.jsp";
        String lien= null;
                facture.Client clt[] = null;
        UserEJB u = null;

    String idDed = null;
String numObjet = null;
 DedLc ded[]= null;
 String nature= null;
     %>
<%

  numObjet=request.getParameter("numObjet");
  nature=request.getParameter("nature");

idDed=request.getParameter("id");
if(idDed == null) idDed= "";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
System.out.println("numObjet=============>"+numObjet);
if (numObjet==null) numObjet ="";

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>VISA Demande Depense </h1>
<h2>&nbsp;</h2>


<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
 
        <tr>
    <td height="30" align="center">

<table width="100%" border="0" class="monographe">

   <tr>
            <td class="left">Ded num : <span class="remarque">*</span></td>
            <td align="center"><input name="idDed" type="text" class="champ"  id="idDed" value="<%=numObjet%>" /></td>
            <td align="left">&nbsp;<input name="choix3" type="button" onClick="pagePopUp('ded/choix_ded.jsp?champReturn=idDed')" value="..." class="submit"><img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
  <tr>
    <td class="left">Date</td>
    <td align="center"><input name="daty" type="text" class="champ" id="daty" value="<%=Utilitaire.dateDuJour()%>" >
            </td>
             <td class="left"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>  </td>
  </tr>
  <tr>
    <td class="left">Remarque</td>
    <td align="center"><input name="remarque" type="text" class="champ" id="remarque" maxlength="20">
              &nbsp;</td>
                   <td align="left">&nbsp;   <img src="images/blank.gif" width="16" height="16" align="absmiddle">    </td>
  </tr>

</table>


	  <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
   <input name="idObjet" type="hidden" id="idObjet" value="<%=numObjet%>">
          <input name="acte" type="hidden" id="acte" value="INSERT">
              <input type="submit" name="Submit" value="Viser" class="submit">
          </td>

  </tr>
</table>


    </td>
        </tr>
</table>










</form>
<div align="center">
  <script language="javascript">
var cal1 = new calendar1(document.forms['recette'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;

</script>
  <span class="remarque">(*) Champs obligatoires</span></div>