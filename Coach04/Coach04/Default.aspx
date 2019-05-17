<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Coach04._Default" %>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="Stylesheet1.css" rel="stylesheet" type="text/css" />
    
    <script src="jquery-1.11.0.min.js" type="text/javascript">
    </script>
    <script src="jquery.easing.1.3.js" type="text/javascript"></script>
<script src="jquery.color.js" type="text/javascript"></script>
    <script src="dataModul.js" type="text/javascript"> </script>
  
     
    <script type="text/javascript">
       $(document).ready(function() {
           $('#Roster').hover(
     function() {
		$(this).stop().animate(
		{
			left: '0',
			//backgroundColor: 'rgb(110,138,195)'
		},
		500,
		'easeInSine'
		); // end animate
	 }, 
	 function() {
		 $(this).stop().animate(
		{
			left: '-197px',
			//backgroundColor: 'rgb(110,138,195)'
		},
		1000,
		'easeOutSine'
		); // end animate
	 }
  ); // end hover
}); // end ready
</script>
        <script type="text/javascript">

            $(document).ready(function () {
                $('#panelSetup').hover(
          function () {
              $(this).stop().animate(
              {
                  top: '30',
                 
                  //backgroundColor: 'rgb(110,138,195)'
              },
              500,
              'easeInSine'
              ); // end animate
          },
          function () {
              $(this).stop().animate(
             {
                 top: '-127px',
                // backgroundColor: 'rgb(110,138,195)'
             },
            1000,
             'easeOutSine'
             ); // end animate
          }
       ); // end hover
            }); // end ready
</script>

    <script type="text/javascript">
        
        $(document).ready(function onload() {
            var players = "xmlPlayers.xml";
            var xmlfile;
            xmlfile = loadXMLRoaster(players);
            buildRoaster(xmlfile);
            $('#stop').fadeOut();
        }// end buildRoster
        ); // end document ready
          </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('a').mouseover(function () {
                $(this).addClass('hover');
                return false;
            });//end add hover

            $('a').mouseout(function () {
                $(this).removeClass('hover');
                return false;
            }); // end remove hover
            $('.Player a[name=remove]').click(function () {
                var t = "Delete? " + $(this).siblings('input[type=textbox]').val() + $(this).attr('value');
                var q = window.confirm(t);
                if (q) {
                    // $(this).parent().remove();
                    // $("#line" + $(this).attr('value')).remove();
                    $('#all').after(document.getElementById("line" + $(this).attr('value')));
                    document.getElementById("line" + $(this).attr('value')).children('input[type=checkbox]').last().prop('checked', 'checked');
                    $("#line" + $(this).attr('value')).removeClass('ch');
                    $("#line" + $(this).attr('value')).addClass('chR');
                }
                return false;
            });// end remove Player


            $('.iad a[name=insert]').click(function () {
                var t = "Add a new player?";
                //alert(t);
                var q = window.confirm(t);
                if (q)
                    addPlayer(xmlfile);

                return false;
            }); // end insert Player
            $('#all').click(function () {
                //alert('ch :' + $(this).attr('value'));
                var sourceList = $('#Roster').children('.Player');
                var playersList = $('#PlayersList').children('.Player');
                var waitList = $('#WaitList').children('.Player');
                var teamSize = $('#teamsize').val();
                var check = (teamSize - playersList.length);
                //alert(check);
                sourceList.each(function () {

                    if (check <= 0) {
                        $(this).appendTo('#WaitList');
                        $(this).children('input:checked').removeAttr('checked');//.prop('checked', false);
                        $("#line" + $(this).attr('value')).removeClass('chR');
                        $("#line" + $(this).attr('value')).addClass('ch');
                        $(this).children('input[type=textbox]').prop('readonly', true);//.prop('checked', false);
                    }
                    else {
                        $(this).appendTo('#PlayersList');
                        check--;
                        $("#line" + $(this).attr('value')).removeClass('chR');
                        $("#line" + $(this).attr('value')).addClass('ch');
                        $(this).children('input[type=textbox]').prop('readonly', true);
                    }

                });
            }); // end click all
            $('.chR').change(function () {
                //var sourceList = parseFloat($('#Roster').children('.Player')) ;
                var players = parseFloat($('#PlayersList').children('.Player').length);
                // var waitList = parseFloat($('#WaitList').children('.Player').length);
                var teamSize = parseFloat($('#teamsize').val());


                if ($(this).is(':checked')) {
                    return false;
                }
                else {

                    //$(this).change('checked','checked')
                    if (teamSize - players > 0) {

                        document.getElementById('PlayersList').appendChild(document.getElementById("line" + $(this).attr('value')));
                        $(this).prop('checked', 'checked');


                    }
                    else {
                        document.getElementById('WaitList').appendChild(document.getElementById("line" + $(this).attr('value')));
                        $(this).prop('checked', false);

                    }
                }


                var totalmin = parseFloat($('#totalmin').val());
                var avg = parseInt(teamsize * totalmin / players);
                $('#avg').text(avg);
                return false;
            }); // end chR move available Player to PlayersList
            $('.ch').change(function () {
                if ($(this).is(':checked')) {
                    document.getElementById('PlayersList').appendChild(document.getElementById("line" + $(this).attr('value')));
                    $(this).prop('checked', 'checked');
                }
                else {
                    document.getElementById('WaitList').appendChild(document.getElementById("line" + $(this).attr('value')));
                    $(this).prop('checked', false);
                }
                return;
            }); // end toggle Player in-out

        });// edn adding events


      </script>
   
    <script type="text/javascript">
              var players = "xmlPlayers.xml";
              $(document).ready(function unload() {
                //  unloadXMLRoaster(players);
              });

    </script>
        
    
    <script type="text/javascript">
        var timer;
        var txt;
        var st;
        function fnStart() {
            var rf = 0;
            rf = parseInt($('#refreshsec').val());

            timer = setInterval(fnUpdateTime, rf * 1000);

            fnToggleStatus("running");
        }
        function fnStop() {

            clearInterval(timer);
            fnToggleStatus("stopped");
        }

        function fnUpdateTime() {

            var rf = parseInt($('#refreshsec').val());

            $('#PlayersList').children('div').children('.timein').each(function () {
                var st = $(this).text();

                var current = parseInt(st.split(':')[0]) * 60 + parseInt(st.split(':')[1]);

                if (isNaN(current))
                    current = 0;
                else {
                    current = parseInt(current);
                }
                var min = parseInt((rf + parseInt(current)) / 60);
                var sec = parseInt((rf + parseInt(current)) % 60);
                var tm;
                if (sec < 10)
                    tm = min + ':0' + sec;
                else
                    tm = min + ':' + sec;
                $(this).text(tm);


            });//end each
            return;
        }


    </script>
      <script type="text/javascript">
          function fnRemoveParent(numid) {
              var t = "Delete fn ? :" + $(this).attr('value') + ';' + $(this).val() + ';' + numid;
              var q = window.confirm(t);
              if (q) {
                  // $(this).parent().remove();
                  $("#line" + numid).remove();
              }
              return false;
          }
      </script>
</head>
<body>



    <div id="panelSetup">

                <ul style="list-style: none">
                    <li><a class="label">Game(min):</a><input class="num" id="totalmin" value="90" /></li>
                    <li><a class="label">Team(size):</a><input class="num" id="teamsize" value="11" /></li>
                    <li><a class="label">Refresh(sec):</a><input class="num" type="text" id="refreshsec" value="5" /></li>
                    
                </ul>

    </div>        
       <div class="tabbedPanels" id="panel">
        <ul class="tabs">
           <li><a id="begin" onclick="fnStart()">Start</a></li>
                <li><a id="stop" onclick="fnStop()">Stop</a></li> 
            <li><a  class="value" id="status">not running</a></li>
                    <li><a class="label">Avg(min):</a><a class="value" id="avg">90</a></li>
                    <li><a class="label">Elapsed(min):</a><a class="value" id="elapsed">0</a></li> 
            <li><a id="save" onclick="fnUpdateValueA()">Select</a><input id="test" value="selector" /></li>
        </ul>
    </div>
    <div id="mainCol"> 

            <div id="PlayersList" class="players"></div>
            <hr />
            <div id="WaitList" class="players"></div>
            
        </div>
        <div class="roster" id="Roster">
            <input type="checkbox" id="all" class="all"/>
                               
        </div>
</body>
</html>
