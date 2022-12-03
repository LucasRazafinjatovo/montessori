<%@page import="pub.PubClientFille"%>
<%@page import="pub.PubClient"%>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<%
    String lien=(String)session.getValue("lien");
    String id=request.getParameter("id");
    PubClient mere []=(PubClient[])CGenUtil.rechercher(new PubClient(), null, null, " and id='"+id+"'");
    PubClientFille[] listeF = (PubClientFille[]) CGenUtil.rechercher(new PubClientFille(), null, null, " and mere='"+id+"'");
%>
<form action="<%=lien%>?but=pub/apresPubClient.jsp" method="post" id="mere"> 
    
        <section>
            <h1>Client mere</h1>
        </section>
            
             <table>
                 <%if(mere!=null && mere.length>0){%>
                 <tr>
                      <th><label for='client' tabindex='1'>Client: </label></th>
                      <td> <input name="client" type="text" value="<%=mere[0].getClient()%>"></td>
                     <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/clientChoix.jsp?champReturn=client')">...</button></td>
                                           
                 </tr>
                 <tr>
                      <th><label for='nom_compagne' tabindex='1'>Nom compagne:  </label></th>
                      <td><input name="nom_compagne" type="text" value="<%=mere[0].getNom_compagne()%>"></td>
                 </tr>
                 <% }
                 else{%>
                 <tr>
                      <th><label for='client' tabindex='1'>Client: </label></th>
                      <td> <input name="client" type="text" value=""></td>
                     <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/clientChoix.jsp?champReturn=client')">...</button></td>
                                           
                 </tr>
                 <tr>
                      <th><label for='nom_compagne' tabindex='1'>Nom compagne:  </label></th>
                      <td><input name="nom_compagne" type="text" value=""></td>
                 </tr>
                 <%}%>
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
                                    <%if(listeF!=null && listeF.length >0){%>
                                    <% for (int i = 0; i < listeF.length; i++) {%>
                                    <tr>
                                        <td>
                                                                         
                                                <input  id="nom_pub_<%=i + 1%>" name="nom_pub_<%=i + 1%>" type="text" value="<%=listeF[i].getNom_pub()%>">
                                        </td>
                                        <td>
                                             <input  id="ref_<%=i + 1%>" name="ref_<%=i + 1%>" type="text" value="<%=listeF[i].getRef()%>">
                                        </td>
                                        <td>
                                            <input  id="duree_<%=i + 1%>" name="duree_<%=i + 1%>" type="text" value="<%=listeF[i].getDuree()%>">
                                        </td>
                                        <td><input type="text" id="idtype_<%=i + 1%>"  name="idtype_<%=i + 1%>" value="<%=listeF[i].getIdtype()%>"></td>
                                        <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/typeChoix.jsp?champReturn=idtype_<%=i + 1%>')">...</button></td>
                                        <td><input type="text" id="idplage_<%=i + 1%>"  name="idplage_<%=i + 1%>" value="<%=listeF[i].getIdplage()%>"></td>
                                        <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/plageChoix.jsp?champReturn=idplage_<%=i + 1%>')">...</button></td>
                                        <td><input type="text" id="date_debut_diff_<%=i + 1%>"  name="date_debut_diff_<%=i + 1%>" value="<%=listeF[i].getDate_debut_diff()%>"></td>
                                        <td><input type="text" id="date_fin_diff_<%=i + 1%>"  name="date_fin_diff_<%=i + 1%>" value="<%=listeF[i].getDate_fin_diff()%>"></td>
                                        <td><input type="text" id="qte_<%=i + 1%>"  name="qte_<%=i + 1%>" value="<%=listeF[i].getQte()%>"></td>
                                        <td><input type="text" id="remarques_<%=i + 1%>"  name="remarques_<%=i + 1%>" value="<%=listeF[i].getRemarques()%>"></td>
                                </tr>
                                <% }}else{%>
                                 <% for (int i = 0; i < 10; i++) {%>
                                <tr>
                                        <td>
                                                                         
                                                <input  id="nom_pub_<%=i + 1%>" name="nom_pub_<%=i + 1%>" type="text">
                                        </td>
                                        <td>
                                             <input  id="ref_<%=i + 1%>" name="ref_<%=i + 1%>" type="text">
                                        </td>
                                        <td>
                                            <input  id="duree_<%=i + 1%>" name="duree_<%=i + 1%>" type="text">
                                        </td>
                                        <td><input type="text" id="idtype_<%=i + 1%>"  name="idtype_<%=i + 1%>"></td>
                                        <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/typeChoix.jsp?champReturn=idtype_<%=i + 1%>')">...</button></td>
                                        <td><input type="text" id="idplage_<%=i + 1%>"  name="idplage_<%=i + 1%>"></td>
                                        <td><button class="btn btn-default btn-sm" type="button" onclick="pagePopUp('pub/plageChoix.jsp?champReturn=idplage_<%=i + 1%>')">...</button></td>
                                        <td><input type="text" id="date_debut_diff_<%=i + 1%>"  name="date_debut_diff_<%=i + 1%>"></td>
                                        <td><input type="text" id="date_fin_diff_<%=i + 1%>"  name="date_fin_diff_<%=i + 1%>"></td>
                                        <td><input type="text" id="qte_<%=i + 1%>"  name="qte_<%=i + 1%>"></td>
                                        <td><input type="text" id="remarques_<%=i + 1%>"  name="remarques_<%=i + 1%>"></td>
                                </tr>
                                <% }
                                   }
                                %>
                                </tbody>
                            </table>
    <input type="hidden" name="acte" value="updatePubClient"/>
    <input type="hidden" name="bute" value="pub/pubclient-fiche.jsp"/>
    <input type="hidden" name="classe" value=""/>
    <button class="btn btn-primary" type="submit">Modifier</button>
    <input id="nbrLigne" name="nbrLigne" type="hidden" value="10">  
</form>

