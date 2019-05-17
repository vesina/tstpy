function loadXMLRoaster(xmlPlayersFile) {
    if (1==1) //(window.XMLHttpRequest())
        xmlhttp = new XMLHttpRequest();
    else
        xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');

    xmlhttp.open('get', xmlPlayersFile, false);
    xmlhttp.send();
    var xmlDoc = xmlhttp.responseXML;

    return xmlDoc;

}

function buildRoaster(xmlFile) {
    var xmlDoc = xmlFile;

    //document.getElementById("name").innerHTML = xmlDoc.getElementsByTagName("players")[0].childNodes[0].nodeValue;
    var doc = xmlDoc.getElementsByTagName("players")[0];
    var x = doc.getElementsByTagName('name');
    var id = doc.getElementsByTagName('playerid');
    //$('#PlayersList').before("Count=" + x.length);
    //$('#Roster').before('<br/><div class="iad"><a name="insert">insert</a><a name="update"><span>  update</span></a></div>');
    for (i = 0; i < x.length; i++) {
        var name = x[i].childNodes[0].nodeValue;//.nodeValue;
        var nid = id[i].childNodes[0].nodeValue;
        var txt = fnBuildPlayer(name, nid);
   
        $('#all').after(txt);
        
    }

}

function fnBuildPlayer(name, id) {
    var str = '<div id="line' + id + '" class="Player">';
    str = str + '<a name="remove" value="' + id + '">x </a>';
    //txt = txt + '<a name="update">v </a>';
    str = str + '<input type="checkbox" name="selected" class="ch" id="ch' + id + '" checked="checked" value="' + id + '"/>';
    str = str + '<input type="textbox" id="player' + id + '" readonly!="readonly" value="' + name + '"/>';
    str = str + '<a class="timein" id="timein' + id + '">0:00</a>';
    str = str + '</div>';
    return str;
}
function fnBuildPlayerForRoster(name, id) {
    var str = '<div id="Rline' + id + '" class="Player"  enableviewstate="true">';   
    str = str + '<input type="checkbox" name="selected" onclick="fnMovePlayerRosterWaitList()" class="ch" id="ch' + id + '" checked!="checked" value="' + id + '"/>';
    str = str + '<input type="textbox" id="player' + id + '" value="' + name + '"/>';
    str = str + '</div>';
    return str;
}

function addPlayer(xmlFile) {

    //var doc = xmlFile.getElementsByTagName("players")[0];
    //var id = (doc.getElementsByTagName('playerid')).length;
    
    var i = xmlFile.getElementsByTagName("players")[0].getElementsByTagName('name').length;
    if (isNaN(i))
        i = "-1";
    else
        i++;
        var txt = '<div id="line' + i.toString() + '" class="iad"  enableviewstate="true">';
        txt = txt + '<a name="remove" onclick="fnRemoveParent(' + i.toString() + ')" onmouseout="$(this).removeClass(\'hover\');" onmouseover="$(this).addClass(\'hover\');" value="' + i.toString() + '">x </a>';
        //txt = txt + '<a name="update">v </a>';
        txt = txt + '<input type="checkbox" name="selected" onclick="fnMovePlayerWaitList()" checked="" class="ch" id="ch' + i.toString() + '" value="' + i.toString() + '"/>';
        txt = txt + '<input type="textbox" id="player' + i.toString() + '" value="' + i.toString() + '"/>';
        txt = txt + '<a class="timein" id="timein' + i.toString() + '">0:00</a>';
        txt = txt + '</div>';
        $('#all').after(txt);
    

}
/*
function unloadXMLRoaster(xmlPlayersFile) {
    alert("unloading!");

}

function fnAddOnmouseHover() {
    $(this).addClass('hover');
    return false;
}

function fnRemoveOnmouseHover() {
    $(this).removeClass('hover');
    return false;
}*/

function fnMovePlayerWaitList() {

    var id = $(this).parent().attr('id');
    document.getElementById('#WaitList').appendChild(document.getElementById(id));

    return false;
}
function fnUpdateValueA() {
    //$('#status').childNodes[0].nodeValue;
    alert($($('#test').val()).html());
   
    
}
function getInteger(n) {
    var n = new Number(n);
   // if (!isNaN(n) && n === parseInt(n, 10) && n > 0)
        return parseInt(n, 10);
    //else
       // return -9999;
}
function fnToggleStatus(status) {
    $('#status').text(status);   
    if (status == "running") {        
        $('#begin').fadeOut();
        $('#stop').fadeIn(700);
    }
    else {
        $('#stop').fadeOut();
        $('#begin').fadeIn(700);
    }
}
function fnUpdateAvg() {
        var totalmin = parseFloat($('#totalmin').val());
        var avg = parseInt(teamsize * totalmin / players);
        $('#avg').text(avg);
}
function fnTimeInAddSeconds(current, rf) {
    
    var current = parseInt(st.split(':')[0]) * 60 + parseInt(st.split(':')[1]);

    if (isNaN(current))
        current = 0;
    else {
        current = parseInt(current);
    }

    var min= parseInt((rf + parseInt(current)) / 60);
    var sec = parseInt((rf + parseInt(current)) % 60);

    if (sec < 10)
        return min + ':0' + sec;
    else
        return min + ':' + sec;
    //alert(st + ' ; ' + current + ' ; ' + tm);
    

}