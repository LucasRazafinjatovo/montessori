<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="facturefournisseur/apresEntreeFacture.jsp";
        String lien= null;
        facture.Client clt[] = null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        TypeObjet dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet source[] =null;
        TypeObjet ag[] =null;
        Caisse caiss[] = null;
        String idFact = null;
        facture.Tva tva = null;
        String nature=null;

%>
<%
idFact=request.getParameter("idFacture");
nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="FactureFournisseur";
if(idFact == null) idFact = "";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
out.println("lien = "+lien);
dev = u.findTypeObjet("Devise","%","%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
tva = u.loadTva(Utilitaire.dateDuJour());

}catch(Exception e){
    e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>ENREGISTREMENT <%=nature%></h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value) && verifie(designation.value) && verifie(montant.value))">

    <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
                    <tr>
                        <td class="left">Num <%=nature%>: <span class="remarque">*</span></td>
                        <td align="center"> <input name="numFact" type='text' class="champ"  id="numFact">
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="left">Designation: <span class="remarque">*</span></td>
                        <td align="center"> <textarea name="designation" class="champ"  id="designation"></textarea>
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">         </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">Date : <span class="remarque">*</span></td>
                        <td align="center"> <input name="daty" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>">
                            &nbsp;           </td>
                        <td align="center"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>  </td>
                    </tr>
                    <tr>
                        <td class="left">Fournisseur: <span class="remarque">*</span></td>
                        <td align="center">          <input type="text" class="champ" name="fournisseur" value=""/>
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center"><input name="choix3" type="button" class="submit" onclick="pagePopUp('ded/choix_tiers.jsp?champReturn=fournisseur')" value="..." /></td>
                    </tr>
                    <tr>
                        <td class="left">Montant (TTC) Ar : </td>
                        <td align="center"><input name="montantTTC" type="text" class="champ" id="montantTTC" />
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">Montant TVA Ar : </td>
                        <td align="center"> <input name="tva" type="text" class="champ" id="tva">
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">Devise : <span class="remarque">*</span></td>
                        <td align="center"> <select name="idDevise" class="champ" id="idDevise">
                                <option value="Ar">Ar</option>
                                <%
                for(int i=0;i<dev.length;i++){
                                %>
                                <option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
                                <%
                }
                                %>
                            </select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">Remarque : </td>
                        <td align="center"> <textarea name="remarque" class="champ" id="remarque" maxlength="100"></textarea>
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">           </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left" valign="top">Date emission:</td>
                        <td align="center"> <input name="dateemission" type="text" class="champ" id="dateemission" value="<%=Utilitaire.dateDuJour()%>" maxlength="10">
                            &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left" valign="top">Date d'&eacute;cheance:</td>
                        <td align="center"> <input name="datyecheance" type="text" class="champ" id="datyecheance" value="<%=Utilitaire.dateDuJour()%>" maxlength="10">
                            &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>            </td>
                        <td align="center">&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="left">Lc unique : <span class="remarque">*</span></td>
                        <td align="center">          <input type="text" class="champ" name="lc" value=""/>
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center"><input name="choix3" type="button" class="submit" onclick="pagePopUp('lc/listeLC2Choix.jsp?champReturn=lc')" value="lc" /></td>
                    </tr>
                </table></td>
        </tr>
        <tr>
            <td height="30" align="center">
                <table width="75%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
                            <input name="acte" type="hidden" id="acte" value="INSERT">
                            <input type="submit" name="Submit" value="Enregistrer" class="submit">
                        </td>
                        <td align="center">
                            <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
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
        var cal1 = new calendar1(document.forms['recette'].elements['dateemission']);
        cal1.year_scroll = false;
        cal1.time_comp = false;
    </script>
    <span class="remarque">(*) Champs obligatoires</span></div>