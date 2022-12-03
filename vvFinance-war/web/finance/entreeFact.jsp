<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresEntree.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        TypeObjet dev[] = null;
        Client clt[] = null;
        Client clt1=null;
        TypeObjet mp[] =null;
        Caisse caiss[] = null;
        FactMere fact=null;
        FactMere[] temp=null;
        String numFact=null;
        TypeObjet ag[] =null;
        TypeObjet source[] =null;
     %>
<%
  u=(UserEJB)session.getAttribute("u");
  lien=(String)session.getAttribute("lien");
  tyo = u.findTypeObjet("TypeEntree","%","%");
  clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
  mp = u.findTypeObjet("ModePaiement","%","%");
  dev = u.findTypeObjet("Devise","%","%");
caiss = u.findCaisse("%","%","%","%");
numFact=request.getParameter("numFact");
ag = u.findTypeObjet("Agence","%","%");
source = u.findTypeObjet("Beneficiaire","%","%");
try
{//findFactureMereDeviseRespEntite(datyinf,datySup,numFact,client,"",idEtat,idCatServ,idSsCatServ,devi,agence,entite);
  temp=u.findFactureMereDeviseRespEntite("","",numFact,"%","","%","%","%","%","%","%");
  if(temp.length==0) throw new Exception("Vérifiez le numéro de pièce!");
  //System.out.println("APRES FIND FACTURE - NUM FACT "+fact.getNoteExplicative())
  fact=temp[0];
  clt1 = u.findClient("%",temp[0].getIdClient(), "%", "%", "%", "%", "%", "%", "%", "%", "%")[0];
}
catch (Exception e){e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Recette &agrave; partir d'une facture existante</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="entreeFact">
  <table width="450" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td>
  <table width="100%" border="0" class="monographe" cellpadding="3" cellspacing="0">
          <tr class="monographe">
            <td class="left">Date :</td>
            <td>&nbsp; <input name="daty" type="text" class="champ" id="daty" size="10" maxlength="10" value="<%=Utilitaire.dateDuJour()%>">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
          </tr>
          <tr class="monographe">
            <td class="left">D&eacute;signation : </td>
            <td>&nbsp; <input name="designation1" type="text" class="champ" id="designation1" value="Règlement  Facture num <%=numFact%>" disabled>
              <input name="designation" type="hidden" class="champ" id="designation" value="Règlement  Facture num <%=numFact%>">
            </td>
          </tr>
          <tr class="monographe">
            <td class="left">Client : </td>
            <td> &nbsp; <input name="text1" type="text" class="champ" id="text1" value=<%=clt1.getNom()%> disabled>
              <input name="idClient" type="hidden" class="champ" id="idClient" value=<%=fact.idClient%>>
              <input name="nomClient" type="hidden" class="champ" id="nomClient" value=<%=clt1.getNom()%>>
            </td>
          </tr>
          <tr class="monographe">
            <td class="left">Type : </td>
            <td>&nbsp; <select name="idType" class="champ" id="idType">
                <%
for(int i=0;i<tyo.length;i++){
%>
                <option value="<%=tyo[i].getId()%>"><%=tyo[i].getVal()%></option>
                <%
}
%>
              </select>
              <input name="numPiece" type="hidden" class="champ" id="numPiece" value=<%=numFact%>></td>
          </tr>
          <tr class="monographe">
            <td class="left">Montant : </td>
            <td>&nbsp; <input name="montant" type="text" class="champ" id="montant" value="<%=fact.getRAP()%>">
            </td>
          </tr>
          <tr class="monographe">
            <td class="left">Caisse : </td>
            <td>&nbsp; <select name="idCaisse" class="champ" id="idCaisse">
                <%

for(int i=0;i<caiss.length;i++){
%>
                <option value="<%=caiss[i].getIdCaisse()%>"><%=caiss[i].getDescCaisse()%></option>
                <%
}
%>
              </select> </td>
          </tr>
          <tr class="monographe">
            <td class="left">Devise en : </td>
            <td>&nbsp; <select name="idDevise" class="champ" id="idDevise">
                <%
for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>" <%if(dev[i].getId().compareTo(fact.getIdFactureEn())==0)out.println("selected");%>><%=dev[i].getVal()%></option>
                <%
}
%>
              </select> </td>
          </tr>
          <tr class="monographe">
            <td class="left">Mode de paiement : </td>
            <td>&nbsp; <select name="idModeP" class="champ" id="idModeP">
                <%
for(int i=0;i<mp.length;i++){
%>
                <option value="<%=mp[i].getId()%>"><%=mp[i].getVal()%></option>
                <%
}
%>
              </select> <input name="acte" type="hidden" id="acte" value="INSERT">
              <input name="numFact" type="hidden" id="numFact" value=<%=numFact%>>
              <input name="typa" type="hidden" id="typa" value="FACT"> </td>
          </tr>
          <tr class="monographe">
            <td class="left" valign="top">Nom du remettant:</td>
            <td>&nbsp; <input name="remarque" type="text" class="champ" id="remarque" value="-"></td>
          </tr>
          <tr>
            <td class="left" valign="top">Parution :</td>
            <td align="center"> <div align="left"> &nbsp;
                <input name="parution" type="text" class="champ" id="parution" value="<%=fact.getParution()%>">
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>
          <tr>
            <td class="left" valign="top">Agence :</td>
            <td align="center"> <div align="left"> &nbsp;
                <select name="agence" class="champ" id="agence">
                  <%
for(int i=0;i<ag.length;i++){
%>
                  <option value="<%=ag[i].getId()%>" <%if(ag[i].getId().compareTo(fact.getResp())==0) out.println("selected");%>><%=ag[i].getVal()%></option>
                  <%
}
%>
                </select>
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>

          <tr>
            <td class="left" valign="top">Source :</td>
            <td align="center"> <div align="left"> &nbsp;<select name="source" class="champ" id="agence">
                <%
for(int i=0;i<source.length;i++){
%>
                <option value="<%=source[i].getId()%>" <%if(source[i].getId().compareTo(fact.getEntite())==0) out.println("selected");%>><%=source[i].getVal()%></option>
                <%
}
%>
              </select>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>

        </table>
  </td></tr>
    <tr>
      <td> <table width="100%" border="0">
          <tr>
            <td width="50%"><div align="center">
                <input type="submit" name="Submit" value="Enregistrer" class="submit" onClick="MM_validateForm('','','RisNum','remarque','','R');return document.MM_returnValue">
              </div></td>
            <td width="50%"><div align="center">
                <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
              </div></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<script language="javascript">
var cal1 = new calendar1(document.forms['entreeFact'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
