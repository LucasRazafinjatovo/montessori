<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="finance/listeEtatFacture.jsp";
	String lien="modele.jsp";
	String valeur="";
	user.UserEJB u=null;
	String client,daty1,daty2,etat;
	String codeProduit;
	String numFact=null;
	facture.EtatFacture[] fac=null;
	bean.TypeObjet dev[]=null;
        facture.SCatService[] sctserv=null;
        String idType=null;
        String entite=null;
        bean.TypeObjet enti[] =null;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//String num, String numFact, String client, String prod, String daty1, String daty2
numFact=request.getParameter("numFact");
client=request.getParameter("client");
daty1=request.getParameter("daty1");
daty2=request.getParameter("daty2");
etat=request.getParameter("etat");
idType=request.getParameter("idType");

if ((numFact==null)||numFact.compareTo("")==0) numFact="%";
if ((idType==null)||idType.compareTo("")==0) idType="%";
if ((client==null)||client.compareTo("")==0) client="%";
if ((daty1==null)||daty1.compareTo("")==0) daty1="";
if ((daty2==null)||daty2.compareTo("")==0) daty2="";
if ((etat==null)||etat.compareTo("")==0) etat="";
         entite=request.getParameter("entite");
          if ((entite==null)|| entite.compareTo("")==0) entite="%";
          dev = u.findTypeObjet("Devise","%","%");
enti = u.findTypeObjet("BENEFICIAIRE","%","%");
sctserv = u.findSCatService("%", "%", "%", "%");
//fac=u.findEtatFacture(numFact,daty1,daty2,etat,client);
%>
 
<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>LISTE DES FACTURES</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" name="etatFact">
  <table width="600" border="0" cellpadding="0">

  <tr>
      <td class="tuple-tableau"> <div align="left">
          <p><span class="remarque">&gt;&gt; Vous pouvez afficher la liste des
            factures selon les crit&egrave;res suivantes : </span><br>
            <span class="remarque">(*) Pour faire une recherche des factures r&eacute;alis&eacute;es
            entre deux dates, remplir les champs &quot;Date d&eacute;but&quot;
            et &quot;Date fin&quot;</span></p>
          <p><span class="remarque"><br>
            </span></p>
        </div></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
          <tr>
            <td width="249" height="24" class="left"> <div align="right">Date
                d&eacute;but :</div></td>
            <td width="189" align="center"><input name="daty1" type="text" class="champ" id="daty13">&nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td width="189" class="left"><div align="right">Date fin :</div></td>
            <td width="189"><div align="center">
                <input name="daty2" type="text" class="champ" id="daty22">&nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </div></td>
          </tr>
          <tr>
            <td height="24" class="left"> <div align="right">Nom du client : </div></td>
            <td align="center"><input name="client" type="text" class="champ" id="client2">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
            <td class="left"><div align="right">N&deg; Facture :</div></td>
            <td><div align="center">
                <input name="numFact" type="text" class="champ" id="numFact">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>
          <tr>
            <td height="24" class="left"> <div align="right">Etat de paiement :</div></td>
            <td align="center"><select name="etat" class="champ" id="select3">
			 <option value="tous">tous</option>
                <option value="oui">Paye</option>
                <option value="non">Impaye</option>
                </select>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
            <td class="left"><div align="right">Agence :</div></td>
            <td align="center">
                <input name="agence" type="text" class="champ" id="agence" value="%">&nbsp;
            <img src="images/blank.gif" width="16" height="16" align="absmiddle">
			</td>
          </tr>
          <tr>
            <td height="24" class="left"><div align="right">Type :</div></td>
            <td align="center"> <select name="idType" class="champ"  id="idType">
            <option value="%" <%if(idType.compareTo("%")==0)out.println("selected");%>>tous</option>
                <%
          for(int i=0;i<sctserv.length;i++){
            if(sctserv[i].getIdCategorie().compareTo("cat2") != 0){
          %>
                <option value="<%=sctserv[i].getIdScatService()%>" <%if(sctserv[i].getIdScatService().compareTo(idType)==0)out.println("selected");%>><%=sctserv[i].getNomSCatService()%></option>
                <%
            }
          }
                %>
              </select>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
             <td class="left">Entité :</td>
            <td><select name="entite" class="champ" id="entite">
                <option value="%" <%if(entite.compareTo("%")==0) out.println("selected");%>>Tous</option>
                <%
                  for(int i=0;i<enti.length;i++){
%>
                <option value="<%=enti[i].getId()%>" <%if(enti[i].getId().compareTo(entite)==0) out.println("selected");%>><%=enti[i].getVal()%></option>
                <%
                  }
%>
              </select>
            </td>
          </tr>
          <tr>
            <td height="24" class="left"> <div align="right">Parution :</div></td>
            <td align="center"><input name="parution" type="text" class="champ" id="parution" value="%">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
            <td class="left">&nbsp;</td>
            <td align="center">&nbsp;
                        </td>
          </tr>
        </table></td>
  </tr>
  <tr>
    <td align="center">
<table width="75%" height="40" border="0" cellpadding="0">
          <tr>
            <td align="center">

  <input name="numFact" type="hidden" id="numFact" value="<%=numFact%>">
                <input name="Submit" type="submit" class="submit" value="Afficher">
             </td>
            <td align="center"> <input name="Submit2" type="reset" class="submit" value="Annuler">
            </td>
          </tr>
          <tr>
            <td colspan="2" class="tuple-tableau"> <div align="left">
                <script language="javascript">
var cal1 = new calendar1(document.forms['etatFact'].elements['daty1']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['etatFact'].elements['daty2']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>          </div></td>
          </tr>
        </table>
</td></tr></Table>

</form></body>
</html>
