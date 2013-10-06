
function checkAll(divID, checktoggle)
{
  
  var checkboxes = new Array(); 
  checkboxes = document.getElementById(divID).getElementsByTagName('input');
  for (var i=0; i<checkboxes.length; i++)  {
    if (checkboxes[i].type == 'checkbox')   {
      checkboxes[i].checked = checktoggle;
    }
  }
}

function countChecked(formid,divId,checkAllName)
{
  
  var checkboxes = new Array(); 
  checkboxes = document.getElementById(divId).getElementsByTagName('input');
  var count = false;
  
  for (var i=0; i<checkboxes.length; i++)  {
    if (checkboxes[i].type == 'checkbox' && checkboxes[i].checked == true)   {
      count = true;
      break;
    }
  }
  if(count == true){
        document.getElementById(formid).elements[checkAllName].checked=true;
    }else{
        document.getElementById(formid).elements[checkAllName].checked=false;
    }
}

function unCheckAll(formid,checkAllName)
{
	document.getElementById(formid).elements[checkAllName].checked=false;
}

// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript
function show_hide(id)
{
    switch(document.getElementById(id).style.display)
    {
        case 'block':
            document.getElementById(id).style.display = 'none';
            break;
        case 'none':
            document.getElementById(id).style.display = 'block';
            break;
    }
}


toggleDiv = function(div)
{

    switch ($("#"+div).css('display'))
    {
        case "none":
            $("#"+div).fadeIn(300);
            break;

        case "block":
            $("#"+div).fadeOut(300);
            break;
    }
}

toggleSwitchDiv = function(div1, div2)
{

    switch ($("#"+div1).css('display'))
    {
        case "none":
            $("#"+div1).fadeIn(100);
            $("#"+div2).fadeOut(100);
            break;

        case "block":
            $("#"+div1).fadeOut(100);
            $("#"+div2).fadeIn(100);
            break;
    }
}


function CheckNumericValue(e) {
           var key = e.which ? e.which : e.keyCode;
           //enter key  //backspace //tabkey      //escape key       //delete key           
           if ((key >= 48 && key <= 57) || key == 13 || key == 8 || key == 9 || key == 27 || key == 46) {
               return true;
           }
           return false;
        }