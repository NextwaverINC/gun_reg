function ToolClick(ConfigName, TID, Command) {
   
    switch (ConfigName) {
        case "Administrator": class_Demo(TID, Command); break;
        case "Gunbook": class_Demo(TID, Command); break;
        default: alert("No ConfigName"); break;
    }
}
//====================== Demo ======================
function class_Demo(TID, Command) {
    switch (TID) {
        case "Tools1": fnDemo_Tools1(Command); break;
        case "Tools2": fnUserType_Tools(Command); break;
        case "Tools3": fnProduct_Tools3(Command); break;
        case "GunTools": fnGunbook_Tools(Command); break;
        case "PageTools": fnGunbook_Tools(Command); break;

        case "GunTypeTools": fnStandardData_Tools(Command); break;
        case "GunSizeTools": fnStandardData_Tools(Command); break;
        case "GunBrandTools": fnStandardData_Tools(Command); break;
        case "GunBarrelTools": fnStandardData_Tools(Command); break;
        case "GunColorTools": fnStandardData_Tools(Command); break;
        case "GunOwnerTools": fnStandardData_Tools(Command); break;
        case "GunCountryTools": fnStandardData_Tools(Command); break;
        default: alert("No Tools  " + Command + " " + TID + " Function in DEMO"); break;
    }
}
function fnUserType_Tools(Command) {
    switch (Command) {
        case "NewPosition":
            var url = "../users/user_type.aspx";
            showpopup('เพิ่มข้อมูลตำแหน่ง', url, 600);
            break;
        case "EditPosition":
            var url = "../users/user_type.aspx";
            showpopup('แก้ไขข้อมูลตำแหน่งงาน', url, 600);
            break;
        default: alert("No Command in Tools demo function"); break;
    }
}
function fnDemo_Tools1(Command) {
    switch (Command) {
        case "AddUser":
            var url = "../users/user.aspx";
            showpopup('เพิ่มข้อมูลผู้ใช้งาน', url, 520, 450);
            break;
        case "EditUser":
            var SelectRows = getSelectRows();
            var ID = getCurrentValue(SelectRows, "ID");
            if (ID == "") return;
            var url = "../users/user.aspx?ID=" + ID;
            showpopup('แก้ไขข้อมูลผู้ใช้งาน', url, 520, 450);
            break;
        case "DeleteUser":
            var SelectRows = getSelectRows();
            if (SelectRows == null) {
                showmessage("โปรดเลือกรายการที่จะทำการแก้ไข");
                return "";
            }
            if (SelectRows.length == 0) {
                showmessage("โปรดเลือกรายการที่จะทำการแก้ไข");
                return "";
            }

            var ID_LIST = new Array();
            for (var i = 0; i < SelectRows.length; i++) {
                for (var j = 0; j < SelectRows[i].COLUMN.length; j++) {
                    if ("ID" == SelectRows[i].COLUMN[j].NAME) {
                        ID_LIST.push(SelectRows[i].COLUMN[j].VALUE);
                    }
                }
            }

            showconfirm("คุณแน่ใจหรือไม่ที่จะทำการลบผู้ใช้งานเหล่านี้ ?", fnDeleteUser, ID_LIST);
            break;

        default: alert("No Command in Tools demo function"); break;
    }
}
function fnGunbook_Tools(Command) {
    switch (Command) {
        case "AddGunBook":
            var url = "../gunbook/addBook.aspx";
            showpopup('เพิ่มข้อมูลหนังสือทะเบียนปืน', url, 400, 500);
            break;
        case "EditGunBook":
            var SelectRows = getSelectRows();
            var ID = getCurrentValue(SelectRows, "ID");
            if (ID == "") return;
            var url = "../gunbook/addBook.aspx?ID=" + ID;
            showpopup('แก้ไขข้อมูลหนังสือทะเบียนปืน', url, 400, 500);
            break;
        case "AddGunPage":
            var url = "../gunbook/addPageNew.aspx";
            showpopup('เพิ่มข้อมูลหนังสือทะเบียนปืน', url, 400, 500);
            break;
        case "EditGunPage":
            var SelectRows = getSelectRows();
            var ID = getCurrentValue(SelectRows, "ID");
            if (ID == "") return;
            var url = "../gunbook/addPage.aspx?ID=" + ID;
            showpopupFull('แก้ไขข้อมูลหนังสือทะเบียนปืน', url);
            break;
        case "LoadGunBook":
            window.open("../download/Debug.zip","_blank")
            break;
        default: alert("No Command in Tools demo function"); break;
    }
}

function fnStandardData_Tools(Command) {

    if (Command.indexOf("Add") !== -1) {
        var url = "../gunbook/addStandardCode.aspx?Command=" + Command;
        showpopup('เพิ่มข้อมูล', url, 300, 700);
    }
    else if (Command.indexOf("Edit") !== -1) {
        var SelectRows = getSelectRows();
        var ID = getCurrentValue(SelectRows, "ID");
        if (ID == "") return;
        var url = "../gunbook/addStandardCode.aspx?ID=" + ID + "&Command=" + Command;
        showpopup('เพิ่มข้อมูล', url, 300, 700);
    }
    else
        alert("No Command in Tools demo function");
}


function fnDeleteUser(ID_LIST) {

    fnLoading();

    var data = $.param({
        Command: 'DeleteUser',
        ID_LIST: ID_LIST.toString()
    });

    $http_gobal.post("../server/Server_User.aspx", data, config)
        .success(function (data, status, headers, config) {
            if (data.output == "OK") {
                showmessage("ลบข้อมูลเรียบร้อยแล้ว", refreshAllData);
            } else {
                showmessage(data.MSG, fnUnLoading);
            }
        })
        .error(function (data, status, header, config) {
            alert(data);
        }
        );
}
//window.parent.ชื่อฟังก์
function fnProduct_Tools3(Command) {
    switch (Command) {

        case "EditDocument":
            var url = "../users/Default.aspx";
            showpopup('เพิ่มข้อมูลผู้ใช้งาน', url, 600);
            //alert(SelectRows[0].PRO_ID);
            break;
        default: alert("No Command in Tools demo function"); break;
    }
}

//==================================================

