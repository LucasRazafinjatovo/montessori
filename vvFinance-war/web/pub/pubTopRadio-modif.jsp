<%@page import="pub.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
PubType[] listePT = (PubType[]) CGenUtil.rechercher(new PubType(), null, null, " ");
TypeObjet crt=new TypeObjet();
crt.setNomTable("sous_plage_horaire");
TypeObjet sousPH[]=(TypeObjet [])CGenUtil.rechercher(crt, null, null, "");
PubPlageHoraire listePH[]=(PubPlageHoraire [])CGenUtil.rechercher(new PubPlageHoraire() , null, null, " " );
String lien=(String)session.getValue("lien");
String apres="pub/apresTarif.jsp";
String plage_horaire=request.getParameter("plage_horaire");
String sous_palge_horaire=request.getParameter("sous_palge_horaire");
String typee=request.getParameter("typee");
String id=request.getParameter("id");
PubTopRadio [] listePub=(PubTopRadio[])CGenUtil.rechercher(new PubTopRadio(), null, null, " and id='"+id+"'");
System.out.println("date"+listePub[0].getDate_debut());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Document sans nom</title>
<link href="style/style.css" rel="stylesheet" type="text/css">
</head>

<body>

  <h1>Modification Publicite</h1>
<center>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="pub" id="pub" target="_parent">
<%if(listePub!=null && listePub.length>0){%>
  <table width="376" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <tr>
      <td class="left">Client:</td>
      <td colspan="4"><input type="text" name="nom_client" class="champ" value="<%=listePub[0].getNom_client()%>">
      <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/clientChoix.jsp?champReturn=nom_client')">...</button></td>
    </tr>
    <tr>
      <td class="left">Nom Campagne:</td>
      <td colspan="4"><input type="text" name="nom_campagne" class="champ" value="<%=listePub[0].getNom_campagne()%>">
       </td>
    </tr>
    <tr>
      <td class="left">Type :</td>
      <td colspan="4"><select name="typee" size="1" class="champ">
<%
for(int i=0;i<listePT.length;i++)
{
  %>
<option value="<%=listePT[i].getId()%>"<% if(listePub[0].getTypee().compareTo(listePT[i].getId())==0) out.print("selected"); %>><%=listePT[i].getDesignation() %></option>
  <%
}
%>      </select>
     </td>
<td></td>
    </tr>
    <tr>
      <td class="left">Duree:</td>
      <td colspan="4"><select name="duree"size="1" class="champ">
              <option value="<%=listePub[0].getDuree()%>" selected="selected"><%=listePub[0].getDuree()%></option>
        <option value="10">10</option>
        <option value="20">20</option>
        <option value="30">30</option>
        <option value="autre">Autre</option>
      </select></td><td>
     </td>
    </tr>
    <tr>
      <td class="left">Date debut diffusion:</td>
      <td colspan="4"><input type="text" name="date_debut" value="<%=listePub[0].getDate_debut()%>" class="champ">
      </td>
    </tr>
        <tr>
      <td class="left">Date fin diffusion: </td>
      <td colspan="4"><input type="text" name="date_fin" class="champ" value="<%=listePub[0].getDate_fin()%>"></td>
    </tr>
       <tr>
      <td class="left">Reference: </td>
      <td colspan="4"><input type="text" name="reference_pub" class="champ" value="<%=listePub[0].getReference_pub()%>"></td>
    </tr>
    <tr>
      <td class="left">Confection pub: </td>
      <td colspan="4"><input type="text" name="confection_pub" class="champ" value="<%=listePub[0].getConfection_pub()%>"></td>
    </tr>
	<tr>
      <td class="left">Plage horaire</td>
      <td colspan="4"><select name="plage_horaire" id="plage_horaire" class="champ" onchange="afficherSousPlageHoraire()">
<%
for(int i=0;i<listePH.length;i++)
{
  %>
<option value="<%=listePH[i].getId()%>" <% if(listePub[0].getPlage_horaire().compareTo(listePH[i].getId())==0) out.print("selected"); %>><%=listePH[i].getDesignation()%></option>
  <%
}
%>
      </select>
     </td>
    </tr>
    <tr id="sous_plage" style="visibility:hidden" >
      <td class="left" >Sous Plage horaire:</td>
      <td colspan="4" ><select name="sous_palge_horaire" id="sous_palge_horaire" class="champ">
<%
for(int i=0;i<sousPH.length;i++)
{
  %>
<option value="<%=sousPH[i].getId()%>" <% if(sous_palge_horaire!=null && sous_palge_horaire.compareTo(sousPH[i].getId())==0) out.print("selected"); %>><%=sousPH[i].getVal() %></option>
  <%
}
%>
      </select>
      </td>
    </tr>
  </table>
      <%}%>
  <p>&nbsp;</p>
  <table width="374" border="0">
  <tr>
      <input type="hidden" name="acte" value="update">
         <input name="classe" type="hidden" id="classe" value="pub.PubTopRadio">
          <input type="hidden" name="bute" value="pub/pubradio-fiche.jsp">
    <td><input type="submit" name="Submit" value="Valider" class="submit" /></td>

    <td><input type="reset" name="Submit2" value="Annuler" class="submit"></td>
  </tr>
</table>
</form>
</center>
<p align="center">
  <label></label>
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
      <script> 
          function afficherSousPlageHoraire(){
        var e = document.getElementById("plage_horaire");
        var strUser = e.options[e.selectedIndex].text;
        if(strUser==="TOP HORAIRE"){
            
                document.getElementById("sous_plage").style.visibility='visible';
        }
        else
        {
           
             document.getElementById("sous_plage").style.visibility='hidden';
        }
    } 
      </script>