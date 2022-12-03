<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresSortie.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
         TypeObjet ts[] = null;
        TypeObjet dev[] = null;
        TypeObjet ben[] = null;
		TypeObjet ag[] = null;
        Client clt = null;
        TypeObjet mp[] =null;
        Caisse caiss[] = null;
     %>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//tyo = u.findTypeObjet("TypeObjet","%","%");
ts = u.findTypeObjet("TypeSortie","%","%");
ben = u.findTypeObjet("beneficiaire","%","%");
mp = u.findTypeObjet("ModePaiement","%","%");
dev = u.findTypeObjet("Devise","%","%");
ag = u.findTypeObjet("Agence","%","%");
caiss = u.findCaisse("%","%","%","%");
ben = u.findTypeObjet("Beneficiaire","%","%");
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<script language="javascript">
function findFacture(){
//alert("affichage");
//window.open("affichageContent/show_img.php?img="+img, "image", "resizable=no,scrollbars=yes,location=no,width=640,height=500,top=0,left=0")	;
window.open("facturefournisseur/listeChoixFF.jsp?targetForm=depense&targetInput=facture", "fature", "resizable=no,scrollbars=yes,location=no,width=650,height=600,top=0,left=0")	;
}
function testCheque(){
	if (document.forms["depense"].elements["idMode"].value=="pay2")
	{
			d=eval("document.all.numPDiv");
			d.style.display="block";

	}else{
		d=eval("document.all.numPDiv");
		d.style.display="none";
		document.forms["depense"].elements["numP"].value="none";
	}
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter nouveau d&eacute;pense</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="depense" id="depense" target="_parent">
  <table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
 <tr><td>
 <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td class="left">Date : <span class="remarque">*</span></td>
            <td><input name="daty" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
          </tr>
          <tr>
            <td class="left">D&eacute;signation : <span class="remarque">*</span></td>
            <td><input name="designation" type="text" class="champ" id="designation">
            </td>
          </tr>
          <tr>
            <td class="left">Facture : <span class="remarque">*</span></td>
            <td><input name="idFacture" type="text" class="champ" id="idFacture" value="-">
            </td>
          </tr>
          <tr>
            <td class="left">Num Pièce : <span class="remarque">*</span></td>
            <td><input name="numpiece" type="text" class="champ" id="numpiece" value="-">
            </td>
          </tr>
          <tr>
            <td class="left"> B&eacute;n&eacute;ficiaire :</td>
            <td>
              <!--<input name="beneficiaire" type="text" class="champ" id="beneficiaire">-->
              <select name="beneficiaire" class="champ">
                <%
            for(int i=0;i<ben.length;i++){
            %>
                <option value="<%=ben[i].getId()%>" <%if(ben[i].getId().compareTo("BE011")==0) out.println("selected");%>><%=ben[i].getVal()%></option>
                <%
            }
            %>
              </select> </td>
          </tr>
          <tr>
            <td class="left">Caisse : </td>
            <td><select name="idCaisse" class="champ" id="idCaisse">
                <%
for(int i=0;i<caiss.length;i++){
%>
                <option value="<%=caiss[i].getIdCaisse()%>" <%if(caiss[i].getIdCaisse().compareTo("CE000026")==0) out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
}
%>
              </select> </td>
          </tr>
          <tr>
            <td class="left">Devise en : </td>
            <td><select name="idDevise" class="champ" id="idDevise">
                        <option value="Ar">Ar</option>
                <%
for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
                <%
}
%>
              </select> </td>
          </tr>
          <tr>
            <td class="left">Type : </td>
            <td><select name="idType" class="champ" id="idType">
                <%
          for(int i=0;i<ts.length;i++){
          %>
                <option value="<%=ts[i].getId()%>"><%=ts[i].getVal()%></option>
                <%
                }
                %>
              </select> </td>
          </tr>
          <tr>
            <td class="left">Montant : <span class="remarque">*</span></td>
            <td><input name="montant" type="text" class="champ" id="montant" size="20" maxlength="20" >
            </td>
          </tr>
          <tr>
            <td class="left">Mode de paiement : </td>
            <td><select name="idMode" class="champ" id="idModeP">
                <%
for(int i=0;i<mp.length;i++){
%>
                <option value="<%=mp[i].getId()%>"><%=mp[i].getVal()%></option>
                <%
}
%>
              </select> <input name="acte" type="hidden" id="acte" value="INSERT">
            </td>
          </tr>
          <tr>
            <td class="left" valign="top">Parution :</td>
            <td align="center"> <div align="left">
                <input name="parution" type="text" class="champ" id="parution">
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>
          <tr>
            <td class="left" valign="top">Agence :</td>
            <td align="center"> <div align="left">
                <select name="agence" class="champ" id="agence">
                  <%
for(int i=0;i<ag.length;i++){
%>
                  <option value="<%=ag[i].getId()%>" <%if(ag[i].getId().compareTo("ag006")==0) out.println("selected");%>><%=ag[i].getVal()%></option>
                  <%
}
%>
                </select>
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>
          <tr>
            <td class="left" valign="top">Num Ligne Crédit :</td>
            <td align="left"> <input name="numLigneSortie" type="text" class="champ" id="numLigneSortie" size="10">
              &nbsp; <input		name="choix3" type="button" onClick="pagePopUp('lc/listeLC.jsp?sender=sortie')"
					value="...">
            </td>
          </tr>
          <tr>
            <td class="left" valign="top">Remarque :</td>
            <td><textarea name="remarque" class="champ" id="remarque"></textarea></td>
          </tr>
        </table></td></tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
<input type="submit" name="Submit2" value="Enregistrer" class="submit" onClick="MM_validateForm('daty','','R','designation','','R','montant','','RisNum');return document.MM_returnValue">
          </td>
          <td align="center">
<input type="submit" name="Submit" value="R&eacute;tablir" class="submit">
          </td>
  </tr>
</table>
      </td>
  </tr>
 </table>


</form>
<div align="center">
  <script language="javascript">
var cal1 = new calendar1(document.forms['depense'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
  <span class="remarque"> (*) Champs obligatoires</span></div>
