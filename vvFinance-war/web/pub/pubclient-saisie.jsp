<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String lien=(String)session.getValue("lien");
%>
<form action="<%=lien%>?but=pub/apresPubClient.jsp" method="post" id="mere"> 

    <section>
        <h1>Client mere</h1>
    </section>

    <table>
        <tr>
            <th><label for='client' tabindex='1'>Client: </label></th>
            <td> <input name="client" type="text"></td>
            <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/clientChoix.jsp?champReturn=client')">...</button></td>

        </tr>
        <tr>
            <th><label for='nom_compagne' tabindex='1'>Nom compagne:  </label></th>
            <td><input name="nom_compagne" type="text"></td>
        </tr>
    </table>
    <section>
        <h1>Client Fille</h1>
    </section>
    <table class="table table-bordered table-condensed">
        <thead>
            <tr>
                <th>Nom Pub</th>
                <th>Reference</th>
                <th>Duree</th>
                <th>type</th>
                <th></th>
                <th>Plage</th>
                <th></th>
                <th>Date debut diffusion</th>
                <th>Date fin diffusion</th>
                <th>Quantite</th>
                <th>Remarques</th>
            </tr>
        </thead>


        <tbody  id="ajout_ligne">

            <% for (int i = 0; i < 10; i++) {%>
            <tr>
                <td>

                    <input  id="nom_pub_<%=i + 1%>" name="nom_pub" type="text">
                </td>
                <td>
                    <input  id="ref_<%=i + 1%>" name="ref_pub" type="text">
                </td>
                <td>
                    <input  id="duree_<%=i + 1%>" name="duree" type="text">
                </td>
                <td><input type="text" id="idtype_<%=i + 1%>"  name="idtype"></td>
                <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/typeChoix.jsp?champReturn=idtype_<%=i + 1%>')">...</button></td>
                <td><input type="text" id="idplage_<%=i + 1%>"  name="idplage"></td>
                <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/plageChoix.jsp?champReturn=idplage_<%=i + 1%>')">...</button></td>
                <td><input type="text" id="date_debut_diff_<%=i + 1%>"  name="date_debut_diff"></td>
                <td><input type="text" id="date_fin_diff_<%=i + 1%>"  name="date_fin_diff"></td>
                <td><input type="text" id="qte_<%=i + 1%>"  name="qte_<%=i + 1%>"></td>
                <td><input type="text" id="remarques_<%=i + 1%>"  name="remarques_<%=i + 1%>"></td>
            </tr>
            <% }%>
        </tbody>
    </table>
    <input type="hidden" name="acte" value="insertPubClient"/>
    <input type="hidden" name="bute" value="pub/pubclient-liste.jsp"/>
    <input type="hidden" name="classe" value=""/>
    <input type="hidden" name="rajoutLien" value="id"/>
    <button class="btn btn-primary" type="submit">Enregistrer</button>
    <input id="nbrLigne" name="nbrLigne" type="hidden" value="10">  
</form>
