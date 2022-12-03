<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="stock/apresMouvementEntreDepot.jsp";
  String lien= null;
  UserEJB u = null;
 TypeObjet cc[]= null;
 TypeObjet unite[] = null;
  String apresW=null;

 %>
<%


//u.findCompteComplet(String id, String val,string desc,String libelle);//Fait sortir la liste des compte de type magasin

%>
<%
  try{
   u=(UserEJB)session.getValue("u");
       lien=(String)session.getValue("lien");
    unite = u.findTypeObjet("UniteMvt","%","%");
cc = u.findTypeObjet("compte","%","%");
  // sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<script language="javascript">
function page(page_dest){
        document.location=page_dest;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Mouvement entre dépôt</h1>

<form name="form2" method="post" action="<%=lien%>?but=<%=apres%>">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
		<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
        <tr>
          <td width="144" height="23" valign="top" class="left">Date :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" class="champ" id="date" value="" size="10" maxlength="10">
 <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>

		           </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Designation :</td>
          <td valign="top">&nbsp; <input name="designation" type="text" class="champ" id="designation" value="" size="10" maxlength="10"></td>
        </tr>
        <tr>
          <td  height="23" valign="top" class="left">Quantité</td>
          <td valign="top">&nbsp; <input name="valeur" type="text" class="champ" id="valeur" value="" size="10" maxlength="10">
    unite <select name="unite">
                         <%
                  for(int i=0;i<unite.length;i++){
                  %>
  <option value="<%=unite[i].getId()%>"><%=unite[i].getVal()%></option>
  <%
                   }
                  %>
						</select>	  </td>
        </tr>
        <tr>
          <td  height="23" valign="top" class="left">Magasin  </td>
          <td valign="top">&nbsp; <select name="compte">
                         <%
                  for(int i=0;i<cc.length;i++){
                  %>
  <option value="<%=cc[i].getId()%>"><%=cc[i].getVal()%></option>
  <%
                   }
                  %>
						</select>		  </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Remarque :</td>
          <td valign="top">&nbsp; <textarea name="noteExplicative" cols="40" rows="5"></textarea></td>
        </tr>
      </table></td>
  </tr>
</table>


  <div align="center">



    <p>
     <input type="hidden" value="INSERT" name="acte">
      <input type="submit" class="submit" value="enregistrer">
    </p>
  </div>
</form>
<script language="JavaScript">
<!--dateParution
    var cal1 = new calendar1(document.all.date);
     cal1.year_scroll = false;
     cal1.time_comp = false;


     //-->
</script>