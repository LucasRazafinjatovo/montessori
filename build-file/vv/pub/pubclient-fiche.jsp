<%@page import="pub.PubClientLibelle"%>
<%@page import="pub.PubClientFille"%>
<%@page import="pub.PubClient"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    PubClient pC;
%>
<%
    pC = new PubClient();
    PageConsulte pc = new PageConsulte(pC, request, (user.UserEJB) session.getValue("u"));
    pc.setTitre("Fiche pub client");
    String id=request.getParameter("id");
    String lien = (String) session.getValue("lien");
    PubClientLibelle fille = new PubClientLibelle();
    PubClientLibelle[] listeF = (PubClientLibelle[]) CGenUtil.rechercher(fille, null, null, " and id='"+id+"'");
%>
<html>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%
out.println(pc.getHtml());
%>

<a href="<%=lien%>?but=pub/pubclient-modif.jsp&id=<%=id%>"> Modifier</a>
<a href="<%=lien%>?but=&id=<%=id%>">facturation</a>
<table>
    <table id="table" border="1">
                <thead>
                    <tr>
                        <th style='background-color:#FFFFFF' colspan="7"><h3 class="box-title" style="text-align: center;">Liste pub client fille</h3>
                </th>
                </tr>
                <tr>
                    <th style='background-color:#0099FF'>ID</th>
                    <th style='background-color:#0099FF'>Nom pub</th>
                    <th style='background-color:#0099FF'>ref</th>
                    <th style='background-color:#0099FF'>Duree</th>
                    <th style='background-color:#0099FF'>Type</th>
                    <th style='background-color:#0099FF'>Plage</th>
                    <th style='background-color:#0099FF'>Date debut diffusion</th>
                      <th style='background-color:#0099FF'>Date fin diffusion</th>
                      <th style='background-color:#0099FF'>Quantite</th>
                      <th style='background-color:#0099FF'>Remarques</th>
                </tr>

                </thead>
                <tbody id="container-tab-compte">
                    <% if (listeF!=null && listeF.length>0){%>
                    <% for (int i = 0; i < listeF.length; i++) {

                    %>  

                    <tr>   
                        
                        <td><% out.print(listeF[i].getId());%></td>
                        <td><%out.print(listeF[i].getNom_pub());%></td>
                        <td><%out.print(Utilitaire.champNull(listeF[i].getRef()));%></td>
                        <td><%out.print(listeF[i].getDuree());%></td>
                        <td><%out.print(Utilitaire.champNull(listeF[i].getIdtype()));%></td>
                        <td><%out.print(Utilitaire.champNull(listeF[i].getIdplage()));%></td>
                        <td><%out.print(Utilitaire.formatterDaty(listeF[i].getDate_debut_diff()));%></td>
                        <td><%out.print(Utilitaire.formatterDaty(listeF[i].getDate_fin_diff()));%></td>
                        <td><%out.print(listeF[i].getQte());%></td>
                         <td><%out.print(Utilitaire.champNull(listeF[i].getRemarques()));%></td>
                    </tr>

                    <%/*System.out.println(lgrl[i].getId());*/
                    }
                        }%>                      
                </tbody>
            </table>
</table>
</html>