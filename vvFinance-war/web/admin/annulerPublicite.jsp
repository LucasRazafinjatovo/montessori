<%
    String lien = (String) session.getValue("lien");
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Annuler publicité</h1>
    </section>
    <section class="content">
        <center>  </center>

        <div class="row col-md-12">


            <div class="box box-primary listTableau">
                <div class="box-header">
                    <h3 class="box-title" align="center"></h3>
                </div>
                <div class="box-body table-responsive no-padding">
                    <div id="selectnonee">
                        <!--<form method="POST" class="col-md-offset-3 col-md-6" action="module.jsp?but=acte/demande-suiv-saisie.jsp">-->
                        <form method="POST" class="col-md-offset-3 col-md-6" action="<%=lien%>?but=admin/apresTarif.jsp">

                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th><label for="zone" tabindex="1">IdPublicite:</label></th>
                                        <td>
                                            <input type="text" name="idPublicite" />
                                            <!--<input name="choix" class="submit" style="margin-left: 5px;" onclick="pagePopUp('<%= lien%>?but=popup.jsp?but=facture/listeChoixFacture.jsp&amp;champReturn=idFactureClient;&amp;apresLienPageAppel=admin/annulerFactureClient.jsp')" value="..." type="button">-->
                                            <input name="choix" class="submit" style="margin-left: 5px;" onclick="pagePopUp('ded/listeChoixPublicite.jsp?champReturn=idPublicite&apresLienPageAppel=admin/annulerPublicite.jsp')" value="..." type="button">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="box-footer" style="display: block;">
                                <div class="row col-md-12">

                                    <input type="hidden" name="acte" value="annulerPub">
                                    <input type="submit" class="btn btn-success pull-right" id="btnListe" value="Annuler" />
                                </div>
                            </div>
                        </form>         
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>