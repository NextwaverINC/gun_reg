<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addPage.aspx.cs" Inherits="gunbook_addPage" %>

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

        #myInput {
            /*background-image: url('../icon/searchicon.png');
            background-position: 10px 12px;
            background-repeat: no-repeat;*/
            width: 100%;
            font-size: 16px;
            padding: 5px 10px 5px 10px;
            border: 1px solid #ddd;
            margin-bottom: 12px;
        }

        #myUL {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }


            #myUL li a {
                border: 1px solid #ddd;
                margin-top: -1px; /* Prevent double borders */
                background-color: #f6f6f6;
                padding: 12px;
                text-decoration: none;
                font-size: 18px;
                color: black;
                display: block
            }

                #myUL li a.header {
                    background-color: #e2e2e2;
                    cursor: default;
                }

                #myUL li a:hover:not(.header) {
                    background-color: #eee;
                }
    </style>

    <style>
        .modal-dialog-fullscreen {
            height: 100%;
            margin-top: 0px;
            margin-bottom: 0px;
            padding: 0;
        }

        .modal-content-fullscreen {
            height: 100%;
            min-height: 100%;
            border-radius: 0;
        }

        .modal-body {
            max-height: calc(100vh - 100px);
            overflow-y: auto;
        }
    </style>

    <script type="text/javascript">
        function deleteConfirm(Gunid) {
            var result = confirm('Do you want to delete ' + Gunid + ' ?');
            if (result) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>

</head>
<body style="background-color: white">
    <div class="container">
        <div class="row">
            <form id="form1" runat="server">
                <div id="mainApp" ng-app="myApp" ng-controller="StartApp">

                    <div class="widget-box transparent" id="widget-box-2">
                        <div class="widget-header widget-header-small">
                            <h4 class="widget-title blue smaller">
                                <i class="ace-icon fa fa-edit blue"></i>
                                {{titleHead}} 
                            </h4>
                            <span style="color: black; font-size: small">&nbsp;&nbsp;&nbsp;&nbsp;
                                <label class="control-label no-padding-right text-right" for="bookno">เลขที่หนังสือ : </label>
                                <label id="bookno"></label>
                                &nbsp;&nbsp;&nbsp;
                                <label class="control-label no-padding-right text-right" for="pageno">เลขที่หน้า : </label>
                                <label id="pageno"></label>
                                &nbsp;&nbsp;&nbsp;
                                <label class="control-label no-padding-right text-right" for="pagever">เวอร์ชั่น : </label>
                                <label id="pagever"></label>
                                &nbsp;&nbsp;&nbsp;
                                <label class="control-label no-padding-right text-right" for="imgurl">ImgUrl : </label>
                                <label id="imgurl"></label>
                                <%--<span class="glyphicon glyphicon-edit" data-toggle="modal" data-target="#myModalAddImg" style="color: #0088cc; font-size: 13px;"></span>--%>
                            </span>
                            <div class="widget-toolbar">
                                <a ng-show="StatusPage == 'Scan' || StatusPage == 'Save'" class="btn btn-info" ng-click="fnSave('1')" style="width: 100px;">
                                    <i class="ace-icon fa fa-floppy-o"></i>
                                    Save
                                </a>
                                <a ng-show="StatusPage != 'Create'" class="btn btn-primary" ng-click="fnSave('2')" style="width: 100px;">
                                    <i class="ace-icon fa fa-check"></i>
                                    Submit
                                </a>
                                <a ng-show="StatusPage == 'Submit'" class="btn btn-success" ng-click="fnSave('3')" style="width: 100px;">
                                    <i class="ace-icon fa fa-floppy-o"></i>
                                    Approve
                                </a>
                                <a class="btn btn-danger" onclick="fnClose()" style="width: 100px;">
                                    <i class="ace-icon fa fa-remove"></i>
                                    Cancel
                                </a>
                            </div>
                        </div>

                        <div class="widget-body">
                            <%--<div class="row" style="margin: 10px 0px 10px 0px;">
                                <div class="col-sm-2">
                                    <label class="col-sm-7 control-label no-padding-right text-right" for="bookno">เลขที่หนังสือ : </label>
                                    <div class="col-sm-5">
                                        <label id="bookno"></label>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <label class="col-sm-7 control-label no-padding-right text-right" for="pageno">เลขที่หน้า : </label>
                                    <div class="col-sm-5">
                                        <label id="pageno"></label>
                                    </div>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-sm-2 control-label no-padding-right text-right" for="imgurl">ImgUrl : </label>
                                    <div class="col-sm-10">
                                        <label id="imgurl"></label>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="row" style="margin: 5px 15px 0px 0px">
                                <div class="col-sm-12 text-right" style="padding: 0px;">
                                    <a class="btn btn-success btn-xs" data-toggle="modal" data-target="#myModalAddRecord" ng-click="clearId()">
                                        <i class="ace-icon fa fa-plus bigger-110"></i>สร้างเลขทะเบียนปืน
                                    </a>
                                    <a class="btn btn-success btn-xs" data-toggle="modal" data-target="#myModalAddNumber" ng-show="DataRecords.length > 0">
                                        <i class="ace-icon fa fa-plus bigger-110"></i>เพิ่มเลขหมายปืนทั้งหมด
                                    </a>
                                    <%--<a class="btn btn-success btn-xs" data-toggle="modal" data-target="#myModal" ng-click="addnew('F')">
                                <i class="ace-icon fa fa-plus bigger-110"></i>เพิ่มข้อมูล
                            </a>--%>
                                    <a class="btn btn-success btn-xs" data-toggle="modal" data-target="#myModal" ng-click="addnew('T')" ng-show="DataRecords.length > 0">
                                        <i class="ace-icon fa fa-plus bigger-110"></i>จัดการข้อมูลแบบกลุ่ม
                                    </a>
                                </div>
                            </div>
                            <div class="row" style="margin: 0px 15px 0px 15px;">
                                <div class="col-xs-12" style="overflow-x: scroll; padding-left: 0px; padding-right: 0px;">
                                    <table id="simple-table" class="table table-bordered table-hover">
                                        <thead>
                                            <tr style="background: #eeeeee;">
                                                <th class="text-center">&nbsp;</th>
                                                <th class="text-center">&nbsp;</th>
                                                <th class="text-center">ทะเบียนปืน&nbsp;</th>
                                                <th class="text-center">เลขหมายปืน&nbsp;</th>
                                                <%--<th class="text-center">สั้น/ยาว&nbsp;</th>--%>
                                                <th class="text-center">ชนิดอาวุธปืน</th>
                                                <th class="text-center">ขนาด&nbsp;</th>
                                                <th class="text-center">ยี่ห้อ&nbsp;</th>
                                                <th class="text-center">บรรจุ(นัด)&nbsp;</th>
                                                <th class="text-center">ความยาวลำกล้อง&nbsp;</th>
                                                <th class="text-center">สีปืน&nbsp;</th>
                                                <th class="text-center">เจ้าของปืน&nbsp;</th>
                                                <th class="text-center">จำนวน&nbsp;</th>
                                                <th class="text-center">หมายเหตุ&nbsp;</th>
                                                <th class="text-center">วันที่ลงทะเบียน&nbsp;</th>
                                                <th class="text-center">ประเทศนำเข้า&nbsp;</th>
                                                <th class="text-center">&nbsp;</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="item in DataRecords">
                                                <td>
                                                    <input type="checkbox" class="radio" name="datagun" onclick="checkboxClick(this)" ng-click="checkboxValue(item)" /></td>
                                                <td class="text-center" nowrap>
                                                    <span class="glyphicon glyphicon-edit" data-toggle="modal" data-target="#myModal" ng-click="editdata(item, $index)" style="color: #265691; font-size: 16px;"></span>
                                                </td>
                                                <td nowrap>{{item.GunRegID}}</td>
                                                <td nowrap>{{item.GunNo}}</td>
                                                <%--<td nowrap>{{item.GunGroup}}</td>--%>
                                                <td nowrap>{{item.GunType}}</td>
                                                <td nowrap>{{item.GunSize}}</td>
                                                <td nowrap>{{item.GunBrand}}</td>
                                                <td nowrap>{{item.GunMaxShot}}</td>
                                                <td nowrap>{{item.GunBarrel}}</td>
                                                <td nowrap>{{item.GunColor}}</td>
                                                <td nowrap>{{item.GunOwner}}</td>
                                                <td nowrap>{{item.GunLottotal}}</td>
                                                <td nowrap>{{item.GunRemark}}</td>
                                                <td nowrap>{{item.GunRegDate}}</td>
                                                <td nowrap>{{item.GunCountry}}</td>
                                                <td class="text-center" nowrap>
                                                    <span class="glyphicon glyphicon-trash" ng-click="addDelRow($index)" style="color: #a95553; font-size: 16px;"></span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.span -->
                            </div>
                            <div class="row">
                                <label id="ERROR" style="color: red"></label>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade bootstrap-dialog " id="myModal" role="dialog" data-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog modal-dialog-fullscreen">
                            <div class="modal-content modal-content-fullscreen" style="background-color: #eff3f8;">
                                <!-- Modal Header -->
                                <div class="modal-header" style="padding: 5px; border: 0px;">
                                    <button type="button" class="close"
                                        data-dismiss="modal">
                                        <span aria-hidden="true">&times;</span>
                                        <span class="sr-only">Close</span>
                                    </button>
                                    <h4 class="modal-title">{{titleModal}}
                                    </h4>
                                </div>
                                <div class="modal-body" style="background-color: white;">
                                    <div class="row" ng-show="boolmultirow">
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>เลขทะเบียนปืนเริ่มต้น :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input type="text" class="form-control" ng-model="startid" style="width: 100%" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>ถึงเลขทะเบียนปืนที่ :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input type="text" class="form-control" ng-model="endid" style="width: 100%" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" ng-hide="boolmultirow">
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>ทะเบียนปืน :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input type="text" class="form-control" ng-model="RecordData.GunRegID" style="width: 100%" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>เลขหมายปืน :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input type="text" class="form-control" ng-model="RecordData.GunNo" style="width: 100%" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <%--<div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>สั้น/ยาว :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <label>
                                                        <input type="radio" ng-model="RecordData.GunGroup" value="สั้น">
                                                        สั้น
                                                    </label>
                                                    &nbsp;
                                                                <label>
                                                                    <input type="radio" ng-model="RecordData.GunGroup" value="ยาว">
                                                                    ยาว
                                                                </label>
                                                    &nbsp;
                                                                <label>
                                                                    <input type="radio" ng-model="RecordData.GunGroup" value="">
                                                                    ไม่ระบุ
                                                                </label>
                                                </div>
                                            </div>
                                        </div>--%>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>ชนิดอาวุธปืน :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <div class="input-group">
                                                        <input class="form-control" type="text" ng-model="RecordData.GunType" list="dtlGunType" />
                                                        <datalist id="dtlGunType">
                                                            <option ng-repeat="item in datalistGunType" value="{{item}}" />
                                                        </datalist>
                                                        <a class="input-group-addon" ng-click="openDataStandard('GunType')">
                                                            <i class="ace-icon fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>ขนาด :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <div class="input-group">
                                                        <input class="form-control" type="text" ng-model="RecordData.GunSize" list="dtlGunSize" />
                                                        <datalist id="dtlGunSize">
                                                            <option ng-repeat="item in datalistGunSize" value="{{item}}" />
                                                        </datalist>
                                                        <a class="input-group-addon" ng-click="openDataStandard('GunSize')">
                                                            <i class="ace-icon fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>ยี่ห้อ :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <div class="input-group">
                                                        <input class="form-control" type="text" ng-model="RecordData.GunBrand" list="dtlGunBrand" />
                                                        <datalist id="dtlGunBrand">
                                                            <option ng-repeat="item in datalistGunBrand" value="{{item}}" />
                                                        </datalist>
                                                        <a class="input-group-addon" ng-click="openDataStandard('GunBrand')">
                                                            <i class="ace-icon fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>บรรจุ(นัด) :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input type="number" class="form-control" ng-model="RecordData.GunMaxShot" style="width: 100%" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>ความยาวลำกล้อง :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <div class="input-group">
                                                        <input class="form-control" type="text" ng-model="RecordData.GunBarrel" list="dtlGunBarrel" />
                                                        <datalist id="dtlGunBarrel">
                                                            <option ng-repeat="item in datalistGunBarrel" value="{{item}}" />
                                                        </datalist>
                                                        <a class="input-group-addon" ng-click="openDataStandard('GunBarrel')">
                                                            <i class="ace-icon fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>สีปืน :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <div class="input-group">
                                                        <input class="form-control" type="text" ng-model="RecordData.GunColor" list="dtlGunColor" />
                                                        <datalist id="dtlGunColor">
                                                            <option ng-repeat="item in datalistGunColor" value="{{item}}" />
                                                        </datalist>
                                                        <a class="input-group-addon" ng-click="openDataStandard('GunColor')">
                                                            <i class="ace-icon fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>เจ้าของปืน :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <div class="input-group">
                                                        <input class="form-control" type="text" ng-model="RecordData.GunOwner" list="dtlGunOwner" />
                                                        <datalist id="dtlGunOwner">
                                                            <option ng-repeat="item in datalistGunOwner" value="{{item}}" />
                                                        </datalist>
                                                        <a class="input-group-addon" ng-click="openDataStandard('GunOwner')">
                                                            <i class="ace-icon fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>จำนวน :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input type="number" class="form-control" ng-model="RecordData.GunLottotal" style="width: 100%" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>หมายเหตุ :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input type="text" class="form-control" ng-model="RecordData.GunRemark" style="width: 100%" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>วันที่ลงทะเบียน :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input id="GunRegDate" type="text" class="form-control input-mask-date" placeholder="dd/mm/yyyy" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-sm-12" style="margin-bottom: 5px;">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>ประเทศนำเข้า :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <div class="input-group">
                                                        <input class="form-control" type="text" ng-model="RecordData.GunCountry" list="dtlGunCountry" />
                                                        <datalist id="dtlGunCountry">
                                                            <option ng-repeat="item in datalistGunCountry" value="{{item}}" />
                                                        </datalist>
                                                        <a class="input-group-addon" ng-click="openDataStandard('GunCountry')">
                                                            <i class="ace-icon fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="border: 0px;">
                                    <div class="row">
                                        <div class="col-sm-12 text-right">
                                            <a class="btn btn-success btn-xs" ng-click="adddata()" data-dismiss="modal">
                                                <i class="ace-icon fa fa-save bigger-110"></i>บันทึก
                                            </a>
                                            <a class="btn btn-danger btn-xs" data-dismiss="modal">
                                                <i class="ace-icon fa fa-close bigger-110"></i>ปิด
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade bootstrap-dialog" id="myModalAddRecord" role="dialog">
                        <div class="vertical-alignment-helper">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <button type="button" class="close"
                                            data-dismiss="modal">
                                            <span aria-hidden="true">&times;</span>
                                            <span class="sr-only">Close</span>
                                        </button>
                                        <h4 class="modal-title">เพิ่มรหัสทะเบียนปืน
                                        </h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class=" col-sm-6">
                                                <div class="form-group">
                                                    <div class="col-sm-5 col-xs-12">
                                                        <p class="text-right"><strong>เลขทะเบียนปืนเริ่มต้น :</strong></p>
                                                    </div>
                                                    <div class="col-sm-7 col-xs-12">
                                                        <input type="text" class="form-control" ng-model="startid" style="width: 100%" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class=" col-sm-6">
                                                <div class="form-group">
                                                    <div class="col-sm-5 col-xs-12">
                                                        <p class="text-right"><strong>ถึงเลขทะเบียนปืนที่ :</strong></p>
                                                    </div>
                                                    <div class="col-sm-7 col-xs-12">
                                                        <input type="text" class="form-control" ng-model="endid" style="width: 100%" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin: 15px 0px 0px 0px">
                                            <div class="col-sm-12 text-right">
                                                <a class="btn btn-success btn-xs" ng-click="addMultiRow()" data-dismiss="modal">
                                                    <i class="ace-icon fa fa-save bigger-110"></i>บันทึก
                                                </a>
                                                <a class="btn btn-danger btn-xs" data-dismiss="modal">
                                                    <i class="ace-icon fa fa-close bigger-110"></i>ปิด
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade bootstrap-dialog" id="myModalAddImg" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <button type="button" class="close"
                                        data-dismiss="modal">
                                        <span aria-hidden="true">&times;</span>
                                        <span class="sr-only">Close</span>
                                    </button>
                                    <h4 class="modal-title">เลือกรูปภาพ
                                    </h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class=" col-sm-12">
                                            <div class="form-group">
                                                <div class="col-sm-5 col-xs-12">
                                                    <p class="text-right"><strong>รูปภาพ :</strong></p>
                                                </div>
                                                <div class="col-sm-7 col-xs-12">
                                                    <input type="file" name="pic" accept="image/*" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" style="margin: 15px 0px 0px 0px">
                                        <div class="col-sm-12 text-right">
                                            <a class="btn btn-success btn-xs" data-dismiss="modal">
                                                <i class="ace-icon fa fa-save bigger-110"></i>บันทึก
                                            </a>
                                            <a class="btn btn-danger btn-xs" data-dismiss="modal">
                                                <i class="ace-icon fa fa-close bigger-110"></i>ปิด
                                            </a>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade bootstrap-dialog" id="myModalAddStandard" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close"
                                        data-dismiss="modal">
                                        <span aria-hidden="true">&times;</span>
                                        <span class="sr-only">Close</span>
                                    </button>
                                    <h4 class="modal-title">เพิ่มข้อมูล
                                    </h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-xs-12" style="margin: 0px 0px 15px 0px">
                                            <div class="col-sm-10">
                                                <div class=" col-sm-12" style="padding-bottom: 5px;">
                                                    <div class="form-group">
                                                        <div class="col-sm-4 col-xs-12">
                                                            <p class="text-right"><strong>ข้อมูล :</strong></p>
                                                        </div>
                                                        <div class="col-sm-8 col-xs-12">
                                                            <input type="text" class="form-control" ng-model="dataStandard.dataname" style="width: 100%" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class=" col-sm-12">
                                                    <div class="form-group">
                                                        <div class="col-sm-4 col-xs-12">
                                                            <p class="text-right"><strong>รายละเอียด :</strong></p>
                                                        </div>
                                                        <div class="col-sm-8 col-xs-12">
                                                            <textarea ng-model="dataStandard.datadesc" class="form-control" rows="5"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class=" col-sm-2">
                                                <a class="btn btn-success btn-xs" ng-click="fnSaveStandard()" data-dismiss="modal">
                                                    <i class="ace-icon fa fa-plus bigger-110"></i>&nbsp;&nbsp;เพิ่มข้อมูล
                                                </a>
                                            </div>
                                        </div>

                                        <div class="col-xs-12" style="padding: 15px; border: groove;">
                                            <div class="row">
                                                <label id="ERRORStandard" style="color: red"></label>
                                            </div>
                                            <div id="divStandard" class="table-responsive">
                                                <table id="example" class="display">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 20px;"></th>
                                                            <th>ID</th>
                                                            <th>ข้อมูล</th>
                                                            <th>รายละเอียด</th>
                                                            <%--<th>
                                                                <i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>
                                                                วันที่อัพเดท
                                                            </th>--%>
                                                            <th style="width: 20px;"></th>
                                                        </tr>
                                                    </thead>

                                                    <tbody>
                                                        <tr ng-repeat="item in DataRecordsStandard" on-finish-render="ngRepeatFinished">
                                                            <td class="text-center" ng-click="fnSelectStandard(item.NAME)"><span class="glyphicon glyphicon-ok" style="color: #0070ff; font-size: 16px;"></span></td>
                                                            <td nowrap>{{item.ID}}</td>
                                                            <td nowrap>{{item.NAME}}</td>
                                                            <td nowrap>{{item.DESCRIPTION}}</td>
                                                            <%--<td nowrap>{{item.UPDATEDATE}}</td>--%>
                                                            <td class="text-center" nowrap>
                                                                <span class="glyphicon glyphicon-trash" ng-click="fnDeleteStandard(item.ID)" style="color: #a95553; font-size: 16px;"></span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade bootstrap-dialog" id="myModalAddNumber" role="dialog" data-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog modal-dialog-fullscreen" style="width: 400px;">
                            <div class="modal-content modal-content-fullscreen">
                                <div class="modal-header" style="padding: 10px 5px 5px 5px; background: #eff3f8;">
                                    <%--<button type="button" class="close"
                                        data-dismiss="modal">
                                        <span aria-hidden="true">&times;</span>
                                        <span class="sr-only">Close</span>
                                    </button>--%>
                                    <button class="btn btn-danger" data-dismiss="modal" style="float: right; border: 0px;">
                                        Close
                                    </button>
                                    <h4 class="modal-title">ข้อมูลเลขหมายปืนทั้งหมด
                                    </h4>
                                </div>
                                <div class="modal-body" style="max-height: calc(100vh - 55px);">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <table id="simple-table" class="table table-bordered table-hover">
                                                <thead>
                                                    <tr style="background: #eeeeee;">
                                                        <th class="text-center">ทะเบียนปืน&nbsp;</th>
                                                        <th class="text-center">เลขหมายปืน&nbsp;</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr ng-repeat="item in DataRecords">
                                                        <td nowrap>{{item.GunRegID}}</td>
                                                        <td nowrap style="padding: 0px;">
                                                            <input type="text" class="form-control" ng-model="item.GunNo" style="width: 100%" /></td>
                                                    </tr>
                                                </tbody>
                                            </table>
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
            </form>
            <form id="TheForm" method="post" action="showimage.aspx" target="TheWindow">
                <input type="hidden" name="pathimg" value="pathimg" />
            </form>
        </div>
    </div>
    <!-- basic scripts -->

    <!--[if !IE]> -->
    <script src="../assets/js/jquery.js"></script>
    <script src="../assets/js/dataTables/jquery.dataTables.js"></script>
    <!-- <![endif]-->
    <!--[if IE]>
        <script src="../assets/js/jquery1x.js"></script>
        <![endif]-->
    <script type="text/javascript">
        if ('ontouchstart' in document.documentElement) document.write("<script src='../assets/js/jquery.mobile.custom.js'>" + "<" + "/script>");
    </script>
    <script src="../assets/js/bootstrap.js"></script>

    <!-- page specific plugin scripts -->
    <script src="../assets/js/jquery.nestable.js"></script>
    <script src="../assets/js/jquery.maskedinput.js"></script>
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
    <link href="../assets/css/jquery.dataTables.min.css" rel="stylesheet" />

    <script type="text/javascript"> ace.vars['base'] = '..'; </script>
    <script src="../assets/js/ace/elements.onpage-help.js"></script>
    <script src="../assets/js/ace/ace.onpage-help.js"></script>
    <script src="../docs/assets/js/rainbow.js"></script>
    <script src="../docs/assets/js/language/generic.js"></script>
    <script src="../docs/assets/js/language/html.js"></script>
    <script src="../docs/assets/js/language/css.js"></script>
    <script src="../docs/assets/js/language/javascript.js"></script>
    <script src="../assets/js/bootbox.js"></script>

    <%--    <link href="../assets/js/date-time/bootstrap-datepicker.css" rel="stylesheet" />--%>
    <%--<script src="../assets/js/date-time/bootstrap-datepicker-custom.js"></script>--%>
    <%--<script src="../assets/js/date-time/locales/bootstrap-datepicker.th.min.js" charset="UTF-8"></script>--%>

    <script>

        function myFunction() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            ul = document.getElementById("myUL");
            li = ul.getElementsByTagName("li");
            for (i = 0; i < li.length; i++) {
                a = li[i].getElementsByTagName("a")[0];
                if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";
                }
            }
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
        function fnLoading() {
            document.getElementById("mainApp").style.display = "none";
            document.getElementById("loading").style.display = "";
        }
        function fnUnLoading() {
            document.getElementById("mainApp").style.display = "";
            document.getElementById("loading").style.display = "none";
        }
        function fnClose() {
            window.parent.closepopupfull();
        }
        //======================================================
        var app = angular.module('myApp', []);
        var config = { headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;' } }
        app.controller('StartApp', StartApp);
        var $tmp_scope;
        var $tmp_http;

        app.filter('replaceAllstr', function () {
            return function (input) {
                input = String(input).replace('&amp;', '&');
                input = String(input).replace('&lt;', '<');
                input = String(input).replace('&gt;', '>');
                input = String(input).replace('&apos;', "'");
                input = String(input).replace('&quot;', '"');
                input = String(input).replace('&#39;', "'");
                return input;
            };
        });

        app.filter('replaceAllstrChar', function () {
            return function (item) {
                angular.forEach(item, function (input, key) {
                    input = String(input).replace('&', '&amp;');
                    input = String(input).replace('<', '&lt;');
                    input = String(input).replace('>', '&gt;');
                    input = String(input).replace("'", '&apos;');
                    input = String(input).replace('"', '&quot;');
                    input = String(input).replace("'", '&#39;');
                });
                return item;
            };
        });

        app.directive('onFinishRender', ['$timeout', '$parse', function ($timeout, $parse) {
            return {
                restrict: 'A',
                link: function (scope, element, attr) {
                    if (scope.$last === true) {
                        $timeout(function () {
                            scope.$emit('ngRepeatFinished');
                            if (!!attr.onFinishRender) {
                                $parse(attr.onFinishRender)(scope);
                            }
                        });
                    }
                }
            }
        }]);

        function StartApp($scope, $http, $filter) {
            fnLoading();

            var ID = getParamValue("ID");
            loadData($scope, $http, ID);

            $tmp_scope = $scope;
            $tmp_http = $http;

            $scope.titleHead = "จัดการข้อมูลหนังสือทะเบียนปืน";

            $scope.titleModal = '';
            $scope.booledit = false;
            $scope.boolmultirow = false;
            $scope.idx = '';
            $scope.DataRecordsStandard = [];

            $scope.datalistGunType = ["GunType"];
            $scope.datalistGunSize = ["GunSize"];
            $scope.datalistGunBrand = ["GunBrand"];
            $scope.datalistGunBarrel = ["GunBarrel"];
            $scope.datalistGunColor = ["GunColor"];
            $scope.datalistGunOwner = ["GunOwner"];
            $scope.datalistGunCountry = ["GunCountry"];

            $scope.RecordData = {
                GunRegID: '',
                GunNo: '',
                GunGroup: '',
                GunType: '',
                GunSize: '',
                GunBrand: '',
                GunMaxShot: '',
                GunBarrel: '',
                GunColor: '',
                GunOwner: '',
                GunLottotal: '',
                GunRemark: '',
                GunRegDate: '',
                GunCountry: '',
                CreateDate: '',
                CreateBy: '',
                UpdateDate: '',
                UpdateBy: ''
            };

            $scope.clearRow = function () {
                document.getElementById('GunRegDate').value = "";
                $scope.RecordData = {
                    GunRegID: '',
                    GunNo: '',
                    GunGroup: '',
                    GunType: '',
                    GunSize: '',
                    GunBrand: '',
                    GunMaxShot: '',
                    GunBarrel: '',
                    GunColor: '',
                    GunOwner: '',
                    GunLottotal: '',
                    GunRemark: '',
                    GunRegDate: '',
                    GunCountry: '',
                    CreateDate: '',
                    CreateBy: '',
                    UpdateDate: '',
                    UpdateBy: ''
                };
            }
            $scope.startid = "";
            $scope.endid = "";

            $scope.clearId = function () {
                $scope.startid = "";
                $scope.endid = "";
            };

            $scope.addnew = function (multirow) {
                $scope.boolmultirow = false;
                $scope.titleModal = 'เพิ่มข้อมูล'
                $scope.booledit = false;

                var numberOfChecked = $('input:checkbox:checked').length;
                if (numberOfChecked == 0)
                    $scope.clearRow();
                document.getElementById('GunRegDate').value = $scope.RecordData.GunRegDate;
                if (multirow == "T") {
                    $scope.clearId();
                    $scope.boolmultirow = true;
                    $scope.titleModal = 'เพิ่มข้อมูลแบบกลุ่ม'
                }
            };

            $scope.addMultiRow = function () {
                var idstart = parseInt($scope.startid);
                var idend = parseInt($scope.endid);
                var d = new Date();
                var strDate = formatDate(d)

                var numLenght = $scope.startid.length;

                //if (input.length >= n)
                //    return input
                //var zeros = "0".repeat(n);
                //return (zeros + input).slice(-1 * n)
                var zeros = "0".repeat(numLenght);

                for (var i = idstart; i <= idend; i++) {
                    $scope.clearRow();
                    var GunRegID = (zeros + i.toString()).slice(-1 * numLenght)
                    $scope.RecordData.GunRegID = GunRegID.toString();
                    $scope.RecordData.CreateDate = strDate;
                    $scope.RecordData.CreateBy = $scope.UserAuth;
                    $scope.RecordData.UpdateDate = strDate;
                    $scope.RecordData.UpdateBy = $scope.UserAuth;
                    //console.log($scope.RecordData);
                    $scope.DataRecords.push($scope.RecordData);
                }
                //var gunid = idstart;
                //angular.forEach($scope.DataRecords, function (value, key) {
                //    if (gunid <= idend) {
                //        value.GunRegID = gunid.toString();
                //        value.UpdateDate = strDate;
                //        value.UpdateBy = $scope.UserAuth;
                //    }
                //    gunid++;
                //});
            };

            $scope.addDelRow = function (index) {
                $scope.DataRecords.splice(index, 1);
            };

            $scope.editdata = function (item, idx) {
                $scope.titleModal = 'แก้ไขข้อมูล'
                $scope.booledit = true;
                $scope.boolmultirow = false;
                $scope.RecordData = item;
                $scope.RecordData.GunRegID = item.GunRegID;
                if (item.GunMaxShot != "")
                    $scope.RecordData.GunMaxShot = parseInt(item.GunMaxShot);
                if (item.GunLottotal != "")
                    $scope.RecordData.GunLottotal = parseInt(item.GunLottotal);
                document.getElementById('GunRegDate').value = $scope.RecordData.GunRegDate;

                $("input[type='checkbox']:checked").prop('checked', false);
                //var GunRegDate = $scope.RecordData.GunRegDate.split("/");

                //$scope.GunRegDate.day = parseInt(GunRegDate[0]);
                //$scope.GunRegDate.month = parseInt(GunRegDate[1]);
                //$scope.GunRegDate.year = parseInt(GunRegDate[2]);
                $scope.idx = idx;
            };

            $scope.editmultirow = function () {
                $scope.GunRegIDarray = [];

                var idstart = parseInt($scope.startid);
                var idend = parseInt($scope.endid);

                var numLenght = $scope.startid.length;
                var zeros = "0".repeat(numLenght);
                for (var i = idstart; i <= idend; i++) {
                    var GunRegID = (zeros + i.toString()).slice(-1 * numLenght)
                    $scope.GunRegIDarray.push(GunRegID);
                }
                var d = new Date();
                var strDate = formatDate(d);

                angular.forEach($scope.DataRecords, function (value, key) {
                    if ($scope.GunRegIDarray.indexOf(value.GunRegID.toString()) > -1) {
                        value.GunGroup = $scope.RecordData.GunGroup;
                        value.GunType = $scope.RecordData.GunType;
                        value.GunSize = $scope.RecordData.GunSize;;
                        value.GunBrand = $scope.RecordData.GunBrand;
                        value.GunMaxShot = $scope.RecordData.GunMaxShot;
                        value.GunBarrel = $scope.RecordData.GunBarrel;
                        value.GunColor = $scope.RecordData.GunColor;
                        value.GunOwner = $scope.RecordData.GunOwner;
                        value.GunLottotal = $scope.RecordData.GunLottotal;
                        value.GunRemark = $scope.RecordData.GunRemark;
                        value.GunRegDate = $scope.RecordData.GunRegDate;
                        value.GunCountry = $scope.RecordData.GunCountry;
                        value.UpdateDate = strDate;
                        value.UpdateBy = $scope.UserAuth;
                    }
                });
            };

            $scope.adddata = function () {
                var d = new Date();
                var strDate = formatDate(d)

                if ($scope.booledit == true) {
                    $scope.RecordData.UpdateDate = strDate;
                    $scope.RecordData.UpdateBy = $scope.UserAuth;
                    $scope.RecordData.GunRegDate = document.getElementById('GunRegDate').value;
                    //$scope.DataRecords.contacts[$scope.idx] = $scope.RecordData;
                }
                else if ($scope.boolmultirow == true) {
                    $scope.RecordData.GunRegDate = document.getElementById('GunRegDate').value;
                    $scope.editmultirow();
                }
                else {
                    $scope.RecordData.CreateDate = strDate;
                    $scope.RecordData.CreateBy = $scope.UserAuth;
                    $scope.RecordData.UpdateDate = strDate;
                    $scope.RecordData.UpdateBy = $scope.UserAuth;
                    $scope.RecordData.GunRegDate = document.getElementById('GunRegDate').value;
                    $scope.DataRecords.push($scope.RecordData);
                }
            };

            $scope.fnSave = function (type) {

                var bookno = document.getElementById('bookno').innerHTML;
                var pageno = document.getElementById('pageno').innerHTML;
                var pagever = document.getElementById('pagever').innerHTML;

                fnLoading();
                var data = $.param({
                    Command: 'SavePage',
                    ID: getParamValue("ID"),
                    bookno: bookno,
                    pageno: pageno,
                    pagever: pagever,
                    savetype: type,
                    record: JSON.stringify($scope.DataRecords)
                });

                $tmp_http.post("../server/Server_Gunbook.aspx", data, config)
                    .success(function (data, status, headers, config) {
                        if (data.output == 'OK') {
                            fnUnLoading();
                            if (type != "1") {
                                window.parent.refreshAllData();
                                return;
                            }
                        } else {
                            ERROR.innerHTML = data.MSG;
                            fnUnLoading();
                        }
                    })
                    .error(function (data, status, header, config) { });
            }

            $scope.dataStandard = {
                datatype: "",
                dataname: "",
                datadesc: ""
            };

            $scope.fnSaveStandard = function () {
                if ($scope.dataStandard.dataname.trim() !== "") {
                    fnLoading();
                    var data = $.param({
                        Command: 'SaveStandardP',
                        ID: "",
                        datatype: $scope.dataStandard.datatype,
                        name: $scope.dataStandard.dataname,
                        desc: $scope.dataStandard.datadesc
                    });

                    $tmp_http.post("../server/Server_Gunbook.aspx", data, config)
                        .success(function (data, status, headers, config) {
                            if (data.output == 'OK') {
                                switch ($scope.dataStandard.datatype) {
                                    case 'GunType':
                                        $scope.datalistGunType = data.DATARECORDS;
                                        break;
                                    case 'GunSize':
                                        $scope.datalistGunSize = data.DATARECORDS;
                                        break;
                                    case 'GunBrand':
                                        $scope.datalistGunBrand = data.DATARECORDS;
                                        break;
                                    case 'GunBarrel':
                                        $scope.datalistGunBarrel = data.DATARECORDS;
                                        break;
                                    case 'GunColor':
                                        $scope.datalistGunColor = data.DATARECORDS;
                                        break;
                                    case 'GunOwner':
                                        $scope.datalistGunOwner = data.DATARECORDS;
                                        break;
                                    case 'GunCountry':
                                        $scope.datalistGunCountry = data.DATARECORDS;
                                        break;
                                    default:
                                }
                                $('#myModalAddStandard').modal('hide');
                                $scope.openDataStandard($scope.dataStandard.datatype);
                                fnUnLoading();
                            } else {
                                fnUnLoading();
                                alert(data.MSG);

                            }
                        })
                        .error(function (data, status, header, config) { });
                }
                else {
                    alert("ระบุข้อมูล");
                }

            }

            $scope.openDataStandard = function (Datatype) {

                $('#example').DataTable().destroy();

                fnLoading();

                $scope.dataStandard = {
                    datatype: "",
                    dataname: "",
                    datadesc: ""
                };

                var data = $.param({
                    Command: 'LoadStandardCode',
                    datatype: Datatype
                });
                ERRORStandard.innerHTML = "";
                divStandard.style.display = "";
                $scope.dataStandard.datatype = Datatype;
                $scope.DataRecordsStandard = [];

                $http.post("../server/Server_Gunbook.aspx", data, config)
                    .success(function (data, status, headers, config) {
                        if (data.output == "OK") {
                            if (data.Records.length < 1) {
                                divStandard.style.display = "none";
                                ERRORStandard.innerHTML = "ไม่มีข้อมูล";
                            }
                            $scope.DataRecordsStandard = data.Records;
                            $('#myModalAddStandard').modal('show');
                            fnUnLoading();
                        } else {
                            fnUnLoading();
                            alert(data.MSG);
                        }
                    })
                    .error(function (data, status, header, config) { });
            }

            $scope.checkboxValue = function (itemdata) {
                
                $scope.RecordData.GunType = itemdata.GunType;
                $scope.RecordData.GunSize = itemdata.GunSize;
                $scope.RecordData.GunBrand = itemdata.GunBrand;
                $scope.RecordData.GunBarrel = itemdata.GunBarrel;
                $scope.RecordData.GunColor = itemdata.GunColor;
                $scope.RecordData.GunOwner = itemdata.GunOwner;
                $scope.RecordData.GunRemark = itemdata.GunRemark;
                $scope.RecordData.GunRegDate = itemdata.GunRegDate;
                $scope.RecordData.GunCountry = itemdata.GunCountry;
                
                if (itemdata.GunMaxShot != "")
                    $scope.RecordData.GunMaxShot = parseInt(itemdata.GunMaxShot);
                if (itemdata.GunLottotal != "")
                    $scope.RecordData.GunLottotal = parseInt(itemdata.GunLottotal);

            }

            $scope.fnDeleteStandard = function (strID) {

                fnLoading();
                var data = $.param({
                    Command: 'DeleteStandard',
                    datatype: $scope.dataStandard.datatype,
                    ID: strID
                });

                $tmp_http.post("../server/Server_Gunbook.aspx", data, config)
                    .success(function (data, status, headers, config) {
                        if (data.output == 'OK') {
                            $scope.openDataStandard($scope.dataStandard.datatype);
                            fnUnLoading();
                        } else {
                            ERROR.innerHTML = data.MSG;
                            fnUnLoading();
                        }
                    })
                    .error(function (data, status, header, config) { });
            }

            $scope.fnSelectStandard = function (strData) {
                switch ($scope.dataStandard.datatype) {
                    case 'GunType':
                        $scope.RecordData.GunType = strData;
                        break;
                    case 'GunSize':
                        $scope.RecordData.GunSize = strData;
                        break;
                    case 'GunBrand':
                        $scope.RecordData.GunBrand = strData;
                        break;
                    case 'GunBarrel':
                        $scope.RecordData.GunBarrel = strData;
                        break;
                    case 'GunColor':
                        $scope.RecordData.GunColor = strData;
                        break;
                    case 'GunOwner':
                        $scope.RecordData.GunOwner = strData;
                        break;
                    case 'GunCountry':
                        $scope.RecordData.GunCountry = strData;
                        break;
                    default:
                }
                $('#myModalAddStandard').modal('hide');
            }

            $scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) {
                $('#example').DataTable();
            });
        }

        function loadData($scope, $http, ID) {
            var data = $.param({
                Command: 'LoadDataPage',
                ID: ID
            });

            $http.post("../server/Server_Gunbook.aspx", data, config)
                .success(function (data, status, headers, config) {
                    if (data.output == "OK") {

                        document.getElementById('bookno').innerHTML = data.BOOKNO;
                        document.getElementById('pageno').innerHTML = data.PAGENO;
                        document.getElementById('pagever').innerHTML = data.PAGEVER;
                        $scope.StatusPage = data.STATUS;

                        if (data.IMGURL.trim() == "")
                            document.getElementById('imgurl').innerHTML = "ยังไม่มีรูปภาพ"
                        else
                            document.getElementById('imgurl').innerHTML = "<button onclick='openImage()' class='btn btn-link' >รูปภาพ</button>";

                        $scope.UserAuth = data.USER;
                        $scope.DataRecords = data.DATARECORDS;

                        $scope.datalistGunType = data.standardGunType;
                        $scope.datalistGunSize = data.standardGunSize;
                        $scope.datalistGunBrand = data.standardGunBrand;
                        $scope.datalistGunBarrel = data.standardGunBarrel;
                        $scope.datalistGunColor = data.standardGunColor;
                        $scope.datalistGunOwner = data.standardGunOwner;
                        $scope.datalistGunCountry = data.standardGunCountry;

                        fnUnLoading();

                    } else {
                        showmessage(data.MSG);
                    }
                })
                .error(function (data, status, header, config) { });
        }

        function getParamValue(name) {
            var url = location.href;
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(url);
            return results == null ? null : results[1];
        }

        function formatDate(date) {
            var sYear = date.getFullYear();
            if (sYear < 2400)
                sYear = sYear + 543;
            var sMonth = date.getMonth() + 1;

            return date.getDate() + "/" + sMonth + "/" + sYear + "  " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        }

        function openWindowWithPost(pathimg) {
            var f = document.getElementById('TheForm');
            f.pathimg.value = pathimg;
            window.open('', 'TheWindow');
            f.submit();
        }

        function openImage() {
            window.open('showimage.aspx?Book=' + document.getElementById('bookno').innerHTML + '&Page=' + document.getElementById('pageno').innerHTML + '&Ver=' + document.getElementById('pagever').innerHTML, '_blank');
        }

        function checkboxClick(item) {
            var $box = $(item);

            if ($box.is(':checked')) {
                // the name of the box is retrieved using the .attr() method
                // as it is assumed and expected to be immutable
                var group = 'input:checkbox[name="' + $box.attr('name') + '"]';
                // the checked state of the group/box on the other hand will change
                // and the current value is retrieved using .prop() method
                $(group).prop('checked', false);
                $box.prop('checked', true);
            } else {
                $box.prop('checked', false);
            }
        }

        function fnSetDate(OPNdate) {
            try {
                $('#datereg').datepicker({
                    language: 'thai',
                    format: 'dd MM yyyy',
                    autoclose: true
                });
                var Odate = OPNdate.split(' ');

                var OPdate = Odate[0].split('/');
                var opnDT = new Date(parseInt(OPdate[2]) - 543, parseInt(OPdate[1]) - 1, parseInt(OPdate[0]));

                $('#datereg').datepicker('setDate', opnDT);
            } catch (err) {

            }
        }

        function daysInMonth(m, y) { // m is 0 indexed: 0-11
            switch (m) {
                case 1:
                    return (y % 4 == 0 && y % 100) || y % 400 == 0 ? 29 : 28;
                case 8: case 3: case 5: case 10:
                    return 30;
                default:
                    return 31
            }
        }

    </script>
    <script type="text/javascript">
        jQuery(function ($) {
            $('.input-mask-date').mask('99/99/9999');

        });

    </script>
</body>
</html>
