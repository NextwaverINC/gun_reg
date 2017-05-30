<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showimage.aspx.cs" Inherits="gunbook_showimage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="height: 100%">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>รูปภาพ</title>
    <script src="../js.iviewer/test/jquery.js"></script>
    <script src="../js.iviewer/test/jqueryui.js"></script>
    <script src="../js.iviewer/test/jquery.mousewheel.min.js"></script>
    <script src="../js.iviewer/jquery.iviewer.js"></script>
    <link rel="stylesheet" href="../assets/css/bootstrap.css" />
    <script src="../Scripts/angular.min.js"></script>

    <%--<script type="text/javascript">
        
        $(document).ready(function () {

            var iv2 = 
        });
    </script>--%>
    <link href="../js.iviewer/jquery.iviewer.css" rel="stylesheet" />
    <style>
        .viewer {
            width: 100%;
            height: 100%;
            /*border: 1px solid black;*/
            position: relative;
        }

        .wrapper {
            overflow: hidden;
        }
    </style>
</head>
<body style="height: 100%">
    <div id="mainApp" ng-app="myApp" ng-controller="StartApp" style="height: 100%">
        <div>
            <div class="row" style="padding: 10px;">
                <div class=" col-sm-10">
                    <div class="form-group" style="margin: 0px">
                        <table>
                            <tr>
                                <td style="width: 50px;"></td>
                                <td style="width: 100px;" class="text-right"><span class="text-right"><strong>เลขหนังสือ :</strong>&nbsp;&nbsp;</span></td>
                                <td style="width: 100px;">
                                    <input type="number" class="form-control" ng-model="bookno" min="1" style="width: 100%" />
                                </td>
                                <td style="width: 100px;" style="width: 100px;" class="text-right"><span class="text-right"><strong>หน้า :</strong>&nbsp;&nbsp;</span></td>
                                <td style="width: 100px;">
                                    <input type="number" class="form-control" ng-model="pageno" min="1" style="width: 100%" />
                                </td>
                                <td style="width: 100px;" class="text-right"><span class="text-right"><strong>เวอร์ชั่น :</strong>&nbsp;&nbsp;</span></td>
                                <td style="width: 100px;">
                                    <input type="number" class="form-control" ng-model="pagever" min="1" style="width: 100%" />
                                </td>
                                <td style="width: 100px;" class="text-right">
                                    <button class="btn btn-info" style="float: right; border: 0px;" ng-click="fnOpenImage()">
                                        ดูรูปภาพ
                                    </button>
                                </td>
                            </tr>
                        </table>


                    </div>
                </div>
                <div class="col-sm-2">
                    <label id="ERROR" style="color: red"></label>
                </div>
            </div>
        </div>
        <div class="wrapper" style="height: calc(100vh - 80px);">
            <div id="viewer2" class="viewer" style="width: 100%;"></div>
        </div>
        <%--<img src="data:image/png;base64,<% =imgdata %>" style="width: 100%" />--%>
    </div>
    <div id="loading" style="display: none; margin-top: 50px">
        <center>
            <h1 class="bigger"><i class="ace-icon fa fa-spinner fa-spin orange"></i></h1>
            <h3>                    
                อยู่ระหว่างประมวลผลโปรดรอ...
            </h3>
        </center>
    </div>

    <%--<script src="../assets/js/bootstrap.js"></script>--%>
    <script>
        function fnLoading() {
            document.getElementById("mainApp").style.display = "none";
            document.getElementById("loading").style.display = "";
        }
        function fnUnLoading() {
            document.getElementById("mainApp").style.display = "";
            document.getElementById("loading").style.display = "none";
        }
        var $ = jQuery;

        var $scope_gobal;
        var $http_gobal;
        var data_gobal;
        var column_gobal;
        var tmp_grp_id;

        var app = angular.module('myApp', []);
        var config = { headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;' } }
        app.controller('StartApp', StartApp);
        function StartApp($scope, $http) {
            $scope.bookno = parseInt(getParamValue("Book"));
            $scope.pageno = parseInt(getParamValue("Page"));
            $scope.pagever = parseInt(getParamValue("Ver"));

            fnLoading();
            var data = $.param({
                Command: 'GetImage',
                bookno: getParamValue("Book"),
                pageno: getParamValue("Page"),
                pagever: getParamValue("Ver")
            });

            $http.post("../server/Server_Gunbook.aspx", data, config)
                .success(function (data, status, headers, config) {
                    if (data.output == 'OK') {
                        fnUnLoading();
                        $("#viewer2").iviewer(
                            {
                                src: "data:image/png;base64," + data.imgStr
                            });
                    } else {
                        fnUnLoading();
                        alert(data.MSG);
                    }
                })
                .error(function (data, status, header, config) { });


            $scope.fnOpenImage = function () {
                window.open('showimage.aspx?Book=' + $scope.bookno + '&Page=' + $scope.pageno + '&Ver=' + $scope.pagever, '_self');
            }
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
