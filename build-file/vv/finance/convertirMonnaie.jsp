<%@page import="user.*" %>
<%@page import="bean.*" %>
<%@page import="utilitaire.*" %>
<%@page import="facture.*" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/convertirMonnaie.jsp";
        String lien= null;
        UserEJB u = null;
        String valeur= null;
        String devise1=null;
        String devise2=null;
        String daty = null;
	double rapport;
        TypeObjet dev[] = null;
	String val;
%>
<%
devise1=request.getParameter("devise1");
devise2=request.getParameter("devise2");
valeur=request.getParameter("valeur");
daty = request.getParameter("daty");
if(valeur==null)valeur="1";
if(devise1==null)devise1="Ar";
if(devise2==null)devise2="Ar";
if(daty==null)daty=Utilitaire.dateDuJour();
//valeur=Utilitaire.stringToDouble(val);
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
dev=u.findTypeObjet("Devise","%","%");

/*Change ch1=null;
Change ch2=null;
ch1=(Change)new ChangeUtil().loadChangeValide(devise1,Utilitaire.dateDuJour());
ch2=(Change)new ChangeUtil().loadChangeValide(devise2,Utilitaire.dateDuJour());
rapport=ch1.getValeurEnAriary()/ch2.getValeurEnAriary();*/
rapport=u.calculChange(valeur,devise1,devise2,daty);

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<form action="<%=lien%>?but=finance/convertirMonnaie.jsp" method="POST" name="convertir">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td align="center" valign="top"><div align="left">Date du cours :
              </div></td>
            <td align="center"><input name="daty" type="text" id="daty" value="<%=daty%>">
              <span class="remarque"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></span>
            </td>
          </tr>
          <tr>
            <td width="54%" align="center" valign="top"> <div align="left">Montant
                :
                <input name="valeur" type="text" class="champ"  value=<%=valeur%>>
              </div></td>
            <td width="46%" align="center">en
              <select name="devise1" class="champ" id="devise1">
                <%
  for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>" <%if(dev[i].getId().compareTo("fmg")==0)out.println("selected");%>><%=dev[i].getVal()%></option>
                <%
  }
%>
              </select> </td>
          </tr>
          <tr align="center" valign="top">
            <td><div align="left">Convertir en :</div></td>
            <td> <select name="devise2" class="champ" id="devise2">
                <%
  for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>" <%if(dev[i].getId().compareTo("Ar")==0)out.println("selected");%>><%=dev[i].getVal()%></option>
                <%
  }
%>
              </select> </td>
          </tr>
        </table></td>
  </tr>
  <tr>
    <td height="30"><div align="center">
          <input type="submit" name="Submit" value="Convertir" class="submit" onClick="MM_validateForm('valeur','','RisNum');return document.MM_returnValue">
        </div>
        <div align="center"></div></td>
  </tr>
</table>
</form>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="3" cellspacing="0" class="monographe">
        <tr>
          <td width="54%" align="center" valign="top"> <div align="center"><%=valeur%> <%=devise1%> = <%=Utilitaire.formaterAr((double)rapport)%> <%=devise2%> </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<script language="">
var cal1 = new calendar1(document.forms['convertir'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
