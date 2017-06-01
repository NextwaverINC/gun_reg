<%@ Page Title="" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="master_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="mainApp">
        <div class="row">
            <div class="col-lg-12">
                <div class="widget-box widget-color-blue" id="widget-box-9">
                    <div class="widget-header">
                        <h5 class="widget-title">ตัวกรองข้อมูล</h5>
                        <div class="widget-toolbar">
                            <a href="#" data-action="collapse">
                                <i class="1 ace-icon fa fa-chevron-up bigger-125"></i>
                            </a>
                        </div>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main">
                            <div class="row">
                                <div class="col-md-8 col-sm-12">
                                    <div class="form-group">
                                        <div class="col-md-4 col-sm-8" style="padding: 0px;">
                                            <p class="text-right"><strong>เลือกวันที่ต้องการค้นหา&nbsp;&nbsp;จากวันที่&nbsp;&nbsp;:&nbsp;&nbsp;</strong></p>
                                        </div>
                                        <div class="col-sm-3 col-xs-4" style="padding: 0px;">
                                            <input type="number" class="form-control" style="width: 100%" />
                                        </div>
                                        <div class="col-sm-2 col-xs-8" style="padding: 0px;">
                                            <p class="text-right"><strong>ถึงวันที่&nbsp;&nbsp;:&nbsp;&nbsp;</strong></p>
                                        </div>
                                        <div class="col-sm-3 col-xs-4" style="padding: 0px;">
                                            <input type="number" class="form-control" style="width: 100%" />
                                        </div>

                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-12">
                                    <div class="col-md-3 col-sm-6" style="">
                                        <div class="form-group">
                                            <div class="col-sm-6 col-xs-6" style="padding: 0px;">
                                                <p class="text-right"><strong>Status :</strong></p>
                                            </div>
                                            <div class="col-sm-6 col-xs-6" style="padding: 0px;">
                                                <select>
                                                    <option value="Create">Create</option>
                                                    <option value="Scan">Scan</option>
                                                    <option value="Save">Save</option>
                                                    <option value="Submit">Submit</option>
                                                    <option value="Approve">Approve</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-1 col-sm-6">
                                        <button class="btn btn-app btn-success btn-sm" ng-click="fnManagementSearch()" style="padding: 5px; float: right;">
                                            Search
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
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

    <script>   
        function fnLoading() {
            document.getElementById("mainApp").style.display = "none";
            document.getElementById("loading").style.display = "";
        }
        function fnUnLoading() {
            document.getElementById("mainApp").style.display = "";
            document.getElementById("loading").style.display = "none";
        }
        function getCurrentValue(SelectRows, ColumnName) {
            if (SelectRows == null) {
                showmessage("โปรดเลือกรายการที่จะทำการแก้ไข");
                return "";
            }
            if (SelectRows.length == 0) {
                showmessage("โปรดเลือกรายการที่จะทำการแก้ไข");
                return "";
            }
            if (SelectRows.length > 1) {
                showmessage("ไม่สามารถแก้ไขรายการพร้อมกันหลายรายการได้");
                return "";
            }
            for (var i = 0; i < SelectRows[0].COLUMN.length; i++) {
                if (ColumnName == SelectRows[0].COLUMN[i].NAME) {
                    return SelectRows[0].COLUMN[i].VALUE;
                }
            }
            return "";
        }
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
        function showconfirm(msg, fun, parameter) {
            bootbox.confirm("<span class='bigger-125'>" + msg + "</span>", function (result) {
                if (result) {
                    fun(parameter);
                }
            });
        }
        //======================================================
        var $scope_gobal;
        var $http_gobal;
        var data_gobal;
        var column_gobal;
        var tmp_grp_id;
        function refreshAllData() {
            closepopup();
            window.location.reload();
        }
        function StartPages($scope, $http) {
        }
        function loadData($scope, $http) {
            var data = $.param({
                Command: 'LoadManagement',
                ConfigName: getParamValue("CFN"),
                MID: getParamValue("MID"),
                TID: getParamValue("TID"),
                SRD: getParamValue("SRD")
            });

            $http.post("../server/server.aspx", data, config)
                .success(function (data, status, headers, config) {
                    $scope.COLUMN = data.columns;
                    $scope.DATA = data.records;
                    $scope.TOOLS = data.tools;
                    $scope.TITLE = data.title;
                    $scope.SEARCH = data.search;
                    numPageDisplay = parseInt(data.pagedisplay)
                    if (data.group.length != 0) {
                        $scope.GROUP = data.group;
                        document.getElementById("grpName").innerHTML = '<font size="4" color="navy">' + data.group_txt + '</font>';
                        document.getElementById('tblGrp').style.display = "block";
                    }

                })
                .error(function (data, status, header, config) { });
        }
    </script>
</asp:Content>

