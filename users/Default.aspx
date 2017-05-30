<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="users_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        C01 : <label id="C01"></label>
        <br />
        C02 : <label id="C02"></label>
     </div>
    </form>
    <script>
        function fnLoad() {
            var SelectRows = window.parent.getSelectRows();
            //SelectRows.length
            document.getElementById("C01").innerHTML = SelectRows[0].COLUMN[0].VALUE;
            document.getElementById("C02").innerHTML = SelectRows[0].COLUMN[1].VALUE;


            ///refresh grid data
            //   window.parent.refreshAllData();


            //alert(SelectRows[0].COLUMN[0].VALUE);
            //alert(SelectRows[0].COLUMN[1].VALUE);
        }
        fnLoad();
    </script>
</body>
</html>
