<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="historique.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String lien = null;
  String apres = "facture/listeClient.jsp";
  TraficConteneur tc[] = null;
  UserEJB u = null;
  String mois1 = null;
  String mois2 = null;
  String annee1 = null;
  String annee2 = null;
  int pazy=0;
  int nbParPazy=Parametre.getNbParPage();
   historique.MapUtilisateur ut=null;
   Service svc[] = null;

%>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
mois1 = request.getParameter("mois1");
mois2 = request.getParameter("mois2");
annee1 = request.getParameter("annee1");
annee2 = request.getParameter("annee2");
if ((mois1 == null)) mois1="01";
if ((mois2 == null)) mois2="12";
if (annee1 == null || annee1.compareTo("")==0 ) annee1=String.valueOf(Utilitaire.getAneeEnCours());
if (annee2 == null || annee1.compareTo("")==0) annee2=String.valueOf(Utilitaire.getAneeEnCours());
%>
<%
try{
	u=(UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
        apres = "facture/listeTraficEvp.jsp";
        svc = u.findService("%", "%", "", "", "%", "%","%","%");
        ut=u.getUser();
        tc = u.findTraficPeriode("%", "", "", "%",mois1,mois2,annee1,annee2);

}catch(Exception e){
 return;
}

%>
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
 

<h1>Liste Trafic EVP</h1>
<form action="<%=lien%>?but=facture/listeTraficEvp.jsp" name="listeTraffic" method="post">
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="3" cellspacing="0" class="monographe">
        <tr>
            <td width="17%" class="left">Mois d&eacute;but :</td>
          <td width="31%"><select name="mois1" class="champ" id="mois1">
                <option value="01" <%if(mois1.compareTo("01")==0)out.print("selected");%>>janvier</option>
                <option value="02" <%if(mois1.compareTo("02")==0)out.print("selected");%>>f&eacute;vrier</option>
                <option value="03" <%if(mois1.compareTo("03")==0)out.print("selected");%>>mars</option>
                <option value="04" <%if(mois1.compareTo("04")==0)out.print("selected");%>>avril</option>
                <option value="05" <%if(mois1.compareTo("05")==0)out.print("selected");%>>mai</option>
                <option value="06" <%if(mois1.compareTo("06")==0)out.print("selected");%>>juin</option>
                <option value="07" <%if(mois1.compareTo("07")==0)out.print("selected");%>>juillet</option>
                <option value="08" <%if(mois1.compareTo("08")==0)out.print("selected");%>>ao&ucirc;t</option>
                <option value="09" <%if(mois1.compareTo("09")==0)out.print("selected");%>>sept.</option>
                <option value="10" <%if(mois1.compareTo("10")==0)out.print("selected");%>>oct.</option>
                <option value="11" <%if(mois1.compareTo("11")==0)out.print("selected");%>>nov.</option>
                <option value="12" <%if(mois1.compareTo("12")==0)out.print("selected");%>>d&eacute;c.</option>
              </select> </td>  <td width="17%" class="left">Ann&eacute;e d&eacute;but :</td>
          <td width="35%"><input name="annee1" type="text" class="champ" id="annee1" value="<%=annee1%>" maxlength="4">
            </td>
        </tr>
		 <tr>
            <td class="left">Mois fin :</td>
          <td><select name="mois2" class="champ" id="mois2">
                 <option value="01" <%if(mois2.compareTo("01")==0)out.print("selected");%>>janvier</option>
                <option value="02" <%if(mois2.compareTo("02")==0)out.print("selected");%>>f&eacute;vrier</option>
                <option value="03" <%if(mois2.compareTo("03")==0)out.print("selected");%>>mars</option>
                <option value="04" <%if(mois2.compareTo("04")==0)out.print("selected");%>>avril</option>
                <option value="05" <%if(mois2.compareTo("05")==0)out.print("selected");%>>mai</option>
                <option value="06" <%if(mois2.compareTo("06")==0)out.print("selected");%>>juin</option>
                <option value="07" <%if(mois2.compareTo("07")==0)out.print("selected");%>>juillet</option>
                <option value="08" <%if(mois2.compareTo("08")==0)out.print("selected");%>>ao&ucirc;t</option>
                <option value="09" <%if(mois2.compareTo("09")==0)out.print("selected");%>>sept.</option>
                <option value="10" <%if(mois2.compareTo("10")==0)out.print("selected");%>>oct.</option>
                <option value="11" <%if(mois2.compareTo("11")==0)out.print("selected");%>>nov.</option>
                <option value="12" <%if(mois2.compareTo("12")==0)out.print("selected");%>>d&eacute;c.</option>
              </select> </td>
            <td class="left">Ann&eacute;e fin :</td>
          <td><input name="annee2" type="text" class="champ" id="annee2" value="<%=annee2%>" maxlength="4">
            </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
<input name="Submit" type="submit" class="submit" value="Afficher">
          </td>
          <td align="center">
<input name="Submit2" type="reset" class="submit" value="Annuler">
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<br>
<table width="600" border="0" align="center" cellpadding="3" cellspacing="0">
        <tr>
          <td> <table width="100%" border="0" cellpadding="3" cellspacing="0" align="center" class="monographe">
              <tr>
                <td width="13%" valign="middle"> <div align="center"></div></td>
                <td width="14%" valign="middle">&nbsp;</td>
                <td width="9%" valign="middle"> <div align="center"></div></td>
                <td width="13%" height="20" valign="middle"> <div align="center"></div></td>
                <td width="20%" height="20" valign="middle"> <div align="center"><strong>Total
                    général : </strong></div></td>
                <td width="31%" height="20" valign="middle"> <p align="center"><strong><%=(long)AdminTrafic.calculSommeFacture(tc)%>
                    EVP</strong></p></td>
              </tr>
            </table></td>
        </tr>
      </table>
<table width="600" border="0" align="center" cellpadding="3" cellspacing="0">
  <tr>
  <td>
      <table width="100%" border="0" cellpadding="3" cellspacing="0" align="center" class="monographe">
        <tr class="head">
          <td width="13%" valign="middle"> <div align="center">Num&eacute;ro </div></td>
          <td width="14%" valign="middle">Date saisie</td>
          <td width="9%" valign="middle"> <div align="center">Mois</div></td>
          <td width="13%" height="20" valign="middle"> <div align="center"><strong>Ann&eacute;e</strong></div></td>
         <!-- <td width="20%" height="20" valign="middle"> <div align="center"><strong>Service</strong></div></td>-->
          <td width="31%" height="20" valign="middle"> <p align="center"><strong>Nombre(EVP)</strong></p></td>
    <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {
   %>
          <td>&nbsp;</td>
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
if(pazy2>tc.length){
  pazy2=tc.length;
}
%>
        <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr>
          <td><div align="center"><%=tc[i].getIdTrafic()%></div></td>
          <td><%=Utilitaire.formatterDaty(tc[i].getDaty())%></td>
          <td><div align="center"><%=Utilitaire.nbToMois(Utilitaire.stringToInt(Utilitaire.getMois(Utilitaire.formatterDaty(tc[i].getPeriodeDebut()))))%></div></td>
          <td><div align="center"><%=Utilitaire.getAnnee(Utilitaire.formatterDaty(tc[i].getPeriodeFin()))%></div></td>
          <!--<td><div align="center"></div></td>-->
          <td><div align="center"><%=(long)tc[i].getNombre()%></div></td>
      <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {
   %>
          <td><div align="center"><a href="javascript:decision('Vous voulez vraiment annuler ce trafic?\n\nCette opération supprimera définitivement le trafic du système.','<%=lien%>?but=facture/apresTraficEvp.jsp&idTrafic=<%=tc[i].getIdTrafic()%>&acte=ANNULE')">
              Annuler</a></div></td>
   <%
                }
                %>
        </tr>
        <%
}
%>
      </table>
</td>
</tr>
</table>
<table width="600" border="0" align="center" cellpadding="3" cellspacing="0">
        <tr>
          <td> <table width="100%" border="0" cellpadding="3" cellspacing="0" align="center" class="monographe">
              <tr>
                <td width="13%" valign="middle"> <div align="center"></div></td>
                <td width="14%" valign="middle">&nbsp;</td>
                <td width="9%" valign="middle"> <div align="center"></div></td>
                <td width="5%" height="20" valign="middle"> <div align="center"></div></td>
                <td width="28%" height="20" valign="middle"> <div align="center"><strong>Total
                    de la page : </strong></div></td>
                <td width="31%" height="20" valign="middle"> <p align="center"><%=AdminTrafic.calculSommeFactureIndice(tc,pazy1,pazy2)%>
                    EVP</p></td>
              </tr>
            </table></td>
        </tr>
      </table>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=tc.length%></td><td align="right"><%if(tc.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%if(tc.length%nbParPazy==0)out.println(tc.length/nbParPazy);else out.println(tc.length/nbParPazy+1);}%></td></tr>
   <tr>
    <td width="295" valign="middle" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=facture/listeTraficEvp.jsp&pazy=<%=pazy-1%>&mois1=<%=mois1%>&mois2=<%=mois2%>&annee1=<%=annee1%>&annee2=<%=annee2%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" valign="middle" align="right">
      <%
      if(tc.length>pazy2){
      %>
      <a href="<%=lien%>?but=facture/listeTraficEvp.jsp&pazy=<%=pazy%>&mois1=<%=mois1%>&mois2=<%=mois2%>&annee1=<%=annee1%>&annee2=<%=annee2%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>
