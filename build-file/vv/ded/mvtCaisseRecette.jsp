<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
 String apres="ded/apresMvtCaisse.jsp";
 String lien= null;
 UserEJB u = null;

 TypeObjet mp[] =null;
 TypeObjet tmvt[] =null;
 Caisse caiss[] = null;
 TypeObjet dev[] =null;
TypeObjet ag[] =null;
TypeObjet etablissement[] = null;
String nature = null;
String numPiece= null;
String numObjet=null;
String typeObjet = null;
String montantObjet= null;
String debit = null;
String credit = null;
OrdonnerPayement[] op=null;
String[] g=null;
OpUtil ou=null;
String designation;
     %>
<%


numObjet=request.getParameter("numObjet");
 typeObjet = request.getParameter("typeObjet");
 montantObjet= request.getParameter("montantObjet");
if(typeObjet.compareTo(Constante.getObjetOp())==0){
    debit = montantObjet;
    credit = "0";
}
else{
  debit = "0";
 credit = montantObjet;
}
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
g=Utilitaire.split(numObjet,"<br/>");
tmvt= u.findTypeObjet("typemvt","%","%");
mp = u.findTypeObjet("modepaiement","%","%");
caiss = u.findCaisse("%","%","%","%");
dev = u.findTypeObjet("Devise","%","%");
ag = u.findTypeObjet("Agence","%","%");
etablissement = u.findTypeObjet("etablissement", "%", "%");
ou=new OpUtil();
ou.setNomTable("orapayer");
designation="";
for(int j=0;j<g.length;j++){
   op=(OrdonnerPayement[])ou.rechercher(1,g[j]);
   designation+="-"+op[0].getRemarque()+"<br/>";
}

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>MOUVEMENT CAISSE Recette </h1>
<h2>&nbsp;</h2>


<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

          <tr>
            <td class="left">Date : <span class="remarque">*</span></td>
            <td align="center"> <input name="daty" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>">
&nbsp;            </td>
            <td align="center"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
                   <tr>
            <td class="left">Designation : <span class="remarque">*</span></td>
            <td align="center"><%=designation%><input name="designation" type="hidden" class="champ" id="designation" value="<%=designation%>"> </td>
            <td align="center">&nbsp;</td>
              </tr>
                    <tr>
            <td class="left">Credit : <span class="remarque">*</span></td>
            <td align="center"> <%=montantObjet%><input name="debit" type="hidden" class="champ" id="debit" value="<%=montantObjet%>"> <input name="credit" type="hidden" class="champ" id="credit2" value="<%=credit%>">
              </td>
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
              </select> </td>
            <td align="center">&nbsp;</td>
                  </tr>
                  <tr>
            <td class="left">Mode : <span class="remarque">*</span></td>
            <td align="center"> <select name="idMode" class="champ" id="idMode">

                <%
for(int i=0;i<mp.length;i++){
%>
                <option value="<%=mp[i].getId()%>"><%=mp[i].getVal()%></option>
                <%
}
%>
              </select> </td>
            <td align="center">&nbsp;</td>
                  </tr>
                   <tr>
            <td class="left">Caisse : <span class="remarque">*</span></td>
            <td align="center"> <select name="idCaisse" class="champ" id="idCaisse">

                <%
for(int i=0;i<caiss.length;i++){

%>
                <option value="<%=caiss[i].getIdCaisse()%>"><%=caiss[i].getDescCaisse()%></option>
                <%
}
%>
              </select> </td>
            <td align="center">&nbsp;</td>
              </tr>
                   <tr>
            <td class="left">Remarque : <span class="remarque">*</span></td>
            <td align="center"> <input name="remarque" type="text" class="champ" id="remarque" value=""> </td>
            <td align="center">&nbsp;</td>
              </tr>
              <tr>
            <td class="left">numero Pièce : <span class="remarque"></span></td>
            <td align="center"> <input name="numPiece" type="text" class="champ" id="numPiece" value="-"> </td>
            <td align="center">&nbsp;</td>
            </tr>
             <tr>
                 <td class="left">Etablissement : <span class="remarque">*</span></td>
                 <td align="center">
                     <select name="etablissement" class="champ" id="etablissement">
                 <%
                    for(int i=0;i<etablissement.length;i++){
                 %>
                      <option value="<%=etablissement[i].getId()%>" <%if(etablissement[i].getId().compareTo("ag006")==0) out.println("selected");%>><%=etablissement[i].getVal()%></option>
                 <%
                    }
                %>
                    </select>
                 </td>
                 <td align="center">&nbsp;</td>
              </tr>

            <tr>
            <td class="left">Agence : <span class="remarque">*</span></td>
            <td align="center"> <select name="agence" class="champ" id="agence">
              <%
for(int i=0;i<ag.length;i++){
%>
              <option value="<%=ag[i].getId()%>" <%if(ag[i].getId().compareTo("ag006")==0) out.println("selected");%>><%=ag[i].getVal()%></option>
              <%
}
%>
            </select> </td>
            <td align="center">&nbsp;</td>
              </tr>
          <tr>
            <td class="left">Tiers personne : <span class="remarque">*</span></td>
            <td align="center">              <input type="text" name="tiers" value=""/>&nbsp;
            </td>
            <td align="center"><input name="choix3" type="button" onClick="pagePopUp('ded/choix_tiers.jsp?champReturn=tiers')" value="..." class="submit">              </td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">



          <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
              <input name="nature" type="hidden" id="nature" value="<%=nature%>">
              <input name="numCheque" type="hidden" id="numCheque" value="-">
              <input name="typeMvt" type="hidden" value="1">
              <input name="typeObjet" type="hidden" id="typeObjet" value="OR">
              <input name="numObjet" type="hidden" id="numObjet" value="<%=numObjet%>">
              <input name="acte" type="hidden" id="acte" value="INSERT">
              <input type="submit" name="Submit" value="Enregistrer" class="submit">
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
       $(document).ready(function() {
         var mode = $("#idMode" ).val();
         if(mode != 'cheque'){
           $("#etablissement").attr('disabled', 'disabled');
         }
       });

       $("#idMode" ).change(function() {
         var optionSelected = $(this).find("option:selected");
         // var valueSelected  = optionSelected.val();
         var textSelected   = optionSelected.text();
         if(textSelected == 'cheque'){
           $("#etablissement").removeAttr('disabled');
         }else{
           $("#etablissement").attr('disabled', 'disabled');
         }
       });
</script>
  <span class="remarque">(*) Champs obligatoires</span></div>