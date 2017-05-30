<%@ Page Language="VB" AutoEventWireup="false" CodeFile="addPageNew.aspx.vb" Inherits="gunbook_addBook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>Gun register book</title>

    <meta name="description" content="Drag &amp; drop hierarchical list" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="../assets/css/bootstrap.css" />
    <link rel="stylesheet" href="../assets/css/font-awesome.css" />

    <!-- page specific plugin styles -->

    <!-- text fonts -->
    <link rel="stylesheet" href="../assets/css/ace-fonts.css" />

    <!-- ace styles -->
    <link rel="stylesheet" href="../assets/css/ace.css" class="ace-main-stylesheet" />

    <!--[if lte IE 9]>
		<link rel="stylesheet" href="../assets/css/ace-part2.css" class="ace-main-stylesheet" />
	<![endif]-->

    <!--[if lte IE 9]>
	  <link rel="stylesheet" href="../assets/css/ace-ie.css" />
	<![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->
    <script src="../assets/js/ace-extra.js"></script>

    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

    <!--[if lte IE 8]>
	<script src="../assets/js/html5shiv.js"></script>
	<script src="../assets/js/respond.js"></script>
	<![endif]-->

    <script src="../Scripts/angular.min.js"></script>
    <style>
        .checkstyle {
            cursor: pointer;
            height: 30px;
            min-width: 30px;
        }
    </style>
</head>
<body style="background-color: white">
    <form id="form1" runat="server">
        <div id="mainApp" ng-app="myApp" ng-controller="StartApp">
            <div class="widget-box transparent" id="widget-box-2">
                <div class="widget-body">
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 20px"></td>
                            <td class="text-right">
                                <label>เลขที่หนังสือ : </label>
                            </td>
                            <td style="width: 5px"></td>
                            <td>
                                <input type="number" id="bookno" placeholder="เลขที่หนังสือ" style="width: 100%" min="1" /></td>
                            <td style="width: 20px"></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td style="width: 20px"></td>
                            <td class="text-right">
                                <label>หน้าที่ : </label>
                            </td>
                            <td style="width: 5px"></td>
                            <td>
                                <input type="number" id="pageno" placeholder="หน้าที่" style="width: 100%" min="1" /></td>
                            <td style="width: 20px"></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td style="width: 20px"></td>
                            <td class="text-right">
                                <label>รูปภาพ : </label>
                            </td>
                            <td style="width: 5px"></td>
                            <td>
                                <input type="file" name="pic" onchange="readURL(this);" accept="image/*" />
                            </td>
                            <td style="width: 20px"></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 5px"></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="text-align: center">
                                <img id="blah" src="#" alt="your image" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div>
                <label id="ERROR" style="color: red"></label>
            </div>
            <div>
                <a class="btn btn-primary" style="width: 49%">
                    <i class="ace-icon fa fa-floppy-o align-top bigger-125"></i>
                    บันทึก
                </a>
                <a class="btn btn-danger" style="width: 49%">
                    <i class="ace-icon fa fa-remove align-top bigger-125"></i>
                    ยกเลิก
                </a>
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

    <link href="../assets/bootstrap-dialog/css/bootstrap-dialog.css" rel="stylesheet" />
    <script src="../assets/bootstrap-dialog/js/bootstrap-dialog.js"></script>

    <!-- page specific plugin scripts -->
    <script src="../assets/js/jquery.nestable.js"></script>

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
    <script src="../assets/js/bootbox.js"></script>

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
        var imgbyte;
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#blah')
                        .attr('src', e.target.result)
                        .width(350);
                    imgbyte = e.target.result;
                    console.log(imgbyte);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
        var app = angular.module('myApp', []);
        var config = { headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;' } }
        app.controller('StartApp', StartApp);
        function StartApp($scope, $http) {

            //fnLoading();

            var ID = getParamValue("ID");

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
