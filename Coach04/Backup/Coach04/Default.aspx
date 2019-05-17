<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Coach04._Default" %>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="Stylesheet1.css" rel="stylesheet" type="text/css" />
    
    <script src="jquery-1.11.0.min.js" type="text/javascript">
    </script>
    <script type="text/javascript">
    $(document).ready(function(){
        var timer;
        var sec = 2; /* time between changes */
        function fnStart() {
            timer = setInterval(fnUpdateTime(sec), sec * 1000);
        }
        function fnPause() {
            clearInterval(timer);
        }
        function fnUpdateTime() {
 
        }
        }
    );
    </script>
        <script type="text/javascript">
            $(document).ready(function createList() {
                var total = $("#nuAvailable").val();
                $('.Player').remove();
                if (isNaN(total))
                    var total = 0;
                for (var cnt = total; cnt > 0; cnt--) {


                    $('#PlayersList').after(
        '<div id="line"' + cnt.toString() + ' class="Player"  enableviewstate="true"><input type="checkbox" onclick="" checked="" /><input type="text" id="player' + cnt.toString() + '"/> </div>'
        );
                    $('#panelConfig').hide();
                    $('#bnConfig').val("Config");
                }
            });
            
        </script>
        <script type="text/javascript">
//            $(document).ready(function() {
//                $('.tabs a').click(function() {
//                $this = $(this);
//                $('.panel').hide();
//                $('.tabs a.active').removeClass('active');
//                $this.addClass('active').blur();
//                var panel=$this.attr('href');
//                $(panel).fadeIn(250);
//                }); // end click
//            }); // end ready
            //            });
 $(document.ready(function() {
  $($('.tabs a').click(function() {
  $this = $(this);
  $('.panel').hide();
  $('.tabs a.active').removeClass('active');
  $this.addClass('active').blur();
  var panel = $this.attr('href');
  $(panel).fadeIn(250);
 return false;
  }); // end click
  $('.tabs li:first a').click();
  }); // end ready
        </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div class="tabbedPanels">
    <ul class="tabs">
    <li><a href="#panel1" >Configuration</a></li>
    <li><a href="#panel2" >Playing game</a></li>
    <li><a href="#panel3" >Statistics</a></li>
    </ul>
    </div>
    <div class="panelContainer">
    <div class="panel" id="panel1">
    <span class="setting">Total game time (min)</span><input class="num" id="totalmin" type="number" name="total" min="1" max="100"/><br />
    <span class="setting">Refresh interval (sec)</span><input  class="num" id="refreshsec" type="number" name="refresh" min="1" max="5"/><br />
    <span class="setting">Team size</span><input  class="num" id="team" type="number" name="team" min="1" /><br />
    <span class="setting">Available players (count)</span><input  class="num" id="available" type="number" name="available" min="1" max="50" />  
    </div>
    <div class="panel" id="panel2">
    <button id="Button1" onclick="fnStart()">Begin</button>
    <button id="Button2" onclick="fnStop()">Stop</button>
    <div id="PlayersList" class="players" enableviewstate="true">
    
    </div>
 
    <div class="panel" id="panel3">
    </div>
    </div>
    
    
    </div>
    
    <%--<div id="panelConfig">
    Total game time (min)<input id="nuTotal" type="number" name="total" min="1" max="100"/><br />
    Refresh interval (sec)<input id="nuRefresh" type="number" name="refresh" min="1" max="5"/><br />
    Team size<input id="nuTeam" type="number" name="team" min="1" /><br />
    Available players (count)<input id="nuAvailable" type="number" name="available" min="1" max="50" />  
<br />

</div>
<div>
    <button id="bnStart" onclick="fnStart()">Begin</button>
    <button id="bnStop" onclick="fnStop()">Stop</button>
    </div>
    <button onclick="createList()" id="bnConfig">Create list</button>    
    <div id="PlayersList" class="players" enableviewstate="true">
    <div id="dynList"></div>
    </div>--%>
 
    </form>
</body>
</html>
