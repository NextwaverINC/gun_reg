<%@ Page Language="VB" AutoEventWireup="false" CodeFile="addStandardCode.aspx.vb" Inherits="gunbook_addStandardCode" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>Tables - Ace Admin</title>

    <meta name="description" content="Static &amp; Dynamic Tables" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="../assets/css/bootstrap.css" />
    <link rel="stylesheet" href="../assets/css/font-awesome.css" />

    <!-- page specific plugin styles -->

    <!-- text fonts -->
    <link rel="stylesheet" href="../assets/css/ace-fonts.css" />

    <!-- ace styles -->
    <link rel="stylesheet" href="../assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

    <!--[if lte IE 9]>
			<link rel="stylesheet" href="../assets/css/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->

    <!--[if lte IE 9]>
		  <link rel="stylesheet" href="../assets/css/ace-ie.css" />
		<![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->
    <script src="../assets/js/ace-extra.js"></script>

    <script src="../Scripts/angular.min.js"></script>
    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

    <!--[if lte IE 8]>
		<script src="../assets/js/html5shiv.js"></script>
		<script src="../assets/js/respond.js"></script>
		<![endif]-->
</head>

<body class="no-skin" style="background-color: white">
    <!-- #section:basics/navbar.layout -->
    <form id="form1" runat="server">
        <div id="mainApp" ng-app="myApp" ng-controller="StartApp">
            <div class="widget-box transparent" id="widget-box-2">
                <div class="widget-body">
                    <div class="row">
                        <div class="col-xs-12" style="margin: 0px 0px 10px 0px">
                            <div class="col-xs-10">
                                <div class=" col-xs-12" style="padding-bottom: 5px;">
                                    <div class="form-group">
                                        <div class="col-xs-4">
                                            <p class="text-right"><strong>ข้อมูล :</strong></p>
                                        </div>
                                        <div class="col-xs-8">
                                            <input type="text" class="form-control" ng-model="dataStandard.dataname" style="width: 100%" />
                                        </div>
                                    </div>
                                </div>
                                <div class=" col-xs-12">
                                    <div class="form-group">
                                        <div class="col-xs-4">
                                            <p class="text-right"><strong>รายละเอียด :</strong></p>
                                        </div>
                                        <div class="col-xs-8">
                                            <textarea ng-model="dataStandard.datadesc" class="form-control" rows="5"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-2">
                                <a class="btn btn-success btn-xs" ng-click="fnSave()" data-dismiss="modal">
                                    <i class="ace-icon fa fa-plus bigger-110"></i>&nbsp;&nbsp;เพิ่มข้อมูล
                                </a>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <label id="ERROR" style="color: red"></label>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div id="loading" style="display: none; margin-top: 50px">
            <center>
                <h1 class="bigger"><i class="ace-icon fa fa-spinner fa-spin orange"></i></h1>
                <h3>                    
                    อยู่ระหว่างประมวลผลโปรดรอ...
                </h3>
            </center>
        </div>
    </form>
    <!-- basic scripts -->

    <!--[if !IE]> -->
    <script src="../assets/js/jquery.js"></script>

    <!-- <![endif]-->

    <!--[if IE]>
<script src="../assets/js/jquery1x.js"></script>
<![endif]-->
    <script type="text/javascript">
        if ('ontouchstart' in document.documentElement) document.write("<script src='../assets/js/jquery.mobile.custom.js'>" + "<" + "/script>");
    </script>
    <script src="../assets/js/bootstrap.js"></script>

    <!-- page specific plugin scripts -->
    <script src="../assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="../assets/js/dataTables/jquery.dataTables.bootstrap.js"></script>
    <script src="../assets/js/bootbox.js"></script>
    <script src="../assets/js/dataTables/extensions/Buttons/js/dataTables.buttons.js"></script>
    <script src="../assets/js/dataTables/extensions/Buttons/js/buttons.flash.js"></script>
    <script src="../assets/js/dataTables/extensions/Buttons/js/buttons.html5.js"></script>
    <script src="../assets/js/dataTables/extensions/Buttons/js/buttons.print.js"></script>
    <script src="../assets/js/dataTables/extensions/Buttons/js/buttons.colVis.js"></script>
    <script src="../assets/js/dataTables/extensions/Select/js/dataTables.select.js"></script>

    <!-- ace scripts -->
    <script src="../assets/js/ace/elements.scroller.js"></script>
    <script src="../assets/js/ace/elements.colorpicker.js"></script>
    <script src="../assets/js/ace/elements.fileinput.js"></script>
    <script src="../assets/js/ace/elements.typeahead.js"></script>
    <script src="../assets/js/ace/elements.wysiwyg.js"></script>
    <script src="../assets/js/ace/elements.spinner.js"></script>
    <script src="../assets/js/ace/elements.treeview.js"></script>
    <script src="../assets/js/ace/elements.wizard.js"></script>
    <script src="../assets/js/ace/elements.aside.js"></script>
    <script src="../assets/js/ace/ace.js"></script>
    <script src="../assets/js/ace/ace.ajax-content.js"></script>
    <script src="../assets/js/ace/ace.touch-drag.js"></script>
    <script src="../assets/js/ace/ace.sidebar.js"></script>
    <script src="../assets/js/ace/ace.sidebar-scroll-1.js"></script>
    <script src="../assets/js/ace/ace.submenu-hover.js"></script>
    <script src="../assets/js/ace/ace.widget-box.js"></script>
    <script src="../assets/js/ace/ace.settings.js"></script>
    <script src="../assets/js/ace/ace.settings-rtl.js"></script>
    <script src="../assets/js/ace/ace.settings-skin.js"></script>
    <script src="../assets/js/ace/ace.widget-on-reload.js"></script>
    <script src="../assets/js/ace/ace.searchbox-autocomplete.js"></script>

    <!-- inline scripts related to this page -->

    <!-- the following scripts are used in demo only for onpage help and you don't need them -->
    <link rel="stylesheet" href="../assets/css/ace.onpage-help.css" />
    <link rel="stylesheet" href="../docs/assets/js/themes/sunburst.css" />

    <script type="text/javascript"> ace.vars['base'] = '..'; </script>
    <script src="../assets/js/ace/elements.onpage-help.js"></script>
    <script src="../assets/js/ace/ace.onpage-help.js"></script>
    <script src="../docs/assets/js/rainbow.js"></script>
    <script src="../docs/assets/js/language/generic.js"></script>
    <script src="../docs/assets/js/language/html.js"></script>
    <script src="../docs/assets/js/language/css.js"></script>
    <script src="../docs/assets/js/language/javascript.js"></script>

    <script>
        function showmessage(msg, fun, parameter) {
            $('#close').popover('hide');
            bootbox.dialog({
                message: "<span class='bigger-125'><i class='ace-icon fa fa-info-circle'></i>&nbsp;" + msg + "</span>",
                buttons:
                {
                    "click":
                    {
                        "label": "OK",
                        "className": "btn-sm btn-primary",
                        "callback": function () {
                            if (fun) { fun(parameter); }
                        }
                    }
                }
            });
        }
        function fnLoading() {
            document.getElementById("mainApp").style.display = "none";
            document.getElementById("loading").style.display = "";
        }
        function fnUnLoading() {
            document.getElementById("mainApp").style.display = "";
            document.getElementById("loading").style.display = "none";
        }
        function fnClose() {
            window.parent.closepopup();
        }
        //======================================================
        var app = angular.module('myApp', []);
        var config = { headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;' } }
        app.controller('StartApp', StartApp);
        var $tmp_scope;
        var $tmp_http;
        var ID;
        var Command;
        var Datatype;
        function StartApp($scope, $http) {
            //fnLoading();
            //loadPosition($scope, $http);
            
            ID = getParamValue("ID");
            Command = getParamValue("Command");
            Datatype = Command.replace("Add", "").replace("Edit", "");

            $tmp_scope = $scope;
            $tmp_http = $http;

            //$scope.DataRecords = [];

            $scope.dataStandard = {
                dataname: "",
                datadesc: ""
            };

            $scope.fnSave = function () {
                var ERROR = document.getElementById('ERROR');

                ERROR.innerHTML = "";
                if ($scope.dataStandard.dataname == "") {
                    ERROR.innerHTML = "โปรดระบุข้อมูล";
                    return;
                }

                fnLoading();

                var data = $.param({
                    Command: 'SaveStandard',
                    ID: ID,
                    datatype: Datatype,
                    name: $scope.dataStandard.dataname,
                    desc: $scope.dataStandard.datadesc
                });

                $tmp_http.post("../server/Server_Gunbook.aspx", data, config)
                    .success(function (data, status, headers, config) {
                        if (data.output == 'OK') {
                            window.parent.refreshAllData();
                            return;
                        } else {
                            ERROR.innerHTML = data.MSG;
                            fnUnLoading();
                        }
                    })
                    .error(function (data, status, header, config) { });
            }

            $scope.loadData = function () {
                fnLoading();
                var data = $.param({
                    Command: 'LoadStandard',
                    ID: ID,
                    datatype: Datatype
                });

                $http.post("../server/Server_Gunbook.aspx", data, config)
                    .success(function (data, status, headers, config) {
                        if (data.output == "OK") {
                            $scope.dataStandard.dataname = data.NAME;
                            $scope.dataStandard.datadesc = data.DESC;

                            //$scope.DataRecords = data.Records;
                            //window.setTimeout(initpage, 100);
                            fnUnLoading();
                        } else {
                            showmessage(data.MSG);
                        }
                    })
                    .error(function (data, status, header, config) { });
            }

            $scope.fnDelete = function (strID) {
                
                fnLoading();

                var data = $.param({
                    Command: 'DeleteStandard',
                    datatype: Datatype,
                    ID: strID
                });

                $tmp_http.post("../server/Server_Gunbook.aspx", data, config)
                    .success(function (data, status, headers, config) {
                        if (data.output == 'OK') {
                            $scope.loadData();
                        } else {
                            ERROR.innerHTML = data.MSG;
                            fnUnLoading();
                        }
                    })
                    .error(function (data, status, header, config) { });
            }

            $scope.loadData();
        }
        function getParamValue(name) {
            var url = location.href;
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(url);
            return results == null ? null : results[1];
        }
        
    </script>
</body>
</html>
