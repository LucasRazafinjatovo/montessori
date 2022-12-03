<%@page import="mg.vv.service.NouveauObjet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mg.vv.service.ImportService"%>
<%@page import="user.*" %>
<%@page import="utilitaire.*" %>
<%@page import="bean.*" %>
<%@page import="java.sql.SQLException" %>
<%@page import="affichage.*" %>

<%
    try {

        UserEJB u = null;
        String lien = null;
        u = (UserEJB) session.getValue("u");
        lien = (String) session.getValue("lien");
        int tailleExcel = 0, tailleTrouve = 0, tailleNonTrouve = 0;
        String optionType = "", num_ov = "";
        List<NouveauObjet> nouveauxObjets = new ArrayList();
        if (request.getParameter("optionTypes") != null) {
            nouveauxObjets = ImportService.importExcelFile(request, u.getUser());
            tailleNonTrouve = nouveauxObjets.size();
            tailleTrouve = ImportService.getTailleTrouve();
            tailleExcel = tailleTrouve + tailleNonTrouve;
        }
        //tailleExcel = Utilitaire.stringToInt((String) session.getAttribute("tailleExcel"));
%>

<div class="content-wrapper">
    <h1 align="center">Import Excel</h1>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title" color="#edb031">
                            <span color="#edb031" class="center">Import Excel Recette</span></h3>                        
                    </div>
                    <div class="box-body" style="display: block;">
                        <form action="<%=lien%>?but=import.jsp&optionTypes=in" method="POST" enctype="multipart/form-data">
                            <div id="UploadRCVirement">
                                <div class="form-group">
                                    <div id="ajout_ligne">
                                        <!--div class="col-md-3"-->
                                        <table>
                                            <tr>
                                                <td>
                                                    <label><b>FICHIER:</b></label>
                                                </td>
                                                <td>
                                                    <input type="file" value="Choisissez un fichier" name="excel" class="form-control" style="height: 30px;border: none;">
                                                </td>
                                            </tr>
                                            <!--/div-->
                                            <!--div class="col-md-3"-->
                                            <tr>   
                                                <td>
                                                    <label><b>DATE:</b></label>
                                                </td>
                                                <td>
                                                    <input type="text" value="<%= Utilitaire.dateDuJour()%>" name="dateImport" class="form-control" style="height: 30px; border: 1;">
                                                </td>
                                            </tr><!--/div-->

                                            <tr>
                                                <td></td>
                                                <td>
                                                    <input type="submit" class="submit" style="margin: 5px;" value="IMPORTER"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="bute" value="import.jsp">
                            <input type="hidden" name="acteType" value="retourPrestation">


                        </form>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row col-md-6 box">
                                    <div class="box-title with-border">
                                        <h4 class="box-title" style="margin-left: 10px">R&eacute;sultats: </h4>
                                    </div>
                                    <div class="box-body">
                                        <!--<form id="form-export" action="../download" method="post">-->
                                        <form id="form-export" action="download" method="POST">
                                            <input id="excel-input"  type="hidden" name="table" value = "">
                                            <input type="hidden" name="ext"  value="xls"  checked="checked">
                                            <input type="hidden" name="donnee" value="0" checked="checked">
                                            <input type="hidden" value="Exporter" class="btn btn-default">
                                        </form>
                                        Import&eacute; : <b><%= tailleExcel%></b>
                                        Trouv&eacute; : <b><%= tailleTrouve%></b>
                                        Non trouv&eacute; : <b><%= tailleNonTrouve%></b><button style="background-color: blue;margin: 5px; color: white;" class="btn btn-primary"  onclick="exporterCsv()"> Exporter non trouv&eacute;s</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</div>

<div id="selectnonee1"><!-- style="visibility: none;" -->
    <% if (nouveauxObjets.size() > 0) { %>
    <table id="target" class="table table-hover" width="100%" cellspacing="3" cellpadding="3" border="0" align="center">
        <tr>
            <td>Vendeur</td>
            <td>Journal</td>
            <td>Num parution</td>
            <td>Somme</td>
            <td>Motif</td>
        </tr>
        <% for (NouveauObjet nouveau : nouveauxObjets) {%>
        <tr>
            <td><%= nouveau.getIdvendeur()%></td>
            <td><%= nouveau.getJournal()%></td>
            <td><%= nouveau.getParution()%></td>
            <td><%= nouveau.getSomme()%></td>
            <td><%= nouveau.getMotif()%></td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>
<script type="text/javascript">
    function chargerExport() {
        var excelInput = document.getElementById("excel-input");
        excelInput.value = genererPageExcel();
    }
    function exporterCsv() {
        chargerExport();
        var form = $("#form-export");
        form.submit();
    }
    function genererPageExcel() {
        var rst = document.getElementById("selectnonee1").innerHTML;
        return rst;
    }
    var isChecked = false;
    function changerEtat() {
        document.droitmeress.submit();
    }
    function checkAll() {
        $(".choixOPDetails").prop("checked", !isChecked);
        isChecked = !isChecked;
    }
    function exporterXls() {
        var htmlToXls = document.getElementById("tableauNonTrouve").innerHTML;
        $("#htmlValue").val(htmlToXls);
        $("#extValue").val("xls");
        var form = $("#form-export");
        form.submit();
    }
    $(document).ready(function () {
        $("#actionOP").click(function () {
            //acteMarque.value='marquerRecu' ; 
            var checkedOP = $(".choixOPDetails:checked").length;
            //alert("length-- "+checkedOP);
            $("#acteMarque").val("marquerRecu");
            if (checkedOP > 0) {
                $("#formOp").submit();
            } else {
                alert("Veuillez selectionner un OP");
            }

        });
        $("#actionOPValider").click(function () {
            var checkedOP = $(".choixOPDetails:checked").length;
            $("#acteMarque").val("validerTous");
            if (checkedOP > 0) {
                $("#formOp").submit();
            } else {
                alert("Veuillez selectionner un OP");
            }
        });
    });
    function CocheTout(ref, name)
    {
        var form = ref;
        while (form.parentNode && form.nodeName.toLowerCase() != 'form') {
            form = form.parentNode;
        }

        var elements = form.getElementsByTagName('input');

        for (var i = 0; i < elements.length; i++) {
            if (elements[i].type == 'checkbox' && elements[i].name == name) {
                elements[i].checked = ref.checked;
            }
        }
    }
</script>
<% } catch (Exception e) {
        e.printStackTrace();
    }

%>