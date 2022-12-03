<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!


  String apres="ded/visualiserOrdonner.jsp";
  String lien= null;
  UserEJB u = null;
String action = null;
 Utilitaire utilitR=new Utilitaire();
OrdonnerPayement[] op = null;
   String idDED,designation, dateDebut, dateFin,idLigne,id;
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
                   action = request.getParameter("action");if ((action==null)||action.compareTo("")==0) action="ordonnerPayement.jsp";

 id=request.getParameter("id");if ((id==null)||id.compareTo("")==0) id="%";
                        idLigne=request.getParameter("idLigne");if ((idLigne==null)||idLigne.compareTo("")==0) idLigne="%";
                        idDED=request.getParameter("idDED");if ((idDED==null)||idDED.compareTo("")==0) idDED="%";
//OrdonnerPayement[] findOp(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem)
                         op = u.findOp(id,idDED,idLigne,dateDebut, dateFin,"%","%","%");


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
<h1>Lister les Ordes Payement </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les ordres de payement)</p>
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
          <td class="left">id DED </td>
          <td align="center">
<input name="idDED" type="text" class="champ"   id="idDED" value="<%=idDED%>"size="10" maxlength="10" /> </td>
          <td class="left">id Ligne </td>
          <td align="center"><input name="idLigne" type="text" class="champ"   id="idLigne" value="<%=idLigne%>" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /></td>
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
      <p align="center"><strong><u>LISTE</u></strong></p>
	  
	  <form action="<%=lien%>?but=<%=action%>" method="post">

     <input name="typeObjet" type="hidden" value="<%=Constante.getObjetFactureF()%>"> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">

          <td width="66" align="center" valign="top">Date</td>
                   <td width="153" align="right" valign="top"><div align="center">id Ded </div></td>
          <td width="153" align="right" valign="top"><div align="center">id Ligne </div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant </strong></div></td>
  <td width="102" align="center" valign="top">Remarque</td>
  <td width="102" align="center" valign="top">etat</td>
                            <td width="102" align="center" valign="top">Choix</td>

        </tr>
        <%
  for(int i=0;i<op.length;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">

          <td align="center"><%=utilitR.formatterDaty(op[i].getDaty())%></td>
          <td align="right"><%=op[i].getIdDed()%></td>
                  <td align="center"><%=op[i].getIdLigne()%></td>
          <td align="right"><%=utilitR.formaterAr((double)op[i].getMontant())%></td>
          <td align="center"><%=utilitR.formaterAr(op[i].getRemarque()) %></td>
		  <td align="center"><%=utilitR.formaterAr(op[i].getEtat()) %></td>
    <input type="hidden" name="nombre">
                  <td align="center">

<input name="indice" type="radio" id="numObjet" value="<%=i%>" onClick="nombre.value=<%=i%>">
<input type="hidden" name="numObjet<%=i%>" value="<%=op[i].getId()%>">
<input type="hidden" name="montantObjet<%=i%>" value="<%=op[i].getMontant()%>">
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
